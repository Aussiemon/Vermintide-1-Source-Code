CameraStateHelper = CameraStateHelper or {}
CameraStateHelper.set_local_pose = function (camera_unit, unit, node)
	local pose = Unit.local_pose(unit, node)
	local current_node = node

	while current_node ~= 0 do
		local parent_node = Unit.scene_graph_parent(unit, current_node)
		pose = Matrix4x4.multiply(pose, Unit.local_pose(unit, parent_node))
		current_node = parent_node
	end

	Unit.set_local_pose(camera_unit, 0, pose)

	return 
end

return 