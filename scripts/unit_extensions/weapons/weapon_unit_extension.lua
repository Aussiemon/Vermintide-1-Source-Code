require("scripts/unit_extensions/weapons/actions/action_charge")
require("scripts/unit_extensions/weapons/actions/action_dummy")
require("scripts/unit_extensions/weapons/actions/action_wield")
require("scripts/unit_extensions/weapons/actions/action_handgun")
require("scripts/unit_extensions/weapons/actions/action_interaction")
require("scripts/unit_extensions/weapons/actions/action_self_interaction")
require("scripts/unit_extensions/weapons/actions/action_push_stagger")
require("scripts/unit_extensions/weapons/actions/action_sweep")
require("scripts/unit_extensions/weapons/actions/action_block")
require("scripts/unit_extensions/weapons/actions/action_throw")
require("scripts/unit_extensions/weapons/actions/action_instant_wield")
require("scripts/unit_extensions/weapons/actions/action_staff")
require("scripts/unit_extensions/weapons/actions/action_bow")
require("scripts/unit_extensions/weapons/actions/action_true_flight_bow")
require("scripts/unit_extensions/weapons/actions/action_true_flight_bow_aim")
require("scripts/unit_extensions/weapons/actions/action_handgun_lock")
require("scripts/unit_extensions/weapons/actions/action_handgun_lock_targeting")
require("scripts/unit_extensions/weapons/actions/action_bullet_spray")
require("scripts/unit_extensions/weapons/actions/action_bullet_spray_targeting")
require("scripts/unit_extensions/weapons/actions/action_aim")
require("scripts/unit_extensions/weapons/actions/action_shotgun")
require("scripts/unit_extensions/weapons/actions/action_crossbow")
require("scripts/unit_extensions/weapons/actions/action_cancel")
require("scripts/unit_extensions/weapons/actions/action_potion")
require("scripts/unit_extensions/weapons/actions/action_shield_slam")
require("scripts/unit_extensions/weapons/actions/action_charged_projectile")
require("scripts/unit_extensions/weapons/actions/action_beam")
require("scripts/unit_extensions/weapons/actions/action_geiser")
require("scripts/unit_extensions/weapons/actions/action_geiser_targeting")
require("scripts/unit_extensions/weapons/actions/action_throw_grimoire")
require("scripts/unit_extensions/weapons/actions/action_healing_draught")

function weapon_printf(...)
	if script_data.debug_weapons then
		printf(...)
	end

	return 
end

if Development.parameter("debug_weapons") then
	script_data.debug_weapons = true
end

local action_classes = {
	charge = ActionCharge,
	dummy = ActionDummy,
	wield = ActionWield,
	handgun = ActionHandgun,
	interaction = ActionInteraction,
	self_interaction = ActionSelfInteraction,
	push_stagger = ActionPushStagger,
	sweep = ActionSweep,
	block = ActionBlock,
	throw = ActionThrow,
	staff = ActionStaff,
	bow = ActionBow,
	true_flight_bow = ActionTrueFlightBow,
	true_flight_bow_aim = ActionTrueFlightBowAim,
	crossbow = ActionCrossbow,
	cancel = ActionCancel,
	buff = ActionPotion,
	handgun_lock_targeting = ActionHandgunLockTargeting,
	handgun_lock = ActionHandgunLock,
	bullet_spray_targeting = ActionBulletSprayTargeting,
	bullet_spray = ActionBulletSpray,
	aim = ActionAim,
	shotgun = ActionShotgun,
	shield_slam = ActionShieldSlam,
	charged_projectile = ActionChargedProjectile,
	beam = ActionBeam,
	geiser_targeting = ActionGeiserTargeting,
	geiser = ActionGeiser,
	instant_wield = ActionInstantWield,
	throw_grimoire = ActionThrowGrimoire,
	healing_draught = ActionHealingDraught
}

local function create_attack(item_name, attack_kind, world, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
	return action_classes[attack_kind]:new(world, item_name, is_server, owner_unit, damage_unit, first_person_unit, weapon_unit, weapon_system)
end

local function is_within_damage_window(current_time_in_action, action, owner_unit)
	local damage_window_start = action.damage_window_start
	local damage_window_end = action.damage_window_end

	if not damage_window_start and not damage_window_end then
		return false
	end

	local anim_time_scale = action.anim_time_scale or 1
	anim_time_scale = ActionUtils.apply_attack_speed_buff(anim_time_scale, owner_unit)
	damage_window_start = damage_window_start/anim_time_scale
	damage_window_end = damage_window_end or action.total_time or math.huge
	damage_window_end = damage_window_end/anim_time_scale
	local after_start = damage_window_start < current_time_in_action
	local before_end = current_time_in_action < damage_window_end

	return after_start and before_end
end

local function is_within_a_chain_window(current_time_in_action, action, owner_unit)
	local attack_speed_modifier = 1
	attack_speed_modifier = ActionUtils.apply_attack_speed_buff(attack_speed_modifier, owner_unit)

	for action, chain_info in pairs(action.allowed_chain_actions) do
		local start_time = chain_info.start_time or 0
		local end_time = chain_info.end_time or math.huge
		local modified_start_time = start_time/attack_speed_modifier
		local after_start = modified_start_time < current_time_in_action
		local before_end = current_time_in_action < end_time

		if after_start and before_end then
			return true
		end
	end

	return false
end

WeaponUnitExtension = class(WeaponUnitExtension)
WeaponUnitExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.weapon_system = extension_init_data.weapon_system
	local world = extension_init_context.world
	self.world = world
	self.unit = unit
	self.first_person_unit = extension_init_data.first_person_rig
	self.owner_unit = extension_init_data.owner_unit
	self.item_name = extension_init_data.item_name
	self.actual_damage_unit = World.spawn_unit(world, "units/weapons/player/wpn_damage/wpn_damage")

	Unit.disable_physics(self.actual_damage_unit)
	Unit.set_unit_visibility(self.actual_damage_unit, false)

	if self.first_person_unit then
		local attach_nodes = extension_init_data.attach_nodes
		local attachment_nodes = attach_nodes[1]
		local source_node = attachment_nodes.source
		local target_node = "root_point"
		local target_node = 0
		local source_node_index = (type(source_node) == "string" and Unit.node(self.first_person_unit, source_node)) or source_node
		local target_node_index = (type(target_node) == "string" and Unit.node(self.actual_damage_unit, target_node)) or target_node

		World.link_unit(world, self.actual_damage_unit, target_node_index, self.first_person_unit, source_node_index)
	end

	self.actions = {}
	self.action_buff_data = {
		buff_start_times = {},
		buff_end_times = {},
		action_buffs_in_progress = {},
		buff_identifiers = {}
	}
	self.cooldown_timer = 0
	self.chain_action_sound_played = {}
	self.action_cooldowns = {}
	self.is_server = Managers.state.network.network_transmit.is_server

	return 
end
WeaponUnitExtension.extensions_ready = function (self, world, unit)
	if ScriptUnit.has_extension(unit, "ammo_system") then
		self.ammo_extension = ScriptUnit.extension(unit, "ammo_system")
	end

	return 
end
WeaponUnitExtension.destroy = function (self)
	if self.current_action_settings then
		local action_kind = self.current_action_settings.kind
		local attack_prev = self.actions[action_kind]

		if attack_prev.destroy then
			attack_prev.destroy(attack_prev)
		end
	end

	return 
end
WeaponUnitExtension.get_action = function (self, action_name, sub_action_name, actions)
	local sub_actions = actions[action_name]
	local action = sub_actions[sub_action_name]

	return action
end
local interupting_action_data = {}
WeaponUnitExtension.start_action = function (self, action_name, sub_action_name, actions, t)
	local first_person_extension = ScriptUnit.extension(self.owner_unit, "first_person_system")
	local current_action_settings = self.current_action_settings
	local new_action = action_name
	local new_sub_action = sub_action_name

	table.clear(interupting_action_data)

	if t < self.cooldown_timer and new_action then
		local action_settings = self.get_action(self, new_action, new_sub_action, actions)

		if action_settings.cooldown ~= nil then
			new_action, new_sub_action = nil
		end
	end

	if new_action then
		local action_settings = self.get_action(self, new_action, new_sub_action, actions)
		local action_kind = action_settings.kind
		self.actions[action_kind] = self.actions[action_kind] or create_attack(self.item_name, action_kind, self.world, self.is_server, self.owner_unit, self.actual_damage_unit, self.first_person_unit, self.unit, self.weapon_system)
	end

	local ammo_extension = self.ammo_extension

	if ammo_extension ~= nil and new_action then
		local action = self.get_action(self, new_action, new_sub_action, actions)
		local ammo_requirement = action.ammo_requirement or action.ammo_usage or 0
		local ammo_count = ammo_extension.ammo_count(ammo_extension)
		local action_can_abort_reload = (action.can_abort_reload == nil and true) or action.can_abort_reload

		if ammo_extension.is_reloading(ammo_extension) then
			if ammo_requirement <= ammo_count and action_can_abort_reload then
				ammo_extension.abort_reload(ammo_extension)
			else
				new_action, new_sub_action = nil
			end
		elseif ammo_count < ammo_requirement then
			if ammo_extension.total_remaining_ammo(ammo_extension) == 0 then
				local dialogue_input = ScriptUnit.extension_input(self.owner_unit, "dialogue_system")
				local event_data = FrameTable.alloc_table()
				event_data.fail_reason = "out_of_ammo"
				event_data.item_name = self.item_name or "UNKNOWN WEAPON"
				local event_name = "reload_failed"

				dialogue_input.trigger_dialogue_event(dialogue_input, event_name, event_data)
			end

			new_action, new_sub_action = nil
		end
	end

	local chain_action_data = nil

	if new_action and current_action_settings then
		interupting_action_data.new_action = new_action
		interupting_action_data.new_sub_action = new_sub_action
		chain_action_data = self._finish_action(self, "new_interupting_action", interupting_action_data)
	end

	if new_action then
		local owner_unit = self.owner_unit
		local locomotion_extension = ScriptUnit.extension(owner_unit, "locomotion_system")

		if locomotion_extension.is_stood_still(locomotion_extension) then
			local look_rotation = first_person_extension.current_rotation(first_person_extension)

			locomotion_extension.set_stood_still_target_rotation(locomotion_extension, look_rotation)
		end

		local first_person_unit = self.first_person_unit

		Unit.animation_event(first_person_unit, "equip_interrupt")

		current_action_settings = self.get_action(self, new_action, new_sub_action, actions)
		self.current_action_settings = current_action_settings

		table.clear(self.chain_action_sound_played)

		for action_name, chain_info in pairs(current_action_settings.allowed_chain_actions) do
			self.chain_action_sound_played[action_name] = false
		end

		local action_kind = current_action_settings.kind
		local action = self.actions[action_kind]
		local time_to_complete = current_action_settings.total_time

		if current_action_settings.scale_total_time_on_mastercrafted then
			local buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")

			if buff_extension then
				time_to_complete = buff_extension.apply_buffs_to_value(buff_extension, time_to_complete, StatBuffIndex.RELOAD_SPEED)
			end
		end

		local event = current_action_settings.anim_event

		for _, data in pairs(self.action_buff_data) do
			table.clear(data)
		end

		local buff_data = current_action_settings.buff_data

		if buff_data then
			ActionUtils.init_action_buff_data(self.action_buff_data, buff_data, t)

			self.buff_data = buff_data
		end

		action.client_owner_start_action(action, current_action_settings, t, chain_action_data)

		local aim_assist_ramp_multiplier = current_action_settings.aim_assist_ramp_multiplier

		if aim_assist_ramp_multiplier then
			local aim_assist_max_ramp_multiplier = current_action_settings.aim_assist_max_ramp_multiplier
			local aim_assist_ramp_decay_delay = current_action_settings.aim_assist_ramp_decay_delay

			first_person_extension.increase_aim_assist_multiplier(first_person_extension, aim_assist_ramp_multiplier, aim_assist_max_ramp_multiplier, aim_assist_ramp_decay_delay)
		end

		if self.ammo_extension then
			if self.ammo_extension:total_remaining_ammo() == 0 then
				if not current_action_settings.anim_event_no_ammo_left then
				end
			elseif self.ammo_extension:total_remaining_ammo() == 1 and not current_action_settings.anim_event_last_ammo then
			end
		end

		self.action_time_started = t
		self.action_time_done = t + time_to_complete

		if current_action_settings.cooldown then
			self.cooldown_timer = t + current_action_settings.cooldown
		end

		if current_action_settings.enter_function then
			local input_extension = ScriptUnit.extension(owner_unit, "input_system")

			current_action_settings.enter_function(owner_unit, input_extension)
		end

		if event then
			local anim_time_scale = current_action_settings.anim_time_scale or 1
			anim_time_scale = ActionUtils.apply_attack_speed_buff(anim_time_scale, owner_unit)
			local go_id = Managers.state.unit_storage:go_id(owner_unit)
			local event_id = NetworkLookup.anims[event]
			local variable_id = NetworkLookup.anims.attack_speed

			if not LEVEL_EDITOR_TEST then
				if self.is_server then
					Managers.state.network.network_transmit:send_rpc_clients("rpc_anim_event_variable_float", event_id, go_id, variable_id, anim_time_scale)
				else
					Managers.state.network.network_transmit:send_rpc_server("rpc_anim_event_variable_float", event_id, go_id, variable_id, anim_time_scale)
				end
			end

			if Application.platform() ~= "win32" and event == "attack_shoot" then
				anim_time_scale = anim_time_scale*1.2
			end

			local first_person_variable_id = Unit.animation_find_variable(first_person_unit, "attack_speed")

			Unit.animation_set_variable(first_person_unit, first_person_variable_id, anim_time_scale)
			Unit.animation_event(first_person_unit, event)

			local third_person_variable_id = Unit.animation_find_variable(owner_unit, "attack_speed")

			Unit.animation_set_variable(owner_unit, third_person_variable_id, anim_time_scale)
			Unit.animation_event(owner_unit, event)

			if current_action_settings.apply_recoil then
				local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
				local user_setting = Application.user_setting
				local HAS_TOBII = rawget(_G, "Tobii") and Tobii.device_status() == Tobii.DEVICE_TRACKING and user_setting("tobii_eyetracking")
				local tobii_extended_view_enabled = user_setting("tobii_extended_view")

				if not HAS_TOBII or (HAS_TOBII and not tobii_extended_view_enabled) then
					first_person_extension.apply_recoil(first_person_extension, current_action_settings.recoil_factor)
				end
			end
		end
	end

	return 
end
WeaponUnitExtension.stop_action = function (self, reason, data)
	if self.has_current_action(self) then
		self._finish_action(self, reason, data)
	end

	return 
end
WeaponUnitExtension._finish_action = function (self, reason, data)
	local current_action_settings = self.current_action_settings
	local action_kind = current_action_settings.kind
	local action = self.actions[action_kind]
	local buff_data = current_action_settings.buff_data

	if buff_data then
		ActionUtils.remove_action_buff_data(self.action_buff_data, buff_data, self.owner_unit)
	end

	for _, data in pairs(self.action_buff_data) do
		table.clear(data)
	end

	local chain_action_data = action.finish(action, reason, data)

	self.anim_end_event(self, reason)

	self.current_action_settings = nil

	return chain_action_data
end
WeaponUnitExtension.anim_end_event = function (self, reason)
	local current_action_settings = self.current_action_settings
	local go_id = Managers.state.unit_storage:go_id(self.owner_unit)
	local event = current_action_settings.anim_end_event
	local anim_end_event_condition_func = current_action_settings.anim_end_event_condition_func
	local do_event = (not anim_end_event_condition_func and true) or anim_end_event_condition_func(self.owner_unit, reason)

	if event and do_event then
		local event_id = NetworkLookup.anims[event]

		if not LEVEL_EDITOR_TEST then
			if self.is_server then
				Managers.state.network.network_transmit:send_rpc_clients("rpc_anim_event", event_id, go_id)
			else
				Managers.state.network.network_transmit:send_rpc_server("rpc_anim_event", event_id, go_id)
			end
		end

		Unit.animation_event(self.first_person_unit, event)
		Unit.animation_event(self.owner_unit, event)
	end

	return 
end
WeaponUnitExtension.update = function (self, unit, input, dt, context, t)
	local owner_unit = self.owner_unit
	local current_action_settings = self.current_action_settings

	if current_action_settings then
		if script_data.debug_weapons then
			local current_time_in_action = t - self.action_time_started

			Debug.text("Action time:   %.2f", current_time_in_action)
			Debug.text("Can chain:     %s", tostring(is_within_a_chain_window(current_time_in_action, self.current_action_settings, owner_unit)))
			Debug.text("Can do damage: %s", tostring(is_within_damage_window(current_time_in_action, self.current_action_settings, owner_unit)))
			Debug.text("Action kind: %s", tostring(current_action_settings.kind))
		end

		local wwise_world = Managers.world:wwise_world(self.world)

		for action_name, chain_info in pairs(current_action_settings.allowed_chain_actions) do
			local chain_ready_sound = chain_info.chain_ready_sound

			if chain_ready_sound then
				local time_offset = chain_info.sound_time_offset or 0
				local sound_ready = self.is_chain_action_available(self, chain_info, t, time_offset)

				if sound_ready and not self.chain_action_sound_played[action_name] then
					WwiseWorld.trigger_event(wwise_world, chain_ready_sound)

					self.chain_action_sound_played[action_name] = true
				end
			end
		end

		if self.action_time_done < t then
			self._finish_action(self, "action_complete")
		else
			local current_time_in_action = t - self.action_time_started
			local can_damage = is_within_damage_window(current_time_in_action, self.current_action_settings, owner_unit)
			local action_kind = current_action_settings.kind
			local action = self.actions[action_kind]
			local buff_data = current_action_settings.buff_data

			if buff_data then
				Profiler.start("buff")
				ActionUtils.update_action_buff_data(self.action_buff_data, buff_data, owner_unit, t)
				Profiler.stop("buff")
			end

			Profiler.start(action_kind)
			action.client_owner_post_update(action, dt, t, self.world, can_damage, current_time_in_action)
			Profiler.stop(action_kind)

			if current_action_settings.cooldown then
				self.cooldown_timer = t + current_action_settings.cooldown
			end
		end
	end

	return 
end
WeaponUnitExtension.is_streak_action_available = function (self, streak_action, t, time_offset)
	local current_action_settings = self.current_action_settings or self.temporary_action_settings
	local action = self.actions[current_action_settings.kind]
	local current_time_in_action = t - self.action_time_started

	if action.streak_available and action.streak_available(action, current_time_in_action, streak_action) and self.is_chain_action_available(self, streak_action, t, time_offset) then
		return true
	end

	return false
end
WeaponUnitExtension.is_chain_action_available = function (self, next_chain_action, t, time_offset)
	local current_action_settings = self.current_action_settings or self.temporary_action_settings
	local current_time_in_action = t - self.action_time_started
	local max_time = current_action_settings.total_time + 2
	time_offset = time_offset or 0
	local attack_speed_modifier = 1
	attack_speed_modifier = ActionUtils.apply_attack_speed_buff(attack_speed_modifier, self.owner_unit)

	if next_chain_action.auto_chain then
		return ((next_chain_action.start_time and next_chain_action.start_time/attack_speed_modifier) or max_time) + time_offset <= current_time_in_action
	else
		local end_time = next_chain_action.end_time or max_time

		return next_chain_action.start_time/attack_speed_modifier + time_offset <= current_time_in_action and current_time_in_action <= end_time
	end

	return 
end
WeaponUnitExtension.can_stop_hold_action = function (self, t)
	local current_time_in_action = t - self.action_time_started
	local current_action_settings = self.current_action_settings
	local minimum_hold_time = current_action_settings.minimum_hold_time

	if not minimum_hold_time then
		return true
	end

	local buff_extension = ScriptUnit.extension(self.owner_unit, "buff_system")

	if buff_extension then
		minimum_hold_time = buff_extension.apply_buffs_to_value(buff_extension, minimum_hold_time, StatBuffIndex.RELOAD_SPEED)
	end

	return minimum_hold_time < current_time_in_action
end
WeaponUnitExtension.get_current_action = function (self)
	return self.actions[self.current_action_settings.kind]
end
WeaponUnitExtension.has_current_action = function (self)
	return self.current_action_settings ~= nil
end
WeaponUnitExtension.get_current_action_settings = function (self)
	return self.current_action_settings
end

return 
