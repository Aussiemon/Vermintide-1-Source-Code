local DEFAULT_ANGLE = math.degrees_to_radians(0)
InventoryViewPreviewer = class(InventoryViewPreviewer)

InventoryViewPreviewer.init = function (self, ingame_ui_context)
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.input_manager = ingame_ui_context.input_manager
	self.character_unit = nil
	self.item_names = {}
	self.equipment_units = {
		[4] = {},
		[5] = {}
	}
end

InventoryViewPreviewer.destroy = function (self)
	GarbageLeakDetector.register_object(self, "InventoryViewPreviewer")
end

InventoryViewPreviewer.on_enter = function (self, viewport_widget)
	self.viewport_widget = viewport_widget
	local preview_pass_data = self.viewport_widget.element.pass_data[1]
	self.world = preview_pass_data.world
	self.viewport = preview_pass_data.viewport
	self.camera = ScriptViewport.camera(self.viewport)
	self.item_spawn_data = {}
	self.loaded_packages = {}
	self.packages_to_load = {}
	self.time_to_auto_rotate = 0
	self.time_to_auto_zoom = 0
	self.character_look_timer = self.character_look_timer or 0
	self.character_look_current = {
		0,
		3,
		1
	}
	self.character_look_target = {
		0,
		3,
		1
	}

	Application.set_render_setting("max_shadow_casting_lights", 16)

	local camera_position_current = ScriptCamera.position(self.camera)
	self.camera_xy_angle_current = DEFAULT_ANGLE
	self.camera_xy_angle_target = DEFAULT_ANGLE
	self.camera_height_current = camera_position_current.z
	self.camera_height_target = camera_position_current.z
	self.camera_lookat_height_current = 0.9
	self.camera_lookat_height_target = 0.9
	self.camera_distance_default = 2.6
	self.camera_distance_current = 2.6
	self.camera_distance_target = 2.6
	self.camera_distance_modifier = 1
	self.camera_zoom_lerp_t = 1
end

InventoryViewPreviewer.prepare_exit = function (self)
	self:clear_units()
end

InventoryViewPreviewer.on_exit = function (self)
	local max_shadow_casting_lights = Application.user_setting("render_settings", "max_shadow_casting_lights")

	Application.set_render_setting("max_shadow_casting_lights", max_shadow_casting_lights)

	local inventory_package_synchronizer = self.profile_synchronizer:inventory_package_synchronizer()
	local loaded_packages = self.loaded_packages
	local package_manager = Managers.package

	for package_name, _ in pairs(self.packages_to_load) do
		package_manager:unload(package_name, "InventoryViewPreviewer")

		self.packages_to_load[package_name] = nil
	end

	for package_name, _ in pairs(self.loaded_packages) do
		package_manager:unload(package_name, "InventoryViewPreviewer")

		self.loaded_packages[package_name] = nil
	end

	self.items_loaded = nil
end

InventoryViewPreviewer.update = function (self, dt)
	local character_unit = self.character_unit

	if character_unit == nil then
		return
	end

	local unit_pose, unit_extents = Unit.box(character_unit)
	self.camera_height_target = self.camera_lookat_height_target

	if self.camera_xy_angle_target > math.pi * 2 then
		self.camera_xy_angle_current = self.camera_xy_angle_current - math.pi * 2
		self.camera_xy_angle_target = self.camera_xy_angle_target - math.pi * 2
	end

	local character_xy_angle_new = math.lerp(self.camera_xy_angle_current, self.camera_xy_angle_target, 0.1)
	local camera_height_new = math.lerp(self.camera_height_current, self.camera_height_target, 0.1)
	local camera_lookat_height_new = math.lerp(self.camera_lookat_height_current, self.camera_lookat_height_target, 0.1)
	local camera_distance_new = math.lerp(self.camera_distance_current, self.camera_distance_target, 0.05)
	self.camera_xy_angle_current = character_xy_angle_new
	self.camera_height_current = camera_height_new
	self.camera_lookat_height_current = camera_lookat_height_new
	self.camera_distance_current = camera_distance_new
	local camera_position_new = Vector3.zero()
	camera_position_new.x = math.cos(1.57) * camera_distance_new
	camera_position_new.y = math.sin(1.57) * camera_distance_new
	camera_position_new.z = camera_height_new

	ScriptCamera.set_local_position(self.camera, camera_position_new)

	local player_rotation = Quaternion.axis_angle(Vector3(0, 0, 1), -character_xy_angle_new)

	Unit.set_local_rotation(character_unit, 0, player_rotation)

	local look_current = Vector3Aux.unbox(self.character_look_current)
	local aim_constraint_anim_var = Unit.animation_find_constraint_target(character_unit, "aim_constraint_target")
	local rotated_constraint_position = Quaternion.rotate(player_rotation, look_current)

	Unit.animation_set_constraint_target(character_unit, aim_constraint_anim_var, rotated_constraint_position)

	local lookat_target = Vector3(0, 0, camera_lookat_height_new)
	local direction = Vector3.normalize(lookat_target - camera_position_new)
	local rotation = Quaternion.look(direction)

	ScriptCamera.set_local_rotation(self.camera, rotation)

	self.time_to_auto_zoom = self.time_to_auto_zoom - dt

	if self.time_to_auto_zoom <= 0 then
		self.camera_distance_target = self.camera_distance_default
		self.camera_distance_target = 2.9
	end
end

local mouse_pos_temp = {}

InventoryViewPreviewer.handle_input = function (self, input_service)
	if not self.input_manager:is_device_active("mouse") then
		return
	end

	local hotspot_data = self.viewport_widget.content.button_hotspot

	if hotspot_data.is_hover then
		self.time_to_auto_rotate = math.huge
		self.time_to_auto_zoom = math.huge
	end

	local mouse = input_service:get("cursor")
	local hotspot_data = self.viewport_widget.content.button_hotspot

	if hotspot_data.on_double_click then
		self.camera_xy_angle_target = DEFAULT_ANGLE
	end

	if hotspot_data.is_hover or self.is_moving_camera then
		self.is_moving_camera = false
		local mouse_position = input_service:get("cursor")
		local mouse_hold = input_service:get("left_hold")
		local mouse_scroll = input_service:get("scroll_axis")

		if self.last_mouse_position and (mouse_hold or Vector3.length(mouse_scroll) > 0) then
			self.camera_xy_angle_target = self.camera_xy_angle_target - (mouse.x - self.last_mouse_position[1]) * 0.01
			local new_camera_look_height = self.camera_lookat_height_target - (mouse.y - self.last_mouse_position[2]) * 0.005
			self.camera_lookat_height_target = math.min(math.max(new_camera_look_height, 0.3), self.unit_max_look_height)
			self.camera_zoom_lerp_t = self.camera_zoom_lerp_t + mouse_scroll.y
			self.camera_distance_target = self.camera_distance_target - mouse_scroll.y
			self.camera_distance_target = math.max(self.camera_distance_target, 1.5)
			self.camera_distance_target = math.min(self.camera_distance_target, self.camera_distance_default)
			self.is_moving_camera = true
		end

		mouse_pos_temp[1] = mouse.x
		mouse_pos_temp[2] = mouse.y
		self.last_mouse_position = mouse_pos_temp
	else
		self.is_moving_camera = false
		self.last_mouse_pos = nil
	end
end

InventoryViewPreviewer.handle_controller_input = function (self, input_service, dt)
	if not self.input_manager:is_device_active("gamepad") then
		return
	end

	local move_left = input_service:get("trigger_left_soft")
	local move_right = input_service:get("trigger_right_soft")
	self.camera_xy_angle_target = self.camera_xy_angle_target + (move_left - move_right) * dt * 5
end

InventoryViewPreviewer.handle_character_preview_input = function (self)
	return
end

InventoryViewPreviewer.start_character_rotation = function (self, direction)
	if direction then
		self.rotation_direction = direction
	end
end

InventoryViewPreviewer.end_character_rotation = function (self)
	print("end_character_rotation", self.rotation_direction)
end

InventoryViewPreviewer.update_selected_character = function (self, profile_name)
	self:clear_units()

	local world = self.world
	local sp_profile = SPProfiles[FindProfileIndex(profile_name)]
	local skin_settings = Managers.unlock:get_skin_settings(profile_name)
	local unit_name = skin_settings.units.third_person.third_person
	local character_unit = World.spawn_unit(world, unit_name)
	self.character_unit = character_unit

	if Unit.has_lod_object(character_unit, "lod") then
		local lod_object = Unit.lod_object(character_unit, "lod")

		LODObject.set_static_select(lod_object, 0)
	end

	self.character_look_target = {
		0,
		3,
		1
	}
	self.character_look_current = self.character_look_target
	local look_target = Vector3Aux.unbox(self.character_look_target)
	local aim_constraint_anim_var = Unit.animation_find_constraint_target(character_unit, "aim_constraint_target")
	local look_direction_anim_var = Unit.animation_find_variable(character_unit, "aim_direction")
	local aim_direction_pitch_var = Unit.animation_find_variable(character_unit, "aim_direction_pitch")

	Unit.animation_set_constraint_target(character_unit, aim_constraint_anim_var, look_target)

	local unit_box, box_dimension = Unit.box(character_unit)

	if box_dimension then
		local default_unit_height_dimension = 1.7
		local default_diff = box_dimension.z - default_unit_height_dimension
		self.unit_max_look_height = (default_unit_height_dimension < box_dimension.z and 1.5) or 0.9
	else
		self.unit_max_look_height = 0.9
	end

	self.camera_distance_target = self.camera_distance_default
	self.camera_lookat_height_target = 0.9
	self.time_to_auto_rotate = math.huge
	self.time_to_auto_zoom = math.huge
end

InventoryViewPreviewer.wield_weapon_slot = function (self, slot_type)
	self.wielded_slot_type = slot_type

	if self.item_names.melee then
		self:equip_item(self.item_names.melee, "melee", 5)
	elseif slot_type == "melee" then
	end

	if self.item_names.ranged then
		self:equip_item(self.item_names.ranged, "ranged", 4)
	elseif slot_type == "ranged" then
	end
end

InventoryViewPreviewer.unequip_item_in_slot = function (self, item_slot_type, equipment_slot_index)
	local world = self.world

	if item_slot_type == "melee" or item_slot_type == "ranged" then
		local old_unit_right = self.equipment_units[equipment_slot_index].right

		if old_unit_right ~= nil then
			World.destroy_unit(world, old_unit_right)

			self.equipment_units[equipment_slot_index].right = nil
		end

		local old_unit_left = self.equipment_units[equipment_slot_index].left

		if old_unit_left ~= nil then
			World.destroy_unit(world, old_unit_left)

			self.equipment_units[equipment_slot_index].left = nil
		end
	else
		local old_unit = self.equipment_units[equipment_slot_index]

		if old_unit ~= nil then
			World.destroy_unit(world, old_unit)

			self.equipment_units[equipment_slot_index] = nil
		end
	end

	self.item_names[item_slot_type] = nil
end

InventoryViewPreviewer.equip_item = function (self, item_name, item_slot_type, equipment_slot_index)
	self.items_loaded = nil
	local item_data = ItemMasterList[item_name]
	local item_units = BackendUtils.get_item_units(item_data)
	local item_template = ItemHelper.get_template_by_item_name(item_name)
	local units_to_spawn_data = {}
	self.item_spawn_data[item_name] = units_to_spawn_data
	self.item_names[item_slot_type] = item_name
	local package_names = {}

	if item_slot_type == "melee" or item_slot_type == "ranged" then
		local left_hand_unit = item_units.left_hand_unit
		local right_hand_unit = item_units.right_hand_unit
		local despawn_both_hands_units = right_hand_unit == nil or left_hand_unit == nil

		if left_hand_unit then
			local left_unit = left_hand_unit .. "_3p"
			units_to_spawn_data[#units_to_spawn_data + 1] = {
				left_hand = true,
				despawn_both_hands_units = despawn_both_hands_units,
				unit_name = left_unit,
				item_slot_type = item_slot_type,
				equipment_slot_index = equipment_slot_index,
				unit_attachment_node_linking = item_template.left_hand_attachment_node_linking.third_person
			}
			package_names[#package_names + 1] = left_unit
		end

		if right_hand_unit then
			local right_unit = right_hand_unit .. "_3p"
			units_to_spawn_data[#units_to_spawn_data + 1] = {
				right_hand = true,
				despawn_both_hands_units = despawn_both_hands_units,
				unit_name = right_unit,
				item_slot_type = item_slot_type,
				equipment_slot_index = equipment_slot_index,
				unit_attachment_node_linking = item_template.right_hand_attachment_node_linking.third_person
			}

			if right_hand_unit ~= left_hand_unit then
				package_names[#package_names + 1] = right_unit
			end
		end
	else
		local unit = item_units.unit

		if unit then
			local attachment_slot_lookup_index = item_slot_type == "hat" and 1

			if equipment_slot_index == 3 then
				attachment_slot_lookup_index = 1
			elseif equipment_slot_index == 2 then
				attachment_slot_lookup_index = 2
			elseif equipment_slot_index == 1 then
				attachment_slot_lookup_index = 3
			end

			local attachment_slot_name = item_template.slots[attachment_slot_lookup_index]
			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = unit,
				item_slot_type = item_slot_type,
				equipment_slot_index = equipment_slot_index,
				unit_attachment_node_linking = item_template.attachment_node_linking[attachment_slot_name]
			}
			package_names[#package_names + 1] = unit
		end
	end

	self:load_package(package_names, item_name)
end

InventoryViewPreviewer.load_package = function (self, package_names, item_name)
	local package_names_to_load = {}

	for index, package_name in ipairs(package_names) do
		if not self.packages_to_load[package_name] then
			self.packages_to_load[package_name] = true
			package_names_to_load[#package_names_to_load + 1] = package_name
		end
	end

	for index, package_name in ipairs(package_names_to_load) do
		local package_manager = Managers.package
		local cb = callback(self, "on_load_complete", package_name, item_name)

		package_manager:load(package_name, "InventoryViewPreviewer", cb, true)
	end
end

InventoryViewPreviewer.on_load_complete = function (self, package_name, item_name)
	local loaded_packages = self.loaded_packages
	loaded_packages[package_name] = true
	self.packages_to_load[package_name] = nil
	local item_names = self.item_names
	local spawn_data = self.item_spawn_data[item_name]

	for _, unit_spawn_data in ipairs(spawn_data) do
		local item_slot_type = unit_spawn_data.item_slot_type

		if item_names[item_slot_type] ~= item_name then
			return
		end

		local unit_name = unit_spawn_data.unit_name

		if not loaded_packages[unit_name] then
			return
		end
	end

	self:_spawn_item(item_name)

	self.items_loaded = self:update_package_loaded_status()
end

InventoryViewPreviewer.update_package_loaded_status = function (self)
	for package_name, _ in pairs(self.packages_to_load) do
		return
	end

	return true
end

InventoryViewPreviewer.items_spawned = function (self)
	return self.items_loaded
end

InventoryViewPreviewer._spawn_items = function (self)
	local item_spawn_data = self.item_spawn_data
	local loaded_packages = self.loaded_packages

	for slot_type, item_name in pairs(self.item_names) do
		local spawn_data = item_spawn_data[item_name]

		for _, unit_spawn_data in ipairs(spawn_data) do
			local unit_name = unit_spawn_data.unit_name

			if not loaded_packages[unit_name] then
				return
			end
		end
	end

	for slot_type, item_name in pairs(self.item_names) do
		self:_spawn_item(item_name)
	end

	return true
end

InventoryViewPreviewer._spawn_item = function (self, item_name)
	local world = self.world
	local character_unit = self.character_unit
	local scene_graph_links = {}
	local item_data = ItemMasterList[item_name]
	local item_units = BackendUtils.get_item_units(item_data)
	local item_template = ItemHelper.get_template_by_item_name(item_name)
	local item_spawn_data = self.item_spawn_data
	local spawn_data = item_spawn_data[item_name]

	if spawn_data then
		for _, unit_spawn_data in ipairs(spawn_data) do
			local unit_name = unit_spawn_data.unit_name
			local item_slot_type = unit_spawn_data.item_slot_type
			local equipment_slot_index = unit_spawn_data.equipment_slot_index
			local unit_attachment_node_linking = unit_spawn_data.unit_attachment_node_linking

			if item_slot_type == "melee" or item_slot_type == "ranged" then
				if unit_spawn_data.right_hand or unit_spawn_data.despawn_both_hands_units then
					local old_unit_right = self.equipment_units[equipment_slot_index].right

					if old_unit_right ~= nil then
						World.destroy_unit(world, old_unit_right)

						self.equipment_units[equipment_slot_index].right = nil
					end
				end

				if unit_spawn_data.left_hand or unit_spawn_data.despawn_both_hands_units then
					local old_unit_left = self.equipment_units[equipment_slot_index].left

					if old_unit_left ~= nil then
						World.destroy_unit(world, old_unit_left)

						self.equipment_units[equipment_slot_index].left = nil
					end
				end

				local unit = World.spawn_unit(world, unit_name)

				self:equip_item_unit(unit, item_slot_type, item_template, unit_attachment_node_linking, scene_graph_links)

				if unit_spawn_data.right_hand then
					self.equipment_units[equipment_slot_index].right = unit
				elseif unit_spawn_data.left_hand then
					self.equipment_units[equipment_slot_index].left = unit
				end
			else
				local old_unit = self.equipment_units[equipment_slot_index]

				if old_unit ~= nil then
					World.destroy_unit(world, old_unit)

					self.equipment_units[equipment_slot_index] = nil
				end

				local unit = World.spawn_unit(world, unit_name)
				self.equipment_units[equipment_slot_index] = unit

				self:equip_item_unit(unit, item_slot_type, item_template, unit_attachment_node_linking, scene_graph_links)
			end

			local show_attachments_event = item_template.show_attachments_event

			if show_attachments_event then
				Unit.flow_event(character_unit, show_attachments_event)
			end
		end
	end
end

InventoryViewPreviewer.equip_item_unit = function (self, unit, item_slot_type, item_template, unit_attachment_node_linking, scene_graph_links)
	local world = self.world
	local character_unit = self.character_unit

	if item_slot_type == "melee" or item_slot_type == "ranged" then
		if self.wielded_slot_type == item_slot_type then
			unit_attachment_node_linking = unit_attachment_node_linking.wielded

			Unit.flow_event(unit, "lua_wield")

			if item_template.wield_anim then
				Unit.animation_event(character_unit, item_template.wield_anim)
			end
		else
			Unit.set_unit_visibility(unit, false)

			unit_attachment_node_linking = unit_attachment_node_linking.unwielded

			Unit.flow_event(unit, "lua_unwield")
		end
	end

	if Unit.has_lod_object(unit, "lod") then
		local lod_object = Unit.lod_object(unit, "lod")

		LODObject.set_static_select(lod_object, 0)
	end

	GearUtils.link(world, unit_attachment_node_linking, scene_graph_links, character_unit, unit)
end

InventoryViewPreviewer.clear_units = function (self)
	local world = self.world

	for i = 1, 6, 1 do
		if i == 4 or i == 5 then
			if self.equipment_units[i].left then
				World.destroy_unit(world, self.equipment_units[i].left)

				self.equipment_units[i].left = nil
			end

			if self.equipment_units[i].right then
				World.destroy_unit(world, self.equipment_units[i].right)

				self.equipment_units[i].right = nil
			end
		elseif self.equipment_units[i] then
			World.destroy_unit(world, self.equipment_units[i])

			self.equipment_units[i] = nil
		end
	end

	table.clear(self.item_names)

	if self.character_unit ~= nil then
		World.destroy_unit(world, self.character_unit)

		self.character_unit = nil
	end
end

return
