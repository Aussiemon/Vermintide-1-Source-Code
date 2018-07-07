BackendManagerLocal = class(BackendManagerLocal)
BackendManagerLocalEnabled = BackendManagerLocalEnabled or false

function make_script_backend_local()
	make_script_backend_session_local()
	make_script_backend_item_local()
	make_script_backend_profile_attribute_local()

	BackendManagerLocalEnabled = true
end

BackendManagerLocal.init = function (self)
	fassert(self:verify_data(DefaultLocalBackendData), "Mismatch between (local) default equipment and ItemMasterList")

	self._file_name = "backend_local"

	make_script_backend_local()

	local platform = Application.platform()
	self._interfaces = {
		quests = BackendQuestsLocal:new(),
		boons = BackendBoonsLocal:new()
	}

	if platform == "win32" then
		local function load_callback(info)
			local save_data_version = info.data and info.data.save_data_version

			if info.error or not save_data_version or save_data_version ~= BackendSaveDataVersion then
				Application.warning("Local backend load error %q", info.error or "save data format has changed")

				self._save_data = table.clone(DefaultLocalBackendData)
			elseif self:verify_data(info.data) then
				self._save_data = info.data
			else
				print("Broken (local) save, replacing with default")

				self._save_data = table.clone(DefaultLocalBackendData)
			end

			self._save_loaded = true

			self._interfaces.boons:set_save(self._save_data)
			self._interfaces.quests:setup(self._save_data)
		end

		Managers.save:auto_load(self._file_name, load_callback)
	elseif platform == "xb1" or platform == "ps4" then
		if not SaveData.local_backend_save then
			SaveData.local_backend_save = table.clone(DefaultLocalBackendData)
		end

		if (SaveData.user_settings and SaveData.user_settings.development_settings and SaveData.user_settings.development_settings.all_items_of_rarity) or script_data.all_items_of_rarity then
			local rarity = (SaveData.user_settings and SaveData.user_settings.development_settings.all_items_of_rarity) or script_data.all_items_of_rarity
			local items_to_add = XBoxItemsByRarity[rarity]

			for _, item in ipairs(items_to_add) do
				SaveData.local_backend_save.items[#SaveData.local_backend_save.items + 1] = item
			end
		end

		self._save_data = SaveData.local_backend_save
		self._save_loaded = true

		self._interfaces.boons:set_save(self._save_data)
		self._interfaces.quests:setup(self._save_data)
	end

	self._quests = BackendQuestsLocal:new()
end

BackendManagerLocal.reset = function (self)
	return
end

BackendManagerLocal.get_interface = function (self, interface_name, player_id)
	fassert(self._interfaces[interface_name], "Requesting unknown interface %q", interface_name)

	return self._interfaces[interface_name]
end

BackendManagerLocal.verify_data = function (self, data)
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

BackendManagerLocal.is_disconnected = function (self)
	return false
end

BackendManagerLocal.is_waiting_for_user_input = function (self)
	return false
end

BackendManagerLocal.start_tutorial = function (self)
	print("[BackendManager] Backend Disabled Tutorial")
	fassert(self._script_backend_items_backup == nil, "Tutorial already started")

	self._script_backend_items_backup = ScriptBackendItem

	make_script_backend_item_tutorial()
end

BackendManagerLocal.stop_tutorial = function (self)
	fassert(self._script_backend_items_backup ~= nil, "Stopping tutorial without starting it")

	ScriptBackendItem = self._script_backend_items_backup
	self._script_backend_items_backup = nil
end

BackendManagerLocal.signin = function (self)
	return
end

BackendManagerLocal.item_script_type = function (self)
	return ScriptBackendItem.type()
end

BackendManagerLocal._get_loadout_item_id = function (self, profile, slot)
	local save_data = self._save_data
	local save_data_slots = save_data.loadout
	local profile_slots = save_data_slots[profile]

	for slot_name, item_id in pairs(profile_slots) do
		if slot == slot_name then
			return item_id
		end
	end

	return nil
end

BackendManagerLocal._set_loadout_item = function (self, item_id, profile, slot)
	local save_data = self._save_data
	local save_data_slots = save_data.loadout
	local profile_slots = save_data_slots[profile]
	profile_slots[slot] = item_id
end

BackendManagerLocal._get_all_backend_items = function (self)
	return self._save_data.items
end

BackendManagerLocal._get_loadout = function (self)
	return self._save_data.loadout
end

BackendManagerLocal._get_items = function (self, profile, slot, rarity)
	local item_list = {}
	local item_master_list = ItemMasterList
	local save_data = self._save_data
	local save_data_items = save_data.items
	local save_data_items_n = #save_data_items

	for id, _ in pairs(save_data_items) do
		repeat
			local key = ScriptBackendItemLocal.get_key(id)
			local item_data = item_master_list[key]
			local wrong_slot = slot and slot ~= item_data.slot_type

			if wrong_slot then
				break
			end

			local wrong_rarity = rarity and rarity ~= item_data.rarity

			if wrong_rarity then
				break
			end

			if profile ~= "all" then
				local can_wield = ScriptBackendCommon.can_wield(profile, item_data)

				if not can_wield then
					break
				end
			end

			item_list[#item_list + 1] = id
		until true
	end

	return item_list
end

BackendManagerLocal.get_stats = function (self)
	return self._save_data.stats
end

BackendManagerLocal.set_stats = function (self, stats)
	self._save_data.stats = stats
end

BackendManagerLocal.destroy = function (self)
	return
end

BackendManagerLocal.update = function (self, dt)
	self._interfaces.quests:update(dt)
	self._interfaces.boons:update()
end

BackendManagerLocal.set_popup_handler = function (self, popup_handler)
	return
end

BackendManagerLocal.available = function (self)
	return
end

BackendManagerLocal.profiles_loaded = function (self)
	return self._save_loaded
end

BackendManagerLocal._remove_item = function (self, item_id)
	local item_id = tonumber(item_id)
	local save_data = self._save_data
	local save_data_items = save_data.items
	local exists = save_data_items[item_id] ~= nil
	save_data_items[item_id] = nil

	return exists
end

BackendManagerLocal._add_item = function (self, item_key)
	local save_data = self._save_data
	local save_data_items = save_data.items
	local item_id = 0

	for id, data in pairs(save_data_items) do
		if item_id < id then
			item_id = id or item_id
		end
	end

	item_id = item_id + 1
	local backend_item_entry = {
		traits = "",
		xp = 0,
		key = item_key
	}
	self._save_data.items[item_id] = backend_item_entry

	return item_id
end

BackendManagerLocal.commit = function (self)
	local function save_callback(info)
		if info.error then
			Application.warning("save error %q", info.error)
		end
	end

	if Application.platform() == "win32" then
		Managers.save:auto_save(self._file_name, self._save_data, save_callback)
	elseif Application.platform() == "ps4" then
		Managers.save:auto_save(SaveFileName, SaveData, save_callback)
	end
end

return
