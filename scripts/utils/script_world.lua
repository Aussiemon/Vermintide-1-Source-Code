if PLATFORM == "win32" then
end

ScriptWorld.foundation_create_viewport = ScriptWorld.create_viewport
ScriptWorld.create_viewport = function (world, name, template, layer, position, rotation, add_shadow_cull_camera, force_no_scaling)
	local viewports = World.get_data(world, "viewports")

	fassert(viewports[name] == nil, "Viewport %q already exists", name)

	local viewport = Application.create_viewport(world, template)

	Viewport.set_data(viewport, "layer", layer or 1)
	Viewport.set_data(viewport, "active", true)
	Viewport.set_data(viewport, "name", name)

	viewports[name] = viewport

	if force_no_scaling then
		Viewport.set_data(viewport, "no_scaling", true)
	end

	local splitscreen = Managers.splitscreen and Managers.splitscreen:active()

	if splitscreen and not force_no_scaling then
		Viewport.set_data(viewport, "rect", {
			SPLITSCREEN_OFFSET_X,
			SPLITSCREEN_OFFSET_Y,
			SPLITSCREEN_WIDTH,
			SPLITSCREEN_HEIGHT
		})
	else
		Viewport.set_data(viewport, "rect", {
			0,
			0,
			1,
			1
		})
	end

	Viewport.set_rect(viewport, unpack(Viewport.get_data(viewport, "rect")))

	local camera_unit = nil

	if position and rotation then
		camera_unit = World.spawn_unit(world, "core/units/camera", position, rotation)
	elseif position then
		camera_unit = World.spawn_unit(world, "core/units/camera", position)
	else
		camera_unit = World.spawn_unit(world, "core/units/camera")
	end

	local camera = Unit.camera(camera_unit, "camera")

	Camera.set_data(camera, "unit", camera_unit)
	Viewport.set_data(viewport, "camera", camera)

	if add_shadow_cull_camera then
		local shadow_cull_camera = Unit.camera(camera_unit, "shadow_cull_camera")

		Camera.set_data(shadow_cull_camera, "unit", camera_unit)
		Viewport.set_data(viewport, "shadow_cull_camera", shadow_cull_camera)
	end

	ScriptWorld._update_render_queue(world)

	return viewport
end
ScriptWorld.render = function (world)
	local shading_env = World.get_data(world, "shading_environment")

	if not shading_env then
		return 
	end

	local global_free_flight_viewport = World.get_data(world, "global_free_flight_viewport")

	if global_free_flight_viewport then
		ShadingEnvironment.blend(shading_env, World.get_data(world, "shading_settings"))
		ShadingEnvironment.apply(shading_env)

		if World.has_data(world, "shading_callback") and not Viewport.get_data(global_free_flight_viewport, "avoid_shading_callback") then
			local callback = World.get_data(world, "shading_callback")

			callback(world, shading_env, World.get_data(world, "render_queue")[1])
		end

		local camera = ScriptViewport.camera(global_free_flight_viewport)

		Application.render_world(world, camera, global_free_flight_viewport, shading_env)
	elseif Bulldozer.rift then
		local render_queue = World.get_data(world, "render_queue")

		if table.is_empty(render_queue) then
			return 
		end

		local viewport = render_queue[1]
		local camera = ScriptViewport.camera(viewport)
		local camera_unit = Camera.get_data(camera, "unit")

		ShadingEnvironment.blend(shading_env, {
			"default",
			1
		})
		Camera.set_local_position(camera, camera_unit, Vector3(-Bulldozer.half_eye_shift, 0, 0))
		Camera.set_post_projection_transform(camera, Bulldozer.left_projection_transform:unbox())
		Viewport.set_rect(viewport, 0, 0, 0.5, 1)
		Application.render_world(world, camera, viewport, shading_env)
		Camera.set_local_position(camera, camera_unit, Vector3(Bulldozer.half_eye_shift, 0, 0))
		Camera.set_post_projection_transform(camera, Bulldozer.right_projection_transform:unbox())
		Viewport.set_rect(viewport, 0.5, 0, 0.5, 1)
		Application.render_world(world, camera, viewport, shading_env)
	else
		local render_queue = World.get_data(world, "render_queue")

		if table.is_empty(render_queue) then
			Application.update_render_world(world)

			return 
		end

		for _, viewport in ipairs(render_queue) do
			if not World.get_data(world, "avoid_blend") then
				ShadingEnvironment.blend(shading_env, World.get_data(world, "shading_settings"), World.get_data(world, "override_shading_settings"))
			end

			if World.has_data(world, "shading_callback") and not Viewport.get_data(viewport, "avoid_shading_callback") then
				local callback = World.get_data(world, "shading_callback")

				callback(world, shading_env, viewport)
			end

			if not World.get_data(world, "avoid_blend") then
				ShadingEnvironment.apply(shading_env)
			end

			local camera = ScriptViewport.camera(viewport)

			Application.render_world(world, camera, viewport, shading_env)
		end
	end

	return 
end

return 
