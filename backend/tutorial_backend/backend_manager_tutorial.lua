-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
BackendManagerTutorial = class(BackendManagerTutorial)
BackendManagerTutorialEnabled = BackendManagerTutorialEnabled or false

function make_script_backend_tutorial()
	make_script_backend_session_local()
	make_script_backend_item_tutorial()
	make_script_backend_profile_attribute_tutorial()

	BackendManagerTutorialEnabled = true

	return 
end

BackendManagerTutorial.init = function (self)
	fassert(self.verify_data(self, DefaultTutorialBackendData), "Mismatch between (local) default equipment and ItemMasterList")
	make_script_backend_tutorial()

	self._backend_data = table.clone(DefaultTutorialBackendData)

	return 
end
BackendManagerTutorial.verify_data = function (self, data)
	local valid = true

	for _, item in pairs(data.items) do
		local item_data = rawget(ItemMasterList, item.key)

		if not item_data then
			print("Save data missing item", item.key)

			valid = false
		end
	end

	return valid
end
BackendManagerTutorial.is_disconnected = function (self)
	return false
end
BackendManagerTutorial.is_waiting_for_user_input = function (self)
	return false
end
BackendManagerTutorial.signin = function (self)
	return 
end
BackendManagerTutorial._get_loadout_item_id = function (self, profile, slot)
	local backend_data = self._backend_data
	local backend_data_slots = backend_data.loadout
	local profile_slots = backend_data_slots[profile]

	for slot_name, item_id in pairs(profile_slots) do
		if slot == slot_name then
			return item_id
		end
	end

	return nil
end
BackendManagerTutorial._set_loadout_item = function (self, item_id, profile, slot)
	ferror("Not allowed to set loadout on tutorial backend")

	return 
end
BackendManagerTutorial._get_all_backend_items = function (self)
	return self._backend_data.items
end
BackendManagerTutorial._get_loadout = function (self)
	return self._backend_data.loadout
end
BackendManagerTutorial._get_items = function (self, profile, slot, rarity)
	local item_list = {}
	local item_master_list = ItemMasterList
	local backend_data = self._backend_data
	local backend_data_items = backend_data.items

	for id, _ in pairs(backend_data_items) do
		local key = ScriptBackendItemTutorial.get_key(id)
		local item_data = item_master_list[key]
		local wrong_slot = slot and slot ~= item_data.slot_type

		if wrong_slot then
		else
			local wrong_rarity = rarity and rarity ~= item_data.rarity

			if wrong_rarity then
			elseif profile ~= "all" then
				local can_wield = ScriptBackendCommon.can_wield(profile, item_data)
			else
				item_list[#item_list + 1] = id
			end
		end
	end

	return item_list
end
BackendManagerTutorial.get_stats = function (self)
	return self._backend_data.stats
end
BackendManagerTutorial.set_stats = function (self, stats)
	printf("TUTORIAL BACKEND SET STATS DISABLED")

	return 
end
BackendManagerTutorial.destroy = function (self)
	return 
end
BackendManagerTutorial.update = function (self, dt)
	local lol = math.random()

	return 
end
BackendManagerTutorial.set_popup_handler = function (self, popup_handler)
	return 
end
BackendManagerTutorial.available = function (self)
	return 
end
BackendManagerTutorial.profiles_loaded = function (self)
	return true
end
BackendManagerTutorial._remove_item = function (self, item_id)
	printf("TUTORIAL BACKEND REMOVE ITEM DISABLED")

	return 
end
BackendManagerTutorial._add_item = function (self, item_key)
	printf("TUTORIAL BACKEND ADD ITEM DISABLED")

	return 
end
BackendManagerTutorial.commit = function (self)
	printf("TUTORIAL BACKEND COMMIT DISABLED")

	return 
end

return 
