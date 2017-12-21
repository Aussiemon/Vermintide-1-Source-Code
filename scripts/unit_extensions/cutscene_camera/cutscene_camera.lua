CutsceneCamera = class(CutsceneCamera)
CutsceneCamera.init = function (self, extension_init_context, unit, extension_init_data)
	local world = extension_init_context.world
	self.level = LevelHelper:current_level(world)
	self.unit = unit
	self.camera = Unit.camera(self.unit, "camera")
	self.viewport = "player_1"
	self.source_camera = nil
	self.target_camera = nil
	self.transition_start_time = nil
	self.transition_end_time = nil
	local near_range = Unit.get_data(self.unit, "near_range") or 0.1
	local far_range = Unit.get_data(self.unit, "far_range") or 1000

	Camera.set_near_range(self.camera, near_range)
	Camera.set_far_range(self.camera, far_range)

	return 
end
CutsceneCamera.destroy = function (self)
	self.level = nil
	self.unit = nil
	self.camera = nil
	self.source_camera = nil
	self.target_camera = nil

	return 
end
CutsceneCamera.activate = function (self, transition_data)
	local transition = transition_data.transition
	local source_camera, target_camera, transition_start_time, transition_end_time = nil

	if transition == "NONE" then
		source_camera = self
	end

	if transition == "PLAYER_TO_CUTSCENE" then
		local external_camera = self.setup_external_camera(self, transition, "first_person", "first_person_node")
		local time = Managers.time:time("game")
		source_camera = external_camera
		target_camera = self
		transition_start_time = time + (transition_data.transition_start_time or 0)
		transition_end_time = transition_start_time + transition_data.transition_length
	end

	if transition == "CUTSCENE_TO_PLAYER" then
		local external_camera = self.setup_external_camera(self, transition, "first_person", "first_person_node")
		local time = Managers.time:time("game")
		source_camera = self
		target_camera = external_camera
		transition_start_time = time + (transition_data.transition_start_time or 0)
		transition_end_time = transition_start_time + transition_data.transition_length
	end

	self.source_camera = source_camera
	self.target_camera = target_camera
	self.transition_start_time = transition_start_time
	self.transition_end_time = transition_end_time

	return 
end
CutsceneCamera.setup_external_camera = function (self, transition, tree_name, node_name)
	local camera_manager = Managers.state.camera
	local camera_node = camera_manager.tree_node(camera_manager, self.viewport, tree_name, node_name)

	camera_node.set_active(camera_node, true)
	camera_manager.force_update_nodes(camera_manager, 0, self.viewport)

	return camera_node
end
CutsceneCamera.update = function (self)
	self.update_cutscene_camera(self)

	return 
end
CutsceneCamera.update_cutscene_camera = function (self)
	local source_camera = self.source_camera
	local target_camera = self.target_camera
	local pose, vertical_fov, near_range, far_range = nil

	if target_camera then
		local time = Managers.time:time("game")
		local progress = self.transition_progress(self, self.transition_start_time, self.transition_end_time, time)
		pose = Matrix4x4.lerp(source_camera.pose(source_camera), target_camera.pose(target_camera), progress)
		vertical_fov = math.lerp(source_camera.vertical_fov(source_camera), target_camera.vertical_fov(target_camera), progress)
		near_range = math.lerp(source_camera.near_range(source_camera), target_camera.near_range(target_camera), progress)
		far_range = math.lerp(source_camera.far_range(source_camera), target_camera.far_range(target_camera), progress)
	else
		pose = source_camera.pose(source_camera)
		vertical_fov = source_camera.vertical_fov(source_camera)
		near_range = source_camera.near_range(source_camera)
		far_range = source_camera.far_range(source_camera)
	end

	local camera_manager = Managers.state.camera
	local viewport = self.viewport

	camera_manager.set_node_tree_root_position(camera_manager, viewport, "cutscene", Matrix4x4.translation(pose))
	camera_manager.set_node_tree_root_rotation(camera_manager, viewport, "cutscene", Matrix4x4.rotation(pose))
	camera_manager.set_node_tree_root_vertical_fov(camera_manager, viewport, "cutscene", vertical_fov)
	camera_manager.set_node_tree_root_near_range(camera_manager, viewport, "cutscene", near_range)
	camera_manager.set_node_tree_root_far_range(camera_manager, viewport, "cutscene", far_range)
	camera_manager.set_camera_node(camera_manager, viewport, "cutscene", "root_node")

	return 
end
CutsceneCamera.transition_progress = function (self, start_time, end_time, time)
	local progress = nil
	local interpolation_time = end_time - start_time

	if interpolation_time <= 0.001 then
		progress = 1
	else
		progress = math.clamp((time - start_time)/interpolation_time, 0, 1)
		progress = (progress*2 - 3)*progress^2
	end

	return progress
end
CutsceneCamera.pose = function (self)
	return Unit.world_pose(self.unit, 0)
end
CutsceneCamera.vertical_fov = function (self)
	return Camera.vertical_fov(self.camera)
end
CutsceneCamera.near_range = function (self)
	return Camera.near_range(self.camera)
end
CutsceneCamera.far_range = function (self)
	return Camera.far_range(self.camera)
end

return 
