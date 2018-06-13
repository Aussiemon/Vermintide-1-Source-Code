DiceTester = class(DiceTester)

DiceTester.init = function (self)
	self._state = "done"
	self._heroes = {
		"empire_soldier",
		"wood_elf",
		"bright_wizard",
		"dwarf_ranger",
		"witch_hunter"
	}
	self._difficulties = {
		"easy",
		"normal",
		"hard",
		"harder",
		"hardest"
	}
	self._dlcs = {
		"none",
		"drachenfels"
	}
end

DiceTester.start_networked = function (self, max_rolls, delay)
	if Managers.player.is_server then
		self._is_host = true

		self:start(max_rolls, delay)
	else
		Managers.state.event:register(self, "event_trigger_dice_roll", "event_trigger_dice_roll")
		Managers.state.event:register(self, "event_trigger_dice_done", "event_trigger_dice_done")

		self._is_client = true
		self._errors = {}
		self._num_rolls = 0
		self._state = "waiting_for_server"
		self._total_duration = 0
		local update = callback(self, "update")

		Managers.debug_updator:add_updator(update, "DiceTester")
	end
end

DiceTester.start = function (self, max_rolls, delay)
	self._delay = delay or 0
	self._num_rolls = 0
	self._state = "roll"
	self._max_rolls = max_rolls or 100
	self._errors = {}
	self._total_duration = 0
	local update = callback(self, "update")

	Managers.debug_updator:add_updator(update, "DiceTester")
end

DiceTester.update = function (self, dt)
	local rarity = self._rarity

	if self._state == "roll" then
		if self._is_host then
			Managers.state.network.network_transmit:send_rpc_all("rpc_event_manager_event", "event_trigger_dice_roll", "")
		end

		self:roll_one()

		self._state = "poll"
	elseif self._state == "poll" then
		local result = self:poll_answer()

		if result then
			self._num_rolls = self._num_rolls + 1

			if self._is_client then
				self._state = "waiting_for_server"
			elseif self._max_rolls <= self._num_rolls then
				self:_finish()
			else
				self._state = "waiting_for_delay"
				local time = Managers.time:time("main")
				self._next_roll_time = time + self._delay
			end
		end
	elseif self._state == "waiting_for_delay" then
		local time = Managers.time:time("main")

		if self._next_roll_time < time then
			self._state = "roll"
		end
	elseif self._state == "waiting_for_server" and self._server_event_roll then
		self._server_event_roll = false
		self._state = "roll"
	end
end

DiceTester._finish = function (self)
	if self._is_host then
		Managers.state.network.network_transmit:send_rpc_all("rpc_event_manager_event", "event_trigger_dice_done", "")
	end

	self._state = "done"

	Managers.debug_updator:remove_updator_by_name("DiceTester")
	print("Done with dice test")
	print(string.format("%d rolls in %d seconds at an average of %f seconds/roll", self._num_rolls, self._total_duration, self._total_duration / self._num_rolls))

	if next(self._errors) then
		print("")

		for _, value in pairs(self._errors) do
			print(value)
		end
	end
end

DiceTester.event_trigger_dice_roll = function (self)
	self._server_event_roll = true
end

DiceTester.event_trigger_dice_done = function (self)
	self:_finish()
end

DiceTester.roll_one = function (self)
	local script = GameSettingsDevelopment.backend_settings.dice_script
	local dice = self:_randomize_dice()
	local difficulty = self._difficulties[Math.random(#self._difficulties)]
	local start_level = 5
	local end_level = 5
	local hero_name = self._heroes[Math.random(#self._heroes)]
	local dlc_name = self._dlcs[Math.random(#self._dlcs)]

	if dlc_name ~= "none" then
		print("Roll dice:", script, "param_dice", dice, "param_difficulty", difficulty, "param_start_level", start_level, "param_end_level", end_level, "param_hero_name", hero_name, "param_dlc_name", dlc_name)
		BackendSession.item_server_script(script, "param_dice", dice, "param_difficulty", difficulty, "param_start_level", start_level, "param_end_level", end_level, "param_hero_name", hero_name, "param_dlc_name", dlc_name)
	else
		print("Roll dice:", script, "param_dice", dice, "param_difficulty", difficulty, "param_start_level", start_level, "param_end_level", end_level, "param_hero_name", hero_name)
		BackendSession.item_server_script(script, "param_dice", dice, "param_difficulty", difficulty, "param_start_level", start_level, "param_end_level", end_level, "param_hero_name", hero_name)
	end

	self._expected_result = {
		start_time = os.time()
	}
end

DiceTester._randomize_dice = function (self)
	local metal = Math.random(2)
	local gold = Math.random(3)
	local warpstone = Math.random(2)
	local wood = 7 - (metal + gold + warpstone)

	return string.format("metal,%d;wood,%d;warpstone,%d;gold,%d;", metal, wood, warpstone, gold)
end

DiceTester.poll_answer = function (self)
	local items, parameters, error_message = BackendSession.poll_item_server()

	if error_message then
		if type(error_message) == "table" then
			for k, v in pairs(error_message) do
				self:_report_error(k .. " " .. v)
			end
		else
			self:_report_error(error_message)
		end
	elseif items then
		self:_verify_result(items)

		return true
	end
end

DiceTester._report_error = function (self, ...)
	local formatted = string.format(...)

	Application.error(formatted)
	table.insert(self._errors, formatted)
end

DiceTester._verify_result = function (self, items)
	local duration = os.time() - self._expected_result.start_time

	if duration > 5 then
		self:_report_error(string.format("Dice duration too large: %d seconds", duration))
	end

	print("Dice roll duration:", duration)

	self._total_duration = self._total_duration + duration

	for key, value in pairs(items) do
		print("won", key, value)
	end
end

return
