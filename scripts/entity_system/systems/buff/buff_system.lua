require("scripts/unit_extensions/default_player_unit/buffs/buff_templates")
require("scripts/unit_extensions/default_player_unit/buffs/group_buff_templates")
require("scripts/unit_extensions/default_player_unit/buffs/buff_function_templates")
require("scripts/unit_extensions/default_player_unit/buffs/buff_extension")
require("scripts/unit_extensions/default_player_unit/buffs/buff_utils")
require("scripts/utils/script_application")

BuffSystem = class(BuffSystem, ExtensionSystemBase)
local s = 0

for buff_name, data in pairs(BuffTemplates) do
	local buffs = data.buffs

	if buffs then
		for i, buff_data in pairs(buffs) do
			local proc = buff_data.proc_chance

			if type(proc) == "table" then
				s = s + proc[1] + proc[2]
			elseif proc then
				s = s + proc
			end
		end
	end
end

if math.abs(s - __dgaa) > 0.001 then
	print("rhino", s, __dgaa)
	ScriptApplication.send_to_crashify("SimpleInventoryExtension", "rhino %f %f", s, __dgaa)
else
	print("oliphant", s, __dgaa)
end

IGNORED_ITEM_TYPES_FOR_BUFFS = {
	grenade = true,
	explosive_inventory_item = true
}
local RPCS = {
	"rpc_add_buff",
	"rpc_add_volume_buff_multiplier",
	"rpc_remove_volume_buff",
	"rpc_add_group_buff",
	"rpc_remove_group_buff",
	"rpc_buff_on_attack"
}
local extensions = {
	"BuffExtension"
}

BuffSystem.init = function (self, entity_system_creation_context, system_name)
	BuffSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))

	self.network_manager = entity_system_creation_context.network_manager
	self.unit_extension_data = {}
	self.player_group_buffs = {}
	self.volume_buffs = {}
end

BuffSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local buff_extension = BuffSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)
	self.unit_extension_data[unit] = buff_extension

	return buff_extension
end

BuffSystem.hot_join_sync = function (self, sender)
	if self.is_server then
		local num_group_buffs = #self.player_group_buffs

		for i = 1, num_group_buffs, 1 do
			local group_buff_data = self.player_group_buffs[i]
			local group_buff_template_name = group_buff_data.group_buff_template_name
			local group_buff_template_id = NetworkLookup.group_buff_templates[group_buff_template_name]

			self.network_manager.network_transmit:send_rpc("rpc_add_group_buff", sender, group_buff_template_id, 1)
		end
	end
end

BuffSystem.on_remove_extension = function (self, unit, extension_name)
	self:on_freeze_extension(unit, extension_name)
	BuffSystem.super.on_remove_extension(self, unit, extension_name)
end

BuffSystem.on_freeze_extension = function (self, unit, extension_name)
	self.unit_extension_data[unit] = nil
end

local debug_units = {}

BuffSystem.update = function (self, context, t)
	BuffSystem.super.update(self, context, t)

	if script_data.debug_legendary_traits then
		local human_players = Managers.player:human_players()
		local offset_vector = Vector3(0, 0, 0.5)
		local color = Vector3(0, 0, 255)
		local viewport_name = "player_1"

		for _, player in pairs(human_players) do
			local unit = player.player_unit
			local damage_ext = ScriptUnit.has_extension(unit, "damage_system")
			local has_shield = damage_ext and damage_ext:has_assist_shield()

			if has_shield then
				local head_node = Unit.node(unit, "c_head")
				local text = string.format("has shield")

				Managers.state.debug_text:clear_unit_text(unit, "has_shield")
				Managers.state.debug_text:output_unit_text(text, 0.3, unit, head_node, offset_vector, nil, "has_shield", color, viewport_name)
			else
				Managers.state.debug_text:clear_unit_text(unit, "has_shield")
			end
		end
	end
end

BuffSystem.get_player_group_buffs = function (self)
	return self.player_group_buffs
end

BuffSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)

	self.network_event_delegate = nil
	self.unit_extension_data = nil
end

local params = {}

BuffSystem.add_buff = function (self, unit, template_name, attacker_unit)
	if ScriptUnit.has_extension(unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		params.attacker_unit = attacker_unit

		buff_extension:add_buff(template_name, params)
	end

	local network_manager = self.network_manager
	local unit_object_id = network_manager:unit_game_object_id(unit)
	local attacker_unit_object_id = network_manager:unit_game_object_id(attacker_unit)
	local buff_template_name_id = NetworkLookup.buff_templates[template_name]

	if self.is_server then
		network_manager.network_transmit:send_rpc_clients("rpc_add_buff", unit_object_id, buff_template_name_id, attacker_unit_object_id)
	else
		network_manager.network_transmit:send_rpc_server("rpc_add_buff", unit_object_id, buff_template_name_id, attacker_unit_object_id)
	end
end

BuffSystem.rpc_add_buff = function (self, sender, unit_id, buff_template_name_id, attacker_unit_id)
	if self.is_server then
		self.network_manager.network_transmit:send_rpc_clients_except("rpc_add_buff", sender, unit_id, buff_template_name_id, attacker_unit_id)
	end

	local unit = self.unit_storage:unit(unit_id)
	local attacker_unit = self.unit_storage:unit(attacker_unit_id)
	local buff_template_name = NetworkLookup.buff_templates[buff_template_name_id]

	if ScriptUnit.has_extension(unit, "buff_system") then
		local buff_extension = ScriptUnit.extension(unit, "buff_system")
		params.attacker_unit = attacker_unit

		buff_extension:add_buff(buff_template_name, params)
	end
end

BuffSystem.add_volume_buff_multiplier = function (self, unit, buff_template_name, multiplier)
	assert(self.is_server, "[BuffSystem] add_volume_buff_multiplier should only be called on server!")

	local owner = Managers.player:unit_owner(unit)

	if owner.remote then
		local network_manager = Managers.state.network
		local unit_object_id = network_manager:unit_game_object_id(unit)
		local buff_template_name_id = NetworkLookup.buff_templates.movement_volume_generic_slowdown

		network_manager.network_transmit:send_rpc("rpc_add_volume_buff_multiplier", owner.peer_id, unit_object_id, buff_template_name_id, multiplier)
	else
		self:add_volume_buff(unit, buff_template_name, multiplier)
	end
end

BuffSystem.add_volume_buff = function (self, unit, buff_template_name, multiplier)
	if not Unit.alive(unit) then
		return
	end

	local buff_extension = ScriptUnit.extension(unit, "buff_system")
	local params = {
		external_optional_multiplier = multiplier
	}

	if not self.volume_buffs[unit] then
		self.volume_buffs[unit] = {}
	end

	if not self.volume_buffs[unit][buff_template_name] then
		self.volume_buffs[unit][buff_template_name] = buff_extension:add_buff(buff_template_name, params)
	end
end

BuffSystem.remove_volume_buff_multiplier = function (self, unit, buff_template_name)
	assert(self.is_server, "[BuffSystem] remove_volume_buff should only be called on server!")

	local owner = Managers.player:unit_owner(unit)

	if owner.remote then
		local network_manager = Managers.state.network
		local unit_object_id = network_manager:unit_game_object_id(unit)
		local buff_template_name_id = NetworkLookup.buff_templates.movement_volume_generic_slowdown

		network_manager.network_transmit:send_rpc("rpc_remove_volume_buff", owner.peer_id, unit_object_id, buff_template_name_id)
	else
		self:remove_volume_buff(unit, buff_template_name)
	end
end

BuffSystem.remove_volume_buff = function (self, unit, buff_template_name)
	if not Unit.alive(unit) then
		return
	end

	local buff_extension = ScriptUnit.extension(unit, "buff_system")
	local id = self.volume_buffs[unit][buff_template_name]

	buff_extension:remove_buff(id)

	self.volume_buffs[unit][buff_template_name] = nil
end

BuffSystem.rpc_add_volume_buff_multiplier = function (self, sender, unit_id, buff_template_name_id, multiplier)
	local unit = self.unit_storage:unit(unit_id)
	local buff_template_name = NetworkLookup.buff_templates[buff_template_name_id]

	self:add_volume_buff(unit, buff_template_name, multiplier)
end

BuffSystem.rpc_remove_volume_buff = function (self, sender, unit_id, buff_template_name_id)
	local unit = self.unit_storage:unit(unit_id)
	local buff_template_name = NetworkLookup.buff_templates[buff_template_name_id]

	self:remove_volume_buff(unit, buff_template_name)
end

BuffSystem.rpc_add_group_buff = function (self, sender, group_buff_template_id, num_instances)
	local group_buff_template_name = NetworkLookup.group_buff_templates[group_buff_template_id]
	local group_buff = GroupBuffTemplates[group_buff_template_name]
	local buff_per_instance = group_buff.buff_per_instance

	if self.is_server then
		self.network_manager.network_transmit:send_rpc_clients("rpc_add_group_buff", group_buff_template_id, num_instances)
	end

	local players = Managers.player:human_and_bot_players()

	for i = 1, num_instances, 1 do
		local group_buff_data = {
			group_buff_template_name = group_buff_template_name,
			recipients = {}
		}

		for _, player in pairs(players) do
			local unit = player.player_unit

			if Unit.alive(unit) then
				local buff_extension = ScriptUnit.extension(unit, "buff_system")
				local id = buff_extension:add_buff(buff_per_instance)
				local recipients = group_buff_data.recipients
				recipients[unit] = id
			end
		end

		self.player_group_buffs[#self.player_group_buffs + 1] = group_buff_data
	end
end

BuffSystem.rpc_remove_group_buff = function (self, sender, group_buff_template_id, num_instances)
	local group_buff_template_name = NetworkLookup.group_buff_templates[group_buff_template_id]
	local group_buffs = self.player_group_buffs

	for i = 1, num_instances, 1 do
		local num_group_buffs = #group_buffs
		local group_buff_data, index_to_remove = nil

		for i = 1, num_group_buffs, 1 do
			group_buff_data = group_buffs[i]

			if group_buff_data.group_buff_template_name == group_buff_template_name then
				index_to_remove = i

				break
			end
		end

		fassert(index_to_remove, "trying to remove a player group buff that isn't currently applied")
		table.remove(group_buffs, index_to_remove)

		if self.is_server then
			self.network_manager.network_transmit:send_rpc_clients("rpc_remove_group_buff", group_buff_template_id, num_instances)
		end

		local recipients = group_buff_data.recipients

		for unit, id in pairs(recipients) do
			if Unit.alive(unit) then
				local buff_extension = ScriptUnit.extension(unit, "buff_system")

				buff_extension:remove_buff(id)
			end
		end
	end
end

BuffSystem.rpc_buff_on_attack = function (self, sender, attacking_unit_id, hit_unit_id, attack_type_id)
	local hit_unit = self.unit_storage:unit(hit_unit_id)
	local attacking_unit = self.unit_storage:unit(attacking_unit_id)
	local attack_type = NetworkLookup.buff_proc_attack_types[attack_type_id]

	if not Unit.alive(attacking_unit) then
		return
	end

	DamageUtils.buff_on_attack(attacking_unit, hit_unit, attack_type)
end

return
