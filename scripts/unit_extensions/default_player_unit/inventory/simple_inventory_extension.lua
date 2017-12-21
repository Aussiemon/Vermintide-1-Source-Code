-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
require("scripts/unit_extensions/default_player_unit/inventory/gear_utils")
require("scripts/managers/backend/backend_utils")

SimpleInventoryExtension = class(SimpleInventoryExtension)
local TraitUsingSlotTypes = {
	melee = true,
	ranged = true
}
local empty_trait_table = {}
SimpleInventoryExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._world = extension_init_context.world
	self._unit = unit
	self._profile = extension_init_data.profile
	self._profile_index = FindProfileIndex(self._profile.display_name)
	self._attached_units = {}
	self._equipment = {
		slots = {},
		item_data = {}
	}
	local player = extension_init_data.player
	self.is_server = Managers.player.is_server
	self.is_bot = player.bot_player or false
	self.player = player
	self.initial_inventory = extension_init_data.initial_inventory
	self.initial_ammo_percent = extension_init_data.ammo_percent
	self._show_first_person = true
	self._show_third_person = false
	self._show_first_person_lights = true
	self.current_item_buffs = {
		wield = {},
		equip = {
			slot_melee = {},
			slot_ranged = {}
		}
	}
	self.recently_acquired_list = {}

	return 
end
SimpleInventoryExtension.extensions_ready = function (self, world, unit)
	local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
	self.first_person_extension = first_person_extension
	self._first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)
	self.buff_extension = ScriptUnit.extension(unit, "buff_system")
	local equipment = self._equipment
	local profile = self._profile
	local unit_1p = self._first_person_unit
	local unit_3p = self._unit

	self.add_equipment_by_category(self, "weapon_slots")
	self.add_equipment_by_category(self, "enemy_weapon_slots")
	Unit.set_data(self._first_person_unit, "equipment", self._equipment)

	if profile.default_wielded_slot then
		local default_wielded_slot = profile.default_wielded_slot
		local slot_data = self._equipment.slots[default_wielded_slot]

		if not slot_data then
			table.dump(self._equipment.slots, "self._equipment.slots", 1)
			Application.error("Tried to wield default slot %s that contained no weapon.", default_wielded_slot)
		end

		GearUtils.wield_slot(equipment, slot_data, unit_1p, unit_3p)

		local item_data = slot_data.item_data
		local item_template = BackendUtils.get_item_template(item_data)

		self._spawn_attached_units(self, item_template.first_person_attached_units)

		local uses_traits = TraitUsingSlotTypes[item_data.slot_type]
		local is_bot = self.is_bot

		if uses_traits and not is_bot then
			local backend_id = item_data.backend_id

			fassert(backend_id, "missing backend id for non temporary item")

			local traits = self._get_traits(self, item_data)

			self.apply_buffs(self, traits, "wield", item_data.name, default_wielded_slot)
		else
			self.apply_buffs(self, empty_trait_table, "wield", item_data.name, default_wielded_slot)
		end
	end

	self._equipment.wielded_slot = profile.default_wielded_slot

	return 
end
SimpleInventoryExtension.add_equipment_by_category = function (self, category)
	local profile = self._profile
	local category_slots = InventorySettings[category]
	local num_slots = #category_slots

	for i = 1, num_slots, 1 do
		local slot = category_slots[i]
		local slot_name = slot.name
		local item_data = ItemHelper.get_loadout_item(slot_name, profile)

		if not item_data then
			local item_name = self.initial_inventory[slot_name]
			item_data = rawget(ItemMasterList, item_name)
		else
			self.add_equipment(self, slot_name, item_data, nil, nil, self.initial_ammo_percent[slot_name])
		end
	end

	return 
end
SimpleInventoryExtension.destroy = function (self)
	for slot_id, slot_data in pairs(self._equipment.slots) do
		GearUtils.destroy_slot(self._world, self._unit, slot_data, self._equipment, true)
	end

	self._despawn_attached_units(self)

	return 
end
SimpleInventoryExtension.equipment = function (self)
	return self._equipment
end
local wield_time = 0.2
SimpleInventoryExtension.update = function (self, unit, input, dt, context, t)
	if script_data.debug_equip_all_weapons and DebugKeyHandler.key_pressed("i", "thing", "thang") then
		local player = Managers.player:local_player()
		local profile_index = player.profile_index
		self.profile_name = SPProfiles[profile_index].display_name
		self.lets_do_this = true
		self.melee_items_to_test = BackendUtils.get_inventory_items(self.profile_name, "melee")
		self.ranged_items_to_test = BackendUtils.get_inventory_items(self.profile_name, "ranged")
		self.current_debug_index = 0
		self.wielded_that_shiz = false
		self.loaded_slot = "slot_ranged"
		self.time_till_next_load = 0
	end

	if self.lets_do_this and not self._item_to_spawn then
		if not self.wielded_that_shiz then
			self.wielded_that_shiz = true
			self.time_till_next_load = t + wield_time

			self.wield(self, self.loaded_slot)
		end

		if self.time_till_next_load <= t then
			local next_index = (self.loaded_slot == "slot_ranged" and self.current_debug_index + 1) or self.current_debug_index
			local next_table = (self.loaded_slot == "slot_ranged" and self.melee_items_to_test) or self.ranged_items_to_test
			local next_slot = (self.loaded_slot == "slot_ranged" and "slot_melee") or "slot_ranged"

			if not self.melee_items_to_test[next_index] and not self.ranged_items_to_test[next_index] then
				print("DING FRIES ARE DONE")

				self.lets_do_this = false
			end

			if next_table[next_index] then
				local item_data = next_table[next_index]
				local item_name = item_data.name
				local test_inventory_icon = UIAtlasHelper.get_atlas_settings_by_texture_name(item_data.inventory_icon)

				fassert(item_data.item_type, "missing item_type for item: %s", item_name)

				local test_hud_icon = UIAtlasHelper.get_atlas_settings_by_texture_name(item_data.hud_icon)

				fassert(item_data.rarity, "missing rarity for item: %s", item_name)
				fassert(item_data.description, "missing description for item: %s", item_name)
				fassert(item_data.right_hand_unit or item_data.left_hand_unit, "no units defined for item: %s", item_name)
				print("Equipping Weapon:", item_name)

				local backend_id = item_data.backend_id

				BackendUtils.set_loadout_item(item_data, self.profile_name, next_slot)
				self.create_equipment_in_slot(self, next_slot, backend_id)
			end

			self.current_debug_index = next_index
			self.loaded_slot = next_slot
			self.wielded_that_shiz = false
		end
	end

	self.update_resync_loadout(self)

	return 
end
SimpleInventoryExtension.recently_acquired = function (self, slot_name)
	local slot_data = self.recently_acquired_list[slot_name]
	self.recently_acquired_list[slot_name] = nil

	return slot_data
end
SimpleInventoryExtension.update_resync_loadout = function (self)
	local equipment_to_spawn = self._item_to_spawn

	if not equipment_to_spawn then
		return 
	end

	if self.resync_loadout_needed then
		self.resync_id = self.resync_loadout(self, equipment_to_spawn)
		self.resync_loadout_needed = false
	end

	local resync_id = self.resync_id

	if resync_id and self.all_clients_loaded_resource(self, resync_id) then
		self.spawn_resynced_loadout(self, equipment_to_spawn)

		self._item_to_spawn = nil
		self.resync_id = nil
	end

	return 
end
SimpleInventoryExtension.can_wield = function (self)
	local equipment = self._equipment
	local current_wielded_slot = self._equipment.wielded_slot
	local slot_data = equipment.slots[current_wielded_slot]
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)
	local can_wield = true

	if item_template.block_wielding then
		can_wield = false
	end

	return can_wield
end
SimpleInventoryExtension.wield_previous = function (self)
	local equipment = self._equipment
	local slot_name = (equipment.previously_wielded_slot ~= "slot_packmaster_claw" and equipment.previously_wielded_slot) or "slot_melee"

	if equipment.slots[slot_name] == nil then
		slot_name = "slot_melee"
	end

	self.wield(self, slot_name)

	return 
end
SimpleInventoryExtension.rewield_wielded_slot = function (self)
	local equipment = self._equipment
	local wielded_slot = equipment.wielded_slot

	self.wield(self, wielded_slot)

	return 
end
SimpleInventoryExtension.wield = function (self, slot_name)
	self._despawn_attached_units(self)

	local equipment = self._equipment
	local slot_data = equipment.slots[slot_name]

	if slot_data == nil then
		return 
	end

	equipment.previously_wielded_slot = equipment.wielded_slot
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)
	local wielded_weapon = GearUtils.wield_slot(equipment, slot_data, self._first_person_unit, self._unit)
	equipment.wielded_slot = slot_name

	CharacterStateHelper.stop_weapon_actions(self, "weapon_wielded")

	local uses_traits = TraitUsingSlotTypes[item_data.slot_type]

	if uses_traits then
		local backend_id = item_data.backend_id

		fassert(backend_id, "missing backend id for non temporary item")

		local traits = self._get_traits(self, item_data)

		self.apply_buffs(self, traits, "wield", item_data.name, slot_name)
	else
		self.apply_buffs(self, empty_trait_table, "wield", item_data.name, slot_name)
	end

	if item_template.buff then
		self.apply_buffs(self, item_template.buff, "wield", item_data.name, slot_name)
	end

	if wielded_weapon then
		self.show_first_person_inventory(self, self._show_first_person)
		self.show_first_person_inventory_lights(self, self._show_first_person_lights)
		self.show_third_person_inventory(self, self._show_third_person)
	end

	local network_manager = Managers.state.network
	local game_session = network_manager.game(network_manager)
	local slot_id = NetworkLookup.equipment_slots[slot_name]
	local go_id = Managers.state.unit_storage:go_id(self._unit)

	if game_session and not LEVEL_EDITOR_TEST then
		if self.is_server then
			network_manager.network_transmit:send_rpc_clients("rpc_wield_equipment", go_id, slot_id)
		else
			network_manager.network_transmit:send_rpc_server("rpc_wield_equipment", go_id, slot_id)
		end
	end

	self._spawn_attached_units(self, item_template.first_person_attached_units)

	return 
end
SimpleInventoryExtension._despawn_attached_units = function (self)
	local attached_units = self._attached_units
	local world = self._world

	for index, attached_unit in pairs(attached_units) do
		Managers.state.unit_spawner:mark_for_deletion(attached_unit)

		attached_units[index] = nil
	end

	return 
end
SimpleInventoryExtension._spawn_attached_units = function (self, attached_units)
	if attached_units == nil then
		return 
	end

	local unit = self._unit
	local world = self._world
	local own_attached_units = self._attached_units

	for index, attached_unit in pairs(attached_units) do
		local spawned_unit = AttachmentUtils.create_weapon_visual_attachment(world, unit, attached_unit.unit, attached_unit.attachment_node_linking)
		own_attached_units[index] = spawned_unit
	end

	return 
end
local trait_params = {}
SimpleInventoryExtension.apply_buffs = function (self, buffs, reason, item_name, slot_name)
	local buff_extension = self.buff_extension
	local current_item_buffs = self.current_item_buffs[reason]

	if reason == "wield" then
		for _, buff_id in pairs(current_item_buffs) do
			buff_extension.remove_buff(buff_extension, buff_id)
		end

		table.clear(current_item_buffs)
	elseif reason == "equip" then
		current_item_buffs = current_item_buffs[slot_name]

		if current_item_buffs then
			for _, buff_id in pairs(current_item_buffs) do
				buff_extension.remove_buff(buff_extension, buff_id)
			end

			table.clear(current_item_buffs)
		end
	end

	local num_new_buffs = #buffs

	for i = 1, num_new_buffs, 1 do
		local buff_data = buffs[i]
		local buff_name = buff_data.trait_name

		fassert(BuffTemplates[buff_name], "trait / buff name %s does not exist on item %s, typo?", buff_name, item_name)

		local apply_on = BuffTemplates[buff_name].apply_on

		if apply_on and apply_on == reason then
			table.clear(trait_params)

			local params = trait_params
			local proc_chance = buff_data.proc_chance
			local multiplier = buff_data.multiplier
			local bonus = buff_data.bonus

			if proc_chance then
				params.external_optional_proc_chance = proc_chance
			end

			if multiplier then
				params.external_optional_multiplier = multiplier
			end

			if bonus then
				params.external_optional_bonus = bonus
			end

			current_item_buffs[i] = buff_extension.add_buff(buff_extension, buff_name, params)
		end
	end

	return 
end
SimpleInventoryExtension.add_equipment = function (self, slot_name, item_data, unit_template, extra_extension_data, ammo_percent)
	local world = self._world
	local equipment = self._equipment
	local unit_1p = self._first_person_unit
	local unit_3p = self._unit
	local is_bot = self.is_bot
	local uses_traits = TraitUsingSlotTypes[item_data.slot_type]

	if uses_traits and not is_bot then
		local backend_id = item_data.backend_id

		fassert(backend_id, "missing backend id for non temporary item")

		local traits = self._get_traits(self, item_data)

		self.apply_buffs(self, traits, "equip", item_data.name, slot_name)
	else
		self.apply_buffs(self, empty_trait_table, "equip", item_data.name, slot_name)
	end

	local slot_equipment_data = GearUtils.create_equipment(world, slot_name, item_data, unit_1p, unit_3p, is_bot, unit_template, extra_extension_data, ammo_percent)
	slot_equipment_data.master_item = item_data
	equipment.slots[slot_name] = slot_equipment_data
	self.recently_acquired_list[slot_name] = slot_equipment_data

	return 
end
SimpleInventoryExtension.show_particle_effects_on_unit = function (self, unit, show)
	if show then
		Unit.flow_event(unit, "lua_wield")
	else
		Unit.flow_event(unit, "lua_unwield")
	end

	return 
end
SimpleInventoryExtension.show_first_person_inventory_lights = function (self, show)
	self._show_first_person_lights = show
	local right_hand_wielded_unit = self._equipment.right_hand_wielded_unit

	if right_hand_wielded_unit and Unit.has_visibility_group(right_hand_wielded_unit, "normal") then
		local num_lights = Unit.num_lights(right_hand_wielded_unit)

		for i = 1, num_lights, 1 do
			Light.set_enabled(Unit.light(right_hand_wielded_unit, i - 1), show)
		end
	end

	local left_hand_wielded_unit = self._equipment.left_hand_wielded_unit

	if left_hand_wielded_unit and Unit.has_visibility_group(left_hand_wielded_unit, "normal") then
		local num_lights = Unit.num_lights(left_hand_wielded_unit)

		for i = 1, num_lights, 1 do
			Light.set_enabled(Unit.light(left_hand_wielded_unit, i - 1), show)
		end
	end

	return 
end
SimpleInventoryExtension.show_first_person_inventory = function (self, show)
	self._show_first_person = show
	local right_hand_wielded_unit = self._equipment.right_hand_wielded_unit

	if right_hand_wielded_unit then
		if Unit.has_visibility_group(right_hand_wielded_unit, "normal") then
			Unit.set_visibility(right_hand_wielded_unit, "normal", show)
		else
			Unit.set_unit_visibility(right_hand_wielded_unit, show)
		end

		local right_hand_ammo_unit_1p = self._equipment.right_hand_ammo_unit_1p

		if right_hand_ammo_unit_1p then
			Unit.set_unit_visibility(right_hand_ammo_unit_1p, show)
		end

		if show then
			Unit.flow_event(right_hand_wielded_unit, "lua_wield")

			if right_hand_ammo_unit_1p then
				Unit.flow_event(right_hand_ammo_unit_1p, "lua_wield")
			end
		else
			Unit.flow_event(right_hand_wielded_unit, "lua_unwield")

			if right_hand_ammo_unit_1p then
				Unit.flow_event(right_hand_ammo_unit_1p, "lua_unwield")
			end
		end
	end

	local left_hand_wielded_unit = self._equipment.left_hand_wielded_unit

	if left_hand_wielded_unit then
		if Unit.has_visibility_group(left_hand_wielded_unit, "normal") then
			Unit.set_visibility(left_hand_wielded_unit, "normal", show)
		else
			Unit.set_unit_visibility(left_hand_wielded_unit, show)
		end

		local left_hand_ammo_unit_1p = self._equipment.left_hand_ammo_unit_1p

		if left_hand_ammo_unit_1p then
			Unit.set_unit_visibility(left_hand_ammo_unit_1p, show)
		end

		if show then
			Unit.flow_event(left_hand_wielded_unit, "lua_wield")

			if left_hand_ammo_unit_1p then
				Unit.flow_event(left_hand_ammo_unit_1p, "lua_wield")
			end
		else
			Unit.flow_event(left_hand_wielded_unit, "lua_unwield")

			if left_hand_ammo_unit_1p then
				Unit.flow_event(left_hand_ammo_unit_1p, "lua_unwield")
			end
		end
	end

	self._despawn_attached_units(self)

	local equipment = self._equipment
	local current_wielded_slot = equipment.wielded_slot

	if current_wielded_slot then
		local slot_data = equipment.slots[current_wielded_slot]

		if slot_data then
			local item_data = slot_data.item_data
			local item_template = BackendUtils.get_item_template(item_data)

			if show then
				self._spawn_attached_units(self, item_template.first_person_attached_units)
			else
				self._spawn_attached_units(self, item_template.third_person_attached_units)
			end
		end
	end

	return 
end
SimpleInventoryExtension.show_third_person_inventory = function (self, show)
	self._show_third_person = show
	local right_hand_wielded_unit = self._equipment.right_hand_wielded_unit_3p

	if right_hand_wielded_unit then
		if Unit.has_visibility_group(right_hand_wielded_unit, "normal") then
			Unit.set_visibility(right_hand_wielded_unit, "normal", show)
		else
			Unit.set_unit_visibility(right_hand_wielded_unit, show)
		end

		local right_hand_ammo_unit_3p = self._equipment.right_hand_ammo_unit_3p

		if right_hand_ammo_unit_3p then
			Unit.set_unit_visibility(right_hand_ammo_unit_3p, show)
		end

		if show then
			Unit.flow_event(right_hand_wielded_unit, "lua_wield")

			if right_hand_ammo_unit_3p then
				Unit.flow_event(right_hand_ammo_unit_3p, "lua_wield")
			end
		else
			Unit.flow_event(right_hand_wielded_unit, "lua_unwield")

			if right_hand_ammo_unit_3p then
				Unit.flow_event(right_hand_ammo_unit_3p, "lua_unwield")
			end
		end
	end

	local left_hand_wielded_unit = self._equipment.left_hand_wielded_unit_3p

	if left_hand_wielded_unit then
		if Unit.has_visibility_group(left_hand_wielded_unit, "normal") then
			Unit.set_visibility(left_hand_wielded_unit, "normal", show)
		else
			Unit.set_unit_visibility(left_hand_wielded_unit, show)
		end

		local left_hand_ammo_unit_3p = self._equipment.left_hand_ammo_unit_3p

		if left_hand_ammo_unit_3p then
			Unit.set_unit_visibility(left_hand_ammo_unit_3p, show)
		end

		if show then
			Unit.flow_event(left_hand_wielded_unit, "lua_wield")

			if left_hand_ammo_unit_3p then
				Unit.flow_event(left_hand_ammo_unit_3p, "lua_wield")
			end
		else
			Unit.flow_event(left_hand_wielded_unit, "lua_unwield")

			if left_hand_ammo_unit_3p then
				Unit.flow_event(left_hand_ammo_unit_3p, "lua_unwield")
			end
		end
	end

	self._despawn_attached_units(self)

	local equipment = self._equipment
	local current_wielded_slot = self._equipment.wielded_slot

	if current_wielded_slot then
		local slot_data = equipment.slots[current_wielded_slot]

		if slot_data then
			local item_data = slot_data.item_data
			local item_template = BackendUtils.get_item_template(item_data)

			if show then
				self._spawn_attached_units(self, item_template.third_person_attached_units)
			else
				self._spawn_attached_units(self, item_template.first_person_attached_units)
			end
		end
	end

	return 
end
SimpleInventoryExtension.hot_join_sync = function (self, sender)
	GearUtils.hot_join_sync(sender, self._unit, self._equipment)

	return 
end
SimpleInventoryExtension.destroy_slot = function (self, slot_name, allow_destroy_weapon)
	local equipment = self._equipment
	local slot_data = equipment.slots[slot_name]

	if slot_data == nil then
		return 
	end

	local weapon_unit_1p = slot_data.right_unit_1p or slot_data.left_unit_1p

	if Managers.player.is_server and ScriptUnit.has_extension(weapon_unit_1p, "limited_item_track_system") then
		local weapon_limited_item_track_extension = ScriptUnit.extension(weapon_unit_1p, "limited_item_track_system")

		if not weapon_limited_item_track_extension.thrown then
			local spawner_unit = weapon_limited_item_track_extension.spawner_unit
			local spawner_limited_item_track_extension = ScriptUnit.extension(spawner_unit, "limited_item_track_system")
			local limited_item_id = weapon_limited_item_track_extension.id

			if spawner_limited_item_track_extension.is_transformed(spawner_limited_item_track_extension, limited_item_id) then
				local limited_item_track_system = Managers.state.entity:system("limited_item_track_system")

				limited_item_track_system.held_limited_item_destroyed(limited_item_track_system, spawner_unit, limited_item_id)
			end
		end
	end

	local go_id = Managers.state.unit_storage:go_id(self._unit)
	local slot_id = NetworkLookup.equipment_slots[slot_name]
	local network_manager = Managers.state.network

	if Managers.state.network:game() and not LEVEL_EDITOR_TEST then
		if self.is_server then
			network_manager.network_transmit:send_rpc_clients("rpc_destroy_slot", go_id, slot_id)
		else
			network_manager.network_transmit:send_rpc_server("rpc_destroy_slot", go_id, slot_id)
		end
	end

	GearUtils.destroy_slot(self._world, self._unit, slot_data, equipment, allow_destroy_weapon)

	return 
end
SimpleInventoryExtension.current_ammo_status = function (self, slot_name)
	local slot_data = self._equipment.slots[slot_name]
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)
	local ammo_data = item_template.ammo_data

	if ammo_data then
		local max = ammo_data.max_ammo
		local right_unit = slot_data.right_unit_1p
		local left_unit = slot_data.left_unit_1p
		local ammo_extension = (right_unit and ScriptUnit.has_extension(right_unit, "ammo_system") and ScriptUnit.extension(right_unit, "ammo_system")) or (left_unit and ScriptUnit.has_extension(left_unit, "ammo_system") and ScriptUnit.extension(left_unit, "ammo_system"))

		return ammo_extension.total_remaining_ammo(ammo_extension), max
	end

	return 
end
SimpleInventoryExtension.current_overcharge_status = function (self, slot_name)
	local slot_data = self._equipment.slots[slot_name]
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)
	local overcharge_data = item_template.overcharge_data

	if overcharge_data then
		local right_unit = slot_data.right_unit_1p
		local left_unit = slot_data.left_unit_1p
		local overcharge_extension = (right_unit and ScriptUnit.has_extension(right_unit, "overcharge_system") and ScriptUnit.extension(right_unit, "overcharge_system")) or (left_unit and ScriptUnit.has_extension(left_unit, "overcharge_system") and ScriptUnit.extension(left_unit, "overcharge_system"))

		return overcharge_extension.get_overcharge_value(overcharge_extension), overcharge_extension.get_overcharge_threshold(overcharge_extension), overcharge_extension.get_max_value(overcharge_extension)
	end

	return 
end
SimpleInventoryExtension.add_ammo_from_pickup = function (self, pickup_settings)
	local equipment = self._equipment
	local slots = equipment.slots

	for slot_name, slot_data in pairs(slots) do
		local item_data = slot_data.item_data
		local item_template = BackendUtils.get_item_template(item_data)
		local ammo_data = item_template.ammo_data

		if ammo_data and not ammo_data.ignore_ammo_pickup then
			self._add_ammo_to_slot(self, slot_name, slot_data)
		end
	end

	return 
end
SimpleInventoryExtension._add_ammo_to_slot = function (self, slot_name, slot_data)
	local left_hand_unit = slot_data.left_unit_1p
	local right_hand_unit = slot_data.right_unit_1p
	local ammo_extension = nil

	if left_hand_unit and ScriptUnit.has_extension(left_hand_unit, "ammo_system") then
		ammo_extension = ScriptUnit.extension(left_hand_unit, "ammo_system")
	end

	if right_hand_unit then
		if ScriptUnit.has_extension(right_hand_unit, "ammo_system") then
			ammo_extension = ScriptUnit.extension(right_hand_unit, "ammo_system")
		elseif not ammo_extension then
			return 
		end
	elseif not ammo_extension then
		return 
	end

	ammo_extension.add_ammo(ammo_extension)

	local should_reload_now = ammo_extension.reload_on_ammo_pickup or ammo_extension.ammo_count(ammo_extension) == 0

	if should_reload_now and self._equipment.wielded_slot == slot_name and ammo_extension.can_reload(ammo_extension) then
		local play_reload_animation = true

		ammo_extension.start_reload(ammo_extension, play_reload_animation)
	end

	return 
end
SimpleInventoryExtension.get_item_template = function (self, slot_data)
	local item_data = slot_data.item_data
	local item_template = BackendUtils.get_item_template(item_data)

	return item_template
end
SimpleInventoryExtension.get_wielded_slot_item_template = function (self)
	local slot_name = self.get_wielded_slot_name(self)
	local slot_data = self.get_slot_data(self, slot_name)

	if not slot_data then
		return nil
	end

	return self.get_item_template(self, slot_data)
end
SimpleInventoryExtension.get_wielded_slot_name = function (self)
	local equipment = self._equipment
	local wielded_slot = equipment.wielded_slot

	return wielded_slot
end
SimpleInventoryExtension.get_slot_data = function (self, slot_id)
	local equipment = self._equipment
	local slots = equipment.slots

	return slots[slot_id]
end
SimpleInventoryExtension.resync_loadout = function (self, equipment_to_spawn)
	if not equipment_to_spawn then
		return 
	end

	local network_manager = Managers.state.network
	local resync_id = network_manager.profile_synchronizer:resync_loadout(self._profile_index, self.player)

	return resync_id
end
SimpleInventoryExtension.create_equipment_in_slot = function (self, slot_id, backend_id)
	local item_data = BackendUtils.get_item_from_masterlist(backend_id)
	local slot_data = self._equipment.slots[slot_id]
	local item_template = BackendUtils.get_item_template(item_data)
	local item_units = BackendUtils.get_item_units(item_data)
	local weapon_already_equiped = slot_data.item_data == item_data
	local item_name = item_data.name

	if weapon_already_equiped then
		return 
	end

	self.destroy_slot(self, slot_id, true)

	self._item_to_spawn = {
		slot_id = slot_id,
		item_data = item_data
	}

	self.update_gameobject(self, slot_id, item_name)

	self.resync_loadout_needed = true

	return 
end
SimpleInventoryExtension.update_gameobject = function (self, slot_id, item_name)
	GearUtils.update_gameobject(self._unit, slot_id, item_name)

	return 
end
SimpleInventoryExtension.spawn_resynced_loadout = function (self, equipment_to_spawn)
	local item_data = equipment_to_spawn.item_data
	local slot_name = equipment_to_spawn.slot_id
	local network_manager = Managers.state.network
	local unit_object_id = Managers.state.unit_storage:go_id(self._unit)
	local slot_id = NetworkLookup.equipment_slots[slot_name]
	local item_id = NetworkLookup.item_names[item_data.name]
	local is_server = self.is_server

	if is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_add_equipment", unit_object_id, slot_id, item_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_add_equipment", unit_object_id, slot_id, item_id)
	end

	self.add_equipment(self, slot_name, item_data)
	self.wield(self, slot_name)

	return 
end
SimpleInventoryExtension.all_clients_loaded_resource = function (self, resync_id)
	local profile_synchronizer = Managers.state.network.profile_synchronizer
	local all_clients_have_loaded_resources = profile_synchronizer.all_clients_have_loaded_sync_id(profile_synchronizer, resync_id)

	return all_clients_have_loaded_resources
end
local slots_to_check = {
	slot_ranged = true,
	slot_melee = true
}
SimpleInventoryExtension.has_ammo_consuming_weapon_equipped = function (self)
	local equipment = self._equipment
	local inventory_slots = equipment.slots

	for slot_name, slot_data in pairs(inventory_slots) do
		if slots_to_check[slot_name] then
			local left_hand_unit = slot_data.left_unit_1p
			local right_hand_unit = slot_data.right_unit_1p

			if (left_hand_unit and ScriptUnit.has_extension(left_hand_unit, "ammo_system")) or (right_hand_unit and ScriptUnit.has_extension(right_hand_unit, "ammo_system")) then
				return true
			end
		end
	end

	return false
end
SimpleInventoryExtension.apply_buffs_to_ammo = function (self)
	local equipment = self._equipment
	local inventory_slots = equipment.slots

	for slot_name, slot_data in pairs(inventory_slots) do
		if slots_to_check[slot_name] then
			local left_hand_unit = slot_data.left_unit_1p
			local right_hand_unit = slot_data.right_unit_1p

			if left_hand_unit and ScriptUnit.has_extension(left_hand_unit, "ammo_system") then
				local ammo_extension = ScriptUnit.extension(left_hand_unit, "ammo_system")
				local item_data = slot_data.item_data
				local buffs = self._get_traits(self, item_data)

				self.apply_buffs(self, buffs, "equip", item_data.name, slot_name)
				ammo_extension.apply_buffs(ammo_extension, left_hand_unit)
			end

			if right_hand_unit and ScriptUnit.has_extension(right_hand_unit, "ammo_system") then
				local ammo_extension = ScriptUnit.extension(right_hand_unit, "ammo_system")
				local item_data = slot_data.item_data
				local buffs = self._get_traits(self, item_data)

				self.apply_buffs(self, buffs, "equip", item_data.name, slot_name)
				ammo_extension.apply_buffs(ammo_extension, right_hand_unit)
			end
		end
	end

	return 
end
SimpleInventoryExtension.has_full_ammo = function (self)
	local equipment = self._equipment
	local inventory_slots = equipment.slots
	local full_ammo = true

	for slot_name, slot_data in pairs(inventory_slots) do
		if slots_to_check[slot_name] then
			local left_hand_unit = slot_data.left_unit_1p
			local right_hand_unit = slot_data.right_unit_1p
			local ammo_extension = ScriptUnit.has_extension(right_hand_unit, "ammo_system") and ScriptUnit.extension(right_hand_unit, "ammo_system")
			ammo_extension = ammo_extension or (ScriptUnit.has_extension(left_hand_unit, "ammo_system") and ScriptUnit.extension(left_hand_unit, "ammo_system"))

			if ammo_extension and not ammo_extension.full_ammo(ammo_extension) then
				full_ammo = false

				break
			end
		end
	end

	return full_ammo
end
SimpleInventoryExtension.drop_level_event_item = function (self, slot_data)
	local item_template = self.get_item_template(self, slot_data)
	local weapon_unit = slot_data.right_unit_1p or slot_data.left_unit_1p
	local action = item_template.actions.action_one.default
	local projectile_info = action.projectile_info
	local unit = self._unit
	local position = Unit.world_position(unit, 0) + Vector3(0, 0, 2)
	local proj_rotation = Quaternion.identity()
	local velocity = Vector3(math.random(), math.random(), math.random())
	local angular_velocity_transformed = Vector3(math.random(), math.random(), math.random())
	local item_data = slot_data.item_data
	local item_name = item_data.name
	local spawn_type = "dropped"

	ActionUtils.spawn_pickup_projectile(self._world, weapon_unit, projectile_info.projectile_unit_name, projectile_info.projectile_unit_template_name, action, unit, position, proj_rotation, velocity, angular_velocity_transformed, item_name, spawn_type)
	self.destroy_slot(self, "slot_level_event")

	return 
end
SimpleInventoryExtension.check_and_drop_pickups = function (self, drop_reason)
	local unit = self._unit
	local equipment = self._equipment
	local inventory_slots = equipment.slots
	local slot_settings = InventorySettings.slots_by_name
	local current_wielded_slot = self.get_wielded_slot_name(self)
	local i = 0

	for slot_name, slot_data in pairs(inventory_slots) do
		if slot_data then
			local item_data = slot_data.item_data
			local item_template = BackendUtils.get_item_template(item_data)
			local pickup_data = item_template.pickup_data
			local slot_drop_reasons = slot_settings[slot_name].drop_reasons
			local should_drop = slot_drop_reasons and slot_drop_reasons[drop_reason]

			if should_drop then
				if pickup_data and slot_name ~= "slot_level_event" then
					local random_vector = Vector3(math.random(-1, 1) + i*2, math.random(-1, 1) + i, math.random(0, 1))
					local random_angle = math.random(-math.half_pi, math.half_pi)
					local random_direction = Vector3.normalize(random_vector)
					local position = POSITION_LOOKUP[unit] + random_vector*0.2
					local rotation = Quaternion.axis_angle(random_direction, random_angle)
					local pickup_name = pickup_data.pickup_name
					local pickup_name_id = NetworkLookup.pickup_names[pickup_name]
					local pickup_spawn_type = "dropped"
					local pickup_spawn_type_id = NetworkLookup.pickup_spawn_types[pickup_spawn_type]
					local network_manager = Managers.state.network

					network_manager.network_transmit:send_rpc_server("rpc_spawn_pickup_with_physics", pickup_name_id, position, rotation, pickup_spawn_type_id)

					i = i + 1
				elseif slot_name == "slot_level_event" then
					self.drop_level_event_item(self, slot_data)
				end

				self.destroy_slot(self, slot_name)

				if slot_name == current_wielded_slot then
					self.wield(self, "slot_melee")
				end
			end
		end
	end

	return 
end
SimpleInventoryExtension.resyncing_loadout = function (self)
	return self.resync_id
end
SimpleInventoryExtension._get_traits = function (self, item_data)
	local backend_id = item_data.backend_id

	if script_data.unlock_all_weapon_traits then
		local trait_names = item_data.traits
		local traits = {}

		for i = 1, #trait_names, 1 do
			local trait_name = trait_names[i]
			local trait = BuffTemplates[trait_name]
			traits[i] = {
				trait_name = trait_name
			}
			local proc_chances = trait.buffs[1].proc_chance

			if proc_chances then
				traits[i].proc_chance = proc_chances[2]
			end
		end

		return traits
	end

	return BackendUtils.get_traits(backend_id)
end

return 
