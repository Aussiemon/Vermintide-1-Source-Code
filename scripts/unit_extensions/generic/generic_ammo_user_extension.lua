script_data.infinite_ammo = script_data.infinite_ammo or Development.parameter("infinite_ammo")
GenericAmmoUserExtension = class(GenericAmmoUserExtension)
GenericAmmoUserExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.owner_unit = extension_init_data.owner_unit
	self.item_name = extension_init_data.item_name
	local ammo_percent = extension_init_data.ammo_percent or 1
	local ammo_data = extension_init_data.ammo_data
	self.reload_time = ammo_data.reload_time
	self.max_ammo = ammo_data.max_ammo
	self.start_ammo = math.floor(ammo_percent*self.max_ammo)
	self.ammo_per_clip = ammo_data.ammo_per_clip or self.max_ammo
	self.original_max_ammo = self.max_ammo
	self.original_start_ammo = self.start_ammo
	self.original_ammo_per_clip = self.ammo_per_clip
	self.ammo_immediately_available = ammo_data.ammo_immediately_available or false
	self.reload_on_ammo_pickup = ammo_data.reload_on_ammo_pickup or false
	self.play_reload_anim_on_wield_reload = ammo_data.play_reload_anim_on_wield_reload
	self.destroy_when_out_of_ammo = ammo_data.destroy_when_out_of_ammo
	self.play_reload_animation = true
	self.reload_event = extension_init_data.reload_event
	self.last_reload_event = extension_init_data.last_reload_event or self.reload_event
	self.no_ammo_reload_event = extension_init_data.no_ammo_reload_event
	self.slot_name = extension_init_data.slot_name

	if ScriptUnit.has_extension(self.owner_unit, "first_person_system") then
		self.first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")
	end

	return 
end
GenericAmmoUserExtension.extensions_ready = function (self, world, unit)
	self.apply_buffs(self, unit)

	return 
end
GenericAmmoUserExtension.apply_buffs = function (self, unit)
	if self.slot_name == "slot_ranged" then
		local buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")
		self.owner_buff_extension = buff_extension
		self.ammo_per_clip = math.ceil(buff_extension.apply_buffs_to_value(buff_extension, self.original_ammo_per_clip, StatBuffIndex.CLIP_SIZE))
		self.max_ammo = math.ceil(buff_extension.apply_buffs_to_value(buff_extension, self.original_max_ammo, StatBuffIndex.TOTAL_AMMO))
		self.start_ammo = math.ceil(buff_extension.apply_buffs_to_value(buff_extension, self.original_start_ammo, StatBuffIndex.TOTAL_AMMO))
	end

	self.reset(self)

	return 
end
GenericAmmoUserExtension.destroy = function (self)
	return 
end
GenericAmmoUserExtension.reset = function (self)
	if self.ammo_immediately_available then
		self.current_ammo = self.start_ammo
	else
		self.current_ammo = math.min(self.ammo_per_clip, self.start_ammo)
	end

	self.available_ammo = self.start_ammo - self.current_ammo
	self.shots_fired = 0

	return 
end
local telemetry_data = {}

local function _add_ammo_depleted_telemetry(player_id, hero, weapon_name, position)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.hero = hero
	telemetry_data.weapon_name = weapon_name
	telemetry_data.position = position

	Managers.telemetry:register_event("player_ammo_depleted", telemetry_data)

	return 
end

local function _add_ammo_refilled_telemetry(player_id, hero, weapon_name, position)
	table.clear(telemetry_data)

	telemetry_data.player_id = player_id
	telemetry_data.hero = hero
	telemetry_data.weapon_name = weapon_name
	telemetry_data.position = position

	Managers.telemetry:register_event("player_ammo_refilled", telemetry_data)

	return 
end

GenericAmmoUserExtension.update = function (self, unit, input, dt, context, t)
	if 0 < self.shots_fired then
		self.current_ammo = self.current_ammo - self.shots_fired
		self.shots_fired = 0

		assert(0 <= self.current_ammo)

		if self.current_ammo == 0 then
			Unit.flow_event(unit, "used_last_ammo_clip")

			if self.available_ammo == 0 then
				if self.destroy_when_out_of_ammo then
					local inventory_extension = ScriptUnit.extension(self.owner_unit, "inventory_system")

					inventory_extension.destroy_slot(inventory_extension, self.slot_name)
					inventory_extension.wield(inventory_extension, "slot_melee")
				elseif GameSettingsDevelopment.use_telemetry then
					local player_manager = Managers.player
					local player = player_manager.unit_owner(player_manager, self.owner_unit)
					local player_id = player.telemetry_id(player)
					local hero = player.profile_display_name(player)
					local item_name = self.item_name
					local position = POSITION_LOOKUP[self.owner_unit]

					_add_ammo_depleted_telemetry(player_id, hero, item_name, position)
				end

				Unit.flow_event(unit, "used_last_ammo")
			end
		end
	end

	if self.next_reload_time and self.next_reload_time < t then
		if not self.start_reloading then
			local reload_amount = self.ammo_per_clip - self.current_ammo
			reload_amount = math.min(reload_amount, self.available_ammo)
			self.current_ammo = self.current_ammo + reload_amount
			self.available_ammo = self.available_ammo - reload_amount
		end

		self.start_reloading = nil
		local num_missing = self.ammo_per_clip - self.current_ammo

		if 0 < num_missing and 0 < self.available_ammo then
			local reload_time = self.reload_time
			local unmodded_reload_time = reload_time

			if self.owner_buff_extension then
				reload_time = self.owner_buff_extension:apply_buffs_to_value(reload_time, StatBuffIndex.RELOAD_SPEED)
			end

			self.next_reload_time = t + reload_time

			if self.play_reload_animation then
				Unit.set_flow_variable(self.unit, "wwise_reload_speed", unmodded_reload_time/reload_time)
				self.start_reload_animation(self, reload_time)
			end
		else
			self.next_reload_time = nil
		end
	end

	return 
end
GenericAmmoUserExtension.start_reload_animation = function (self, reload_time)
	local reload_event = self.reload_event
	local num_missing = self.ammo_per_clip - self.current_ammo

	if self.reloaded_from_zero_ammo then
		self.reloaded_from_zero_ammo = nil

		if self.no_ammo_reload_event then
			reload_event = self.no_ammo_reload_event
		end
	elseif num_missing == 1 or self.available_ammo == 1 then
		reload_event = self.last_reload_event
	end

	if reload_event then
		if self.first_person_extension then
			local first_person_extension = self.first_person_extension

			first_person_extension.animation_set_variable(first_person_extension, "reload_time", reload_time)
			first_person_extension.animation_event(first_person_extension, reload_event)
		end

		local go_id = Managers.state.unit_storage:go_id(self.owner_unit)
		local event_id = NetworkLookup.anims[reload_event]

		if not LEVEL_EDITOR_TEST then
			if self.is_server then
				Managers.state.network.network_transmit:send_rpc_clients("rpc_anim_event", event_id, go_id)
			else
				Managers.state.network.network_transmit:send_rpc_server("rpc_anim_event", event_id, go_id)
			end
		end
	end

	return 
end
GenericAmmoUserExtension.add_ammo = function (self)
	if self.available_ammo == 0 and self.current_ammo == 0 then
		self.reloaded_from_zero_ammo = true

		if GameSettingsDevelopment.use_telemetry then
			local player_manager = Managers.player
			local player = player_manager.unit_owner(player_manager, self.owner_unit)
			local player_id = player.telemetry_id(player)
			local hero = player.profile_display_name(player)
			local item_name = self.item_name
			local position = POSITION_LOOKUP[self.owner_unit]

			_add_ammo_refilled_telemetry(player_id, hero, item_name, position)
		end
	end

	if self.ammo_immediately_available then
		self.current_ammo = self.max_ammo
	else
		self.available_ammo = self.max_ammo - self.current_ammo - self.shots_fired
	end

	return 
end
GenericAmmoUserExtension.add_ammo_to_reserve = function (self, amount)
	if self.ammo_immediately_available then
		self.current_ammo = math.min(self.max_ammo, self.current_ammo + amount)
	else
		self.available_ammo = math.min(self.max_ammo - self.current_ammo, self.available_ammo + amount)
	end

	return 
end
GenericAmmoUserExtension.use_ammo = function (self, ammo_used)
	if not self.destroy_when_out_of_ammo and script_data.infinite_ammo then
		ammo_used = 0
	end

	self.shots_fired = self.shots_fired + ammo_used

	assert(0 <= self.ammo_count(self), "ammo went below 0")

	return 
end
GenericAmmoUserExtension.start_reload = function (self, play_reload_animation)
	assert(self.can_reload(self))
	assert(self.next_reload_time == nil)

	self.start_reloading = true
	self.next_reload_time = 0
	self.play_reload_animation = play_reload_animation
	local dialogue_input = ScriptUnit.extension_input(self.owner_unit, "dialogue_system")
	local event_data = FrameTable.alloc_table()
	event_data.item_name = self.item_name or "UNKNOWN ITEM"
	local event_name = "reload_started"

	dialogue_input.trigger_dialogue_event(dialogue_input, event_name, event_data)

	return 
end
GenericAmmoUserExtension.abort_reload = function (self)
	assert(self.is_reloading(self))

	self.start_reloading = nil
	self.next_reload_time = nil

	Unit.flow_event(self.unit, "stop_reload_sound")

	return 
end
GenericAmmoUserExtension.ammo_count = function (self)
	return self.current_ammo - self.shots_fired
end
GenericAmmoUserExtension.clip_size = function (self)
	return self.ammo_per_clip
end
GenericAmmoUserExtension.remaining_ammo = function (self)
	return self.available_ammo
end
GenericAmmoUserExtension.ammo_available_immediately = function (self)
	return self.ammo_immediately_available
end
GenericAmmoUserExtension.can_reload = function (self)
	if self.is_reloading(self) then
		return false
	end

	if self.ammo_count(self) == self.ammo_per_clip then
		return false
	end

	if script_data.infinite_ammo then
		return true
	end

	return 0 < self.available_ammo
end
GenericAmmoUserExtension.total_remaining_ammo = function (self)
	return self.remaining_ammo(self) + self.ammo_count(self)
end
GenericAmmoUserExtension.is_reloading = function (self)
	return self.next_reload_time ~= nil
end
GenericAmmoUserExtension.full_ammo = function (self)
	return self.remaining_ammo(self) + self.ammo_count(self) == self.max_ammo
end

return 