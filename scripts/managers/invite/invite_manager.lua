InviteManager = class(InviteManager)
InviteManager.init = function (self)
	self.lobby_data = nil
	self.is_steam = (rawget(_G, "Steam") and rawget(_G, "Friends") and true) or false

	return 
end
InviteManager.update = function (self, dt)
	if self.is_steam then
		local invite_type, lobby_id, params = Friends.next_invite()

		if invite_type ~= 0 then
			print(invite_type)
		end

		if invite_type == Friends.INVITE_LOBBY then
			local lobby_data = SteamMisc.get_lobby_data(lobby_id)
			lobby_data.id = lobby_id
			self.lobby_data = lobby_data
		end
	end

	return 
end
InviteManager.has_invitation = function (self)
	if self.is_steam then
		local invite_type, lobby_id, params = Friends.next_invite()

		return invite_type == Friends.INVITE_LOBBY
	end

	return 
end
InviteManager.get_invited_lobby_data = function (self)
	local lobby_data = self.lobby_data
	self.lobby_data = nil

	return lobby_data
end
InviteManager.clear_invites = function (self)
	return 
end

return 
