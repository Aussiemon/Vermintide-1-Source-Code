ScriptBackendCommon = ScriptBackendCommon or {}
ScriptBackendCommon.filter_slot_items = function (items, profile, slot)
	local item_list = {}
	local item_master_list = ItemMasterList

	for backend_id, item in pairs(items) do
		local key = item.key
		local item_data = item_master_list[key]

		if slot == item_data.slot_type and ScriptBackendCommon.can_wield(profile, item_data) then
			item_list[#item_list + 1] = backend_id
		end
	end

	return item_list
end
ScriptBackendCommon.can_wield = function (profile, item_data)
	local can_wield = item_data.can_wield

	assert(can_wield, "ScriptBackendCommon - Item %q has not specified what profiles that can use it.", item_data.name or "(item_data missing name)")

	for _, wield_profile in ipairs(can_wield) do
		if profile == wield_profile then
			return true
		end
	end

	return 
end
local filter_operators = {
	not = {
		4,
		1,
		function (op1)
			return not op1
		end
	},
	["<"] = {
		3,
		2,
		function (op1, op2)
			return op1 < op2
		end
	},
	[">"] = {
		3,
		2,
		function (op1, op2)
			return op2 < op1
		end
	},
	["<="] = {
		3,
		2,
		function (op1, op2)
			return op1 <= op2
		end
	},
	[">="] = {
		3,
		2,
		function (op1, op2)
			return op2 <= op1
		end
	},
	["~="] = {
		3,
		2,
		function (op1, op2)
			return op1 ~= op2
		end
	},
	["=="] = {
		3,
		2,
		function (op1, op2)
			return op1 == op2
		end
	},
	and = {
		2,
		2,
		function (op1, op2)
			return op1 and op2
		end
	},
	or = {
		1,
		2,
		function (op1, op2)
			return op1 or op2
		end
	}
}
local filter_macros = {
	item_key = function (item_data, backend_id)
		return item_data.key
	end,
	item_rarity = function (item_data, backend_id)
		return item_data.rarity
	end,
	slot_type = function (item_data, backend_id)
		return item_data.slot_type
	end,
	item_type = function (item_data, backend_id)
		return item_data.item_type
	end,
	trinket_as_hero = function (item_data, backend_id)
		if item_data.traits then
			for _, trait_name in ipairs(item_data.traits) do
				local trait_config = BuffTemplates[trait_name]
				local roll_dice_as_hero = trait_config.roll_dice_as_hero

				if roll_dice_as_hero then
					return true
				end
			end
		end

		return 
	end,
	equipped_by = function (item_data, backend_id)
		local hero = ScriptBackendItem.equipped_by(backend_id)

		return hero
	end,
	current_hero = function (item_data, backend_id)
		local profile_synchronizer = Managers.state.network.profile_synchronizer
		local player = Managers.player:local_player()
		local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, player.network_id(player), player.local_player_id(player))
		local hero_data = SPProfiles[profile_index]
		local hero_name = hero_data.display_name

		return hero_name
	end,
	can_wield_bright_wizard = function (item_data, backend_id)
		local hero_name = "bright_wizard"
		local can_wield = item_data.can_wield

		return table.contains(can_wield, hero_name)
	end,
	can_wield_dwarf_ranger = function (item_data, backend_id)
		local hero_name = "dwarf_ranger"
		local can_wield = item_data.can_wield

		return table.contains(can_wield, hero_name)
	end,
	can_wield_empire_soldier = function (item_data, backend_id)
		local hero_name = "empire_soldier"
		local can_wield = item_data.can_wield

		return table.contains(can_wield, hero_name)
	end,
	can_wield_witch_hunter = function (item_data, backend_id)
		local hero_name = "witch_hunter"
		local can_wield = item_data.can_wield

		return table.contains(can_wield, hero_name)
	end,
	can_wield_wood_elf = function (item_data, backend_id)
		local hero_name = "wood_elf"
		local can_wield = item_data.can_wield

		return table.contains(can_wield, hero_name)
	end,
	player_owns_item_key = function (item_data, backend_id)
		local all_items = ScriptBackendItem.get_all_backend_items()

		for backend_id, config in pairs(all_items) do
			if item_data.key == config.key then
				return true
			end
		end

		return false
	end
}
ScriptBackendCommon.filter_postfix_cache = ScriptBackendCommon.filter_postfix_cache or {}
ScriptBackendCommon.filter_items = function (items, filter_infix)
	local filter_postfix = ScriptBackendCommon.filter_postfix_cache[filter_infix]

	if not filter_postfix then
		filter_postfix = ScriptBackendCommon.infix_to_postfix_item_filter(filter_infix)
		ScriptBackendCommon.filter_postfix_cache[filter_infix] = filter_postfix
	end

	local item_master_list = ItemMasterList
	local stack = {}
	local passed = {}

	for backend_id, item in pairs(items) do
		local key = item.key
		local item_data = item_master_list[key]

		table.clear(stack)

		for i = 1, #filter_postfix, 1 do
			local token = filter_postfix[i]

			if filter_operators[token] then
				local num_params = filter_operators[token][2]
				local op_func = filter_operators[token][3]
				local op1 = table.remove(stack)

				if num_params == 1 then
					stack[#stack + 1] = op_func(op1)
				else
					local op2 = table.remove(stack)
					stack[#stack + 1] = op_func(op1, op2)
				end
			else
				local macro_func = filter_macros[token]

				if macro_func then
					stack[#stack + 1] = macro_func(item_data, backend_id)
				else
					stack[#stack + 1] = token
				end
			end
		end

		if stack[1] == true then
			local clone_item_data = table.clone(item_data)
			clone_item_data.backend_id = backend_id
			passed[#passed + 1] = clone_item_data
		end
	end

	return passed
end
ScriptBackendCommon.infix_to_postfix_item_filter = function (filter_infix)
	local output = {}
	local stack = {}

	for token in string.gmatch(filter_infix, "%S+") do
		if filter_operators[token] then
			while 0 < #stack do
				local top = stack[#stack]

				if filter_operators[top] and filter_operators[token][1] <= filter_operators[top][1] then
					output[#output + 1] = table.remove(stack)
				else
					break
				end
			end

			stack[#stack + 1] = token
		elseif token == "(" then
			stack[#stack + 1] = "("
		elseif token == ")" then
			while 0 < #stack do
				local top = stack[#stack]

				if top ~= "(" then
					output[#output + 1] = table.remove(stack)
				else
					stack[#stack] = nil

					break
				end
			end
		else
			output[#output + 1] = token
		end
	end

	while 0 < #stack do
		output[#output + 1] = table.remove(stack)
	end

	for i = 1, #output, 1 do
		local token = output[i]

		if token == "true" then
			output[i] = true
		elseif token == "false" then
			output[i] = false
		elseif tonumber(token) then
			output[i] = tonumber(token)
		end
	end

	return output
end
ScriptBackendCommon.serialize_traits = function (traits)
	local serialized_traits = ""

	for id, trait_data in pairs(traits) do
		local trait_name = trait_data.trait_name
		local serialized = trait_name

		for variable_name, value in pairs(trait_data) do
			if variable_name ~= "trait_name" then
				serialized = serialized .. string.format(",%s,%.3f", variable_name, value)
			end
		end

		serialized = serialized .. ";"
		serialized_traits = serialized_traits .. serialized
	end

	return serialized_traits
end

return 
