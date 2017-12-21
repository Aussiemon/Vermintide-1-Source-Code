require("scripts/settings/camera_transition_templates")
require("scripts/settings/camera_settings")
require("scripts/settings/camera_effect_settings")
require("scripts/managers/camera/transitions/camera_transition_generic")
require("scripts/managers/camera/transitions/camera_transition_fov_linear")
require("scripts/managers/camera/transitions/camera_transition_position_linear")
require("scripts/managers/camera/transitions/camera_transition_rotation_lerp")
require("scripts/managers/camera/cameras/base_camera")
require("scripts/managers/camera/cameras/root_camera")
require("scripts/managers/camera/cameras/transform_camera")
require("scripts/managers/camera/cameras/scalable_transform_camera")
require("scripts/managers/camera/cameras/rotation_camera")
require("scripts/managers/camera/cameras/blend_camera")
require("scripts/managers/camera/cameras/aim_camera")
require("scripts/managers/camera/cameras/sway_camera")
require("scripts/managers/camera/cameras/object_link_camera")
require("scripts/managers/camera/cameras/offset_camera")
require("scripts/managers/camera/mood_handler/mood_handler")
require("scripts/level/environment/environment_blender")

if Development.parameter("camera_debug") then
	script_data.camera_debug = true
end

CameraManager = class(CameraManager)
CameraManager.NODE_PROPERTY_MAP = {
	"position",
	"rotation",
	"vertical_fov",
	"near_range",
	"far_range",
	"yaw_speed",
	"pitch_speed",
	"shading_environment",
	"fade_to_black",
	"pitch_offset"
}
CameraManager.init = function (self, world)
	self._world = world
	self._scatter_system = World.scatter_system(self._world)
	self._node_trees = {}
	self._current_trees = {}
	self._camera_nodes = {}
	self._terrain_decoration_observers = {}
	self._scatter_system_observers = {}
	self._variables = {}
	self._listener_elevation_offset = 0
	self._listener_elevation_scale = 1
	self._listener_elevation_min = -math.huge
	self._listener_elevation_max = math.huge
	self._sequence_event_settings = {
		time_to_recover = 0,
		end_time = 0,
		start_time = 0
	}
	self._shake_event_settings = {}
	self._level_particle_effect_ids = {}
	self._level_screen_effect_ids = {}
	self._frozen = false
	self._frame = 0
	self._shadow_lights = {}
	self._shadow_lights_active = false
	self._shadow_lights_max_active = 1
	self._shadow_lights_viewport = nil
	self._property_temp_table = {}
	self.mood_handler = MoodHandler:new(world)
	self._environment_blenders = {}
	self._shading_environment = {}
	self._fov_multiplier = 1

	return 
end
CameraManager.destroy = function (self)
	self.mood_handler:destroy()

	self.mood_handler = nil

	return 
end
CameraManager.set_shadow_lights = function (self, active, max, viewport)
	self._shadow_lights_active = active
	self._shadow_lights_max_active = max

	if not GameSettingsDevelopment.disable_shadow_lights_system and not active then
		for _, shadow_light in ipairs(self._shadow_lights) do
			self._set_shadow_light(self, shadow_light.unit, false)
		end
	end

	return 
end
CameraManager.set_elevation_offset = function (self, offset, scale, min, max)
	self._listener_elevation_offset = offset
	self._listener_elevation_scale = scale
	self._listener_elevation_min = min or -math.huge
	self._listener_elevation_max = max or math.huge

	return 
end
CameraManager.register_shadow_lights = function (self, set)
	local level = LevelHelper:current_level(self._world)

	for _, index in pairs(set.units) do
		local unit = Level.unit_by_index(level, index)
		self._shadow_lights[#self._shadow_lights + 1] = {
			distance = 0,
			unit = unit
		}

		if not GameSettingsDevelopment.disable_shadow_lights_system then
			self._set_shadow_light(self, unit, false)
		end
	end

	return 
end
CameraManager._set_shadow_light = function (self, unit, active)
	if not GameSettingsDevelopment.disable_shadow_lights_system then
		for i = 1, Unit.num_lights(unit), 1 do
			local light = Unit.light(unit, i - 1)

			Light.set_casts_shadows(light, active)
		end
	end

	return 
end
CameraManager._update_shadow_lights = function (self, dt, viewport)
	local lights = self._shadow_lights

	if self._shadow_lights_active and viewport == self._shadow_lights_viewport and not table.is_empty(lights) then
		local camera_pos = self.camera_position(self, viewport)

		for _, light in ipairs(lights) do
			local unit = light.unit

			self._set_shadow_light(self, unit, false)

			light.distance = Vector3.length(Unit.world_position(unit, 0) - self.camera_position(self, viewport))
		end

		table.sort(lights, function (light1, light2)
			return light1.distance < light2.distance
		end)

		local max_lights = math.min(self._shadow_lights_max_active, #lights)

		for i = 1, max_lights, 1 do
			self._set_shadow_light(self, lights[i].unit, true)
		end

		if script_data.debug_draw_shadow_lights and 0 < max_lights then
			local step = max_lights/255

			for i = 1, max_lights, 1 do
				QuickDrawer:sphere(Unit.local_position(lights[i].unit, 0), 0.25, Color(i*step, step*i - 255, 0))
			end
		end
	end

	return 
end
CameraManager.add_viewport = function (self, viewport_name, position, rotation)
	self._terrain_decoration_observers[viewport_name] = TerrainDecoration.create_observer(self._world, position)
	self._scatter_system_observers[viewport_name] = ScatterSystem.make_observer(self._scatter_system, position, rotation)
	self._node_trees[viewport_name] = {}
	self._variables[viewport_name] = {}
	self._camera_nodes[viewport_name] = {}
	self._shadow_lights_viewport = viewport_name
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	self._environment_blenders[viewport_name] = EnvironmentBlender:new(self._world, viewport)

	return 
end
CameraManager.create_viewport = function (self, viewport_name, position, rotation)
	ScriptWorld.create_viewport(self._world, viewport_name, "default", 1, position, rotation, true)
	self.add_viewport(self, viewport_name, position, rotation)

	return 
end
CameraManager.destroy_viewport = function (self, viewport_name)
	TerrainDecoration.destroy_observer(self._world, self._terrain_decoration_observers[viewport_name])
	ScatterSystem.destroy_observer(self._scatter_system, self._scatter_system_observers[viewport_name])

	self._terrain_decoration_observers[viewport_name] = nil
	self._scatter_system_observers[viewport_name] = nil
	self._node_trees[viewport_name] = nil
	self._variables[viewport_name] = nil
	self._camera_nodes[viewport_name] = nil

	self._environment_blenders[viewport_name]:destroy()

	self._environment_blenders[viewport_name] = nil

	return 
end
CameraManager.load_node_tree = function (self, viewport_name, tree_id, tree_name)
	local tree_settings = CameraSettings[tree_name]
	local node_table = {}
	local root_node = self._setup_child_nodes(self, node_table, viewport_name, tree_id, nil, tree_settings)
	local tree_table = {
		root_node = root_node,
		nodes = node_table
	}
	self._node_trees[viewport_name][tree_id] = tree_table

	return 
end
CameraManager.node_tree_loaded = function (self, viewport_name, tree_id)
	if self._node_trees[viewport_name] and self._node_trees[viewport_name][tree_id] then
		return true
	end

	return false
end
CameraManager.debug_reload_tree = function (self, viewport_name, tree_id, tree_name, node, unit)
	self.load_node_tree(self, viewport_name, tree_id, tree_name)
	self.set_node_tree_root_unit(self, viewport_name, tree_name, unit)
	self.set_camera_node(self, viewport_name, tree_name, node)

	return 
end
CameraManager.set_node_tree_root_unit = function (self, viewport_name, tree_id, unit, object, preserve_aim_yaw)
	self._node_trees[viewport_name][tree_id].root_node:set_root_unit(unit, object, preserve_aim_yaw)

	return 
end
CameraManager.current_node_tree_root_unit = function (self, viewport_name)
	local tree_id = self._current_trees[viewport_name]

	return self._node_trees[viewport_name][tree_id].root_node:root_unit()
end
CameraManager.set_node_tree_root_position = function (self, viewport_name, tree_id, position)
	self._node_trees[viewport_name][tree_id].root_node:set_root_position(position)

	return 
end
CameraManager.set_node_tree_root_rotation = function (self, viewport_name, tree_id, rotation)
	self._node_trees[viewport_name][tree_id].root_node:set_root_rotation(rotation)

	return 
end
CameraManager.set_node_tree_root_vertical_fov = function (self, viewport_name, tree_id, vertical_fov)
	self._node_trees[viewport_name][tree_id].root_node:set_root_vertical_fov(vertical_fov)

	return 
end
CameraManager.set_node_tree_root_near_range = function (self, viewport_name, tree_id, near_range)
	self._node_trees[viewport_name][tree_id].root_node:set_root_near_range(near_range)

	return 
end
CameraManager.set_node_tree_root_far_range = function (self, viewport_name, tree_id, far_range)
	self._node_trees[viewport_name][tree_id].root_node:set_root_far_range(far_range)

	return 
end
CameraManager.current_camera_node = function (self, viewport_name)
	return self._camera_nodes[viewport_name][#self._camera_nodes[viewport_name]].node:name()
end
CameraManager.tree_node = function (self, viewport_name, tree_id, node_name)
	local tree = self._node_trees[viewport_name][tree_id]

	return tree.nodes[node_name]
end
CameraManager.shading_callback = function (self, world, shading_env, viewport)
	if self._world == world then
		local shading_env_settings = self._shading_environment[viewport] or self._shading_environment[Viewport.get_data(viewport, "overridden_viewport")]

		if shading_env_settings.dof_near_focus and shading_env_settings.dof_near_blur then
			local nf = shading_env_settings.dof_near_focus
			local nb = shading_env_settings.dof_near_blur

			ShadingEnvironment.set_vector2(shading_env, "dof_near_setting", Vector3(nf, nf - nb, 0))
		end

		if shading_env_settings.dof_far_focus and shading_env_settings.dof_far_blur then
			local ff = shading_env_settings.dof_far_focus
			local fb = shading_env_settings.dof_far_blur

			ShadingEnvironment.set_vector2(shading_env, "dof_far_setting", Vector3(ff, fb - ff, 0))
		end

		if shading_env_settings.dof_amount then
			local amount = shading_env_settings.dof_amount

			ShadingEnvironment.set_scalar(shading_env, "dof_amount", amount)
		end

		for name, settings in pairs(OutlineSettings.colors) do
			local c = settings.color
			local color = Vector3(c[2]/255, c[3]/255, c[4]/255)
			local multiplier = settings.outline_multiplier

			if settings.pulsate then
				multiplier = settings.outline_multiplier*0.5 + math.sin(Application.time_since_launch()*settings.pulse_multiplier)*settings.outline_multiplier*0.5
			end

			ShadingEnvironment.set_vector3(shading_env, settings.variable, color)
			ShadingEnvironment.set_scalar(shading_env, settings.outline_multiplier_variable, multiplier)
		end

		if self._frame == 0 then
			self._frame = 1

			ShadingEnvironment.set_scalar(shading_env, "reset_luminance_adaption", 1)
		elseif self._frame == 1 then
			self._frame = 2

			ShadingEnvironment.set_scalar(shading_env, "reset_luminance_adaption", 0)
		end

		if self._vignette_falloff_opacity and self._vignette_color then
			local env_vignette_color = ShadingEnvironment.vector3(shading_env, "vignette_color")
			local env_vignette_scale_falloff_opacity = ShadingEnvironment.vector3(shading_env, "vignette_scale_falloff_opacity")
			local vignette_t = self._vignette_t
			local vignette_s_f_o = self._vignette_falloff_opacity:unbox()
			local max_scale_falloff_opacity = Vector3(math.min(vignette_s_f_o.x, env_vignette_scale_falloff_opacity.x), math.max(vignette_s_f_o.y, env_vignette_scale_falloff_opacity.y), math.max(vignette_s_f_o.z, env_vignette_scale_falloff_opacity.z))
			local new_scale_falloff_opacity = Vector3.smoothstep(vignette_t, env_vignette_scale_falloff_opacity, max_scale_falloff_opacity)

			ShadingEnvironment.set_vector3(shading_env, "vignette_color", self._vignette_color:unbox())
			ShadingEnvironment.set_vector3(shading_env, "vignette_scale_falloff_opacity", new_scale_falloff_opacity)
		end

		gamma = Application.user_setting("gamma") or 1

		ShadingEnvironment.set_scalar(shading_env, "exposure", ShadingEnvironment.scalar(shading_env, "exposure")*gamma)

		if Application.user_setting("render_settings", "particles_receive_shadows") then
			local last_slice_idx = ShadingEnvironment.array_elements(shading_env, "sun_shadow_slice_depth_ranges") - 1
			local last_slice_depths = ShadingEnvironment.array_vector2(shading_env, "sun_shadow_slice_depth_ranges", last_slice_idx)
			last_slice_depths.x = 0

			ShadingEnvironment.set_array_vector2(shading_env, "sun_shadow_slice_depth_ranges", last_slice_idx, last_slice_depths)
		end

		self.mood_handler:apply_environment_variables(shading_env)
	end

	return 
end
CameraManager._update_level_particle_effects = function (self, viewport_name)
	for id, _ in pairs(self._level_particle_effect_ids) do
		World.move_particles(self._world, id, self.camera_position(self, viewport_name))
	end

	return 
end
CameraManager.set_camera_node = function (self, viewport_name, tree_id, node_name)
	if not script_data.camera_debug and script_data.camera_node_debug then
	end

	local old_tree_id = self._current_trees[viewport_name]
	self._current_trees[viewport_name] = tree_id
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = camera_nodes[#camera_nodes]
	local tree = self._node_trees[viewport_name][tree_id]
	local next_node = {
		node = tree.nodes[node_name]
	}

	assert(current_node ~= next_node)

	if current_node then
		local transition_template = nil

		if old_tree_id ~= tree_id then
			local tree_transitions = current_node.node:tree_transitions()
			transition_template = tree_transitions[tree_id] or tree_transitions.default
		else
			local node_transitions = current_node.node:node_transitions()
			transition_template = node_transitions[next_node.node:name()] or node_transitions.default
		end

		if transition_template then
			self._add_transition(self, viewport_name, current_node, next_node, transition_template)

			if transition_template.inherit_aim_rotation and old_tree_id ~= tree_id then
				local old_root = self._node_trees[viewport_name][old_tree_id].root_node
				local old_pitch = old_root.aim_pitch(old_root)
				local old_yaw = old_root.aim_yaw(old_root)

				tree.root_node:set_aim_pitch(old_pitch)
				tree.root_node:set_aim_yaw(old_yaw)
			end
		else
			next_node.transition = {}

			self._remove_camera_node(self, camera_nodes, #camera_nodes)
		end
	else
		next_node.transition = {}
	end

	next_node.node:set_active(true)

	camera_nodes[#camera_nodes + 1] = next_node

	return 
end
CameraManager.set_frozen = function (self, frozen)
	self._frozen = frozen

	return 
end
CameraManager.is_in_view = function (self, viewport_name, position)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return 0 < Camera.inside_frustum(camera, position)
end
CameraManager._remove_camera_node = function (self, camera_nodes, index)
	for i = 1, index, 1 do
		local node_table = table.remove(camera_nodes, 1)

		node_table.node:set_active(false)
	end

	return 
end
CameraManager.camera_position = function (self, viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.world_position(camera)
end
CameraManager.camera_rotation = function (self, viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.world_rotation(camera)
end
CameraManager.camera_pose = function (self, viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.world_pose(camera)
end
CameraManager.fov = function (self, viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	return Camera.vertical_fov(camera)
end
CameraManager.has_viewport = function (self, viewport_name)
	return ScriptWorld.has_viewport(self._world, viewport_name)
end
CameraManager.aim_rotation = function (self, viewport_name)
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self._current_node(self, camera_nodes)
	local root_node = current_node.root_node(current_node)
	local aim_pitch = root_node.aim_pitch(root_node)
	local aim_yaw = root_node.aim_yaw(root_node)
	local rotation_pitch = Quaternion(Vector3(1, 0, 0), aim_pitch)
	local rotation_yaw = Quaternion(Vector3(0, 0, 1), aim_yaw)
	local aim_rotation = Quaternion.multiply(rotation_yaw, rotation_pitch)
	local pitch_offset = self._variables[viewport_name].pitch_offset

	if pitch_offset then
		local offset_aim_rotation = Quaternion.multiply(aim_rotation, Quaternion(Vector3(1, 0, 0), pitch_offset))

		return offset_aim_rotation
	else
		return aim_rotation
	end

	return 
end
CameraManager._setup_child_nodes = function (self, node_table, viewport_name, tree_id, parent_node, settings, root_node)
	local node_settings = settings._node
	local node = self._setup_node(self, node_settings, parent_node, root_node)
	root_node = root_node or node
	node_table[node.name(node)] = node

	for key, child_settings in pairs(settings) do
		if key ~= "_node" then
			self._setup_child_nodes(self, node_table, viewport_name, tree_id, node, child_settings, root_node)
		end
	end

	return node
end
CameraManager._setup_node = function (self, node_settings, parent_node, root_node)
	local node_class = rawget(_G, node_settings.class)
	local node = node_class.new(node_class, root_node)

	node.parse_parameters(node, node_settings, parent_node)

	if parent_node then
		parent_node.add_child_node(parent_node, node)
	end

	return node
end
CameraManager.update = function (self, dt, t, viewport_name)
	if not GameSettingsDevelopment.disable_shadow_lights_system then
		self._update_shadow_lights(self, dt, viewport_name)
	end

	local node_trees = self._node_trees[viewport_name]
	local data = self._variables[viewport_name]
	local current_tree = self._node_trees[viewport_name][self._current_trees[viewport_name]]
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self._current_node(self, camera_nodes)

	current_tree.root_node:update_pitch_yaw(dt, data, current_node, viewport_name)

	local yaw = current_tree.root_node:aim_yaw()
	local pitch = current_tree.root_node:aim_pitch()

	for tree_id, tree in pairs(node_trees) do
		if tree ~= current_tree then
			tree.root_node:set_aim_pitch(pitch)
			tree.root_node:set_aim_yaw(yaw)
		end
	end

	self._update_level_particle_effects(self, viewport_name)
	self.mood_handler:update(dt)
	self._environment_blenders[viewport_name]:update(dt, t)

	return 
end
CameraManager.set_fov_multiplier = function (self, multiplier)
	self._fov_multiplier = multiplier

	return 
end
CameraManager.set_pitch_yaw = function (self, viewport_name, pitch, yaw)
	local node_trees = self._node_trees[viewport_name]

	for tree_id, tree in pairs(node_trees) do
		tree.root_node:set_aim_pitch(pitch)
		tree.root_node:set_aim_yaw(yaw)
	end

	return 
end
CameraManager.set_variable = function (self, viewport_name, field, value)
	self._variables[viewport_name][field] = value

	return 
end
CameraManager.variable = function (self, viewport_name, field)
	return self._variables[viewport_name][field]
end
CameraManager.post_update = function (self, dt, t, viewport_name)
	if self._frozen then
		return 
	end

	local node_trees = self._node_trees[viewport_name]
	local data = self._variables[viewport_name]

	for tree_id, tree in pairs(node_trees) do
		self._update_nodes(self, dt, viewport_name, tree_id, data)
	end

	self._update_camera(self, dt, t, viewport_name)
	self._update_sound_listener(self, viewport_name)

	return 
end
CameraManager.force_update_nodes = function (self, dt, viewport_name)
	local node_trees = self._node_trees[viewport_name]
	local data = self._variables[viewport_name]

	for tree_id, tree in pairs(node_trees) do
		self._update_nodes(self, dt, viewport_name, tree_id, data)
	end

	return 
end
local SWEEP_EPSILON = 0.01
CameraManager._smooth_camera_collision = function (self, camera_position, safe_position, smooth_radius, near_radius)
	local physics_world = World.get_data(self._world, "physics_world")
	local cast_from = safe_position
	local cast_to = camera_position
	local dir = Vector3.normalize(cast_to - cast_from)
	local len = Vector3.length(cast_to - cast_from)
	local cast_distance = len
	local cast_radius = smooth_radius

	if len < cast_radius then
		return cast_to
	end

	local drawer = nil

	if script_data.camera_debug then
		drawer = Managers.state.debug:drawer({
			name = "Intersection"
		})

		drawer.reset(drawer)
	end

	local hit_actors, num_hits = PhysicsWorld.immediate_overlap(physics_world, "shape", "sphere", "position", cast_from, "size", smooth_radius, "types", "statics", "collision_filter", "filter_camera_sweep", "use_global_table")

	if 0 < num_hits then
		if script_data.camera_debug then
			Application.warning("[CameraManager] Safe spot is intersecting with geometry")
		end

		return cast_from
	end

	while true do
		if cast_distance < SWEEP_EPSILON then
			return cast_from
		end

		self._hits = PhysicsWorld.linear_sphere_sweep(physics_world, cast_from, cast_to, cast_radius, 1, "types", "statics", "collision_filter", "filter_camera_sweep")
		local hits = self._hits
		local hit = nil

		if hits and 0 < #hits then
			if script_data.camera_debug then
				local last_pos = cast_from

				for _, k in ipairs(hits) do
					local dir = Vector3.normalize(k.position - last_pos)
					local length = Vector3.length(last_pos - k.position)

					drawer.vector(drawer, last_pos, k.position - last_pos, Color(0, 255, 0))
					drawer.sphere(drawer, k.position, 0.1, Color(0, 255, 0))

					last_pos = k.position
				end
			end

			hit = hits[1]
			local x = Vector3.dot(dir, hit.position - cast_from)
			local y = Vector3.length(hit.position - cast_from - x*dir)

			if y == 0 then
				return hit.position
			end

			local cd = nil

			if y < near_radius then
				cd = x - cast_radius
			else
				cd = (x + (y - near_radius)/(smooth_radius - near_radius)*(len - x)) - cast_radius
			end

			if cd < cast_distance then
				cast_distance = cd
				cast_to = cast_from + dir*cast_distance
			end

			if cast_radius - y < 0.05 then
				cast_radius = math.max(cast_radius - 0.05, near_radius)
			else
				cast_radius = math.max(y, near_radius)
			end
		elseif script_data.camera_debug then
			drawer.sphere(drawer, cast_to, 0.2, Color(0, 0, 255))
		end

		return cast_to
	end

	return 
end
CameraManager._update_nodes = function (self, dt, viewport_name, tree_id, data)
	local tree = self._node_trees[viewport_name][tree_id]
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self._current_node(self, camera_nodes)

	tree.root_node:update(dt, data, current_node.pitch_speed(current_node), current_node.yaw_speed(current_node))

	return 
end
CameraManager._current_node = function (self, camera_nodes)
	return camera_nodes[#camera_nodes].node
end
CameraManager.camera_effect_sequence_event = function (self, event, start_time)
	local sequence_event_settings = self._sequence_event_settings
	local previous_values = nil

	if sequence_event_settings.event then
		previous_values = sequence_event_settings.current_values
	end

	sequence_event_settings.start_time = start_time
	sequence_event_settings.event = CameraEffectSettings.sequence[event]
	sequence_event_settings.transition_function = CameraEffectSettings.transition_functions.lerp
	local duration = 0

	for modifier_type, modifiers in pairs(sequence_event_settings.event.values) do
		for index, settings in ipairs(modifiers) do
			if duration < settings.time_stamp then
				duration = settings.time_stamp
			end
		end
	end

	sequence_event_settings.end_time = start_time + duration

	if previous_values then
		fassert(0 < duration, "Camera effect sequence duration is %f", duration)

		local recuperate_percentage = sequence_event_settings.event.time_to_recuperate_to

		fassert(0 < recuperate_percentage, "Camera effect sequence time_to_recuperate_to is %f", recuperate_percentage)

		local time_to_recover = recuperate_percentage/100*duration
		sequence_event_settings.time_to_recover = time_to_recover
		sequence_event_settings.recovery_values = self._calculate_sequence_event_values_normal(self, sequence_event_settings.event.values, time_to_recover)
		sequence_event_settings.previous_values = previous_values
	end

	return 
end
CameraManager.camera_effect_shake_event = function (self, event, start_time, scale)
	if Application.user_setting("disable_camera_shake") then
		return 
	end

	local data = {}
	local event = CameraEffectSettings.shake[event]
	local duration = event.duration
	local fade_in = event.fade_in
	local fade_out = event.fade_out
	duration = (duration or 0) + (fade_in or 0) + (fade_out or 0)
	data.event = event
	data.start_time = start_time
	data.end_time = duration and start_time + duration
	data.fade_in_time = fade_in and start_time + fade_in
	data.fade_out_time = fade_out and data.end_time - fade_out
	data.seed = event.seed or Math.random(1, 100)
	data.scale = scale or 1
	self._shake_event_settings[data] = true

	return data
end
CameraManager.stop_camera_effect_shake_event = function (self, id)
	self._shake_event_settings[id] = nil

	return 
end
CameraManager._update_camera = function (self, dt, t, viewport_name)
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local shadow_cull_camera = ScriptViewport.shadow_cull_camera(viewport)
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self._current_node(self, camera_nodes)
	local camera_data = self._update_transition(self, viewport_name, camera_nodes, dt)

	if self._sequence_event_settings.event then
		camera_data = self._apply_sequence_event(self, table.clone(camera_data), t)
	end

	for settings, _ in pairs(self._shake_event_settings) do
		camera_data = self._apply_shake_event(self, settings, table.clone(camera_data), t)
	end

	self._update_camera_properties(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
	ScriptCamera.force_update(self._world, camera)

	if GameSettingsDevelopment.simple_first_person then
		local camera_unit = Camera.get_data(camera, "unit")

		World.update_unit(self._world, camera_unit)

		local rig_unit = Unit.get_data(camera_unit, "rig_unit")

		if Unit.alive(rig_unit) then
			World.update_unit(self._world, rig_unit)
		end
	end

	return 
end
CameraManager._apply_sequence_event = function (self, current_data, t)
	local sequence_event_settings = self._sequence_event_settings
	local new_values = nil
	local time_to_recover = sequence_event_settings.time_to_recover
	local start_time = sequence_event_settings.start_time

	if t < time_to_recover + start_time then
		new_values = self._calculate_sequence_event_values_recovery(self, t)
	else
		local total_progress = t - sequence_event_settings.start_time
		local event_values = sequence_event_settings.event.values
		new_values = self._calculate_sequence_event_values_normal(self, event_values, total_progress)
	end

	local new_data = current_data
	new_data.position = self._calculate_sequence_event_position(self, current_data, new_values)
	new_data.rotation = self._calculate_sequence_event_rotation(self, current_data, new_values)
	sequence_event_settings.current_values = new_values

	if self._sequence_event_settings.end_time <= t then
		sequence_event_settings.start_time = 0
		sequence_event_settings.end_time = 0
		sequence_event_settings.event = nil
		sequence_event_settings.current_values = nil
		sequence_event_settings.time_to_recover = 0
		sequence_event_settings.recovery_values = nil
		sequence_event_settings.transition_function = nil
	end

	return new_data
end
CameraManager._calculate_sequence_event_values_recovery = function (self, t)
	local new_values = {
		yaw = 0,
		z = 0,
		roll = 0,
		y = 0,
		pitch = 0,
		x = 0
	}
	local sequence_event_settings = self._sequence_event_settings
	local time_to_recover = sequence_event_settings.time_to_recover

	if time_to_recover <= 0 then
		table.dump(sequence_event_settings)
		fassert(false, "time to recover is less than 0")
	end

	local starting_values = sequence_event_settings.previous_values
	local recovery_values = sequence_event_settings.recovery_values
	local start_time = sequence_event_settings.start_time
	local progress = (t - start_time)/time_to_recover

	for modifier, value in pairs(starting_values) do
		new_values[modifier] = math.lerp(value, recovery_values[modifier], progress)
	end

	return new_values
end
CameraManager._calculate_sequence_event_values_normal = function (self, event_values, total_progress)
	local new_values = {
		yaw = 0,
		z = 0,
		roll = 0,
		y = 0,
		pitch = 0,
		x = 0
	}

	for modifier_type, modifiers in pairs(event_values) do
		for index, settings in ipairs(modifiers) do
			if total_progress < settings.time_stamp then
				local next_settings = settings
				local current_settings = modifiers[index - 1] or CameraEffectSettings.empty_modifier_settings
				local progress = total_progress - current_settings.time_stamp
				local time_stamp_difference = next_settings.time_stamp - current_settings.time_stamp

				if time_stamp_difference == 0 then
					table.dump(current_settings, "current settings")
					table.dump(next_settings, "next_settings")
					assert(false, "Time stamp difference is 0, this would result in a div0")
				end

				local lerp_progress = progress/time_stamp_difference
				new_values[modifier_type] = self._sequence_event_settings.transition_function(current_settings.value, next_settings.value, lerp_progress)

				break
			end
		end
	end

	return new_values
end
CameraManager._calculate_sequence_event_position = function (self, current_data, new_values)
	local current_pos = current_data.position
	local current_rot = current_data.rotation
	local x = new_values.x*Quaternion.right(current_rot)
	local y = new_values.y*Quaternion.forward(current_rot)
	local z = Vector3(0, 0, new_values.z)

	return current_pos + x + y + z
end
CameraManager._calculate_sequence_event_rotation = function (self, current_data, new_values)
	local current_rot = current_data.rotation
	local deg_to_rad = math.pi/180
	local yaw_offset = Quaternion(Vector3.up(), new_values.yaw*deg_to_rad)
	local pitch_offset = Quaternion(Vector3.right(), new_values.pitch*deg_to_rad)
	local roll_offset = Quaternion(Vector3.forward(), new_values.roll*deg_to_rad)
	local total_offset = Quaternion.multiply(Quaternion.multiply(yaw_offset, pitch_offset), roll_offset)

	return Quaternion.multiply(current_rot, total_offset)
end
CameraManager._apply_shake_event = function (self, settings, current_data, t)
	local shake_event_settings = self._shake_event_settings
	local start_time = settings.start_time
	local end_time = settings.end_time
	local fade_in_time = settings.fade_in_time
	local fade_out_time = settings.fade_out_time

	if fade_in_time and t <= fade_in_time then
		settings.fade_progress = math.clamp((t - start_time)/(fade_in_time - start_time), 0, 1)
	elseif fade_out_time and fade_out_time <= t then
		settings.fade_progress = math.clamp((end_time - t)/(end_time - fade_out_time), 0, 1)
	end

	local pitch_noise_value = self._calculate_perlin_value(self, t - settings.start_time, settings)*settings.scale
	local yaw_noise_value = self._calculate_perlin_value(self, t - settings.start_time + 10, settings)*settings.scale
	local new_data = current_data
	local current_rot = current_data.rotation
	local deg_to_rad = math.pi/180
	local yaw_offset = Quaternion(Vector3.up(), yaw_noise_value*deg_to_rad)
	local pitch_offset = Quaternion(Vector3.right(), pitch_noise_value*deg_to_rad)
	local total_offset = Quaternion.multiply(yaw_offset, pitch_offset)
	new_data.rotation = Quaternion.multiply(current_rot, total_offset)

	if settings.end_time and settings.end_time <= t then
		shake_event_settings[settings] = nil
	end

	return new_data
end
CameraManager._calculate_perlin_value = function (self, x, settings)
	local total = 0
	local event_settings = settings.event
	local persistance = event_settings.persistance
	local number_of_octaves = event_settings.octaves

	for i = 0, number_of_octaves, 1 do
		local frequency = 2^i
		local amplitude = persistance^i
		total = total + self._interpolated_noise(self, x*frequency, settings)*amplitude
	end

	local amplitude_multiplier = event_settings.amplitude or 1
	local fade_multiplier = settings.fade_progress or 1
	total = total*amplitude_multiplier*fade_multiplier

	return total
end
CameraManager._interpolated_noise = function (self, x, settings)
	local x_floored = math.floor(x)
	local remainder = x - x_floored
	local v1 = self._smoothed_noise(self, x_floored, settings)
	local v2 = self._smoothed_noise(self, x_floored + 1, settings)

	return math.lerp(v1, v2, remainder)
end
CameraManager._smoothed_noise = function (self, x, settings)
	return self._noise(self, x, settings)/2 + self._noise(self, x - 1, settings)/4 + self._noise(self, x + 1, settings)/4
end
CameraManager._noise = function (self, x, settings)
	local next_seed, _ = Math.next_random(x + settings.seed)
	local _, value = Math.next_random(next_seed)

	return value*2 - 1
end
CameraManager.apply_level_particle_effects = function (self, effects, viewport_name)
	for _, effect in ipairs(effects) do
		local world = self._world
		local effect_id = World.create_particles(world, effect, self.camera_position(self, viewport_name))
		self._level_particle_effect_ids[effect_id] = true
	end

	return 
end
CameraManager.apply_level_screen_effects = function (self, effects, viewport_name)
	for _, effect in ipairs(effects) do
		local world = self._world
		local effect_id = World.create_particles(world, effect, Vector3(0, 0, 0))
		self._level_screen_effect_ids[effect_id] = true
	end

	return 
end
CameraManager._update_camera_properties = function (self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
	if camera_data.position then
		local root_unit, root_object = current_node.root_unit(current_node)
		local pos = camera_data.position

		if root_unit and Unit.alive(root_unit) then
			local safe_position_offset = current_node.safe_position_offset(current_node)
			local safe_pos = Unit.world_position(root_unit, (root_object and Unit.node(root_unit, root_object)) or 0) + safe_position_offset.unbox(safe_position_offset)
			pos = self._smooth_camera_collision(self, camera_data.position, safe_pos, 0.35, 0.25)
		end

		if script_data.camera_debug and Managers.state.debug then
			local drawer = Managers.state.debug:drawer({
				name = "CameraManager"
			})

			if DebugKeyHandler.key_pressed("z", "clear camera debug") then
				drawer.reset(drawer)
			end

			drawer.sphere(drawer, pos, 0.1)
		end

		ScriptCamera.set_local_position(camera, pos)
		TerrainDecoration.move_observer(self._world, self._terrain_decoration_observers[viewport_name], pos)
		ScatterSystem.move_observer(self._scatter_system, self._scatter_system_observers[viewport_name], pos, camera_data.rotation)

		local physics_world = World.get_data(self._world, "physics_world")

		if physics_world and PhysicsWorld.set_observer then
			PhysicsWorld.set_observer(physics_world, Matrix4x4.from_quaternion_position(camera_data.rotation, pos))
		end
	end

	if camera_data.yaw_speed then
		self._variables[viewport_name].yaw_speed = camera_data.yaw_speed
	end

	if camera_data.pitch_offset then
		self._variables[viewport_name].pitch_offset = camera_data.pitch_offset
	end

	if camera_data.pitch_speed then
		self._variables[viewport_name].pitch_speed = camera_data.pitch_speed
	end

	if camera_data.rotation then
		ScriptCamera.set_local_rotation(camera, camera_data.rotation)
	end

	if script_data.fov_override then
		Camera.set_vertical_fov(shadow_cull_camera, (math.pi*script_data.fov_override)/180)
		Camera.set_vertical_fov(camera, (math.pi*script_data.fov_override)/180)
	elseif camera_data.vertical_fov then
		local vertical_fov = camera_data.vertical_fov

		if current_node.should_apply_fov_multiplier(current_node) then
			Camera.set_vertical_fov(camera, vertical_fov*self._fov_multiplier)
			Camera.set_vertical_fov(shadow_cull_camera, current_node.default_fov(current_node))
		else
			Camera.set_vertical_fov(camera, vertical_fov)
			Camera.set_vertical_fov(shadow_cull_camera, current_node.default_fov(current_node))
		end

		if script_data.camera_debug and Managers.state.debug then
			local fov_text = string.format("Vertical FOV: %s", (vertical_fov*180)/math.pi)

			Debug.text(fov_text)
		end
	end

	if camera_data.near_range then
		Camera.set_near_range(camera, camera_data.near_range)
		Camera.set_near_range(shadow_cull_camera, camera_data.near_range)
	end

	if camera_data.far_range then
		Camera.set_far_range(camera, camera_data.far_range)
		Camera.set_far_range(shadow_cull_camera, camera_data.far_range)
	end

	if camera_data.fade_to_black then
		self._variables[viewport_name].fade_to_black = camera_data.fade_to_black
	end

	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	self._shading_environment[viewport] = camera_data.shading_environment

	return 
end
CameraManager._update_sound_listener = function (self, viewport_name)
	local world = self._world
	local pose = self.listener_pose(self, viewport_name)
	local wwise_world = Managers.world:wwise_world(world)

	WwiseWorld.set_listener(wwise_world, 0, pose)

	local position = Matrix4x4.translation(pose)
	local scale = self._listener_elevation_scale
	local offset = self._listener_elevation_offset
	local min = self._listener_elevation_min
	local max = self._listener_elevation_max
	local elevation = math.clamp((position.z - offset)*scale, min, max)

	if script_data.debug_wwise_elevation then
		Debug.text("Elevation: %f", elevation)
		Debug.text("")
		Debug.text("Current z position: %f", position.z)
		Debug.text("Offset z: %f", offset)
		Debug.text("Scale: %f", scale)
		Debug.text("Min: %f", min)
		Debug.text("Max: %f", max)
	end

	WwiseWorld.set_global_parameter(wwise_world, "lua_elevation", elevation)

	return 
end
CameraManager.listener_pose = function (self, viewport_name)
	local world = self._world
	local viewport = ScriptWorld.viewport(world, viewport_name, true)
	local camera = ScriptViewport.camera(viewport)
	local pose = Camera.world_pose(camera)

	return pose
end
CameraManager._add_transition = function (self, viewport_name, from_node, to_node, transition_template)
	local transition = {}

	for _, property in ipairs(self.NODE_PROPERTY_MAP) do
		local settings = transition_template[property]

		if settings then
			local duration = settings.duration
			local speed = settings.speed
			local transition_class = rawget(_G, settings.class)
			local instance = transition_class.new(transition_class, from_node.node, to_node.node, duration, speed, settings)
			transition[property] = instance
		end
	end

	to_node.transition = transition

	return 
end
CameraManager._update_transition = function (self, viewport_name, nodes, dt)
	local values = self._property_temp_table

	table.clear(values)

	local value = nil
	local node_property_map = self.NODE_PROPERTY_MAP

	for _prop_index, property in ipairs(node_property_map) do
		for _node_index, node_table in ipairs(nodes) do
			local transition = node_table.transition
			local transition_class = transition[property]

			if transition_class then
				local done = nil
				local update_time = _node_index == #nodes
				value, done = transition_class.update(transition_class, dt, value, update_time)

				if done then
					transition[property] = nil
				end
			else
				value = node_table.node[property](node_table.node)
			end
		end

		values[property] = value
		value = nil
	end

	local remove_from_index = nil

	for index, node_table in ipairs(nodes) do
		if not next(node_table.transition) then
			remove_from_index = index - 1
		end
	end

	if remove_from_index and 0 < remove_from_index then
		self._remove_camera_node(self, nodes, remove_from_index)
	end

	return values
end

return 