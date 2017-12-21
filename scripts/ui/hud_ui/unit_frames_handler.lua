require("scripts/ui/hud_ui/unit_frame_ui")

local character_portrait_mapping = {
	witch_hunter = "unit_frame_portrait_witch_hunter",
	empire_soldier = "unit_frame_portrait_empire_soldier",
	dwarf_ranger = "unit_frame_portrait_dwarf_ranger",
	test_profile = "unit_frame_portrait_empire_soldier",
	wood_elf = "unit_frame_portrait_way_watcher",
	bright_wizard = "unit_frame_portrait_bright_wizard",
	downed = "unit_frame_portrait_downed",
	dead = "unit_frame_portrait_dead"
}
local character_portrait_mapping_point_sample = {
	witch_hunter = "unit_frame_portrait_witch_hunter_point_sample",
	empire_soldier = "unit_frame_portrait_empire_soldier_point_sample",
	dwarf_ranger = "unit_frame_portrait_dwarf_ranger_point_sample",
	test_profile = "unit_frame_portrait_empire_soldier_point_sample",
	wood_elf = "unit_frame_portrait_way_watcher_point_sample",
	bright_wizard = "unit_frame_portrait_bright_wizard_point_sample",
	downed = "unit_frame_portrait_downed",
	dead = "unit_frame_portrait_dead"
}
local allowed_consumable_slots = {
	slot_healthkit = true,
	slot_grenade = true,
	slot_potion = true
}
local allowed_weapon_slots = {
	slot_ranged = true,
	slot_melee = true
}
local MIN_HEALTH_DIVIDERS = 0
local MAX_HEALTH_DIVIDERS = 10
local NUM_TEAM_MEMBERS = 3
UnitFramesHandler = class(UnitFramesHandler)
local DO_RELOAD = true
UnitFramesHandler.init = function (self, ingame_ui_context)
	self.ingame_ui_context = ingame_ui_context
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.peer_id = ingame_ui_context.peer_id
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.player_manager = ingame_ui_context.player_manager
	self.lobby = ingame_ui_context.network_lobby
	self.my_player = ingame_ui_context.player
	local network_manager = Managers.state.network
	local network_transmit = network_manager.network_transmit
	local server_peer_id = network_transmit.server_peer_id
	self.host_peer_id = server_peer_id or network_transmit.peer_id
	self.platform = Application.platform()
	self._unit_frames = {}
	self.unit_frame_index_by_ui_id = {}

	self._create_player_unit_frame(self)
	self._create_team_members_unit_frames(self)
	rawset(_G, "unit_frames_handler", self)

	self._current_frame_index = 1

	return 
end

local function get_portrait_name_by_profile_index(profile_index)
	local scale = RESOLUTION_LOOKUP.scale
	local portrait_mapping = character_portrait_mapping
	local portrait_mapping_point_sample = character_portrait_mapping_point_sample
	local profile_data = SPProfiles[profile_index]
	local display_name = profile_data.display_name
	local character_portrait = portrait_mapping[display_name]
	local character_portrait_point_sample = scale == 1 and portrait_mapping_point_sample[display_name]

	return character_portrait, character_portrait_point_sample
end

UnitFramesHandler._create_player_unit_frame = function (self)
	local unit_frame = self._create_unit_frame_by_type(self, "player")
	local player = self.my_player
	local player_ui_id = player.ui_id(player)
	local player_data = {
		player_ui_id = player_ui_id,
		player = player,
		own_player = true,
		peer_id = player.network_id(player),
		local_player_id = player.local_player_id(player)
	}
	unit_frame.player_data = player_data
	unit_frame.sync = true
	self._unit_frames[1] = unit_frame
	self.unit_frame_index_by_ui_id[player_ui_id] = 1

	return 
end
UnitFramesHandler._create_team_members_unit_frames = function (self)
	local player_manager = self.player_manager
	local players = self.player_manager:human_and_bot_players()
	local unit_frames = self._unit_frames

	for i = 1, NUM_TEAM_MEMBERS, 1 do
		local unit_frame = self._create_unit_frame_by_type(self, "team", i)
		unit_frames[#unit_frames + 1] = unit_frame
	end

	self._align_team_member_frames(self)

	return 
end
UnitFramesHandler._create_unit_frame_by_type = function (self, frame_type, frame_index)
	local ingame_ui_context = self.ingame_ui_context
	local unit_frame = {}
	local state_data = {}
	local player_data = {}
	local definitions = nil

	if frame_type == "team" then
		definitions = local_require("scripts/ui/hud_ui/team_member_unit_frame_ui_definitions")
	elseif frame_type == "player" then
		local gamepad_active = self.input_manager:is_device_active("gamepad")

		if self.platform ~= "win32" or gamepad_active then
			definitions = local_require("scripts/ui/hud_ui/player_console_unit_frame_ui_definitions")
			unit_frame.gamepad_version = true
		else
			definitions = local_require("scripts/ui/hud_ui/player_unit_frame_ui_definitions")
		end
	else
		definitions = local_require("scripts/ui/hud_ui/team_member_unit_frame_ui_definitions")
	end

	unit_frame.data = state_data
	unit_frame.player_data = player_data
	unit_frame.definitions = definitions
	unit_frame.features_list = definitions.features_list
	unit_frame.widget = UnitFrameUI:new(ingame_ui_context, definitions, state_data, frame_index)

	return unit_frame
end
UnitFramesHandler._get_unused_unit_frame = function (self)
	for index, unit_frame in ipairs(self._unit_frames) do
		if not unit_frame.player_data.player then
			return unit_frame, index
		end
	end

	return 
end
UnitFramesHandler._reset_unit_frame = function (self, unit_frame)
	local widget = unit_frame.widget

	widget.reset(widget)
	table.clear(unit_frame.player_data)
	table.clear(unit_frame.data)

	unit_frame.sync = false

	return 
end
local temp_active_ui_ids = {}
UnitFramesHandler._handle_unit_frame_assigning = function (self)
	local player_manager = self.player_manager
	local players = self.player_manager:human_and_bot_players()
	local unit_frames = self._unit_frames
	local unit_frame_index_by_ui_id = self.unit_frame_index_by_ui_id
	local my_player = self.my_player

	table.clear(temp_active_ui_ids)

	local frames_changed = false

	for index, player in pairs(players) do
		local player_ui_id = player.ui_id(player)
		local player_peer_id = player.network_id(player)
		temp_active_ui_ids[player_ui_id] = true
		local own_player = player == my_player

		if not own_player and not unit_frame_index_by_ui_id[player_ui_id] then
			local avaiable_unit_frame, unit_frame_index = self._get_unused_unit_frame(self)

			if avaiable_unit_frame then
				unit_frame_index_by_ui_id[player_ui_id] = unit_frame_index

				table.clear(avaiable_unit_frame.data)

				local player_data = {
					player_ui_id = player_ui_id,
					player = player,
					own_player = own_player,
					peer_id = player_peer_id,
					local_player_id = player.local_player_id(player)
				}
				avaiable_unit_frame.player_data = player_data
				avaiable_unit_frame.sync = true
				frames_changed = true
			end
		end
	end

	for index, unit_frame in ipairs(unit_frames) do
		local player_data = unit_frame.player_data
		local player_ui_id = player_data.player_ui_id

		if player_ui_id and not temp_active_ui_ids[player_ui_id] then
			unit_frame_index_by_ui_id[player_ui_id] = nil

			self._reset_unit_frame(self, unit_frame)

			frames_changed = true
		end
	end

	if frames_changed then
		self._align_team_member_frames(self)
	end

	return 
end
UnitFramesHandler._align_team_member_frames = function (self)
	local position_y = 100
	local start_offset_x = 70
	local count = 0

	for index, unit_frame in ipairs(self._unit_frames) do
		if 1 < index then
			local widget = unit_frame.widget
			local player_data = unit_frame.player_data
			local player_ui_id = player_data.player_ui_id

			if player_ui_id then
				local position_x = start_offset_x + count*340

				widget.set_position(widget, position_x, position_y)

				count = count + 1

				widget.set_visible(widget, true)
			else
				widget.set_visible(widget, false)
			end
		end
	end

	return 
end

local function get_ammunition_count(left_hand_wielded_unit, right_hand_wielded_unit, item_template)
	local ammo_extension = nil

	if not item_template.ammo_data then
		return 
	end

	local ammo_unit_hand = item_template.ammo_data.ammo_hand

	if ammo_unit_hand == "right" then
		ammo_extension = ScriptUnit.extension(right_hand_wielded_unit, "ammo_system")
	elseif ammo_unit_hand == "left" then
		ammo_extension = ScriptUnit.extension(left_hand_wielded_unit, "ammo_system")
	else
		return 
	end

	local ammo_count = ammo_extension.ammo_count(ammo_extension)
	local remaining_ammo = ammo_extension.remaining_ammo(ammo_extension)
	local single_clip = ammo_extension.using_single_clip(ammo_extension)

	return ammo_count, remaining_ammo, single_clip
end

local function get_overcharge_amount(left_hand_wielded_unit, right_hand_wielded_unit)
	local overcharge_extension = nil

	if right_hand_wielded_unit and ScriptUnit.has_extension(right_hand_wielded_unit, "overcharge_system") then
		overcharge_extension = ScriptUnit.extension(right_hand_wielded_unit, "overcharge_system")
	elseif left_hand_wielded_unit and ScriptUnit.has_extension(left_hand_wielded_unit, "overcharge_system") then
		overcharge_extension = ScriptUnit.extension(left_hand_wielded_unit, "overcharge_system")
	end

	if overcharge_extension then
		local overcharge_fraction = overcharge_extension.overcharge_fraction(overcharge_extension)
		local threshold_fraction = overcharge_extension.threshold_fraction(overcharge_extension)
		local anim_blend_overcharge = overcharge_extension.get_anim_blend_overcharge(overcharge_extension)

		return true, overcharge_fraction, threshold_fraction, anim_blend_overcharge
	end

	return 
end

UnitFramesHandler._set_player_extensions = function (self, player_data, player_unit)
	local extensions = {
		health = ScriptUnit.extension(player_unit, "health_system"),
		status = ScriptUnit.extension(player_unit, "status_system"),
		damage = ScriptUnit.extension(player_unit, "damage_system"),
		inventory = ScriptUnit.extension(player_unit, "inventory_system"),
		dialogue = ScriptUnit.extension(player_unit, "dialogue_system"),
		buff = ScriptUnit.extension(player_unit, "buff_system")
	}
	player_data.extensions = extensions
	player_data.player_unit = player_unit

	return 
end
local empty_features_list = {}
UnitFramesHandler._sync_player_stats = function (self, unit_frame)
	if not unit_frame.sync then
		return 
	end

	local features_list = unit_frame.features_list or empty_features_list
	local player_data = unit_frame.player_data
	local player = player_data.player
	local peer_id = player_data.peer_id
	local local_player_id = player_data.local_player_id
	local data = unit_frame.data
	local widget = unit_frame.widget
	local profile_synchronizer = self.profile_synchronizer

	if not player_data.extensions then
		local player_unit = player.player_unit

		if player_unit then
			self._set_player_extensions(self, player_data, player_unit)
		end
	end

	local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, peer_id, local_player_id)

	if not profile_index then
		return 
	end

	local health_percent, active_percentage, has_shield, is_dead, is_knocked_down, needs_help, is_wounded, is_ready_for_assisted_respawn = nil
	local shield_percent = 0
	local is_talking = false
	local player_unit = player_data.player_unit

	if (not player_unit or not Unit.alive(player_unit)) and player_data.extensions then
		player_data.extensions = nil
	end

	local extensions = player_data.extensions
	local equipment = nil

	if extensions then
		local buff_extension = extensions.buff
		local status_extension = extensions.status
		local health_extension = extensions.health
		local damage_extension = extensions.damage
		local inventory_extension = extensions.inventory

		if status_extension.is_dead(status_extension) then
			health_percent = 0
		else
			health_percent = health_extension.current_health_percent(health_extension)
		end

		is_wounded = status_extension.is_wounded(status_extension)
		is_knocked_down = status_extension.is_knocked_down(status_extension) and 0 < health_percent
		is_ready_for_assisted_respawn = status_extension.is_ready_for_assisted_respawn(status_extension)
		needs_help = status_extension.is_grabbed_by_pack_master(status_extension) or is_ready_for_assisted_respawn or status_extension.is_hanging_from_hook(status_extension) or status_extension.is_pounced_down(status_extension) or status_extension.get_is_ledge_hanging(status_extension)
		local max_health = health_extension.unmodified_max_health
		local shield_amount = nil
		has_shield, shield_amount = damage_extension.has_assist_shield(damage_extension)

		if has_shield then
			shield_percent = shield_amount/max_health
		end

		local num_grimoires = buff_extension.num_buff_type(buff_extension, "grimoire_health_debuff")
		local multiplier = buff_extension.apply_buffs_to_value(buff_extension, PlayerUnitDamageSettings.GRIMOIRE_HEALTH_DEBUFF, StatBuffIndex.CURSE_PROTECTION)
		active_percentage = num_grimoires*multiplier - 1
		local dialogue_extension = extensions.dialogue
		is_talking = dialogue_extension.currently_playing_dialogue ~= nil
		equipment = inventory_extension.equipment(inventory_extension)
	else
		health_percent = 0
		active_percentage = 1
		is_knocked_down = false
	end

	local is_dead = health_percent <= 0
	local is_player_controlled = player.is_player_controlled(player)
	local display_name = UIRenderer.crop_text(player.name(player), 26)
	local level_text = (is_player_controlled and (ExperienceSettings.get_player_level(player) or "")) or "BOT"
	local portrait_texture, portrait_texture_point_sample = get_portrait_name_by_profile_index(profile_index)
	local is_player_server = self.host_peer_id == peer_id
	local is_host = is_player_controlled and is_player_server
	local show_overlay = false
	local show_icon = false
	local health_bar_divider_count = 0
	local connecting = false

	if is_knocked_down then
		show_overlay = true
		show_icon = true
	elseif is_dead then
		show_overlay = true
	elseif needs_help then
		show_overlay = true
		show_icon = true
		health_bar_divider_count = MAX_HEALTH_DIVIDERS
	else
		health_bar_divider_count = MAX_HEALTH_DIVIDERS
	end

	local dirty = false
	local update_portrait_status = false
	local update_health_bar_status = false

	if data.connecting ~= connecting then
		data.connecting = connecting

		widget.set_connecting_status(widget, connecting)
	end

	if data.is_knocked_down ~= is_knocked_down then
		data.is_knocked_down = is_knocked_down
		update_portrait_status = true
		update_health_bar_status = true
	end

	if data.is_dead ~= is_dead then
		data.is_dead = is_dead
		update_health_bar_status = true
	end

	if data.is_wounded ~= is_wounded then
		data.is_wounded = is_wounded
		update_health_bar_status = true
	end

	if data.needs_help ~= needs_help then
		data.needs_help = needs_help
		update_portrait_status = true
	end

	if data.is_talking ~= is_talking then
		data.is_talking = is_talking

		widget.set_talking(widget, is_talking)

		dirty = true
	end

	if data.show_overlay ~= show_overlay then
		data.show_overlay = show_overlay

		widget.set_overlay_visibility(widget, show_overlay)

		dirty = true
	end

	if data.show_icon ~= show_icon then
		data.show_icon = show_icon

		widget.set_icon_visibility(widget, show_icon)

		dirty = true
	end

	if data.show_health_bar ~= not is_ready_for_assisted_respawn then
		data.show_health_bar = not is_ready_for_assisted_respawn
		update_health_bar_status = true
		dirty = true
	end

	if data.portrait_texture ~= portrait_texture then
		data.portrait_texture = portrait_texture

		widget.set_potrait(widget, portrait_texture)

		dirty = true
	end

	if data.level_text ~= level_text then
		data.level_text = level_text

		widget.set_player_level(widget, level_text)

		dirty = true
	end

	if data.display_name ~= display_name then
		data.display_name = display_name

		widget.set_player_name(widget, display_name)

		dirty = true
	end

	if data.is_host ~= is_host then
		data.is_host = is_host

		widget.set_host_status(widget, is_host)

		dirty = true
	end

	if update_portrait_status then
		widget.set_portrait_status(widget, is_knocked_down, needs_help)

		dirty = true
	end

	local current_health_percent = data.health_percent
	local current_active_percentage = data.active_percentage

	if data.health_percent ~= health_percent or data.active_percentage ~= active_percentage then
		data.health_percent = health_percent
		local low_health = (not is_dead and not is_knocked_down and health_percent < UISettings.unit_frames.low_health_threshold) or nil

		widget.set_health_percentage(widget, health_percent, active_percentage, low_health)

		dirty = true
	end

	if data.health_bar_divider_count ~= health_bar_divider_count then
		data.health_bar_divider_count = health_bar_divider_count

		widget.set_health_bar_divider_amount(widget, health_bar_divider_count)

		dirty = true
	end

	if data.active_percentage ~= active_percentage then
		data.active_percentage = active_percentage

		widget.set_active_percentage(widget, active_percentage)

		dirty = true
	end

	if data.has_shield ~= has_shield or data.shield_percent ~= data.shield_percent or (has_shield and current_health_percent ~= health_percent) or (has_shield and current_active_percentage ~= active_percentage) then
		widget.set_shielded(widget, has_shield, shield_percent)

		data.has_shield = has_shield
		data.shield_percent = shield_percent
		dirty = true
	end

	if equipment then
		local wielded = equipment.wielded
		local update_equipment = features_list.equipment
		local update_weapons = features_list.weapons

		if update_equipment or update_weapons then
			if update_equipment and not data.inventory_slots then
				data.inventory_slots = {}
			end

			local inventory_slots_data = data.inventory_slots
			local inventory_slots = InventorySettings.slots

			for _, slot in ipairs(inventory_slots) do
				local slot_name = slot.name

				if update_equipment and allowed_consumable_slots[slot_name] then
					if not inventory_slots_data[slot_name] then
						inventory_slots_data[slot_name] = {}
					end

					local slot_data = equipment.slots[slot_name]
					local stored_slot_data = inventory_slots_data[slot_name]
					local slot_visible = (slot_data and true) or false
					local item_name = slot_data and slot_data.item_data.name
					local is_wielded = (item_name and wielded == slot_data.item_data) or false
					local slot_dirty = false

					if stored_slot_data.visible ~= slot_visible or stored_slot_data.item_name ~= item_name then
						stored_slot_data.visible = slot_visible
						stored_slot_data.item_name = item_name

						widget.set_inventory_slot_data(widget, slot_name, slot_visible, item_name)

						dirty = true
						slot_dirty = true
					end

					if stored_slot_data.is_wielded ~= is_wielded or slot_dirty then
						stored_slot_data.is_wielded = is_wielded

						widget.set_selected_slot(widget, slot_name, item_name, is_wielded, slot_visible)

						dirty = true
					end
				elseif update_weapons and allowed_weapon_slots[slot_name] then
					if not inventory_slots_data[slot_name] then
						inventory_slots_data[slot_name] = {}
					end

					local slot_data = equipment.slots[slot_name]

					if slot_data then
						local stored_slot_data = inventory_slots_data[slot_name]
						local item_data = slot_data.item_data
						local item_name = item_data.name
						local hud_icon = item_data.hud_icon
						local is_wielded = wielded == item_data

						if stored_slot_data.is_wielded ~= is_wielded or stored_slot_data.item_name ~= item_name then
							print("set_equipped_weapon_info", slot_name, is_wielded, item_name, hud_icon)
							widget.set_equipped_weapon_info(widget, slot_name, is_wielded, item_name, hud_icon)

							if stored_slot_data.item_name ~= item_name then
								stored_slot_data.no_ammo = nil
							end

							stored_slot_data.is_wielded = is_wielded
							stored_slot_data.item_name = item_name
							stored_slot_data.hud_icon = hud_icon
							dirty = true
						end

						local item_template = BackendUtils.get_item_template(item_data)

						if item_template.ammo_data then
							local ammo_count, remaining_ammo, using_single_clip = get_ammunition_count(slot_data.left_unit_1p, slot_data.right_unit_1p, item_template)

							if stored_slot_data.ammo_count ~= ammo_count or stored_slot_data.remaining_ammo ~= remaining_ammo or stored_slot_data.no_ammo then
								stored_slot_data.ammo_count = ammo_count
								stored_slot_data.remaining_ammo = remaining_ammo
								stored_slot_data.no_ammo = nil

								widget.set_ammo_for_slot(widget, slot_name, ammo_count, remaining_ammo, using_single_clip)

								dirty = true
							end

							if slot_name == "slot_ranged" and stored_slot_data.overcharge_fraction then
								widget.set_overcharge_percentage(widget, false, nil)

								stored_slot_data.overcharge_fraction = nil
							end
						else
							if not stored_slot_data.no_ammo then
								stored_slot_data.no_ammo = true
								dirty = true

								widget.set_ammo_for_slot(widget, slot_name, nil, nil)

								stored_slot_data.overcharge_fraction = nil
								stored_slot_data.ammo_count = nil
								stored_slot_data.remaining_ammo = nil
							end

							if slot_name == "slot_ranged" then
								local has_overcharge, overcharge_fraction, threshold_fraction = get_overcharge_amount(slot_data.left_unit_1p, slot_data.right_unit_1p)

								if stored_slot_data.overcharge_fraction ~= overcharge_fraction then
									widget.set_overcharge_percentage(widget, has_overcharge, overcharge_fraction)

									stored_slot_data.overcharge_fraction = overcharge_fraction
								end
							end
						end
					end
				end
			end
		end
	end

	if update_health_bar_status then
		local show_health_bar = not is_ready_for_assisted_respawn

		widget.set_health_bar_status(widget, show_health_bar, is_knocked_down, is_wounded)

		dirty = true
	end

	if dirty then
		widget.set_dirty(widget)
	end

	return 
end
UnitFramesHandler.destroy = function (self)
	self.ui_animator = nil

	self.set_visible(self, false)
	rawset(_G, "unit_frames_handler", nil)

	return 
end
UnitFramesHandler.set_visible = function (self, visible)
	self._is_visible = visible

	for index, unit_frame in ipairs(self._unit_frames) do
		local player_data = unit_frame.player_data

		if player_data.player_ui_id then
			unit_frame.widget:set_visible(visible)
		end
	end

	return 
end
UnitFramesHandler.on_gamepad_activated = function (self)
	local my_unit_frame = self._unit_frames[1]

	if not my_unit_frame.gamepad_version then
		my_unit_frame.widget:destroy()

		local new_unit_frame = self._create_unit_frame_by_type(self, "player")
		new_unit_frame.player_data = my_unit_frame.player_data
		new_unit_frame.sync = true
		self._unit_frames[1] = new_unit_frame
	end

	return 
end
UnitFramesHandler.on_gamepad_deactivated = function (self)
	local my_unit_frame = self._unit_frames[1]

	if my_unit_frame.gamepad_version then
		my_unit_frame.widget:destroy()

		local new_unit_frame = self._create_unit_frame_by_type(self, "player")
		new_unit_frame.player_data = my_unit_frame.player_data
		new_unit_frame.sync = true
		self._unit_frames[1] = new_unit_frame
	end

	return 
end
UnitFramesHandler.update = function (self, dt, t, my_player)
	local gamepad_active = self.input_manager:is_device_active("gamepad")

	if gamepad_active then
		if not self.gamepad_active_last_frame then
			self.gamepad_active_last_frame = true

			self.on_gamepad_activated(self)
		end
	elseif self.gamepad_active_last_frame then
		self.gamepad_active_last_frame = false

		self.on_gamepad_deactivated(self)
	end

	Profiler.start("handle_unit_frame_assigning")
	self._handle_unit_frame_assigning(self)
	Profiler.stop("handle_unit_frame_assigning")
	Profiler.start("sync")
	self._sync_player_stats(self, self._unit_frames[self._current_frame_index])

	self._current_frame_index = self._current_frame_index%#self._unit_frames + 1

	Profiler.stop("sync")

	for index, unit_frame in ipairs(self._unit_frames) do
		Profiler.start("unit_frame_update")
		unit_frame.widget:update(dt, t)
		Profiler.stop("unit_frame_update")
	end

	Profiler.start("handle_resolution_modified")
	self._handle_resolution_modified(self)
	Profiler.stop("handle_resolution_modified")
	Profiler.start("draw")
	self._draw(self, dt)
	Profiler.stop("draw")

	if DO_RELOAD then
		DO_RELOAD = false

		for index, unit_frame in ipairs(self._unit_frames) do
			table.clear(unit_frame.data)
		end
	end

	return 
end
UnitFramesHandler._handle_resolution_modified = function (self)
	if RESOLUTION_LOOKUP.modified then
		for index, unit_frame in ipairs(self._unit_frames) do
			unit_frame.widget:on_resolution_modified()
		end
	end

	return 
end
UnitFramesHandler._draw = function (self, dt)
	if not self._is_visible then
		return 
	end

	for index, unit_frame in ipairs(self._unit_frames) do
		unit_frame.widget:draw(dt)
	end

	return 
end

return 
