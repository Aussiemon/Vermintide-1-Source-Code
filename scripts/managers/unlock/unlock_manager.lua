require("scripts/managers/unlock/unlock_clan")
require("scripts/managers/unlock/unlock_dlc")
require("scripts/managers/unlock/always_unlocked")
require("scripts/settings/unlock_settings")

UnlockManager = class(UnlockManager)
UnlockManager.init = function (self)
	self._init_unlocks(self)

	self._state = "query_unlocked"
	self._query_unlocked_index = 0

	return 
end
UnlockManager._init_unlocks = function (self)
	local unlocks = {}
	local unlocks_indexed = {}

	for i, settings in ipairs(UnlockSettings) do
		unlocks_indexed[i] = {}

		for unlock_name, unlock_config in pairs(settings.unlocks) do
			local class_name = unlock_config.class
			local id = unlock_config.id
			local backend_required = unlock_config.backend_required
			local class = rawget(_G, class_name)
			local instance = class.new(class, unlock_name, id, backend_required)
			unlocks[unlock_name] = instance
			unlocks_indexed[i][unlock_name] = instance
		end
	end

	self._unlocks = unlocks
	self._unlocks_indexed = unlocks_indexed

	return 
end
UnlockManager.update = function (self, dt)
	self._update_backend_unlocks(self)

	return 
end
UnlockManager._update_backend_unlocks = function (self)
	Profiler.start("UnlockManager:_update_backend_unlocks()")

	if self._state == "query_unlocked" then
		if Managers.backend:profiles_loaded() then
			if not Managers.backend:available() then
				self._state = "backend_not_available"

				return 
			end

			if not self._startup_script_started then
				local queue = Managers.backend:get_data_server_queue()

				queue.register_executor(queue, "script_startup", callback(self, "_executor_script_startup"))
				ScriptBackendItem.data_server_script("script_startup_1")

				self._startup_script_started = true
			end

			local index = self._query_unlocked_index + 1

			if #self._unlocks_indexed < index then
				self._state = "done"

				return 
			end

			self._query_unlocked_index = index
			local settings = UnlockSettings[index]
			local unlock_script = settings.unlock_script

			if unlock_script then
				local profile_attribute = settings.profile_attribute
				local profile_unlocked_string = ScriptBackendProfileAttribute.get_string(profile_attribute)
				local profile_unlocked_table = {}

				if profile_unlocked_string then
					for id in string.gmatch(profile_unlocked_string, "([^,]+)") do
						profile_unlocked_table[id] = true
					end
				end

				local unlocks = self._unlocks_indexed[index]
				local new_unlocked = ""
				local all_unlocked = ""

				for _, unlock in pairs(unlocks) do
					if unlock.backend_required(unlock) and unlock.unlocked(unlock) then
						local id = unlock.id(unlock)
						all_unlocked = string.format("%s%s,", all_unlocked, id)

						if not profile_unlocked_table[id] then
							new_unlocked = string.format("%s%s,", new_unlocked, id)
						end
					end
				end

				if new_unlocked ~= "" then
					local unlock_script_param = settings.unlock_script_param

					print("LOOT", unlock_script, unlock_script_param, new_unlocked)

					self._data_server_request = ScriptBackendItem.data_server_script(unlock_script, unlock_script_param, new_unlocked)

					self._data_server_request:disable_registered_commands()

					self._set_profile_attribute = {
						name = profile_attribute,
						value = all_unlocked
					}
					self._state = "generating"
				end
			end
		end
	elseif self._state == "generating" then
		local request = self._data_server_request

		if request.is_done(request) then
			if request.error_message(request) then
				print("[DlcManager] ERROR generating unlock loot:", request.error_message(request))

				self._state = "query_unlocked"
			elseif request.items(request) then
				table.dump(request.items(request), "dlc items")

				local attribute_name = self._set_profile_attribute.name
				local attribute_value = self._set_profile_attribute.value

				ScriptBackendProfileAttribute.set_string(attribute_name, attribute_value)
				Managers.backend:commit()

				self._set_profile_attribute = nil
				self._state = "query_unlocked"
			else
				print("[DlcManager] ERROR generating unlock loot, failed generating items")

				self._state = "query_unlocked"
			end
		end
	end

	Profiler.stop()

	return 
end
UnlockManager._executor_script_startup = function (self, script_startup_data)
	self._script_startup_data = script_startup_data
	local queue = Managers.backend:get_data_server_queue()

	queue.unregister_executor(queue, "script_startup")

	return 
end
UnlockManager.poll_script_startup_data = function (self)
	local data = self._script_startup_data

	if not data or self._returned_startup_data then
		return 
	end

	self._returned_startup_data = true

	if data.silent then
		return "none"
	end

	return data
end
UnlockManager.is_dlc_unlocked = function (self, name)
	local unlock = self._unlocks[name]

	fassert(unlock, "No such unlock %q", name or "nil")

	return unlock.unlocked(unlock)
end
UnlockManager.dlc_id = function (self, name)
	local unlock = self._unlocks[name]

	fassert(unlock, "No such unlock %q", name or "nil")

	return unlock.id(unlock)
end

return 
