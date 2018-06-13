require("scripts/misc/script_retrieve_auth_session_token")

GrantDlcFromOwnership = class(GrantDlcFromOwnership)

GrantDlcFromOwnership.init = function (self, name, current_app_id, app_id_to_check, unlock_class, host_address, use_fallback)
	self._name = name
	self._current_app_id = current_app_id
	self._app_id_to_check = app_id_to_check
	self._unlock_class = unlock_class
	self._host_address = host_address
	self._done = false
	self._granted = false
	self._use_fallback = true
	self._request_codes = {
		[0] = "UNKNOWN ERROR",
		[401.0] = "Authorization Error",
		[400.0] = "Syntax Error",
		[200.0] = "SUCCESS",
		[500.0] = "Server Error",
		[404.0] = "Wrong App ID"
	}
	self._return_codes = {
		0 = "Granted",
		1 = "Not Owned",
		2 = "Already Granted",
		["-1"] = "No Return Code"
	}
end

GrantDlcFromOwnership.execute = function (self)
	if self._unlock_class:owned() then
		print("########################################################################")
		print("[GrantDlcFromOwnership]")
		print("")
		print(string.format("DLC %q Already Owned --> Unlocking", self._unlock_class:name()))
		print("########################################################################")
		self._unlock_class:set_unlocked(true)

		self._done = true

		return
	end

	if not rawget(_G, "Steam") then
		Application.warning("[GrantDlcFromOwnership] Steam not initialized --> Skipping")

		if self._use_fallback then
			self:_run_fallback()
		end

		self._done = true
	else
		local token = Steam.retrieve_auth_session_ticket()

		if token then
			local steam_auth_session_token = ScriptSteamAuthSessionToken:new(token)

			Managers.token:register_token(steam_auth_session_token, callback(self, "cb_auth_session_ticket_received"))
		else
			Application.warning("[GrantDlcFromOwnership] Could not retrieve Steam Auth Session Ticket --> Skipping")

			if self._use_fallback then
				self:_run_fallback()
			end

			self._done = true
		end
	end
end

GrantDlcFromOwnership.cb_auth_session_ticket_received = function (self, info)
	if info.error then
		Application.warning("[GrantDlcFromOwnership] Could not retrieve Auth Session Ticket from Steam --> Skipping")

		if self._use_fallback then
			self:_run_fallback()
		end

		self._done = true
	else
		local request = self._host_address .. "/grant/" .. self._current_app_id .. "/" .. info.auth_session_ticket .. "/" .. self._app_id_to_check

		print(string.format("******** Sending request: %q", request))
		Managers.curl:get(request, nil, callback(self, "cb_grant_response"))
	end
end

GrantDlcFromOwnership.cb_grant_response = function (self, success, code, headers, data, userdata)
	self._done = true
	self._success = success
	self._request_code = self._request_codes[code]
	local data = data or ""
	local return_code = "-1"
	local start_idx, end_idx = string.find(data, "Code\":")

	if end_idx then
		return_code = string.sub(data, end_idx + 1, end_idx + 1)
	end

	self._return_code = self._return_codes[return_code]

	print("########################################################################")
	print("[GrantDlcFromOwnership]")
	print("\tSuccess:", self._success)
	print("\tRequest Code:", self._request_code, "Code:", code)
	print("\tReturn Code:", self._return_code, "Code:", return_code)
	print("")
	print("------------------------------------")

	if (self._success and self._request_code == "SUCCESS" and self._return_code == "Granted") or self._return_code == "Already Granted" then
		print(":Grant call Succeeded:")
		print("------------------------------------")
		print("")
		print("[Unlocking DLC]", "User owns: " .. self._app_id_to_check, "Was granted: " .. self._unlock_class:name())
		self._unlock_class:set_unlocked(true)
	else
		print(":Grant call failed:")

		if self._use_fallback then
			print("\t--> Running Fallback Check")
			print("------------------------------------")
			print("")

			if Steam.owns_app(self._app_id_to_check) then
				print("Fallback was a sucess:")
				print("[Unlocking DLC]", "User owns: " .. self._app_id_to_check, "Unlocking: " .. self._unlock_class:name())
				self._unlock_class:set_unlocked(true)
			else
				print("Fallback failed:")
				print("User doesn't own " .. self._app_id_to_check)
			end
		end
	end

	print("########################################################################")
end

GrantDlcFromOwnership._run_fallback = function (self)
	print("########################################################################")
	print("[GrantDlcFromOwnership]")
	print("")
	print(":Something went wrong during evaluation:")
	print("\t--> Running Fallback Check")
	print("------------------------------------")
	print("")

	if rawget(_G, "Steam") then
		if Steam.owns_app(self._app_id_to_check) then
			print("Fallback was a sucess:")
			print("[Unlocking DLC]", "User owns: " .. self._app_id_to_check, "Unlocking: " .. self._unlock_class:name())
			self._unlock_class:set_unlocked(true)
		else
			print("Fallback failed:")
			print("User doesn't own " .. self._app_id_to_check)
		end
	end

	print("########################################################################")
end

GrantDlcFromOwnership.done = function (self)
	return self._done
end

GrantDlcFromOwnership.granted = function (self)
	return self._granted
end

return
