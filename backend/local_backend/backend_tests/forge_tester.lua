ForgeTester = class(ForgeTester)
ForgeTester.init = function (self)
	self._item_pool = {
		plentiful = {},
		common = {},
		rare = {}
	}
	self._upgrade_rarity = {
		common = "rare",
		plentiful = "common",
		rare = "exotic"
	}
	self._rarities = {
		"plentiful",
		"common",
		"rare"
	}
	self._slot_types = {
		melee = true,
		ranged = true
	}
	self._state = "create_item"

	return 
end
ForgeTester.start = function (self, rarity)
	self.refresh_item_pool(self)

	self._rarity = rarity or self._select_rarity(self)

	if not self._rarity then
		self._state = "done"

		return 
	end

	local update = callback(self, "update")

	Managers.debug_updator:add_updator(update, "ForgeTester")

	self._state = "create_item"
	self._fused_times = 0
	self._errors = {}

	return 
end
ForgeTester.stop = function (self)
	self._item_pool = {
		plentiful = {},
		common = {},
		rare = {}
	}

	return 
end
ForgeTester._select_rarity = function (self)
	local available = {}

	for rarity, pool in pairs(self._item_pool) do
		if 5 < #self._item_pool[rarity] then
			available[#available + 1] = rarity
		end
	end

	if table.is_empty(available) then
		return 
	end

	return available[Math.random(#available)]
end
ForgeTester.update = function (self, dt)
	local rarity = self._rarity

	if self._state == "create_item" then
		self.fuse_one(self, rarity)

		self._fused_times = self._fused_times + 1
		self._state = "poll"
	elseif self._state == "poll" then
		local result = self.poll_answer(self)

		if result then
			self._state = "select"
		end
	elseif self._state == "select" then
		local next_rarity = self._select_rarity(self)

		if next_rarity then
			self._rarity = next_rarity
			self._state = "create_item"
		else
			Managers.debug_updator:remove_updator_by_name("ForgeTester")
			print("ForgeTester Done")
			print(string.format("Fused %d items into %d new ones", self._fused_times*5, self._fused_times))
			table.dump(self._errors, "")

			self._state = "done"
		end
	end

	return 
end
ForgeTester.useable_items = function (self)
	if self._useable_items then
		return self._useable_items
	end

	local useable_items = {
		plentiful = {},
		common = {},
		rare = {}
	}
	local slot_types = self._slot_types
	local item_pool = self._item_pool

	for key, config in pairs(ItemMasterList) do
		local slot_type = config.slot_type

		if slot_type and slot_types[slot_type] then
			local rarity = config.rarity

			if rarity and item_pool[rarity] then
				local rarity_table = useable_items[rarity]
				rarity_table[#rarity_table + 1] = key
			end
		end
	end

	self._useable_items = useable_items

	return useable_items
end
ForgeTester.refresh_item_pool = function (self)
	self._item_pool = {
		plentiful = {},
		common = {},
		rare = {}
	}
	local item_pool = self._item_pool
	local items = ScriptBackendItem.get_all_backend_items()

	for backend_id, data in pairs(items) do
		local key = data.key

		if ScriptBackendItem.is_fuseable(backend_id) then
			local config = ItemMasterList[key]
			local rarity = config.rarity
			local rarity_pool = item_pool[rarity]

			if rarity_pool then
				rarity_pool[#rarity_pool + 1] = {
					backend_id = backend_id,
					key = key
				}
			end
		end
	end

	return item_pool
end
ForgeTester.fuse_one = function (self, rarity)
	local items = {}
	local num_items = 0
	local pool_rarity = self._item_pool[rarity]

	repeat
		local id = Math.random(#pool_rarity)
		local data = pool_rarity[id]
		items[data.backend_id] = data.key

		table.remove(pool_rarity, id)

		num_items = num_items + 1
	until 5 <= num_items

	local items_to_merge = ""
	local item_types = {}

	for backend_id, item_key in pairs(items) do
		items_to_merge = string.format("%s%s,%s;", items_to_merge, item_key, backend_id)
		local config = ItemMasterList[item_key]
		local item_type = config.item_type
		item_types[item_type] = true
	end

	local fuse_script = GameSettingsDevelopment.backend_settings.forge_script

	print("fusing", fuse_script, "param_items_to_merge", items_to_merge)
	BackendSession.item_server_script(fuse_script, "param_items_to_merge", items_to_merge)

	self._expected_result = {
		rarity = self._upgrade_rarity[rarity],
		item_types = item_types
	}

	return 
end
ForgeTester._report_error = function (self, ...)
	local formatted = string.format(...)

	Application.error(formatted)
	table.insert(formatted)

	return 
end
ForgeTester._verify_result = function (self, items)
	local num_items = 0

	for backend_id, key in pairs(items) do
		local config = ItemMasterList[key]
		local rarity = config.rarity

		if rarity ~= self._expected_result.rarity then
			self._report_error(self, "Unexpected rarity %s", rarity)
		end

		local item_type = config.item_type

		if not self._expected_result.item_types[item_type] then
			self._report_error(self, "Unexpected item_type %s", item_type)
		end

		num_items = num_items + 1
	end

	if num_items ~= 1 then
		self._report_error(self, "Unexpected number of items %d", num_items)
	end

	self._expected_result = nil

	return 
end
ForgeTester.poll_answer = function (self)
	local items, parameters, error_message = BackendSession.poll_item_server()

	if error_message then
		Application.error(error_message)
	elseif items then
		self._verify_result(self, items)

		return true
	end

	return 
end
ForgeTester.activate_item_creator = function (self)
	self._create_items_pool = {
		common = 2000,
		plentiful = 2000,
		rare = 2000
	}
	self._commit_wait_time = 3
	self._items_per_commit = 100
	self._creator_state = "create"
	local update = callback(self, "update_item_creator")

	Managers.debug_updator:add_updator(update, "ForgeTesterItemCreator")

	return 
end
ForgeTester.stop_item_creator = function (self)
	print("Done generating items")

	self._creator_state = "done"
	self._creator_next_item = nil

	Managers.debug_updator:remove_updator_by_name("ForgeTesterItemCreator")

	return 
end
ForgeTester.update_item_creator = function (self)
	local a = Math.random()

	if self._creator_state == "create" then
		local rarity, total_amount = next(self._create_items_pool)

		if rarity then
			local amount = self._items_per_commit
			local total_amount = total_amount - amount

			if total_amount < 0 then
				self._create_items_pool[rarity] = nil

				if next(self._create_items_pool) then
					self._creator_state = "wait"
					local time = Managers.time:time("main")
					self._creator_next_item = time + self._commit_wait_time
				else
					print("Done generating items")

					self._creator_state = "done"
					self._creator_next_item = nil

					Managers.debug_updator:remove_updator_by_name("ForgeTesterItemCreator")
				end
			else
				self._create_items_pool[rarity] = total_amount
				self._creator_state = "wait"
				local time = Managers.time:time("main")
				self._creator_next_item = time + self._commit_wait_time

				self._create_items(self, rarity, amount)
			end
		else
			print("Done generating items")

			self._creator_state = "done"
			self._creator_next_item = nil

			Managers.debug_updator:remove_updator_by_name("ForgeTesterItemCreator")
		end
	elseif self._creator_state == "wait" then
		local time = Managers.time:time("main")

		if self._creator_next_item < time then
			self._creator_state = "create"
			self._creator_next_item = nil
		end
	end

	return 
end
ForgeTester._create_items = function (self, rarity, amount)
	local useable_items = self.useable_items(self)
	local items_to_create = {}
	local all_rarity = useable_items[rarity]

	for ii = 1, amount, 1 do
		local key = all_rarity[Math.random(#all_rarity)]
		items_to_create[#items_to_create + 1] = key

		BackendItem.award_item(key)
	end

	Backend.commit()

	return 
end

return 
