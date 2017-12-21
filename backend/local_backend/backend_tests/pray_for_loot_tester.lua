PrayForLootTester = class(PrayForLootTester)
PrayForLootTester.init = function (self)
	self._state = "done"
	self._profiles = {
		"empire_soldier",
		"wood_elf",
		"bright_wizard",
		"dwarf_ranger",
		"witch_hunter"
	}
	self._rarities = {
		"plentiful",
		"common",
		"rare",
		"exotic"
	}
	self._slot_types = {
		"melee",
		"ranged",
		"any"
	}

	return 
end
PrayForLootTester.start = function (self, max_queries)
	self._num_queries = 0
	self._state = "query"
	self._max_queries = max_queries or 100
	self._errors = {}
	local update = callback(self, "update")

	Managers.debug_updator:add_updator(update, "PrayForLootTester")

	return 
end
PrayForLootTester.update = function (self, dt)
	local rarity = self._rarity

	if self._state == "query" then
		self._query(self)

		self._state = "poll"
	elseif self._state == "poll" then
		local result = self.poll_answer(self)

		if result then
			self._num_queries = self._num_queries + 1

			if self._max_queries <= self._num_queries then
				self._state = "done"

				Managers.debug_updator:remove_updator_by_name("PrayForLootTester")
				print("Done with prayer test")

				if next(self._errors) then
					print("")

					for _, value in pairs(self._errors) do
						print(value)
					end
				end
			else
				self._state = "query"
			end
		end
	end

	return 
end
PrayForLootTester._query = function (self)
	local script_name = GameSettingsDevelopment.backend_settings.pray_for_loot_script

	self._submit_query(self, script_name, self._parameters(self))

	return 
end
PrayForLootTester._parameters = function (self)
	self._expected_result = self._expected_result or {}
	local profile_name = self._profiles[Math.random(#self._profiles)]
	self._expected_result.profile_name = profile_name
	local rarity = self._rarities[Math.random(#self._rarities)]
	self._expected_result.rarity = rarity
	local slot_type = self._slot_types[Math.random(#self._slot_types)]
	self._expected_result.slot_type = slot_type

	return "param_profile_name", profile_name, "param_rarity", rarity, "param_slot_type", slot_type
end
PrayForLootTester._submit_query = function (self, script_name, ...)
	printf("Script Name %s", script_name)
	print("Parameters:", ...)
	BackendSession.item_server_script(script_name, ...)

	return 
end
PrayForLootTester.poll_answer = function (self)
	local items, parameters, error_message = BackendSession.poll_item_server()

	if error_message then
		if type(error_message) == "table" then
			for k, v in pairs(error_message) do
				self._report_error(self, k .. " " .. v)
			end
		else
			self._report_error(self, error_message)
		end
	elseif items then
		self._verify_result(self, items)

		return true
	end

	return 
end
PrayForLootTester._report_error = function (self, ...)
	local formatted = string.format(...)

	Application.error(formatted)
	table.insert(self._errors, formatted)

	return 
end
PrayForLootTester._verify_result = function (self, items)
	for backend_id, key in pairs(items) do
		local item_data = ItemMasterList[key]

		if item_data.rarity ~= self._expected_result.rarity then
			self._report_error(self, "Expectied rarity: %s, got %s", self._expected_result.rarity, item_data.rarity)
		end

		if not table.contains(item_data.can_wield, self._expected_result.profile_name) then
			self._report_error(self, "Expected item that %s can wield, got item %s", self._expected_result.profile_name, key)
		end

		if self._expected_result.slot_type ~= "any" and item_data.slot_type ~= self._expected_result.slot_type then
			self._report_error(self, "Expected slot type %s, got slot type %s", self._expected_result.slot_type, item_data.slot_type)
		end

		if item_data.item_type == "ww_2h_axe" or item_data.item_type == "wh_repeating_crossbow" then
			self._report_error(self, "Shouldn't be able to pray for items of item_type: %q", item_data.item_type)
		end

		print("won", backend_id, key)
	end

	return 
end

return 
