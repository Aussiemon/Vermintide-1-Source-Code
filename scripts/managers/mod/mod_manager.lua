ModManager = class(ModManager)

local function mod_print(level, str, ...)
	printf("[MOD MANAGER] [" .. level .. "] " .. str, ...)

	return 
end

function mod_name(mod)
	return mod.name
end

ModManager.init = function (self)
	self._mods = {}
	self._num_mods = nil
	self._developer_mode = Application.user_setting("mod_developer_mode") or false

	self._start_scan(self)

	return 
end
ModManager.state = function (self)
	return self._state
end
ModManager.update = function (self, dt)
	local old_state = self._state

	if self._developer_mode and Keyboard.pressed(Keyboard.button_index("r")) and Keyboard.button(Keyboard.button_index("left shift")) + Keyboard.button(Keyboard.button_index("left ctrl")) == 2 then
		self._reload_requested = true
	end

	if self._reload_requested and self._state == "done" then
		self._reload_mods(self)
	end

	if self._state == "scanning" and not Mod.is_scanning() then
		local num_mods = #Mod.mods()
		self._num_mods = num_mods

		mod_print("info", "found %i mods", num_mods)
		table.dump(Mod.mods(), "Mods", 1)

		self._state = self._load_mod(self, 1)
	elseif self._state == "loading" then
		local handle = self._loading_resource_handle

		if ResourcePackage.has_loaded(handle) then
			ResourcePackage.flush(handle)

			local mod = self._mods[self._mod_load_index]
			local next_index = mod.package_index + 1
			local mod_data = mod.data

			if #mod_data.packages < next_index then
				local on_loaded_func = nil
				mod.state = "running"
				local object = mod_data.run()
				local name = mod_name(mod)

				if object then
					mod.object = object

					if object.init then
						object.init(object)
					end
				else
					mod.object = {}

					mod_print("warning", "Mod %s does not return callback table from run function", name)
				end

				mod_print("info", "%s loaded.", name)

				self._state = self._load_mod(self, self._mod_load_index + 1)
			else
				self._load_package(self, mod, next_index)
			end
		end
	elseif self._state == "done" then
		for i = 1, self._num_mods, 1 do
			local mod = self._mods[i]

			if mod then
				local object = mod.object
				local update_func = object.update

				if update_func then
					update_func(object, dt)
				end
			end
		end
	end

	if old_state ~= self._state then
		mod_print("info", "%s -> %s", old_state, self._state)
	end

	return 
end
ModManager.all_mods_loaded = function (self)
	return self._state == "done"
end
ModManager.destroy = function (self)
	self.unload_all_mods(self)

	return 
end
ModManager._start_scan = function (self)
	Mod.start_scan()

	self._state = "scanning"

	mod_print("info", "scanning")

	return 
end
ModManager._load_mod = function (self, index)
	local mods = Mod.mods()
	local handle = mods[index]

	if handle then
		mod_print("info", "loading mod %s", handle)

		local info = Mod.info(handle)

		mod_print("spew", "<mod info> \n%s\n<\\mod info>", info)

		local data_file = loadstring(info)

		if not data_file then
			mod_print("error", "Syntax error in .mod file. Aborted loading mods.")

			return "done"
		end

		local data = data_file()
		local mod = {
			state = "loading",
			loaded_packages = {},
			handle = handle,
			data = data,
			name = data.NAME or "Mod #" .. index
		}
		self._mods[index] = mod
		self._mod_load_index = index

		self._load_package(self, mod, 1)

		return "loading"
	else
		return "done"
	end

	return 
end
ModManager._load_package = function (self, mod, index)
	mod.package_index = index
	local package_name = mod.data.packages[index]

	mod_print("info", "\tloading package %q", package_name)

	local resource_handle = Mod.resource_package(mod.handle, package_name)
	self._loading_resource_handle = resource_handle

	ResourcePackage.load(resource_handle)

	mod.loaded_packages[#mod.loaded_packages + 1] = resource_handle

	return 
end
ModManager.unload_all_mods = function (self)
	if self._state == "done" then
		mod_print("info", "unload all mod packages")

		for i = 1, self._num_mods, 1 do
			local mod = self._mods[i]

			if mod then
				mod_print("info", "\t unloading %q", mod_name(mod))
				self.unload_mod(self, i)
			end
		end

		table.clear(self._mods)
	else
		mod_print("error", "Mods can't be unloaded, mod state is not \"done\". current: %q", self._state)
	end

	return 
end
ModManager.unload_mod = function (self, index)
	local mod = self._mods[index]

	if mod then
		local object = mod.object
		local unload_func = object.on_unload

		if unload_func then
			unload_func(object)
		end

		for _, handle in ipairs(mod.loaded_packages) do
			Mod.release_resource_package(handle)
		end
	else
		mod_print("error", "Mod index %i can't be unloaded, has not been loaded", index)
	end

	return 
end
ModManager._reload_mods = function (self)
	mod_print("info", "reloading mods")

	for i = 1, self._num_mods, 1 do
		local mod = self._mods[i]

		if mod then
			mod_print("info", "reloading %s", mod_name(mod))

			local object = mod.object
			local reload_func = object.on_reload

			if reload_func then
				reload_func(object)
			end
		end
	end

	self.unload_all_mods(self)
	self._start_scan(self)

	self._reload_requested = false

	return 
end
ModManager.on_game_state_changed = function (self, status, state)
	for i = 1, self._num_mods, 1 do
		local mod = self._mods[i]

		if mod then
			local object = mod.object
			local state_changed_func = object.on_game_state_changed

			if state_changed_func then
				state_changed_func(object, status, state)
			end
		end
	end

	return 
end

return 
