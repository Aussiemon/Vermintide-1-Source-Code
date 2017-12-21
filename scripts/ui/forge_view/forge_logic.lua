local forge_printf = (script_data.forge_debug and printf) or function ()
	return 
end
ForgeLogic = class(ForgeLogic)
ForgeLogic.init = function (self)
	return 
end
local UPGRADE_RARITY = {
	common = "rare",
	plentiful = "common",
	rare = "exotic"
}
ForgeLogic.merge_items = function (self, items_to_merge, token_type, num_tokens)
	forge_printf("[FORGE] merging items")

	local num_items = #items_to_merge

	if num_items == 0 then
		forge_printf("[FORGE] no items to merge")

		return 
	end

	local rarity = nil
	local item_types = {}
	local items = {}

	for i, item_backend_id in pairs(items_to_merge) do
		local item_data = BackendUtils.get_item_from_masterlist(item_backend_id)
		local item_key = item_data.key
		items[item_backend_id] = item_key

		forge_printf("[FORGE] item %s:%s", tostring(i), item_data.name)

		local config = ItemMasterList[item_key]
		local item_type = config.item_type
		item_types[item_type] = true

		if rarity and rarity ~= config.rarity then
			table.dump(items, "merge items")
			error("Trying to fuse items of different rarity")
		end

		rarity = rarity or config.rarity
	end

	BackendUtils.remove_tokens(num_tokens, token_type)

	self._expected_result = {
		rarity = UPGRADE_RARITY[rarity],
		item_types = item_types
	}
	self._fuse_item = ScriptBackendItem.forge(items, num_tokens, token_type)

	Managers.backend:commit()

	return 
end
ForgeLogic.poll_forge = function (self)
	local fuse_item = self._fuse_item

	if fuse_item.is_done(fuse_item) and not fuse_item.error_message(fuse_item) then
		local items = fuse_item.items(fuse_item)
		local backend_id, item_key = next(items)
		local config = ItemMasterList[item_key]
		local item_type = config.item_type
		local rarity = config.rarity

		fassert(self._expected_result.rarity == rarity, "Fused item had wrong rarity. Expected: %q, Actual: %q", self._expected_result.rarity, rarity)
		fassert(self._expected_result.item_types[item_type], "Fused item had wrong item_type. Got: %q", item_type)

		self._expected_result = nil
		self._fuse_item = nil

		return item_key, backend_id
	end

	return 
end
ForgeLogic.upgrade_item = function (self, backend_id, trait_name, token_type, traits_cost)
	if not backend_id or not trait_name then
		return false
	end

	local item_data = BackendUtils.get_item_from_masterlist(backend_id)
	local trait_config = BuffTemplates[trait_name]
	local buff_data = trait_config.buffs[1]
	local value = self._randomize_trait_variable(self, item_data, trait_name, "proc_chance")

	if value then
		forge_printf("[FORGE] upgrade_item: %s trait_name: %s proc_chance %d", item_data.name, trait_name, value)
	else
		forge_printf("[FORGE] upgrade_item: %s trait_name: %s", item_data.name, trait_name)
	end

	BackendUtils.remove_tokens(traits_cost, token_type)

	if value then
		BackendUtils.add_trait(backend_id, trait_name, "proc_chance", value)
	else
		BackendUtils.add_trait(backend_id, trait_name)
	end

	Managers.backend:commit()

	return true
end
ForgeLogic.reroll_trait_variable = function (self, backend_id, trait_name, variable_name)
	local item_info = ScriptBackendItem.get_item_from_id(backend_id)
	local item_data = ItemMasterList[item_info.key]
	local rarity = item_data.rarity
	local settings = AltarSettings.proc_reroll_trait[rarity]

	BackendUtils.remove_tokens(Vault.withdraw_single(VaultAltarRerollTraitProcCostKeyTable[rarity].cost, settings.cost), settings.token_type)

	local item_data = BackendUtils.get_item_from_masterlist(backend_id)
	local new_variable_value = self._randomize_trait_variable(self, item_data, trait_name, variable_name, true)
	local traits = ScriptBackendItem.get_traits(backend_id)
	local current_variable_value = nil

	for _, trait_data in pairs(traits) do
		if trait_data.trait_name == trait_name then
			current_variable_value = trait_data[variable_name]

			if current_variable_value < new_variable_value then
				trait_data[variable_name] = new_variable_value

				ScriptBackendItem.set_traits(backend_id, traits)
			end
		end
	end

	Managers.backend:commit()

	return new_variable_value
end
ForgeLogic._randomize_trait_variable = function (self, item_data, trait_name, variable_name, reroll)
	local trait_config = BuffTemplates[trait_name]
	local buff_data = trait_config.buffs[1]
	local variable = nil
	local variable_base = buff_data[variable_name]

	if variable_base then
		if type(variable_base) == "table" then
			local rarity = item_data.rarity

			if rarity == "unique" then
				variable = variable_base[2]
			else
				local steps = ForgeSettings.trait_steps
				local value = Math.random(steps)

				if reroll and value == 0 then
					value = 1
				end

				local diff = variable_base[2] - variable_base[1]
				local scaled = value/steps*diff
				variable = variable_base[1] + scaled
			end

			variable = math.floor(variable*1000 + 0.5)/1000
		elseif type(variable_base) == "number" then
			variable = variable_base
		end
	end

	return variable
end
ForgeLogic.melt_item = function (self, item_backend_id)
	local item_data = BackendUtils.get_item_from_masterlist(item_backend_id)
	local rarity = item_data.rarity
	local item_name = item_data.name
	local melt_reward_settings = ForgeSettings.melt_reward[rarity]
	local token_type = melt_reward_settings.token_type

	if not token_type then
		return false
	end

	local result = BackendUtils.remove_item(item_backend_id)

	if result then
		local token_reward_amount_min = melt_reward_settings.min
		local token_reward_amount_max = melt_reward_settings.max
		local number_of_tokens = math.random(Vault.withdraw_single_ex(VaultForgeMeltKeyTable[rarity].min, token_reward_amount_min), Vault.withdraw_single_ex(VaultForgeMeltKeyTable[rarity].max, token_reward_amount_max))

		BackendUtils.add_tokens(number_of_tokens, token_type)
		Managers.backend:commit()

		return true, item_name, number_of_tokens
	end

	return 
end
local allowed_slot_types = {
	melee = true,
	ranged = true,
	any = true
}
ForgeLogic.pray_for_loot = function (self, profile_name, rarity, slot_type)
	fassert(allowed_slot_types[slot_type], "Can't produce items for slot of type %s", slot_type)

	local altar_settings = AltarSettings
	local rarity_settings = altar_settings.pray_for_loot_cost[rarity]
	local token_type = rarity_settings.token_type
	local cost = nil

	if slot_type == "any" then
		cost = Vault.withdraw_single_ex(VaultAltarCostKeyTable[rarity].random, rarity_settings.random)
	else
		cost = Vault.withdraw_single_ex(VaultAltarCostKeyTable[rarity].specific, rarity_settings.specific)
	end

	BackendUtils.remove_tokens(cost, token_type)

	local pray_for_loot_script = GameSettingsDevelopment.backend_settings.pray_for_loot_script
	self._prayer_item = ScriptBackendItem.data_server_script(pray_for_loot_script, "param_profile_name", profile_name, "param_rarity", rarity, "param_slot_type", slot_type)

	Managers.backend:commit()

	return 
end
ForgeLogic.poll_pray_for_loot = function (self)
	local prayer_item = self._prayer_item

	if prayer_item.is_done(prayer_item) and not prayer_item.error_message(prayer_item) then
		self._prayer_item = nil
		local items = prayer_item.items(prayer_item)
		local backend_id, item_key = next(items)

		return item_key, backend_id
	end

	return 
end
ForgeLogic.reroll_traits = function (self, backend_id, item_is_equipped)
	local item_info = ScriptBackendItem.get_item_from_id(backend_id)
	local item_data = ItemMasterList[item_info.key]

	table.dump(item_data, "reroll traits item_data")

	local rarity = item_data.rarity
	local settings = AltarSettings.reroll_traits[rarity]

	BackendUtils.remove_tokens(Vault.withdraw_single(VaultAltarRerollTraitsCostKeyTable[rarity].cost, settings.cost), settings.token_type)

	local item_type = item_data.item_type
	local all_of_item_type = {}

	for key, data in pairs(ItemMasterList) do
		if data.item_type == item_type and data.rarity == rarity then
			all_of_item_type[#all_of_item_type + 1] = key
		end
	end

	fassert(1 < #all_of_item_type, "Trying to reroll traits for item type %s and rarity %s, but there are only one such item", item_type, rarity)

	local old_item_key = item_data.key
	local new_item_key = nil

	while not new_item_key do
		local new = all_of_item_type[Math.random(#all_of_item_type)]

		if new ~= old_item_key then
			new_item_key = new
		end
	end

	local hero, slot = ScriptBackendItem.equipped_by(backend_id)
	self._reroll_trait_data = {
		state = 1,
		new_item_key = new_item_key,
		old_backend_id = backend_id,
		hero = hero,
		slot = slot
	}

	Managers.backend:commit()

	return 
end
ForgeLogic.poll_reroll_traits = function (self)
	local data = self._reroll_trait_data

	if data and data.state == 1 then
		data.state = 2

		return data.new_item_key
	end

	return 
end
ForgeLogic.select_rerolled_traits = function (self, accept_new)
	local data = self._reroll_trait_data
	data.accept_new = accept_new

	if accept_new and data.state == 2 then
		local item_key = data.new_item_key

		ScriptBackendItem.award_item(item_key)
		ScriptBackendItem.remove_item(data.old_backend_id, true)

		data.commit_id = Managers.backend:commit()
	end

	data.state = 3

	return 
end
ForgeLogic.poll_select_rerolled_traits = function (self)
	local data = self._reroll_trait_data

	fassert(data, "Polling for select reroll traits when there is nothing to ask about")

	local new_item_key = data.new_item_key

	if data and data.state == 3 then
		if data.accept_new then
			local commit_returned = Managers.backend:commit_status(data.commit_id) == Backend.COMMIT_SUCCESS

			if commit_returned then
				ScriptBackendItem.__dirtify()

				local items = ScriptBackendItem.get_filtered_items("item_key == " .. new_item_key)

				for _, item_data in ipairs(items) do
					local traits = ScriptBackendItem.get_traits(item_data.backend_id)

					if table.is_empty(traits) then
						if data.hero and data.slot then
							ScriptBackendItem.set_loadout_item(item_data.backend_id, data.hero, data.slot)
						end

						self._reroll_trait_data = nil

						return {
							backend_id = item_data.backend_id,
							hero = data.hero,
							slot = data.slot
						}
					end
				end

				table.dump(items, "rerolled items", 2)
				ferror("Found %d items with the name %q, all of which had traits unlocked", #items, new_item_key)
			end
		else
			self._reroll_trait_data = nil

			return {}
		end
	end

	return 
end

return 
