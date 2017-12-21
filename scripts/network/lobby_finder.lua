require("scripts/network/lobby_aux")

LobbyFinder = class(LobbyFinder)
LobbyFinder.init = function (self, network_options, max_num_lobbies)
	local config_file_name = network_options.config_file_name
	local project_hash = network_options.project_hash
	self.network_hash = LobbyAux.create_network_hash(config_file_name, project_hash)
	self.lobby_port = network_options.lobby_port

	assert(self.lobby_port, "Must specify port to LobbyFinder.")

	self.cached_lobbies = {}
	self.max_num_lobbies = max_num_lobbies

	return 
end
LobbyFinder.destroy = function (self)
	return 
end
LobbyFinder.add_filter_requirements = function (self, requirements, force_refresh)
	LobbyInternal.add_filter_requirements(requirements)

	if force_refresh then
		local lobby_browser = LobbyInternal.lobby_browser()

		lobby_browser.refresh(lobby_browser, self.lobby_port)
	end

	self._filter_changed = true

	return 
end
LobbyFinder.lobbies = function (self)
	return self.cached_lobbies
end
LobbyFinder.latest_filter_lobbies = function (self)
	if not self._filter_changed then
		return self.cached_lobbies
	end

	return 
end
LobbyFinder._select_level_exists_locally = function (self, lobby)
	return not not rawget(LevelSettings, lobby.selected_level_key)
end
LobbyFinder.update = function (self, dt)
	local lobby_browser = LobbyInternal.lobby_browser()
	local is_refreshing = lobby_browser.is_refreshing(lobby_browser)

	if not is_refreshing then
		local lobbies = {}
		local num_lobbies = lobby_browser.num_lobbies(lobby_browser)
		local max_num_lobbies = self.max_num_lobbies

		if max_num_lobbies then
			num_lobbies = math.min(max_num_lobbies, num_lobbies)
		end

		for i = 0, num_lobbies - 1, 1 do
			local lobby = LobbyInternal.get_lobby(lobby_browser, i)

			if self._select_level_exists_locally(self, lobby) then
				lobbies[#lobbies + 1] = lobby

				if lobby.network_hash == self.network_hash then
					lobby.valid = true
				end
			end
		end

		self.cached_lobbies = lobbies

		lobby_browser.refresh(lobby_browser, self.lobby_port)

		self._filter_changed = nil
	end

	return 
end

return 
