PlayerEyeTrackingExtension = class(PlayerEyeTrackingExtension)

PlayerEyeTrackingExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.physics_world = World.get_data(self.world, "physics_world")
	self.unit = unit
	self.smooth_gaze = {
		0.5,
		0.5
	}
	self.smooth_forward = Vector3Box()
	self.current_gaze_forward = Vector3Box()

	self.smooth_forward:store(Vector3.forward())
	self.current_gaze_forward:store(Vector3.forward())

	self.had_tobii = false
	self.aim_gaze_data = {
		pitch_offset = 0,
		yaw_offset = 0
	}
end

PlayerEyeTrackingExtension.update = function (self, unit, input, dt, context, t)
	local user_setting = Application.user_setting
	local HAS_TOBII = rawget(_G, "Tobii") and Tobii.device_status() == Tobii.DEVICE_TRACKING and user_setting("tobii_eyetracking")
	local had_tobii = self.had_tobii
	self.had_tobii = HAS_TOBII

	if not HAS_TOBII then
		if had_tobii then
			self:reset_aim()
		end

		return
	end

	self:update_forward_rayhit()
	self:calc_gaze_forward()
	self:calc_smooth_gaze_forward()
	self:update_gaze_aim(dt)
end

PlayerEyeTrackingExtension.reset_aim = function (self)
	local first_person_extension = ScriptUnit.extension(self.unit, "first_person_system")
	local new_target = first_person_extension:current_position() + Quaternion.forward(first_person_extension:current_rotation())

	first_person_extension:set_aim_constraint_target("tobii_aim", new_target)
	first_person_extension:play_animation_event("tobii_aim_inactive")

	self.fire_at_gaze_enabled = false
end

PlayerEyeTrackingExtension.calc_gaze_forward = function (self)
	local first_person_extension = ScriptUnit.extension(self.unit, "first_person_system")
	local HAS_TOBII = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking")

	if not HAS_TOBII or Tobii.user_presence() ~= Tobii.USER_PRESENT or Tobii.device_status() ~= Tobii.DEVICE_TRACKING then
		self.current_gaze_forward:store(Quaternion.forward(first_person_extension:current_rotation()))

		return
	end

	local gaze_point_x, gaze_point_y = Tobii.get_gaze_point()
	local screen_width = RESOLUTION_LOOKUP.res_w
	local screen_height = RESOLUTION_LOOKUP.res_h
	local gaze_x = screen_width * (1 - gaze_point_x)
	local gaze_y = screen_height * gaze_point_y
	local player = Managers.player:owner(self.unit)
	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local gaze_in_world = Camera.screen_to_world(camera, Vector3(gaze_x, gaze_y, 0), 0.1)
	local current_position = first_person_extension:current_position()
	local forward = Vector3.normalize(gaze_in_world - current_position)

	self.current_gaze_forward:store(forward)
end

PlayerEyeTrackingExtension.gaze_forward = function (self)
	return self.current_gaze_forward:unbox()
end

PlayerEyeTrackingExtension.world_position_in_screen = function (self, world_pos)
	local player = Managers.player:owner(self.unit)
	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local position_in_screen = Camera.world_to_screen(camera, world_pos)

	return position_in_screen
end

PlayerEyeTrackingExtension.gaze_rotation = function (self)
	local forward = self:gaze_forward()

	return Quaternion.look(forward, Vector3.up())
end

PlayerEyeTrackingExtension.calc_smooth_gaze_forward = function (self)
	local first_person_extension = ScriptUnit.extension(self.unit, "first_person_system")
	local HAS_TOBII = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking")

	if not HAS_TOBII or Tobii.user_presence() ~= Tobii.USER_PRESENT or Tobii.device_status() ~= Tobii.DEVICE_TRACKING then
		self.smooth_forward:store(Quaternion.forward(first_person_extension:current_rotation()))

		return
	end

	local gaze_point_x = self.smooth_gaze[1]
	local gaze_point_y = self.smooth_gaze[2]
	local screen_width = RESOLUTION_LOOKUP.res_w
	local screen_height = RESOLUTION_LOOKUP.res_h
	local gaze_x = screen_width * (1 - gaze_point_x)
	local gaze_y = screen_height * gaze_point_y
	local player = Managers.player:owner(self.unit)
	local viewport_name = player.viewport_name
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local gaze_in_world = Camera.screen_to_world(camera, Vector3(gaze_x, gaze_y, 0), 0.1)
	local current_position = first_person_extension:current_position()
	local forward = Vector3.normalize(gaze_in_world - current_position)

	self.smooth_forward:store(forward)
end

PlayerEyeTrackingExtension.get_smooth_gaze_forward = function (self)
	return self.smooth_forward:unbox()
end

PlayerEyeTrackingExtension.set_smoothed_gaze = function (self, gaze_x, gaze_y)
	self.smooth_gaze[1] = gaze_x
	self.smooth_gaze[2] = gaze_y
end

local deg_to_rad = math.pi / 180

PlayerEyeTrackingExtension.update_gaze_aim = function (self, dt)
	local user_setting = Application.user_setting
	local inventory_extension = ScriptUnit.extension(self.unit, "inventory_system")
	local equipment = inventory_extension:equipment()
	local wielded_item_data = equipment.wielded
	local item_template = BackendUtils.get_item_template(wielded_item_data)
	local weapon_unit = equipment.right_hand_wielded_unit or equipment.left_hand_wielded_unit
	local fire_at_gaze_setting = item_template.fire_at_gaze_setting

	if weapon_unit then
		local weapon_extension = ScriptUnit.extension(weapon_unit, "weapon_system")

		if weapon_extension:has_current_action() then
			local action_settings = weapon_extension:get_current_action_settings()

			if action_settings.fire_at_gaze_setting then
				fire_at_gaze_setting = action_settings.fire_at_gaze_setting
			end
		end
	end

	fire_at_gaze_setting = fire_at_gaze_setting and user_setting(fire_at_gaze_setting)
	local first_person_extension = ScriptUnit.extension(self.unit, "first_person_system")

	if fire_at_gaze_setting and not self.fire_at_gaze_enabled then
		first_person_extension:play_animation_event("tobii_aim_active")

		self.fire_at_gaze_enabled = true
	elseif not fire_at_gaze_setting and self.fire_at_gaze_enabled then
		self.fire_at_gaze_enabled = false
		local new_target = first_person_extension:current_position() + Quaternion.forward(first_person_extension:current_rotation())

		first_person_extension:set_aim_constraint_target("tobii_aim", new_target)
		first_person_extension:play_animation_event("tobii_aim_inactive")
	end

	local has_device = Tobii.device_status() == Tobii.DEVICE_TRACKING
	local has_presence = Tobii.user_presence() == Tobii.USER_PRESENT

	if (not has_device or not has_presence) and self.fire_at_gaze_enabled then
		local new_target = first_person_extension:current_position() + Quaternion.forward(first_person_extension:current_rotation())

		first_person_extension:set_aim_constraint_target("tobii_aim", new_target)
		first_person_extension:play_animation_event("tobii_aim_inactive")

		self.fire_at_gaze_enabled = false
	elseif self.fire_at_gaze_enabled then
		local gaze_x, gaze_y = Tobii.get_gaze_point()
		gaze_x = (gaze_x - 0.5) * 2
		gaze_y = (gaze_y - 0.5) * 2
		local curve_deadzone = 0.2
		local curve_slope = 2.5
		local curve_shoulder = 0.4
		local transformedX = TobiiCurve(gaze_x, curve_slope, curve_shoulder, curve_deadzone)
		local transformedY = TobiiCurve(gaze_y, curve_slope, curve_shoulder, curve_deadzone)
		local speed = 5
		local base_fov = CameraSettings.first_person._node.vertical_fov
		local fov = Application.user_setting("render_settings", "fov") or base_fov
		local maxYaw = fov / 3
		local maxPitch = nil

		if gaze_y > 0 then
			maxPitch = 15
		else
			maxPitch = 5
		end

		local is_enabled = user_setting("tobii_extended_view")

		if is_enabled then
			maxYaw = maxYaw + user_setting("tobii_extended_view_max_yaw") / 2
			maxPitch = maxPitch + ((gaze_y > 0 and user_setting("tobii_extended_view_max_pitch_up")) or user_setting("tobii_extended_view_max_pitch_down")) * 0.5
		end

		local data = self.aim_gaze_data
		local deltaX = transformedX * maxYaw - data.yaw_offset
		local deltaY = transformedY * maxPitch - data.pitch_offset
		data.yaw_offset = data.yaw_offset + deltaX * dt * speed
		data.pitch_offset = data.pitch_offset + deltaY * dt * speed
		local yaw_offset = Quaternion(Vector3.up(), data.yaw_offset * deg_to_rad)
		local rotation = first_person_extension:current_rotation()
		yaw_offset = Quaternion.multiply(Quaternion.inverse(rotation), yaw_offset)
		yaw_offset = Quaternion.multiply(yaw_offset, rotation)
		local pitch_offset = Quaternion(Vector3.right(), data.pitch_offset * deg_to_rad)
		local total_offset = Quaternion.multiply(yaw_offset, pitch_offset)
		local new_rotation = Quaternion.multiply(rotation, total_offset)
		local new_target = first_person_extension:current_position() + Quaternion.forward(new_rotation)

		first_person_extension:set_aim_constraint_target("tobii_aim", new_target)
	end
end

PlayerEyeTrackingExtension.update_forward_rayhit = function (self)
	local is_enabled = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking")
	is_enabled = is_enabled and Tobii.device_status() == Tobii.DEVICE_TRACKING
	is_enabled = is_enabled and Tobii.user_presence() == Tobii.USER_PRESENT

	if not is_enabled then
		self.forward_rayhit_position = nil

		return
	end

	local first_person_extension = ScriptUnit.extension(self.unit, "first_person_system")
	local cam_position = first_person_extension:current_position()
	local cam_rotation = first_person_extension:current_rotation()
	local cam_forward = Quaternion.forward(cam_rotation)
	local found_collision, world_pos = self.physics_world:immediate_raycast(cam_position + cam_forward, cam_forward, 100, "closest", "collision_filter", "filter_ray_ping")

	if not found_collision then
		world_pos = cam_position + cam_forward
	end

	if self.forward_rayhit_position then
		self.forward_rayhit_position:store(world_pos)
	else
		self.forward_rayhit_position = Vector3Box(world_pos)
	end
end

PlayerEyeTrackingExtension.get_forward_rayhit = function (self)
	return (self.forward_rayhit_position and self.forward_rayhit_position:unbox()) or nil
end

return
