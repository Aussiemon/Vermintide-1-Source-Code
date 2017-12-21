local Items = class(Items)
Items.init = function (self)
	self._dirty = true
	self._debug_end_of_round_timeout = false

	return 
end
local CLEARABLE_SLOTS = {
	slot_trinket_2 = true,
	slot_trinket_3 = true,
	slot_trinket_1 = true
}
local MUST_HAVE_SLOTS = {
	slot_hat = true,
	slot_melee = true,
	slot_ranged = true
}

local function find_item_for_slot(items, profile_name, slot)
	for backend_id, item_data in pairs(items) do
		local item_config = ItemMasterList[item_data.key]
		local can_wield = item_config.can_wield

		for _, profile in ipairs(can_wield) do
			if profile == profile_name then
				local slot_type = item_config.slot_type
				local wanted_type = InventorySettings.slots_by_name[slot].type

				if slot_type == wanted_type then
					return backend_id
				end
			end
		end
	end

	return 
end

local function clean_inventory(items, loadout)
	local missing_items = nil

	for backend_id, item in pairs(items) do
		if not rawget(ItemMasterList, item.key) then
			missing_items = missing_items or {}
			missing_items[backend_id] = item.key
		end
	end

	local empty_must_have_slots = {}

	for profile_name, slots in pairs(loadout) do
		for slot, backend_id in pairs(slots) do
			if slot == "backend_id" then
			elseif not items[backend_id] then
				ScriptApplication.send_to_crashify("ScriptBackendItem", "Tried to equip item not found in items list, clearing slot. Profile: %q, Backend id: %d, Slot: %q", profile_name, backend_id, slot)
				BackendItem.set_loadout_item(nil, loadout[profile_name].backend_id, slot)

				slots[slot] = nil

				if MUST_HAVE_SLOTS[slot] then
					empty_must_have_slots[#empty_must_have_slots + 1] = {
						slot = slot,
						profile_name = profile_name
					}
				end
			elseif missing_items and missing_items[backend_id] then
				ScriptApplication.send_to_crashify("ScriptBackendItem", "Tried to equip item not found in ItemMasterList, clearing slot. Profile: %q, Item: %q, Backend id: %d, Slot: %q", profile_name, missing_items[backend_id], backend_id, slot)
				BackendItem.set_loadout_item(nil, loadout[profile_name].backend_id, slot)

				slots[slot] = nil

				if MUST_HAVE_SLOTS[slot] then
					empty_must_have_slots[#empty_must_have_slots + 1] = {
						slot = slot,
						profile_name = profile_name
					}
				end
			end
		end
	end

	if missing_items then
		for backend_id, key in pairs(missing_items) do
			ScriptApplication.send_to_crashify("ScriptBackendItem", "Missing item %q in backend, removing it. Backend id: %q", key, backend_id)

			items[backend_id] = nil
		end
	end

	for index, slot_data in ipairs(empty_must_have_slots) do
		local profile_name = slot_data.profile_name
		local slot = slot_data.slot
		local backend_id = find_item_for_slot(items, profile_name, slot)

		if backend_id then
			ScriptApplication.send_to_crashify("ScriptBackendItem", "Slot %q was empty, putting item %d in it", slot, backend_id)
			BackendItem.set_loadout_item(backend_id, loadout[profile_name].backend_id, slot)

			empty_must_have_slots[index] = nil
			loadout[profile_name][slot] = backend_id
		end
	end

	fassert(table.is_empty(empty_must_have_slots), "[ScriptBackendItem] Your backend save is broken, ask for help resetting it")

	return 
end

Items._refresh_entities_if_needed = function (self)
	if self._dirty then
		local items, loadout = BackendItem.get_items()

		clean_inventory(items, loadout)

		self._items = items
		self._loadout = loadout
		self._profile_cache = {}
		self._dirty = false
	end

	return 
end
Items.get_all_backend_items = function (self)
	self._refresh_entities_if_needed(self)

	return self._items
end
Items.get_items = function (self, profile, slot)
	self._refresh_entities_if_needed(self)

	local all_items = self.get_all_backend_items(self)
	self._profile_cache[profile] = self._profile_cache[profile] or {}
	local items = self._profile_cache[profile][slot]

	if not items then
		items = ScriptBackendCommon.filter_slot_items(all_items, profile, slot)
		self._profile_cache[profile][slot] = items
	end

	return items
end
Items.get_filtered_items = function (self, filter)
	local all_items = self.get_all_backend_items(self)
	local items = ScriptBackendCommon.filter_items(all_items, filter)

	return items
end
Items.set_error = function (self, error_data)
	self._error_data = error_data

	return 
end
Items.check_for_errors = function (self)
	local error_data = self._error_data
	self._error_data = nil

	return error_data
end
Items.update = function (self, dt)
	if self._dice_game_data then
		local session_ready = not self._debug_end_of_round_timeout and ScriptBackendSession.get_state() == "END_OF_ROUND"
		local sessions_disabled = not GameSettingsDevelopment.backend_settings.enable_sessions

		if session_ready or sessions_disabled then
			local parameters = self._dice_game_data.parameters
			local dice_script = GameSettingsDevelopment.backend_settings.dice_script

			print("Generating backend loot with:", unpack(parameters))

			self._dice_item = self._queue:add_item(dice_script, unpack(parameters))

			self._dice_item:disable_registered_commands()

			self._dice_game_data = nil
		elseif self._dice_game_data.time_out < Managers.time:time("main") then
			self._dice_game_data = nil

			self.set_error(self, {
				reason = BACKEND_LUA_ERRORS.ERR_DICE_TIMEOUT1
			})
		end
	elseif self._upgrades_failed_game_data then
		local session_ready = not self._debug_end_of_round_timeout and ScriptBackendSession.get_state() == "END_OF_ROUND"
		local sessions_disabled = not GameSettingsDevelopment.backend_settings.enable_sessions

		if session_ready or sessions_disabled then
			local start_level = self._upgrades_failed_game_data.start_level
			local end_level = self._upgrades_failed_game_data.end_level
			local upgrades_failed_script = GameSettingsDevelopment.backend_settings.upgrades_failed_script

			print("Generating upgrades for failed game:", upgrades_failed_script, "param_start_level", start_level, "param_end_level", end_level)

			self._upgrades_item = self._queue:add_item(upgrades_failed_script, "param_start_level", start_level, "param_end_level", end_level)

			self._upgrades_item:disable_registered_commands()

			self._upgrades_failed_game_data = nil
		elseif self._upgrades_failed_game_data.time_out < Managers.time:time("main") then
			self._upgrades_failed_game_data = nil

			self.set_error(self, {
				reason = BACKEND_LUA_ERRORS.ERR_UPGRADES_TIMEOUT
			})
		end
	end

	return 
end
Items.reset_dice_game_item = function (self)
	self._dice_item = nil

	return 
end
Items.dice_game_item = function (self)
	return self._dice_item
end
Items.poll_upgrades = function (self)
	local upgrades_item = self._upgrades_item

	if upgrades_item and upgrades_item.is_done(upgrades_item) and not upgrades_item.error_message(upgrades_item) then
		self._upgrades_item = nil

		return upgrades_item.items(upgrades_item)
	end

	return 
end
Items.get_loadout = function (self)
	self._refresh_entities_if_needed(self)

	return self._loadout
end
Items.generate_item_server_loot = function (self, dice, difficulty, start_level, end_level, hero_name, dlc_name)
	fassert(not self._dice_game_data and not self._upgrades_failed_game_data, "Trying to do two item server scripts at once. DiceGame: %s, UpgradesFailedGame: %s", self._dice_game_data and "true", self._upgrades_failed_game_data and "true")

	local time_out = Managers.time:time("main") + 20
	local parameters = {
		"param_dice",
		tostring(dice),
		"param_difficulty",
		difficulty,
		"param_start_level",
		start_level,
		"param_end_level",
		end_level
	}

	if hero_name then
		parameters[#parameters + 1] = "param_hero_name"
		parameters[#parameters + 1] = hero_name
	end

	if dlc_name then
		parameters[#parameters + 1] = "param_dlc_name"
		parameters[#parameters + 1] = dlc_name
	end

	self._dice_game_data = {
		time_out = time_out,
		parameters = parameters
	}

	return 
end
Items.upgrades_failed_game = function (self, start_level, end_level)
	fassert(not self._dice_game_data and not self._upgrades_failed_game_data, "Trying to do two item server scripts at once. DiceGame: %s, UpgradesFailedGame: %s", self._dice_game_data and "true", self._upgrades_failed_game_data and "true")

	local time_out = Managers.time:time("main") + 20
	self._upgrades_failed_game_data = {
		time_out = time_out,
		start_level = start_level,
		end_level = end_level
	}

	return 
end
Items.num_current_item_server_requests = function (self)
	return self._queue:num_current_requests()
end
Items.make_dirty = function (self)
	self._dirty = true

	return 
end
Items.set_rerolling_trait_state = function (self, state)
	self._rerolling_trait_state = state

	return 
end
Items.get_rerolling_trait_state = function (self)
	return self._rerolling_trait_state
end
Items.set_data_server_queue = function (self, queue)
	self._queue = queue

	return 
end
Items.data_server_queue = function (self)
	return self._queue
end
backend_items = backend_items or Items.new(Items)
ScriptBackendItem = ScriptBackendItem or {}
ScriptBackendItem.type = function ()
	return "backend"
end
ScriptBackendItem.update = function ()
	Profiler.start("ScriptBackendItem update")
	backend_items:update()
	Profiler.stop()

	return 
end
ScriptBackendItem.check_for_errors = function ()
	return backend_items:check_for_errors()
end
ScriptBackendItem.num_current_item_server_requests = function ()
	return backend_items:num_current_item_server_requests()
end
ScriptBackendItem.set_traits = function (backend_id, traits)
	local serialized_traits = ScriptBackendCommon.serialize_traits(traits)
	local error_code = BackendItem.set_traits(backend_id, serialized_traits)

	fassert(not error_code or error_code == Backend.RES_NO_CHANGE, "BackendItem.set_traits() returned an unexpected result: %d", error_code)

	return 
end
ScriptBackendItem.add_trait = function (backend_id, trait_name, variable, value)
	local serialized_traits = BackendItem.get_traits(backend_id)
	serialized_traits = serialized_traits or ""

	if variable then
		serialized_traits = string.format("%s%s,%s,%.3f;", serialized_traits, trait_name, variable, value)
	else
		serialized_traits = string.format("%s%s;", serialized_traits, trait_name)
	end

	local error_code = BackendItem.set_traits(backend_id, serialized_traits)

	fassert(not error_code, "BackendItem.set_traits() returned an unexpected result: %d", error_code)

	return 
end
ScriptBackendItem.get_traits = function (backend_id)
	local serialized_traits = BackendItem.get_traits(backend_id)
	serialized_traits = serialized_traits or ""
	local traits = {}

	for trait_name, variable, value in string.gmatch(serialized_traits, "([%w_]+),*([%w_]*),*([%w_%.]*);") do
		local trait_data = {
			trait_name = trait_name
		}

		if variable then
			trait_data[variable] = tonumber(value)
		end

		traits[#traits + 1] = trait_data
	end

	return traits
end
ScriptBackendItem.get_key = function (backend_id)
	local items = backend_items:get_all_backend_items()
	local item = items[backend_id]

	if item then
		return item.key
	end

	return 
end
ScriptBackendItem.get_item_from_id = function (backend_id)
	if backend_id == 0 then
		ScriptApplication.send_to_crashify("ScriptBackendItem", "Tried to get item from backend_id 0")
	end

	local items = backend_items:get_all_backend_items()

	return items[backend_id]
end
ScriptBackendItem.get_item_id = function (item_key)
	error("This concept is broken, don't call this function")

	return 
end
ScriptBackendItem.get_items = function (profile, slot)
	assert(profile and slot, "[ScriptBackendItem:get_items] need both profile %q, and %q", profile or "nil", slot or "nil")

	return backend_items:get_items(profile, slot)
end
ScriptBackendItem.get_all_backend_items = function ()
	return backend_items:get_all_backend_items()
end
ScriptBackendItem.get_loadout = function ()
	return backend_items:get_loadout()
end
ScriptBackendItem.get_loadout_item_id = function (profile, slot)
	local loadout = backend_items:get_loadout()
	local backend_id = loadout[profile][slot]

	return backend_id
end
ScriptBackendItem.get_loadout_slot = function (backend_id)
	local loadout = backend_items:get_loadout()

	return 
end
ScriptBackendItem.get_filtered_items = function (filter)
	local items = backend_items:get_filtered_items(filter)

	return items
end
ScriptBackendItem.set_loadout_item = function (item_id, profile, slot)
	local items = backend_items:get_all_backend_items()

	if item_id then
		fassert(items[item_id], "Trying to equip item that doesn't exist %d", item_id or "nil")
	end

	local loadout = backend_items:get_loadout()
	local profile_id = loadout[profile].backend_id

	BackendItem.set_loadout_item(item_id, profile_id, slot)
	backend_items:make_dirty()

	return 
end
ScriptBackendItem.remove_item = function (backend_id, ignore_equipped)
	if not ignore_equipped then
		local loadout = backend_items:get_loadout()

		for hero, slots in pairs(loadout) do
			for slot, id in pairs(slots) do
				if MUST_HAVE_SLOTS[slot] then
					fassert(backend_id ~= id, "Trying to destroy equipped item: %s:%s:%d", hero, slot, backend_id)
				end
			end
		end
	end

	local result = BackendItem.destroy_entity(backend_id)

	backend_items:make_dirty()

	return result
end
ScriptBackendItem.award_item = function (item_key)
	BackendItem.award_item(item_key)
	backend_items:make_dirty()

	return 
end
ScriptBackendItem.data_server_script = function (script_name, ...)
	local queue = backend_items:data_server_queue()
	local request = queue.add_item(queue, script_name, ...)

	return request
end
ScriptBackendItem.upgrades_failed_game = function (level_start, level_end)
	backend_items:upgrades_failed_game(level_start, level_end)

	return 
end
ScriptBackendItem.poll_upgrades_failed_game = function ()
	return backend_items:poll_upgrades()
end
ScriptBackendItem.generate_item_server_loot = function (dice, difficulty, start_level, end_level, hero_name, dlc_name)
	local dice_string = ""

	for type, amount in pairs(dice) do
		dice_string = dice_string .. type .. "," .. tostring(amount) .. ";"
	end

	backend_items:generate_item_server_loot(dice_string, difficulty, start_level, end_level, hero_name, dlc_name)

	return 
end
ScriptBackendItem.check_for_loot = function ()
	local dice_item = backend_items:dice_game_item()

	if dice_item and dice_item.is_done(dice_item) then
		local error_message = dice_item.error_message(dice_item)

		if error_message then
			backend_items:set_error(error_message)
		elseif dice_item.items(dice_item) then
			local parameters = dice_item.parameters(dice_item)
			local items = dice_item.items(dice_item)
			local successes = {}
			local total_successes = 1
			local successes_string = parameters.successes

			for type, num_successes in string.gmatch(successes_string, "([%w_]+),(%w+);") do
				successes[type] = tonumber(num_successes)
				total_successes = total_successes + num_successes
			end

			local win_list_string = parameters.win_list
			local win_list = {}

			for item in string.gmatch(win_list_string, "([%w_]+),") do
				win_list[#win_list + 1] = item
			end

			local item_key = win_list[total_successes]
			local dice_win_id = nil
			local level_rewards = {}

			for id, key in pairs(items) do
				if item_key == key then
					dice_win_id = id
				else
					level_rewards[id] = key
				end
			end

			fassert(dice_win_id, "Broken dice game winnings")
			ScriptBackendSession.received_dice_game_loot()
			backend_items:reset_dice_game_item()
			backend_items:make_dirty()

			return successes, win_list, dice_win_id, level_rewards
		end
	end

	return 
end
ScriptBackendItem.forge = function (items, num_tokens, token_type)
	local items_to_merge = ""
	local loadout = backend_items:get_loadout()

	for hero, slots in pairs(loadout) do
		for slot, id in pairs(slots) do
			if MUST_HAVE_SLOTS[slot] then
				for backend_id, _ in pairs(items) do
					fassert(backend_id ~= id, "Trying to merge an equipped item: %s:%s:%d", hero, slot, backend_id)
				end
			end
		end
	end

	local all_items = backend_items:get_all_backend_items()

	for backend_id, item_key in pairs(items) do
		fassert(all_items[backend_id], "trying to fuse item user doesn't own, %d, %s", backend_id, item_key)

		items_to_merge = string.format("%s%s,%s;", items_to_merge, item_key, backend_id)
	end

	local fuse_script = GameSettingsDevelopment.backend_settings.forge_script

	print("Fusing in backend with:", fuse_script, "param_items_to_merge", items_to_merge, "params_num_tokens", num_tokens, "params_token_type", token_type)

	local queue = backend_items:data_server_queue()
	local item = queue.add_item(queue, fuse_script, "param_items_to_merge", items_to_merge, "params_num_tokens", num_tokens, "params_token_type", token_type)

	item.disable_registered_commands(item)

	return item
end
ScriptBackendItem.equipped_by = function (backend_id)
	local loadout = backend_items:get_loadout()

	for hero, slots in pairs(loadout) do
		for slot, id in pairs(slots) do
			if backend_id == id then
				return hero, slot
			end
		end
	end

	return 
end
ScriptBackendItem.is_equipped = function (backend_id, profile_name)
	local loadout = backend_items:get_loadout()

	for hero, slots in pairs(loadout) do
		if not profile_name or hero == profile_name then
			for slot, id in pairs(slots) do
				if (MUST_HAVE_SLOTS[slot] or CLEARABLE_SLOTS[slot]) and backend_id == id then
					return true
				end
			end
		end
	end

	return false
end
local SalvageableSlotTypes = {
	ranged = true,
	melee = true,
	hat = true,
	trinket = true
}
local SalvageableRarities = {
	common = true,
	plentiful = true,
	exotic = true,
	rare = true,
	unique = true
}
ScriptBackendItem.is_salvageable = function (backend_id)
	local unequipped = not ScriptBackendItem.is_equipped(backend_id)
	local items = backend_items:get_all_backend_items()
	local item = items[backend_id]
	local item_config = ItemMasterList[item.key]
	local salvageable_slot_type = SalvageableSlotTypes[item_config.slot_type]
	local salvageable_rarity = SalvageableRarities[item_config.rarity]

	return unequipped and salvageable_slot_type and salvageable_rarity
end
local FuseableSlotTypes = {
	melee = true,
	ranged = true
}
local FuseableRarities = {
	common = true,
	plentiful = true,
	rare = true
}
ScriptBackendItem.is_fuseable = function (backend_id)
	local unequipped = not ScriptBackendItem.is_equipped(backend_id)
	local items = backend_items:get_all_backend_items()
	local item = items[backend_id]
	local item_config = ItemMasterList[item.key]
	local fuseable_slot_type = FuseableSlotTypes[item_config.slot_type]
	local fuseable_rarity = FuseableRarities[item_config.rarity]

	return unequipped and fuseable_slot_type and fuseable_rarity
end
ScriptBackendItem.set_rerolling_trait_state = function (state)
	backend_items:set_rerolling_trait_state(state)

	return 
end
ScriptBackendItem.get_rerolling_trait_state = function ()
	return backend_items:get_rerolling_trait_state()
end
ScriptBackendItem.set_data_server_queue = function (queue)
	backend_items:set_data_server_queue(queue)

	return 
end
ScriptBackendItem.__dirtify = function ()
	backend_items:make_dirty()

	return 
end

function make_script_backend_item_tutorial()
	ScriptBackendItem = ScriptBackendItemTutorial

	return 
end

function make_script_backend_item_local()
	ScriptBackendItem = ScriptBackendItemLocal

	return 
end

BackendManagerLocalEnabled = BackendManagerLocalEnabled or false

if BackendManagerLocalEnabled then
	make_script_backend_item_local()
end

BackendManagerTutorialEnabled = BackendManagerTutorialEnabled or false

if BackendManagerTutorialEnabled then
	make_script_backend_item_tutorial()
end

return 
