require("scripts/helpers/steam_helper")

UnlockClan = class(UnlockClan)
UnlockClan.init = function (self, name, clan_id, local_only)
	self._name = name
	self._id = clan_id
	self._local_only = local_only
	self._unlocked = false

	if rawget(_G, "Steam") then
		local clans = SteamHelper.clans()

		if clans[clan_id] then
			self._unlocked = true
		end
	end

	return 
end
UnlockClan.id = function (self)
	return self._id
end
UnlockClan.local_only = function (self)
	return self._local_only
end
UnlockClan.unlocked = function (self)
	return self._unlocked
end

return 
