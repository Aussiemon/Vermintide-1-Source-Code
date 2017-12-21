GearUtils = {}
GearUtils.create_equipment = function (world, slot_name, item_data, unit_1p, unit_3p, is_bot, unit_template, extra_extension_data, ammo_percent)
	local right_hand_weapon_unit_3p, right_hand_weapon_unit_1p, left_hand_weapon_unit_3p, left_hand_weapon_unit_1p, right_hand_ammo_unit_3p, right_hand_ammo_unit_1p, left_hand_ammo_unit_3p, left_hand_ammo_unit_1p = nil
	local item_template = BackendUtils.get_item_template(item_data)
	local item_units = BackendUtils.get_item_units(item_data)

	if item_units.right_hand_unit then
		right_hand_weapon_unit_3p, right_hand_ammo_unit_3p, right_hand_weapon_unit_1p, right_hand_ammo_unit_1p = GearUtils.spawn_inventory_unit(world, "right", item_template.third_person_extension_template, item_units.right_hand_unit, item_template.right_hand_attachment_node_linking, slot_name, item_data, unit_1p, unit_3p, unit_template, extra_extension_data, ammo_percent)
	end

	if item_units.left_hand_unit then
		left_hand_weapon_unit_3p, left_hand_ammo_unit_3p, left_hand_weapon_unit_1p, left_hand_ammo_unit_1p = GearUtils.spawn_inventory_unit(world, "left", item_template.third_person_extension_template, item_units.left_hand_unit, item_template.left_hand_attachment_node_linking, slot_name, item_data, unit_1p, unit_3p, unit_template, extra_extension_data, ammo_percent)
	end

	if right_hand_weapon_unit_3p then
		Unit.set_flow_variable(right_hand_weapon_unit_3p, "is_bot", is_bot)
		Unit.set_unit_visibility(right_hand_weapon_unit_3p, false)

		if right_hand_ammo_unit_3p then
			Unit.set_unit_visibility(right_hand_ammo_unit_3p, false)
		end
	end

	if right_hand_weapon_unit_1p then
		Unit.set_flow_variable(right_hand_weapon_unit_1p, "is_bot", is_bot)
		Unit.set_unit_visibility(right_hand_weapon_unit_1p, false)

		if right_hand_ammo_unit_1p then
			Unit.set_unit_visibility(right_hand_ammo_unit_1p, false)
		end
	end

	if left_hand_weapon_unit_3p then
		Unit.set_flow_variable(left_hand_weapon_unit_3p, "is_bot", is_bot)
		Unit.set_unit_visibility(left_hand_weapon_unit_3p, false)

		if left_hand_ammo_unit_3p then
			Unit.set_unit_visibility(left_hand_ammo_unit_3p, false)
		end
	end

	if left_hand_weapon_unit_1p then
		Unit.set_flow_variable(left_hand_weapon_unit_1p, "is_bot", is_bot)
		Unit.set_unit_visibility(left_hand_weapon_unit_1p, false)

		if left_hand_ammo_unit_1p then
			Unit.set_unit_visibility(left_hand_ammo_unit_1p, false)
		end
	end

	local slot_data = {
		id = slot_name,
		item_data = item_data,
		right_unit_3p = right_hand_weapon_unit_3p,
		right_ammo_unit_3p = right_hand_ammo_unit_3p,
		right_unit_1p = right_hand_weapon_unit_1p,
		right_ammo_unit_1p = right_hand_ammo_unit_1p,
		left_unit_3p = left_hand_weapon_unit_3p,
		left_ammo_unit_3p = left_hand_ammo_unit_3p,
		left_unit_1p = left_hand_weapon_unit_1p,
		left_ammo_unit_1p = left_hand_ammo_unit_1p
	}

	return slot_data
end
GearUtils.spawn_inventory_unit = function (world, hand, third_person_extension_template, unit_name, node_linking_settings, slot_name, item_data, owner_unit_1p, owner_unit_3p, unit_template, extra_extension_data, ammo_percent)
	local item_template = BackendUtils.get_item_template(item_data)
	local ammo_data = item_template.ammo_data
	local overcharge_data = item_template.overcharge_data
	local aim_data = item_template.aim_data
	local item_name = item_data.name
	local ammo_unit_3p = nil

	if ammo_data then
		local ammo_unit_name = ammo_data.ammo_unit_3p

		if ammo_unit_name then
			local ammo_unit_attachment_node_linking = ammo_data.ammo_unit_attachment_node_linking

			assert(ammo_unit_attachment_node_linking, "ammo unit: %s defined in weapon without attachment node linking", ammo_unit_name)

			ammo_unit_3p = GearUtils._attach_ammo_unit(world, ammo_unit_name, ammo_unit_attachment_node_linking.third_person.wielded, owner_unit_3p)
		end
	end

	local attachment_node_linking = node_linking_settings.third_person.wielded
	local unit_template_3p = third_person_extension_template or "weapon_unit_3p"
	local extension_init_data_3p = {}
	local weapon_unit_3p = Managers.state.unit_spawner:spawn_local_unit_with_extensions(unit_name .. "_3p", unit_template_3p, extension_init_data_3p)
	local scene_graph_links = {}

	GearUtils.link(world, attachment_node_linking, scene_graph_links, owner_unit_3p, weapon_unit_3p)

	if owner_unit_1p then
		local attachment_node_linking = node_linking_settings.first_person.wielded
		local extension_init_data_1p = {
			weapon_system = {
				first_person_rig = owner_unit_1p,
				owner_unit = owner_unit_3p,
				attach_nodes = attachment_node_linking,
				item_name = item_name
			},
			ammo_system = {
				owner_unit = owner_unit_3p,
				ammo_data = ammo_data,
				ammo_percent = ammo_percent,
				reload_event = item_template.reload_event,
				no_ammo_reload_event = item_template.no_ammo_reload_event,
				last_reload_event = item_template.reload_end_event,
				item_name = item_name,
				slot_name = slot_name
			},
			spread_system = {
				owner_unit = owner_unit_3p,
				item_name = item_name
			},
			overcharge_system = {
				ammo_percent = ammo_percent,
				owner_unit = owner_unit_3p,
				overcharge_data = overcharge_data,
				item_name = item_name
			}
		}
		local unit_template_1p, ammo_unit_1p = nil
		local ammo_hand = ammo_data and ammo_data.ammo_hand

		if ammo_data then
			fassert(ammo_hand, "weapon %s does not have an ammo hand defined in its ammo_data", item_name)
		end

		local default_spread_template = item_template.default_spread_template

		if ammo_data and ammo_hand == hand then
			local ammo_unit_name = ammo_data.ammo_unit

			if ammo_unit_name then
				local ammo_unit_attachment_node_linking = ammo_data.ammo_unit_attachment_node_linking

				assert(ammo_unit_attachment_node_linking, "ammo unit: %s defined in weapon without attachment node linking", ammo_unit_name)

				ammo_unit_1p = GearUtils._attach_ammo_unit(world, ammo_unit_name, ammo_unit_attachment_node_linking.first_person.wielded, owner_unit_1p)
			end

			if default_spread_template then
				unit_template_1p = "weapon_unit_ammo_spread"
			else
				unit_template_1p = "weapon_unit_ammo"
			end
		elseif overcharge_data then
			if default_spread_template then
				unit_template_1p = "weapon_unit_overcharge_spread"
			else
				unit_template_1p = "weapon_unit_overcharge"
			end
		elseif default_spread_template then
			unit_template_1p = "weapon_unit_spread"
		else
			unit_template_1p = "weapon_unit"
		end

		if unit_template then
			unit_template_1p = unit_template

			table.merge(extension_init_data_1p, extra_extension_data)
		end

		local weapon_unit_1p = Managers.state.unit_spawner:spawn_local_unit_with_extensions(unit_name, unit_template_1p, extension_init_data_1p)
		local scene_graph_links = {}

		GearUtils.link(world, attachment_node_linking, scene_graph_links, owner_unit_1p, weapon_unit_1p)

		return weapon_unit_3p, ammo_unit_3p, weapon_unit_1p, ammo_unit_1p
	end

	return weapon_unit_3p, ammo_unit_3p
end
GearUtils._attach_ammo_unit = function (world, ammo_unit_name, attachment_node_linking, target_unit)
	local ammo_unit = Managers.state.unit_spawner:spawn_local_unit(ammo_unit_name)
	local scene_graph_links = {}

	GearUtils.link(world, attachment_node_linking, scene_graph_links, target_unit, ammo_unit)

	return ammo_unit
end
GearUtils.link = function (world, attachment_node_linking, scene_graph_links, user_unit, unit)
	table.clear(scene_graph_links)
	GearUtils.link_units(world, attachment_node_linking, scene_graph_links, user_unit, unit)

	return 
end
GearUtils.link_units = function (world, attachment_node_linking, link_table, source, target)
	for i, attachment_nodes in ipairs(attachment_node_linking) do
		local source_node = attachment_nodes.source
		local target_node = attachment_nodes.target
		local source_node_index = (type(source_node) == "string" and Unit.node(source, source_node)) or source_node
		local target_node_index = (type(target_node) == "string" and Unit.node(target, target_node)) or target_node
		link_table[#link_table + 1] = {
			unit = target,
			i = target_node_index,
			parent = Unit.scene_graph_parent(target, target_node_index),
			local_pose = Matrix4x4Box(Unit.local_pose(target, target_node_index))
		}

		World.link_unit(world, target, target_node_index, source, source_node_index)
	end

	return 
end
GearUtils.restore_scene_graph = function (scene_graph_links)
	if scene_graph_links then
		for i, link in ipairs(scene_graph_links) do
			if link.parent then
				Unit.scene_graph_link(link.unit, link.i, link.parent)
				Unit.set_local_pose(link.unit, link.i, link.local_pose:unbox())
			end
		end
	end

	return 
end
GearUtils.destroy_wielded = function (world, wielded_unit)
	Unit.flow_event(wielded_unit, "lua_unwield")

	local unit_spawner = Managers.state.unit_spawner

	unit_spawner.mark_for_deletion(unit_spawner, wielded_unit)

	return 
end
GearUtils.wield_slot = function (equipment, slot_data, unit_1p, unit_3p, buff_extension)
	if equipment.right_hand_wielded_unit then
		Unit.flow_event(equipment.right_hand_wielded_unit, "lua_unwield")
		Unit.set_unit_visibility(equipment.right_hand_wielded_unit, false)

		if ScriptUnit.has_extension(equipment.right_hand_wielded_unit, "ammo_system") then
			local ammo_extension = ScriptUnit.extension(equipment.right_hand_wielded_unit, "ammo_system")

			if ammo_extension.is_reloading(ammo_extension) then
				ammo_extension.abort_reload(ammo_extension)
			end
		end
	end

	if equipment.right_hand_ammo_unit_1p then
		Unit.set_unit_visibility(equipment.right_hand_ammo_unit_1p, false)
	end

	if equipment.left_hand_wielded_unit then
		Unit.flow_event(equipment.left_hand_wielded_unit, "lua_unwield")
		Unit.set_unit_visibility(equipment.left_hand_wielded_unit, false)

		if ScriptUnit.has_extension(equipment.left_hand_wielded_unit, "ammo_system") then
			local ammo_extension = ScriptUnit.extension(equipment.left_hand_wielded_unit, "ammo_system")

			if ammo_extension.is_reloading(ammo_extension) then
				ammo_extension.abort_reload(ammo_extension)
			end
		end
	end

	if equipment.left_hand_ammo_unit_1p then
		Unit.flow_event(equipment.left_hand_ammo_unit_1p, "lua_unwield")
		Unit.set_unit_visibility(equipment.left_hand_ammo_unit_1p, false)
	end

	if equipment.right_hand_wielded_unit_3p then
		Unit.flow_event(equipment.right_hand_wielded_unit_3p, "lua_unwield")
		Unit.set_unit_visibility(equipment.right_hand_wielded_unit_3p, false)
	end

	if equipment.right_hand_ammo_unit_3p then
		Unit.flow_event(equipment.right_hand_ammo_unit_3p, "lua_unwield")
		Unit.set_unit_visibility(equipment.right_hand_ammo_unit_3p, false)
	end

	if equipment.left_hand_wielded_unit_3p then
		Unit.flow_event(equipment.left_hand_wielded_unit_3p, "lua_unwield")
		Unit.set_unit_visibility(equipment.left_hand_wielded_unit_3p, false)
	end

	if equipment.left_hand_ammo_unit_3p then
		Unit.flow_event(equipment.left_hand_ammo_unit_3p, "lua_unwield")
		Unit.set_unit_visibility(equipment.left_hand_ammo_unit_3p, false)
	end

	local item_data = slot_data.item_data
	equipment.wielded = item_data
	equipment.wielded_slot = slot_data.id
	equipment.right_hand_wielded_unit_3p = slot_data.right_unit_3p
	equipment.right_hand_ammo_unit_3p = slot_data.right_ammo_unit_3p
	equipment.left_hand_wielded_unit_3p = slot_data.left_unit_3p
	equipment.left_hand_ammo_unit_3p = slot_data.left_ammo_unit_3p
	local item_template = BackendUtils.get_item_template(item_data)
	local wield_anim = item_template.wield_anim

	Unit.animation_event(unit_3p, wield_anim)

	if slot_data.right_unit_1p or slot_data.left_unit_1p then
		equipment.right_hand_wielded_unit = slot_data.right_unit_1p
		equipment.right_hand_ammo_unit_1p = slot_data.right_ammo_unit_1p
		equipment.left_hand_wielded_unit = slot_data.left_unit_1p
		equipment.left_hand_ammo_unit_1p = slot_data.left_ammo_unit_1p

		if equipment.right_hand_wielded_unit then
			Unit.flow_event(equipment.right_hand_wielded_unit, "lua_wield")
		end

		if equipment.right_hand_ammo_unit_1p then
			Unit.flow_event(equipment.right_hand_ammo_unit_1p, "lua_wield")
		end

		if equipment.left_hand_wielded_unit then
			Unit.flow_event(equipment.left_hand_wielded_unit, "lua_wield")
		end

		if equipment.left_hand_ammo_unit_1p then
			Unit.flow_event(equipment.left_hand_ammo_unit_1p, "lua_wield")
		end

		if ScriptUnit.has_extension(equipment.right_hand_wielded_unit, "ammo_system") then
			local ammo_extension = ScriptUnit.extension(equipment.right_hand_wielded_unit, "ammo_system")

			if ammo_extension.can_reload(ammo_extension) and ammo_extension.ammo_count(ammo_extension) == 0 then
				if not item_template.wield_anim_not_loaded then
				end

				local play_reload_animation = ammo_extension.play_reload_anim_on_wield_reload

				ammo_extension.start_reload(ammo_extension, play_reload_animation)
			elseif ammo_extension.total_remaining_ammo(ammo_extension) == 0 and not item_template.wield_anim_no_ammo then
			end
		end

		if ScriptUnit.has_extension(equipment.left_hand_wielded_unit, "ammo_system") then
			local ammo_extension = ScriptUnit.extension(equipment.left_hand_wielded_unit, "ammo_system")

			if ammo_extension.can_reload(ammo_extension) and ammo_extension.ammo_count(ammo_extension) == 0 then
				if not item_template.wield_anim_not_loaded then
				end

				local play_reload_animation = ammo_extension.play_reload_anim_on_wield_reload

				ammo_extension.start_reload(ammo_extension, play_reload_animation)
			elseif ammo_extension.total_remaining_ammo(ammo_extension) == 0 and not item_template.wield_anim_no_ammo then
			end
		end

		Unit.animation_event(unit_1p, wield_anim)

		if slot_data.right_unit_1p then
			if Unit.has_visibility_group(slot_data.right_unit_1p, "normal") then
				Unit.set_visibility(slot_data.right_unit_1p, "normal", true)
			else
				Unit.set_unit_visibility(slot_data.right_unit_1p, true)
			end

			if slot_data.right_ammo_unit_1p then
				Unit.set_unit_visibility(slot_data.right_ammo_unit_1p, true)
			end
		end

		if slot_data.left_unit_1p then
			if Unit.has_visibility_group(slot_data.left_unit_1p, "normal") then
				Unit.set_visibility(slot_data.left_unit_1p, "normal", true)
			else
				Unit.set_unit_visibility(slot_data.left_unit_1p, true)
			end

			if slot_data.left_ammo_unit_1p then
				Unit.set_unit_visibility(slot_data.left_ammo_unit_1p, true)
			end
		end
	else
		if equipment.right_hand_wielded_unit_3p then
			Unit.flow_event(equipment.right_hand_wielded_unit_3p, "lua_wield")
			Unit.set_unit_visibility(equipment.right_hand_wielded_unit_3p, true)

			if slot_data.right_ammo_unit_3p then
				Unit.set_unit_visibility(slot_data.right_ammo_unit_3p, true)
			end
		end

		if equipment.left_hand_wielded_unit_3p then
			Unit.flow_event(equipment.left_hand_wielded_unit_3p, "lua_wield")
			Unit.set_unit_visibility(equipment.left_hand_wielded_unit_3p, true)

			if slot_data.left_ammo_unit_3p then
				Unit.set_unit_visibility(slot_data.left_ammo_unit_3p, true)
			end
		end
	end

	return true
end
GearUtils.wield = function (world, equipment, slot_name, unit_1p, unit_3p)
	local slot = equipment.slots[slot_name]

	if not slot then
		print("Cannot wield item from " .. tostring(slot_name) .. " since this slot does not exist.")

		return 
	end

	local item_data = slot.item_data

	if not item_data then
		print("Cannot wield item from " .. tostring(slot_name) .. " since it is empty.")

		return 
	end

	if equipment.wielded == item_data then
		print("Already wielding item in " .. tostring(slot_name))

		return 
	end

	GearUtils.destroy_equipment(world, equipment)

	local item_template = BackendUtils.get_item_template(item_data)
	local item_units = BackendUtils.get_item_units(item_data)
	local right_hand_weapon_unit_3p, right_hand_weapon_unit_1p, left_hand_weapon_unit_3p, left_hand_weapon_unit_1p, right_hand_ammo_unit_3p, right_hand_ammo_unit_1p, left_hand_ammo_unit_3p, left_hand_ammo_unit_1p = nil

	if item_units.right_hand_unit then
		right_hand_weapon_unit_3p, right_hand_ammo_unit_3p, right_hand_weapon_unit_1p, right_hand_ammo_unit_1p = GearUtils.spawn_inventory_unit(world, "right", item_template.third_person_extension_template, item_units.right_hand_unit, item_template.right_hand_attachment_node_linking, slot_name, item_data, unit_1p, unit_3p)
	end

	if item_units.left_hand_unit then
		left_hand_weapon_unit_3p, left_hand_ammo_unit_3p, left_hand_weapon_unit_1p, left_hand_ammo_unit_1p = GearUtils.spawn_inventory_unit(world, "left", item_template.third_person_extension_template, item_units.left_hand_unit, item_template.left_hand_attachment_node_linking, slot_name, item_data, unit_1p, unit_3p)
	end

	if right_hand_weapon_unit_3p or left_hand_weapon_unit_3p then
		Unit.flow_event(unit_3p, "lua_wield")
		Unit.animation_event(unit_3p, item_template.wield_anim)

		if right_hand_weapon_unit_3p then
			Unit.flow_event(right_hand_weapon_unit_3p, "lua_wield")
		end

		if left_hand_weapon_unit_3p then
			Unit.flow_event(left_hand_weapon_unit_3p, "lua_wield")
		end
	end

	if right_hand_weapon_unit_1p or left_hand_weapon_unit_1p then
		Unit.animation_event(unit_1p, item_template.wield_anim)
	end

	if right_hand_weapon_unit_1p then
		Unit.set_unit_visibility(right_hand_weapon_unit_3p, false)

		if right_hand_ammo_unit_1p then
			Unit.set_unit_visibility(right_hand_ammo_unit_3p, false)
		end
	end

	if left_hand_weapon_unit_1p then
		Unit.set_unit_visibility(left_hand_weapon_unit_3p, false)

		if left_hand_ammo_unit_1p then
			Unit.set_unit_visibility(left_hand_ammo_unit_3p, false)
		end
	end

	equipment.right_hand_wielded_unit_3p = right_hand_weapon_unit_3p
	equipment.right_hand_ammo_unit_3p = right_hand_ammo_unit_3p
	equipment.right_hand_wielded_unit = right_hand_weapon_unit_1p
	equipment.right_hand_ammo_unit_1p = right_hand_ammo_unit_1p
	equipment.left_hand_wielded_unit_3p = left_hand_weapon_unit_3p
	equipment.left_hand_ammo_unit_3p = left_hand_ammo_unit_3p
	equipment.left_hand_wielded_unit = left_hand_weapon_unit_1p
	equipment.left_hand_ammo_unit_1p = left_hand_ammo_unit_1p
	equipment.wielded = item_data
	equipment.wielded_slot = slot_name

	return item_data
end
GearUtils.destroy_equipment = function (world, equipment)
	local slots = equipment.slots
	local unit_spawner = Managers.state.unit_spawner

	if equipment.right_hand_wielded_unit_3p then
		GearUtils.destroy_wielded(world, equipment.right_hand_wielded_unit_3p)
	end

	if equipment.right_hand_ammo_unit_3p then
		unit_spawner.mark_for_deletion(unit_spawner, equipment.right_hand_ammo_unit_3p)
	end

	if equipment.right_hand_wielded_unit then
		GearUtils.destroy_wielded(world, equipment.right_hand_wielded_unit)
	end

	if equipment.right_hand_ammo_unit_1p then
		unit_spawner.mark_for_deletion(unit_spawner, equipment.right_hand_ammo_unit_1p)
	end

	if equipment.left_hand_wielded_unit_3p then
		GearUtils.destroy_wielded(world, equipment.left_hand_wielded_unit_3p)
	end

	if equipment.left_hand_ammo_unit_3p then
		unit_spawner.mark_for_deletion(unit_spawner, equipment.left_hand_ammo_unit_3p)
	end

	if equipment.left_hand_wielded_unit then
		GearUtils.destroy_wielded(world, equipment.left_hand_wielded_unit)
	end

	if equipment.left_hand_ammo_unit_1p then
		unit_spawner.mark_for_deletion(unit_spawner, equipment.left_hand_ammo_unit_1p)
	end

	equipment.right_hand_wielded_unit_3p = nil
	equipment.right_hand_ammo_unit_3p = nil
	equipment.right_hand_wielded_unit = nil
	equipment.right_hand_ammo_unit_1p = nil
	equipment.left_hand_wielded_unit_3p = nil
	equipment.left_hand_ammo_unit_3p = nil
	equipment.left_hand_wielded_unit = nil
	equipment.left_hand_ammo_unit_1p = nil

	return 
end
GearUtils.destroy_slot = function (world, unit, slot_data, equipment, allow_destroy_weapon)
	local item_data = slot_data.item_data
	local slot_name = slot_data.id

	fassert(allow_destroy_weapon or (slot_name ~= "slot_ranged" and slot_name ~= "slot_melee"), "Trying to destroy weapon without permission")

	if item_data == equipment.wielded then
		GearUtils.destroy_equipment(world, equipment)
	else
		local right_hand_weapon_unit_3p = slot_data.right_unit_3p
		local right_hand_ammo_unit_3p = slot_data.right_ammo_unit_3p
		local right_hand_weapon_unit_1p = slot_data.right_unit_1p
		local right_hand_ammo_unit_1p = slot_data.right_ammo_unit_1p
		local left_hand_weapon_unit_3p = slot_data.left_unit_3p
		local left_hand_ammo_unit_3p = slot_data.left_ammo_unit_3p
		local left_hand_weapon_unit_1p = slot_data.left_unit_1p
		local left_hand_ammo_unit_1p = slot_data.left_ammo_unit_1p
		local unit_spawner = Managers.state.unit_spawner

		if right_hand_weapon_unit_3p then
			unit_spawner.mark_for_deletion(unit_spawner, right_hand_weapon_unit_3p)
		end

		if right_hand_ammo_unit_3p then
			unit_spawner.mark_for_deletion(unit_spawner, right_hand_ammo_unit_3p)
		end

		if right_hand_weapon_unit_1p then
			unit_spawner.mark_for_deletion(unit_spawner, right_hand_weapon_unit_1p)
		end

		if right_hand_ammo_unit_1p then
			unit_spawner.mark_for_deletion(unit_spawner, right_hand_ammo_unit_1p)
		end

		if left_hand_weapon_unit_3p then
			unit_spawner.mark_for_deletion(unit_spawner, left_hand_weapon_unit_3p)
		end

		if left_hand_ammo_unit_3p then
			unit_spawner.mark_for_deletion(unit_spawner, left_hand_ammo_unit_3p)
		end

		if left_hand_weapon_unit_1p then
			unit_spawner.mark_for_deletion(unit_spawner, left_hand_weapon_unit_1p)
		end

		if left_hand_ammo_unit_1p then
			unit_spawner.mark_for_deletion(unit_spawner, left_hand_ammo_unit_1p)
		end
	end

	equipment.slots[slot_name] = nil

	return 
end
GearUtils.hot_join_sync = function (sender, unit, equipment)
	local slots = equipment.slots
	local unit_object_id = Managers.state.unit_storage:go_id(unit)

	for slot_name, slot_data in pairs(slots) do
		local slot = InventorySettings.slots_by_name[slot_name]

		if slot.category ~= "weapon" and slot.category ~= "enemy_weapon" and slot.category ~= "level_event" then
		else
			local slot_id = NetworkLookup.equipment_slots[slot_name]
			local item_data = slot_data.item_data
			local item_id = NetworkLookup.item_names[item_data.name]

			RPC.rpc_add_equipment(sender, unit_object_id, slot_id, item_id)
		end
	end

	if equipment.wielded then
		RPC.rpc_wield_equipment(sender, unit_object_id, NetworkLookup.equipment_slots[equipment.wielded_slot])
	end

	return 
end
GearUtils._setup_extension_init_data_type_impact = function (item_template, item_name)
	local explosive_settings = item_template.explosive_settings
	local area_damage_system = {
		item_template_name = item_template.name,
		invisible_projectile = explosive_settings.invisible_projectile,
		impact_player_take_damage = explosive_settings.impact_player_take_damage,
		impact_damage = explosive_settings.impact_damage,
		impact_damage_radius = explosive_settings.impact_damage_radius,
		impact_damage_min_radius_with_max_damage = explosive_settings.impact_damage_min_radius_with_max_damage,
		impact_effect_name = explosive_settings.impact_effect_name,
		impact_sound_event = explosive_settings.impact_sound_event,
		impact_area_damage_template = explosive_settings.impact_area_damage_template,
		item_name = item_name
	}

	return area_damage_system
end
GearUtils._setup_extension_init_data_type_dot = function (item_template, item_name)
	local dot_settings = item_template.dot_settings
	local area_damage_system = {
		item_template_name = item_template.name,
		invisible_projectile = dot_settings.invisible_projectile,
		aoe_dot_player_take_damage = dot_settings.aoe_dot_player_take_damage,
		aoe_dot_life_time = dot_settings.aoe_dot_life_time,
		aoe_dot_radius = dot_settings.aoe_dot_radius,
		aoe_dot_damage = dot_settings.aoe_dot_damage,
		aoe_dot_damage_interval = dot_settings.aoe_dot_damage_interval,
		impact_sound_event = dot_settings.impact_sound_event,
		dot_effect_name = dot_settings.dot_effect_name,
		player_screen_effect_name = dot_settings.player_screen_effect_name,
		area_damage_template = dot_settings.area_damage_template,
		area_ai_random_death_template = dot_settings.area_ai_random_death_template,
		item_name = item_name
	}

	return area_damage_system
end
GearUtils.create_grenade_extension_init_data = function (owner_unit, item_name, current_action, projectile_data, explode_time)
	local network_position = AiAnimUtils.position_network_scale(projectile_data.position, true)
	local network_rotation = AiAnimUtils.rotation_network_scale(projectile_data.rotation, true)
	local network_velocity = AiAnimUtils.velocity_network_scale(projectile_data.velocity, true)
	local network_angular_velocity = AiAnimUtils.velocity_network_scale(projectile_data.angular_velocity, true)
	local projectile_info = current_action.projectile_info
	local lookup_data = current_action.lookup_data
	local life_time = projectile_info.life_time
	local t = Managers.time:time("game")
	local stop_time = explode_time or t + life_time
	local extension_init_data = {
		projectile_locomotion_system = {
			owner_unit = owner_unit,
			network_position = network_position,
			network_rotation = network_rotation,
			network_velocity = network_velocity,
			network_angular_velocity = network_angular_velocity,
			use_dynamic_collision = projectile_info.use_dynamic_collision,
			collision_filter = projectile_info.collision_filter,
			item_name = item_name
		},
		projectile_system = {
			owner_unit = owner_unit,
			stop_time = stop_time,
			projectile_template_name = projectile_info.projectile_template_name,
			item_name = item_name,
			item_template_name = lookup_data.item_template_name,
			action_name = lookup_data.action_name,
			sub_action_name = lookup_data.sub_action_name
		}
	}
	local item_template = Weapons[lookup_data.item_template_name]

	if current_action.is_impact_type then
		extension_init_data.area_damage_system = GearUtils._setup_extension_init_data_type_impact(item_template, item_name)
	else
		extension_init_data.area_damage_system = GearUtils._setup_extension_init_data_type_dot(item_template, item_name)
	end

	return extension_init_data
end
GearUtils.update_gameobject = function (unit, slot_id, item_name)
	local equipped_slots = {}
	local inventory_extension = ScriptUnit.extension(unit, "inventory_system")
	local equipment = inventory_extension.equipment(inventory_extension)
	local inventory_slots = equipment.slots
	local attachment_extension = ScriptUnit.extension(unit, "attachment_system")
	local attachments = attachment_extension.attachments(attachment_extension)
	local attachemnt_slots = attachments.slots
	local slots = table.clone(inventory_slots)

	table.merge(slots, attachemnt_slots)

	local network_slot_id = NetworkLookup.equipment_slots[slot_id]
	local network_weapon_id = NetworkLookup.item_names[item_name]
	equipped_slots[network_slot_id] = network_weapon_id

	for slot_name, slot_data in pairs(slots) do
		if slot_name ~= slot_id then
			local item_data = slot_data.item_data
			local network_slot_id = NetworkLookup.equipment_slots[slot_name]
			local network_weapon_id = NetworkLookup.item_names[item_data.name]
			equipped_slots[network_slot_id] = network_weapon_id
		end
	end

	for i = 1, 11, 1 do
		if equipped_slots[i] == nil then
			equipped_slots[i] = NetworkLookup.item_names["n/a"]
		end
	end

	local game = Managers.state.network:game()
	local go_id = Managers.state.unit_storage:go_id(unit)

	GameSession.set_game_object_field(game, go_id, "inventory_slots", equipped_slots)

	return 
end

return 
