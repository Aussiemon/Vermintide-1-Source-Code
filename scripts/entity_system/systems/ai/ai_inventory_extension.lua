AIInventoryExtension = class(AIInventoryExtension)

local function link_unit(attachment_node_linking, world, target, source)
	for i, attachment_nodes in ipairs(attachment_node_linking) do
		local source_node = attachment_nodes.source
		local target_node = attachment_nodes.target
		local source_node_index = (type(source_node) == "string" and Unit.node(source, source_node)) or source_node
		local target_node_index = (type(target_node) == "string" and Unit.node(target, target_node)) or target_node

		World.link_unit(world, target, target_node_index, source, source_node_index)
	end

	return 
end

AIInventoryExtension.init = function (self, unit, extension_init_data)
	self.world = extension_init_data.world
	self.unit = unit
	local inventory_item_units_by_category = {}
	local inventory_item_units = {}
	local inventory_item_definitions = {}
	local inventory_configuration_name = extension_init_data.inventory_configuration_name

	assert((extension_init_data.is_server and inventory_configuration_name == nil) or inventory_configuration_name ~= nil)

	if extension_init_data.is_server then
		local template_name = extension_init_data.inventory_template or "default"
		local template_function = AIInventoryTemplates[template_name]
		inventory_configuration_name = template_function()
	end

	local item_extension_init_data = {
		ai_inventory_item_system = {
			wielding_unit = unit
		}
	}
	local unit_spawner = Managers.state.unit_spawner
	local inventory_configuration = InventoryConfigurations[inventory_configuration_name]
	local items = inventory_configuration.items
	local items_n = inventory_configuration.items_n

	for i = 1, items_n, 1 do
		local item_category = items[i]
		local item_category_n = item_category.count
		local item_category_name = item_category.name
		local item_index = math.random(1, item_category_n)
		local item = item_category[item_index]
		local item_unit_name = item.unit_name
		local item_unit_template_name = item.unit_extension_template or "ai_inventory_item"
		item_extension_init_data.ai_inventory_item_system.drop_on_hit = item.drop_on_hit

		if item.extension_init_data then
			for data, value in pairs(item.extension_init_data) do
				item_extension_init_data[data] = value

				if data == "weapon_system" then
					item_extension_init_data[data].owner_unit = unit
				end
			end
		end

		local item_unit = unit_spawner.spawn_local_unit_with_extensions(unit_spawner, item_unit_name, item_unit_template_name, item_extension_init_data, nil, nil)
		local attachment_node_linking = item.attachment_node_linking

		link_unit(attachment_node_linking.unwielded, self.world, item_unit, unit)

		inventory_item_units[i] = item_unit
		inventory_item_units_by_category[item_category_name] = item_unit
		inventory_item_definitions[i] = item

		if script_data.ai_debug_inventory then
			printf("[AIInventorySystem] unit[%s] wielding item[%s] of category[%s] in slot[%d]", tostring(unit), item_unit_name, item_category_name, i)
		end
	end

	self.wield_anim = inventory_configuration.wield_anim
	self.inventory_items_n = items_n
	self.inventory_item_units = inventory_item_units
	self.inventory_item_units_by_category = inventory_item_units_by_category
	self.inventory_item_definitions = inventory_item_definitions
	self.inventory_configuration_name = inventory_configuration_name
	self.dropped_items = {}
	local anim_state_event = inventory_configuration.anim_state_event

	if anim_state_event then
		Unit.animation_event(unit, anim_state_event)
	end

	return 
end
AIInventoryExtension.destroy = function (self)
	local unit_spawner = Managers.state.unit_spawner
	local world = self.world
	local inventory_items_n = self.inventory_items_n
	local inventory_item_units = self.inventory_item_units
	local dropped_items = self.dropped_items

	for i = 1, inventory_items_n, 1 do
		local item_unit = inventory_item_units[i]

		unit_spawner.mark_for_deletion(unit_spawner, item_unit)

		local dropped_item_unit = dropped_items[i]

		if dropped_item_unit then
			World.destroy_unit(world, dropped_item_unit)
		end
	end

	return 
end
AIInventoryExtension.show_single_item = function (self, item_inventory_index, show)
	if script_data.ai_debug_inventory then
		printf("[AIInventorySystem] showing[%s] item_inventory_index[%d]", tostring(show), item_inventory_index)
	end

	local item_unit = self.inventory_item_units[item_inventory_index]
	self.hidden_item_index = (not show and item_inventory_index) or nil

	Unit.set_unit_visibility(item_unit, show)

	return 
end
AIInventoryExtension.get_unit = function (self, category)
	return self.inventory_item_units_by_category[category]
end
AIInventoryExtension.get_item_inventory_index = function (self, item_unit)
	for i = 1, self.inventory_items_n, 1 do
		if self.inventory_item_units[i] == item_unit then
			return i
		end
	end

	assert(false, "item_unit not found in ai inventory")

	return 
end
AIInventoryExtension.drop_single_item = function (self, item_inventory_index)
	if script_data.ai_debug_inventory then
		printf("[AIInventorySystem] dropping item_inventory_index[%d] with [%d] total items in inventory", item_inventory_index, self.inventory_items_n)
	end

	assert(self.inventory_item_units[item_inventory_index], "item inventory index out of bounds")

	if self.dropped_items[item_inventory_index] ~= nil then
		return 
	end

	local item_unit = self.inventory_item_units[item_inventory_index]
	local item = self.inventory_item_definitions[item_inventory_index]
	local item_unit_name = item.drop_unit_name or item.unit_name
	local item_unit_template_name = "ai_inventory_item"
	local position = Unit.world_position(item_unit, 0)
	local rotation = Unit.world_rotation(item_unit, 0)
	local new_item_unit = World.spawn_unit(self.world, item_unit_name, position, rotation, nil)

	Unit.flow_event(new_item_unit, "lua_dropped")

	local actor = Unit.create_actor(new_item_unit, "rp_dropped")

	Actor.add_angular_velocity(actor, Vector3(math.random(), math.random(), math.random()) * 2)
	Actor.add_velocity(actor, Vector3.up() * 2)

	self.dropped_items[item_inventory_index] = new_item_unit

	World.unlink_unit(self.world, item_unit)
	Unit.disable_physics(item_unit)
	Unit.set_unit_visibility(item_unit, false)

	ScriptUnit.extension(item_unit, "ai_inventory_item_system").wielding_unit = nil

	return 
end
AIInventoryExtension.play_hit_sound = function (self, victim_unit, damage_type)
	local inventory_configuration_name = self.inventory_configuration_name
	local inventory_configuration = InventoryConfigurations[inventory_configuration_name]
	local enemy_hit_sound = inventory_configuration.enemy_hit_sound

	if enemy_hit_sound == nil then
		return 
	end

	local owner = Managers.player:owner(victim_unit)
	local is_husk = owner.remote or owner.bot_player or false

	EffectHelper.play_melee_hit_effects_enemy("enemy_hit", enemy_hit_sound, self.world, victim_unit, damage_type, is_husk)

	return 
end
AIInventoryExtension.hot_join_sync = function (self, sender)
	if self.hidden_item_index and Unit.alive(self.unit) then
		local go_id = Managers.state.unit_storage:go_id(self.unit)

		RPC.rpc_ai_show_single_item(sender, go_id, self.hidden_item_index, false)
	end

	if self.dropped then
	elseif self.wielded then
		local go_id = Managers.state.unit_storage:go_id(self.unit)

		if go_id then
			RPC.rpc_ai_inventory_wield(sender, go_id)
		end
	end

	return 
end

return 
