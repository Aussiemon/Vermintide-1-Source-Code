if PLATFORM == "win32" then
	require("scripts/managers/input/input_manager")
	require("scripts/utils/visual_assert_log")
	require("foundation/scripts/util/garbage_leak_detector")
	require("scripts/managers/debug/debug")
end

StateSplashScreen = class(StateSplashScreen)
StateSplashScreen.NAME = "StateSplashScreen"
StateSplashScreen.packages_to_load = {
	"resource_packages/title_screen",
	"resource_packages/title_screen_gamma",
	"resource_packages/menu",
	"resource_packages/platform_specific/platform_specific",
	"resource_packages/loading_screens/loading_bg_default",
	"resource_packages/menu_assets_start_screen"
}

for _, dlc in pairs(DLCSettings) do
	local package_name = dlc.package_name

	if package_name then
		table.insert(StateSplashScreen.packages_to_load, 1, package_name)
	end
end

if PLATFORM == "xb1" or PLATFORM == "ps4" then
	StateSplashScreen.delayed_global_packages = {
		"resource_packages/game_scripts",
		"backend/local_backend/local_backend",
		"resource_packages/tutorial_backend",
		"resource_packages/level_scripts",
		"resource_packages/post_localization_boot",
		"resource_packages/levels/debug_levels",
		"resource_packages/levels/benchmark_levels",
		"resource_packages/strings"
	}
end

StateSplashScreen.on_enter = function (self)
	if PLATFORM == "win32" then
		Application.set_time_step_policy("no_smoothing", "clear_history", "throttle", 60)
	end

	if PLATFORM == "win32" then
		local assert_on_leak = true

		GarbageLeakDetector.run_leak_detection(assert_on_leak)
		GarbageLeakDetector.register_object(self, "StateSplashScreen")
		VisualAssertLog.setup(nil)
	end

	Managers.transition:force_fade_in()
	self:setup_world()

	if PLATFORM == "win32" then
		self:setup_input()
	end

	if PLATFORM == "win32" then
		self:setup_splash_screen_view()
	elseif PLATFORM == "ps4" then
		if PS4.title_id() == "CUSA02133_00" then
			self:setup_esrb_logo()
		else
			Managers.package:load("resource_packages/start_menu_splash", "StateSplashScreen", callback(self, "cb_splashes_loaded"), true, true)
		end
	elseif PLATFORM == "xb1" then
		if self:_is_in_esrb_terratory() then
			self:setup_esrb_logo()
		else
			Managers.package:load("resource_packages/start_menu_splash", "StateSplashScreen", callback(self, "cb_splashes_loaded"), true, true)
		end
	end

	local loading_context = self.parent.loading_context

	if loading_context.reload_packages then
		self:unload_packages()
	end

	self:load_packages()
	Managers.transition:fade_out(1)

	local args = {
		Application.argv()
	}

	for _, parameter in pairs(args) do
		if parameter == "-auto-host-level" or parameter == "-auto-join" or parameter == "-skip-splash" or LEVEL_EDITOR_TEST then
			self._skip_splash = true

			break
		end
	end

	if PLATFORM == "win32" and not self._skip_splash then
		self.parent.loading_context.show_profile_on_startup = true
		loading_context.first_time = true
	end
end

StateSplashScreen._is_in_esrb_terratory = function (self)
	local esrb_regions = {
		CA = true,
		US = true,
		MX = true
	}
	local region_info = XboxLive.region_info()
	local iso2 = region_info.GEO_ISO2

	return esrb_regions[iso2]
end

StateSplashScreen.setup_esrb_logo = function (self)
	self.gui = World.create_screen_gui(self.world, "material", "materials/ui/esrb_console_logo", "immediate")

	Managers.package:load("resource_packages/start_menu_splash", "StateSplashScreen", callback(self, "cb_splashes_loaded"), true, true)

	self.showing_esrb = true
	self.esrb_timer = 0
end

StateSplashScreen.update_esrb_logo = function (self, dt, t)
	if not self._test then
		Application.error("##########################")
		Application.error("######## RENDERING #######")
		Application.error("##########################")

		self._test = true
	end

	local total_time = 5
	local timer = self.esrb_timer
	local alpha = 0
	local size = {
		1200,
		576
	}
	local bitmap_name = "esrb_logo"

	if timer > total_time - 0.5 then
		alpha = 255 - 255 * math.clamp((total_time - timer) / 0.5, 0, 1)
	elseif timer <= 0.5 then
		alpha = 255 * math.clamp(1 - timer / 0.5, 0, 255)
	end

	local w, h = Application.resolution()

	Gui.rect(self.gui, Vector3(0, 0, 0), Vector2(w, h), Color(255, 0, 0, 0))
	Gui.bitmap(self.gui, bitmap_name, Vector3(w * 0.5 - size[1] * 0.5, h * 0.5 - size[2] * 0.5, 1), Vector2(size[1], size[2]))
	Gui.rect(self.gui, Vector3(0, 0, 2), Vector2(w, h), Color(alpha, 0, 0, 0))

	self.esrb_timer = math.clamp(self.esrb_timer + math.clamp(dt, 0, 0.1), 0, total_time)

	if total_time <= self.esrb_timer and self.splashes_loaded then
		self:setup_splash_screen_view()
		Managers.transition:force_fade_in()
	end
end

StateSplashScreen.cb_splashes_loaded = function (self)
	self.splashes_loaded = true

	if not self.showing_esrb then
		self:setup_splash_screen_view()
		Application.error("##########################")
		Application.error("######## RENDERING #######")
		Application.error("##########################")
	end
end

StateSplashScreen.setup_world = function (self)
	self._world_name = "splash_ui"
	self._viewport_name = "splash_view_viewport"
	self.world = Managers.world:create_world(self._world_name, GameSettingsDevelopment.default_environment, nil, 980, Application.DISABLE_PHYSICS, Application.DISABLE_APEX_CLOTH)
	self.viewport = ScriptWorld.create_viewport(self.world, self._viewport_name, "overlay", 1)
end

if PLATFORM == "win32" then
	StateSplashScreen.setup_input = function (self)
		self.input_manager = InputManager:new()
		Managers.input = self.input_manager

		self.input_manager:initialize_device("keyboard", 1)
		self.input_manager:initialize_device("mouse", 1)
		self.input_manager:initialize_device("gamepad")
	end
end

StateSplashScreen.setup_splash_screen_view = function (self)
	if not Managers.package:has_loaded("resource_packages/start_menu_splash", "StateSplashScreen") then
		Managers.package:load("resource_packages/start_menu_splash", "StateSplashScreen")
	end

	require("scripts/ui/views/splash_view")

	self.splash_view = SplashView:new(self.input_manager, self.world)

	if self.parent.loading_context.show_splash_screens then
		self.parent.loading_context.show_splash_screens = false
	else
		self.splash_view:set_index(4)
	end
end

StateSplashScreen.update = function (self, dt, t)
	if PLATFORM ~= "xb1" and PLATFORM ~= "ps4" then
		Debug.update(t, dt)
		self.input_manager:update(dt, t)
	end

	if self.splash_view then
		self.splash_view:update(dt)
	elseif self.showing_esrb then
		self:update_esrb_logo(dt, t)
	end

	if not self.wanted_state and ((self.splash_view and self.splash_view:is_completed()) or self._skip_splash) and self:packages_loaded() then
		require("scripts/game_state/state_title_screen")
		Managers.transition:fade_in(0.5, callback(self, "cb_fade_in_done"))
	end

	local state = self:next_state()

	return state
end

StateSplashScreen.render = function (self)
	if self.splash_view then
		self.splash_view:render()
	end
end

StateSplashScreen.next_state = function (self)
	if not self:packages_loaded() or not self.wanted_state then
		return
	end

	if PLATFORM == "win32" and not self.debug_setup then
		self.debug_setup = true

		Debug.setup(self.world, "splash_ui")
	end

	return self.wanted_state
end

StateSplashScreen.unload_packages = function (self)
	local package_manager = Managers.package

	for i, name in ipairs(StateSplashScreen.packages_to_load) do
		if package_manager:has_loaded(name, "state_splash_screen") then
			package_manager:unload(name, "state_splash_screen")
		end
	end

	if GlobalResources.loaded then
		GlobalResources.loaded = nil

		for i, name in ipairs(GlobalResources) do
			package_manager:unload(name, "global")
		end
	end
end

StateSplashScreen.load_packages = function (self)
	local package_manager = Managers.package

	for i, name in ipairs(StateSplashScreen.packages_to_load) do
		if not package_manager:has_loaded(name, "state_splash_screen") then
			package_manager:load(name, "state_splash_screen", nil, true)
		end
	end

	if Development.parameter("gdc") then
		local package_name_to_load = "resource_packages/debug/gdc_materials"

		if not package_manager:has_loaded(package_name_to_load) then
			package_manager:load(package_name_to_load, "state_splash_screen", nil, true)
		end
	end
end

StateSplashScreen.packages_loaded = function (self)
	local package_manager = Managers.package

	for i, name in ipairs(StateSplashScreen.packages_to_load) do
		if not package_manager:has_loaded(name) then
			return false
		end
	end

	if PLATFORM == "xb1" or PLATFORM == "ps4" then
		for i, name in ipairs(StateSplashScreen.delayed_global_packages) do
			if not package_manager:has_loaded(name) then
				return false
			end
		end

		if not self.splash_view or not self.splash_view:video_complete() then
			return false
		end

		if not self._console_delayed_scripts_setup_and_required then
			self:_require_and_setup_delayed_scripts()

			self._console_delayed_scripts_setup_and_required = true
		end
	end

	if not GlobalResources.loaded then
		for i, name in ipairs(GlobalResources) do
			if not package_manager:has_loaded(name) then
				package_manager:load(name, "global", nil, true)
			end
		end

		GlobalResources.loaded = true
	end

	return true
end

if PLATFORM == "xb1" or PLATFORM == "ps4" then
	StateSplashScreen._require_and_setup_delayed_scripts = function (self)
		local function game_require(path, ...)
			for _, s in ipairs({
				...
			}) do
				require("scripts/" .. path .. "/" .. s)
			end
		end

		local function foundation_require(path, ...)
			for _, s in ipairs({
				...
			}) do
				require("foundation/scripts/" .. path .. "/" .. s)
			end
		end

		foundation_require("managers", "localization/localization_manager", "event/event_manager")
		game_require("utils", "util", "loaded_dice", "script_application", "script_world", "assert", "patches", "script_unit", "colors", "random_table", "visual_assert_log")
		game_require("settings", "default_user_settings", "synergy_settings", "controller_settings")
		game_require("game_state", "state_context")
		game_require("entity_system", "entity_system")
		table.dump(DLCSettings, "DLCSettings", 5)
		game_require("managers", "news_ticker/news_ticker_manager", "player/player_manager", "player/player_bot", "save/save_manager", "save/save_data", "perfhud/perfhud_manager", "backend/backend_manager", "splitscreen/splitscreen_tester", "smoketest/smoketest_manager", "debug/updator", "unlock/unlock_manager", "popup/popup_manager", "popup/simple_popup", "light_fx/light_fx_manager", "input/input_manager", "debug/debug", "invite/invite_manager", "controller_features/controller_features_manager")
		game_require("helpers", "effect_helper", "weapon_helper", "item_helper", "lorebook_helper", "ui_atlas_helper", "scoreboard_helper")
		game_require("network", "unit_spawner", "unit_storage", "network_unit")
		DefaultUserSettings.set_default_user_settings()
		self:_init_localizer()
		game_require("ui", "ui_fonts", "views/show_cursor_stack", "views/ingame_ui", "views/end_of_level_ui", "views/title_loading_ui")
		require("foundation/scripts/util/garbage_leak_detector")
		parse_item_master_list()

		Managers.save = SaveManager:new(script_data.settings.disable_cloud_save)

		if SPLITSCREEN_ENABLED then
			Managers.splitscreen = SplitscreenTester:new()
		end

		Managers.perfhud = PerfhudManager:new()
		Managers.debug_updator = Updator:new()
		Managers.player = PlayerManager:new()
		Managers.free_flight = FreeFlightManager:new()
		Managers.smoketest = SmoketestManager:new()

		if not script_data.disable_news_ticker then
			Managers.news_ticker = NewsTickerManager:new()
		end

		Managers.light_fx = LightFXManager:new()
		Managers.invite = InviteManager:new()

		if GameSettingsDevelopment.remove_debug_stuff then
			DebugHelper.remove_debug_stuff()
		end

		if script_data.settings.physics_dump then
			DebugHelper.enable_physics_dump()
		end

		if PLATFORM == "xb1" then
			require("scripts/managers/events/xbox_event_manager")

			Managers.xbox_events = XboxEventManager:new()
		end

		self.splash_view:allow_console_skip()
	end
end

StateSplashScreen._init_localizer = function (self)
	Managers.localizer = LocalizationManager:new("localization/game")

	local function tweak_parser(tweak_name)
		return LocalizerTweakData[tweak_name] or "<missing LocalizerTweakData \"" .. tweak_name .. "\">"
	end

	Managers.localizer:add_macro("TWEAK", tweak_parser)

	local function key_parser(input_service_and_key_name)
		local split_start, split_end = string.find(input_service_and_key_name, "__")

		assert(split_start and split_end, "[key_parser] You need to specify a key using this format $KEY;<input_service>__<key>. Example: $KEY;options_menu__back (note the dubbel underline separating input service and key")

		local input_service_name = string.sub(input_service_and_key_name, 1, split_start - 1)
		local key_name = string.sub(input_service_and_key_name, split_end + 1)
		local input_service = Managers.input:get_service(input_service_name)

		fassert(input_service, "[key_parser] No input service with the name %s", input_service_name)

		local key = input_service:get_keymapping(key_name)

		fassert(key, "[key_parser] There is no such key: %s in input service: %s", key_name, input_service_name)

		local device = Managers.input:get_most_recent_device()
		local device_type = InputAux.get_device_type(device)
		local button_index = nil
		local mapping = key

		if mapping[1] == device_type then
			button_index = mapping[2]
		end

		local key_locale_name = nil

		if button_index then
			key_locale_name = device.button_name(button_index)

			if device_type == "keyboard" then
				key_locale_name = device.button_locale_name(button_index) or key_locale_name
			end

			if device_type == "mouse" then
				key_locale_name = string.format("%s %s", "mouse", key_locale_name)
			end
		else
			local default_device_type = "keyboard"

			if mapping[1] == default_device_type then
				button_index = mapping[2]
			end

			if button_index then
				key_locale_name = Keyboard.button_name(button_index)
				key_locale_name = Keyboard.button_locale_name(button_index) or key_locale_name
			else
				key_locale_name = string.format("<Mapping missing for key %s on device %s>", key_name, device_type)
			end
		end

		return key_locale_name
	end

	Managers.localizer:add_macro("KEY", key_parser)
end

StateSplashScreen.cb_fade_in_done = function (self)
	self.wanted_state = StateTitleScreen
end

StateSplashScreen.on_exit = function (self, application_shutdown)
	if PLATFORM == "win32" then
		local max_fps = Application.user_setting("max_fps")

		if max_fps == nil or max_fps == 0 then
			Application.set_time_step_policy("no_throttle", "smoothing", 11, 2, 0.1)
		else
			Application.set_time_step_policy("throttle", max_fps, "smoothing", 11, 2, 0.1)
		end
	end

	if self.splash_view then
		self.splash_view:destroy()

		self.splash_view = nil
	end

	ScriptWorld.destroy_viewport(self.world, "splash_view_viewport")

	if rawget(_G, "Debug") and Debug.active then
		Debug.teardown()
	end

	Managers.world:destroy_world(self.world)

	self.world = nil

	if PLATFORM == "win32" then
		self.input_manager:destroy()

		self.input_manager = nil
		Managers.input = nil

		Managers.package:unload("resource_packages/start_menu_splash", "StateSplashScreen")
		VisualAssertLog.cleanup()
	end
end

return
