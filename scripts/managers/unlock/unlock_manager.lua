require("scripts/managers/unlock/unlock_clan")
require("scripts/managers/unlock/unlock_dlc")
require("scripts/managers/unlock/grant_dlc_from_ownership")
require("scripts/managers/unlock/always_unlocked")
require("scripts/managers/unlock/always_locked")
require("scripts/settings/unlock_settings")

UnlockManager = class(UnlockManager)
UnlockManager.init = function (self)
	self._init_unlocks(self)

	if PLATFORM == "win32" then
		self._init_grant_dlcs(self)
	end

	self._state = "query_unlocked"
	self._query_grant_index = 1
	self._query_unlocked_index = 0
	self._dlc_status_changed = nil

	if PLATFORM == "xb1" then
		self._licensed_packages = XboxDLC.licensed_packages()
	end

	self._award_queue = {}
	self._award_queue_id = 0

	if PLATFORM == "win32" and rawget(_G, "Steam") then
		self._load_vr_progress_save(self)
	else
		self._vr_status_done = true
	end

	return 
end
UnlockManager.done = function (self)
	if PLATFORM ~= "win32" then
		return true
	end

	return self._state == "done"
end
UnlockManager._load_vr_progress_save = function (self)
	local vr_unlocks = {
		"drachenfels",
		"cart",
		"forest"
	}

	local function cb(save, ...)
		self._vr_status_done = true

		if save.error then
			return 
		else
			local vr_unlocked = {}
			local steam_id = Steam.user_id()

			for _, challenge in ipairs(vr_unlocks) do
				for unlocked_challenge_hash, __ in pairs(save.data.unlocks) do
					local unlock_hash = Application.make_hash(challenge .. "_" .. steam_id)

					if unlock_hash == unlocked_challenge_hash then
						vr_unlocked[challenge] = true
					end
				end
			end

			self._vr_unlocked = vr_unlocked
		end

		return 
	end

	Managers.save:auto_load("xx9b8isopt", cb)

	return 
end
UnlockManager._init_grant_dlcs = function (self)
	self._grant_dlcs = {}
	self._grant_dlcs_indexed = {}
	local grants_dlcs = self._grant_dlcs
	local grant_dlcs_indexed = self._grant_dlcs_indexed
	local index = 1

	if not rawget(_G, "Steam") then
		return 
	end

	local current_app_id = Steam.app_id()

	for grant_dlc_name, grant_dlc_config in pairs(GrantDlcSettings.grants) do
		local class_name = grant_dlc_config.class
		local grant_unlock = grant_dlc_config.grant_unlock
		local app_id_to_check = grant_dlc_config.app_id_to_check
		local host_address = grant_dlc_config.host_address
		local use_fallback = grant_dlc_config.use_fallback
		local unlock_class = self._unlocks[grant_unlock]

		if unlock_class and not unlock_class.unlocked(unlock_class) then
			local class = rawget(_G, class_name)
			local instance = class.new(class, grant_dlc_name, current_app_id, app_id_to_check, unlock_class, host_address, use_fallback)
			grants_dlcs[grant_dlc_name] = instance
			grant_dlcs_indexed[index] = instance
			index = index + 1
		end
	end

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
			local backend_id = unlock_config.backend_id
			local class = rawget(_G, class_name)
			local instance = class.new(class, unlock_name, id, backend_id)
			unlocks[unlock_name] = instance
			unlocks_indexed[i][unlock_name] = instance
		end
	end

	self._unlocks = unlocks
	self._unlocks_indexed = unlocks_indexed

	return 
end
UnlockManager.update = function (self, dt)
	if not self._vr_status_done then
		return 
	end

	if PLATFORM == "xb1" then
		self._dlc_status_changed = nil
		local status = XboxDLC.status()

		if status ~= XboxDLC.IDLE then
			self._check_licenses(self)
			self._reinitialize_backend_dlc(self)
		end

		if self._popup_id then
			local result = Managers.popup:query_result(self._popup_id)

			if result then
				self._popup_id = nil
			end
		else
			self._update_backend_unlocks(self)
		end
	else
		self._update_backend_unlocks(self)
	end

	return 
end
UnlockManager._reinitialize_backend_dlc = function (self)
	self._state = "query_unlocked"
	self._query_unlocked_index = 0

	return 
end
UnlockManager._check_licenses = function (self)
	Application.warning("[UnlockManager] Checking DLC licenses")

	local new_licensed_dlc = ""
	local removed_dlc_licenses = ""
	local licensed_packages = XboxDLC.licensed_packages()

	for _, dlc in ipairs(licensed_packages) do
		if not table.find(self._licensed_packages, dlc) then
			new_licensed_dlc = new_licensed_dlc .. XboxDLC.display_name(dlc) .. "\n"
		end
	end

	for _, dlc in ipairs(self._licensed_packages) do
		if not table.find(licensed_packages, dlc) then
			removed_dlc_licenses = removed_dlc_licenses .. XboxDLC.display_name(dlc) .. "\n"
		end
	end

	self._licensed_packages = licensed_packages

	for _, unlock in pairs(self._unlocks) do
		if unlock.update_license then
			unlock.update_license(unlock)
		end
	end

	if new_licensed_dlc ~= "" then
		if Managers.state.event then
			Managers.state.event:trigger("event_dlc_status_changed")
		end

		self._popup_id = Managers.popup:queue_popup(new_licensed_dlc, Localize("new_dlc_installed"), "ok", Localize("button_ok"))
		self._dlc_status_changed = true
	elseif removed_dlc_licenses ~= "" then
		if Managers.state.event then
			Managers.state.event:trigger("event_dlc_status_changed")
		end

		self._popup_id = Managers.popup:queue_popup(removed_dlc_licenses, Localize("dlc_license_terminated"), "ok", Localize("button_ok"))
		self._dlc_status_changed = true
	end

	return 
end
UnlockManager.dlc_status_changed = function (self)
	return self._dlc_status_changed
end
UnlockManager._update_backend_unlocks = function (self)
	Profiler.start("UnlockManager:_update_backend_unlocks()")

	if self._state == "done" then
		Profiler.stop("UnlockManager:_update_backend_unlocks()")

		return 
	end

	if self._state == "poll_update_required_popup" then
		local result = Managers.popup:query_result(self._update_required_popup_id)

		if result then
			Application.quit()
		end
	elseif self._state == "query_grant_dlc" then
		if not rawget(_G, "Steam") then
			self._state = "done"
		else
			self._query_grants(self)
		end
	elseif self._state == "reevaluate_unlocks" then
		for _, unlock in ipairs(self._unlocks_indexed) do
			if unlock and unlock.reevaluate then
				unlock.reevaluate(unlock)
			end
		end

		self._state = "done"
	elseif self._state == "query_unlocked" then
		if Managers.backend:profiles_loaded() then
			if not Managers.backend:available() then
				self._state = "backend_not_available"

				return 
			end

			if not ScriptBackendItem.data_server_script then
				return 
			end

			if not self._startup_script_started then
				local queue = Managers.backend:get_data_server_queue()

				queue.register_executor(queue, "script_startup", callback(self, "_executor_script_startup"))

				local startup_script_name = GameSettingsDevelopment.backend_settings.startup_script
				local startup_script_params = {}

				if PLATFORM == "win32" then
					queue.register_executor(queue, "revision_check", callback(self, "_executor_revision_check"))

					local engine_revision = script_data.build_identifier

					if engine_revision then
						startup_script_params[#startup_script_params + 1] = "param_engine_revision"
						startup_script_params[#startup_script_params + 1] = engine_revision
					end

					local content_revision = script_data.settings.content_revision

					if content_revision then
						startup_script_params[#startup_script_params + 1] = "param_content_revision"
						startup_script_params[#startup_script_params + 1] = content_revision
					end

					if self._vr_unlocked then
						local vr_unlocked = cjson.encode(self._vr_unlocked)
						startup_script_params[#startup_script_params + 1] = "param_vr_bonus_loot"
						startup_script_params[#startup_script_params + 1] = vr_unlocked
					end
				end

				ScriptBackendItem.data_server_script(startup_script_name, unpack(startup_script_params))

				self._startup_script_started = true
			end

			local index = self._query_unlocked_index + 1

			if #self._unlocks_indexed < index then
				if PLATFORM ~= "win32" then
					self._state = "done"
				else
					self._state = "query_grant_dlc"
				end

				Profiler.start("UnlockManager:_update_backend_unlocks()")

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
				local removed_unlocked = ""
				local all_unlocked = ""

				for _, unlock in pairs(unlocks) do
					local id = unlock.backend_id(unlock)

					if id then
						if unlock.unlocked(unlock) then
							all_unlocked = string.format("%s%s,", all_unlocked, id)

							if not profile_unlocked_table[id] then
								new_unlocked = string.format("%s%s,", new_unlocked, id)
							end
						elseif profile_unlocked_table[id] then
							removed_unlocked = string.format("%s%s,", removed_unlocked, id)
						end
					end
				end

				local unlock_script_param = settings.unlock_script_param
				local remove_script_param = settings.remove_script_param

				if new_unlocked ~= "" or (remove_script_param and removed_unlocked ~= "") then
					if remove_script_param then
						self._data_server_request = ScriptBackendItem.data_server_script(unlock_script, unlock_script_param, new_unlocked, remove_script_param, removed_unlocked)
					else
						self._data_server_request = ScriptBackendItem.data_server_script(unlock_script, unlock_script_param, new_unlocked)
					end

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
			else
				table.dump(request.items(request), "dlc items")

				local attribute_name = self._set_profile_attribute.name
				local attribute_value = self._set_profile_attribute.value

				ScriptBackendProfileAttribute.set_string(attribute_name, attribute_value)
				Managers.backend:commit()

				self._set_profile_attribute = nil
				self._state = "query_unlocked"
				local parameters = request.parameters(request)
				local presentation_data_json = parameters.presentation_data

				if presentation_data_json then
					local presentation_data = cjson.decode(presentation_data_json)

					for _, popup_data in ipairs(presentation_data) do
						self._add_startup_award(self, popup_data)
					end
				end
			end
		end
	elseif self._state == "backend_not_available" and Managers.backend:available() then
		self._state = "query_unlocked"
	end

	Profiler.stop("UnlockManager:_update_backend_unlocks()")

	return 
end
UnlockManager._query_grants = function (self)
	if not self._current_grant_query then
		self._current_grant_query = self._grant_dlcs_indexed[self._query_grant_index]

		if self._current_grant_query then
			self._current_grant_query:execute()

			self._grants_handled = true
		elseif self._grants_handled then
			self._state = "reevaluate_unlocks"
		else
			self._state = "done"
		end
	elseif self._current_grant_query and self._current_grant_query:done() then
		self._query_grant_index = self._query_grant_index + 1
		self._current_grant_query = nil
	end

	return 
end
UnlockManager._executor_revision_check = function (self, revision_check_data)
	local valid_engine = revision_check_data.valid_engine
	local valid_content = revision_check_data.valid_content

	if not valid_engine or not valid_content then
		self._update_required_popup_id = Managers.popup:queue_popup(Localize("new_version_available_on_steam"), Localize("update_required"), "quit", Localize("menu_quit"))
		self._state = "poll_update_required_popup"
	end

	return 
end
UnlockManager._executor_script_startup = function (self, script_startup_data)
	for _, data in ipairs(script_startup_data) do
		self._add_startup_award(self, data)
	end

	local queue = Managers.backend:get_data_server_queue()

	queue.unregister_executor(queue, "script_startup")

	return 
end
UnlockManager._add_startup_award = function (self, data)
	self._award_queue[#self._award_queue + 1] = data

	return 
end
UnlockManager.poll_script_startup_data = function (self)
	if #self._award_queue <= self._award_queue_id then
		return 
	end

	self._award_queue_id = self._award_queue_id + 1
	local data = self._award_queue[self._award_queue_id]

	if data.silent then
		return 
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
UnlockManager.ps4_dlc_product_label = function (self, name)
	assert(PLATFORM == "ps4", "Only call this function on a PS4")

	local unlock = self._unlocks[name]

	fassert(unlock, "No such unlock %q", name or "nil")

	return unlock.product_label(unlock)
end
local profile_dlc_skins = {}
UnlockManager.get_skin_settings = function (self, profile_name)
	local base_skin = nil

	table.clear(profile_dlc_skins)

	for _, skin_settings in pairs(SkinSettings) do
		local skin_profile_name = skin_settings.profile_name

		if skin_profile_name == profile_name then
			local unlock_type = skin_settings.unlock_type

			if unlock_type == "default" then
				base_skin = skin_settings
			elseif unlock_type == "dlc" then
				local dlc_name = skin_settings.dlc_name

				if self.is_dlc_unlocked(self, dlc_name) then
					profile_dlc_skins[#profile_dlc_skins + 1] = skin_settings
				end
			end
		end
	end

	if #profile_dlc_skins == 0 then
		return base_skin
	else
		return profile_dlc_skins[math.random(1, #profile_dlc_skins)]
	end

	return 
end

return 
