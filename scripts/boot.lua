MODE = {}

dofile("foundation/scripts/boot/boot")
require("scripts/settings/dlc_settings")

GlobalResources = GlobalResources or {
	"resource_packages/common_level_resources",
	"resource_packages/menu_assets_common",
	"resource_packages/loading_screens/loading_bg_inn_level",
	"resource_packages/ingame_sounds_one",
	"resource_packages/ingame_sounds_two",
	"resource_packages/ingame_sounds_three",
	"resource_packages/ingame_sounds_weapon_general",
	"resource_packages/ingame_sounds_enemy_clan_rat_vce",
	"resource_packages/ingame_sounds_player_foley_common",
	"resource_packages/ingame_sounds_hud_dice_game",
	"resource_packages/ingame_sounds_general_props",
	"resource_packages/inventory",
	"resource_packages/decals",
	"resource_packages/levels/ui_loot_preview",
	"resource_packages/levels/ui_inventory_preview",
	"resource_packages/ingame",
	"resource_packages/pickups",
	"resource_packages/levels/ui_profile_selection",
	"resource_packages/end_screen_banners/end_screen_banners"
}

if LEVEL_EDITOR_TEST then
	GlobalResources = {
		"resource_packages/menu_assets_common",
		"resource_packages/ingame_light",
		"resource_packages/inventory",
		"resource_packages/pickups",
		"resource_packages/decals",
		"resource_packages/common_level_resources",
		"resource_packages/levels/ui_loot_preview",
		"resource_packages/levels/ui_inventory_preview",
		"resource_packages/levels/ui_profile_selection"
	}
end

Boot.foundation_update = Boot.foundation_update or Boot.update
Boot.foundation_shutdown = Boot.foundation_shutdown or Boot.shutdown
Boot.flow_return_table = Script.new_map(32)

function force_render(dt)
	if Managers.transition then
		Managers.transition:force_render(dt)
	end

	render()

	return 
end

Boot.update = function (self, dt)
	if PlayerUnitLocomotionExtension then
		PlayerUnitLocomotionExtension.set_new_frame()
	end

	UPDATE_RESOLUTION_LOOKUP()
	Managers.perfhud:update(dt)
	Managers.debug_updator:update(dt)
	Boot:foundation_update(dt)
	Managers.news_ticker:update(dt)
	Managers.transition:update(dt)

	if Managers.splitscreen then
		Managers.splitscreen:update(dt)
	end

	Managers.telemetry:update(dt)
	Managers.smoketest:update(dt)
	Managers.invite:update(dt)

	if Managers.account then
		Managers.account:update(dt)
	end

	if Managers.light_fx then
		Managers.light_fx:update(dt)
	end

	if Managers.unlock then
		Managers.unlock:update(dt)
	end

	if Managers.popup then
		Managers.simple_popup:update(dt)
		Managers.popup:update(dt)
	end

	if Managers.beta_overlay then
		Managers.beta_overlay:update(dt)
	end

	if (Application.build() == "dev" or Application.build() == "debug") and SynergyMouse.connected() then
		print("[Boot] SynergyMouse enabled")
	end

	end_function_call_collection()
	table.clear(Boot.flow_return_table)

	return 
end
Boot.shutdown = function (self, dt)
	if Bulldozer.rift then
		Oculus.destroy_device(Bulldozer.rift_info.hmd_device)
	end

	Boot:foundation_shutdown()

	return 
end
Bulldozer = Bulldozer or {}

function project_setup()
	Bulldozer:setup()

	return Bulldozer.entrypoint()
end

Bulldozer.setup = function (self)
	self._init_localizer(self)

	script_data.settings = Application.settings()
	script_data.build_identifier = Application.build_identifier()

	if script_data.settings.content_revision == nil and Development.parameter("trunk_path") and Development.parameter("generate_svn_info") then
		local path = Path.path_from_string(Development.parameter("trunk_path"))

		Path.add_path_part(path, "update_scripts")

		local svn_info_path = Path.copy(path)

		Path.add_path_part(svn_info_path, "svn_info.txt")

		svn_info_path = Path.tostring(svn_info_path, "\\")

		os.remove(svn_info_path)

		local script_path = Path.copy(path)

		Path.add_path_part(script_path, "generate_svn_info.bat")

		script_path = Path.tostring(script_path)
		local drive = path[1]
		path = Path.tostring(path)
		local command = string.format("start \"\" /min cmd /c call \"%s\" %s \"%s\" \"%s\"", script_path, drive, path, svn_info_path)

		print(command)

		local execute_result = os.execute(command)

		if execute_result ~= 0 then
			print("[Boot] Could not execute command, result ", tostring(execute_result))
		end

		local t0 = os.clock()

		while os.clock() - t0 <= 1 do
		end

		local svn_info_file = io.open(svn_info_path, "r")

		if svn_info_file then
			io.input(svn_info_file)

			while true do
				local svn_info_line = io.read()

				if svn_info_line == nil then
					break
				end

				local find_start, find_end = svn_info_line.find(svn_info_line, "Revision: ")

				if find_start and find_end then
					local svn_revision = svn_info_line.sub(svn_info_line, find_end + 1)
					script_data.settings.content_revision = svn_revision

					break
				end
			end

			io.close(svn_info_file)
		else
			print("[Boot] Could not open ", svn_info_path)
		end
	end

	local tab = {}

	for word in string.gmatch(script_data.build_identifier, "([^|]+)") do
		table.insert(tab, word)
	end

	if #tab == 3 then
		local build_id = tab[2]:gsub("^%s*(.-)%s*$", "%1")
		local build_conf = tab[3]:gsub("^%s*(.-)%s*$", "%1")
		local build_url = string.format("http://vcs01.i.fatshark.se:8111/viewLog.html?buildId=%s&tab=buildResultsDiv&buildTypeId=%s", build_id, build_conf)

		print("[Boot] Link to build log:", build_url)
	end

	print("[Boot] Application build:", Application.build())
	print("[Boot] Engine revision:", script_data.build_identifier)
	print("[Boot] Content revision:", script_data.settings.content_revision)

	for _, dlc in pairs(DLCSettings) do
		local package_name = dlc.package_name

		if package_name then
			Managers.package:load(package_name, "boot")
		end
	end

	self._require_scripts(self)

	if Development.parameter("paste_revision_to_clipboard") then
		Clipboard.put(string.format("%s | %s", tostring(script_data.settings.content_revision), tostring(script_data.build_identifier)))
	end

	self._handle_graphics_quality(self)
	DefaultUserSettings.set_default_user_settings()
	Application.set_time_step_policy("no_smoothing")
	self._load_user_settings(self)

	if Development.parameter("network_log_spew") then
		Network.log(Network.SPEW)
	elseif Development.parameter("network_log_messages") then
		Network.log(Network.MESSAGES)
	end

	Application.set_time_step_policy("external_step_range", 0, 100)
	Application.set_time_step_policy("system_step_range", 0, 100)

	if Development.parameter("disable_long_timesteps") then
		Application.set_time_step_policy("external_step_range", 0, 0.2)
		Application.set_time_step_policy("system_step_range", 0, 0.2)
	end

	if GameSettingsDevelopment.remove_debug_stuff then
		DebugHelper.remove_debug_stuff()
	end

	if script_data.settings.physics_dump then
		DebugHelper.enable_physics_dump()
	end

	self._init_random(self)
	self._init_mouse(self)
	self._init_managers(self)
	require("scripts/ui/views/ingame_ui")

	if rawget(_G, "Steam") then
		print("[Boot] User ID:", Steam.user_id(), Steam.user_name())
	end

	if (Application.build() == "dev" or Application.build() == "debug") and Development.parameter("synergy") then
		print("[Boot] Connecting to Synergy")

		local resx, resy = Application.resolution()
		local synergy_setting_name = Development.parameter("synergy")
		local synergy_settings = SynergySettings.user_settings[synergy_setting_name]

		Synergy.connect(synergy_settings.ip, synergy_settings.client_name, resx, resy)
	end

	if Application.build() == "dev" or Application.build() == "debug" then
		Window.set_resizable(true)
	else
		Window.set_resizable(false)
	end

	return 
end
Bulldozer._require_scripts = function (self)
	local function core_require(path, ...)
		for _, s in ipairs({
			...
		}) do
			require("core/" .. path .. "/" .. s)
		end

		return 
	end

	local function game_require(path, ...)
		for _, s in ipairs({
			...
		}) do
			require("scripts/" .. path .. "/" .. s)
		end

		return 
	end

	local function foundation_require(path, ...)
		for _, s in ipairs({
			...
		}) do
			require("foundation/scripts/" .. path .. "/" .. s)
		end

		return 
	end

	Managers.package:load("resource_packages/foundation_scripts", "boot")
	Managers.package:load("resource_packages/game_scripts", "boot")
	Managers.package:load("backend/local_backend/local_backend", "boot")
	Managers.package:load("resource_packages/level_scripts", "boot")
	foundation_require("managers", "localization/localization_manager", "event/event_manager")
	game_require("utils", "assert", "patches", "script_unit", "colors", "table", "random_table", "global_utils", "function_call_stats")
	game_require("settings", "game_settings_development", "controller_settings", "default_user_settings", "synergy_settings")
	game_require("game_state", "state_context")
	game_require("entity_system", "entity_system")
	game_require("managers", "news_ticker/news_ticker_manager", "player/player_manager", "player/player_bot", "save/save_manager", "save/save_data", "perfhud/perfhud_manager", "music/music_manager", "transition/transition_manager", "smoketest/smoketest_manager", "debug/updator", "invite/invite_manager", "unlock/unlock_manager", "popup/popup_manager", "popup/simple_popup", "light_fx/light_fx_manager", "play_go/play_go_manager", "controller_features/controller_features_manager", "leaderboards/leaderboard_manager", "telemetry/telemetry_create")
	game_require("helpers", "effect_helper", "weapon_helper", "item_helper", "lorebook_helper", "ui_atlas_helper", "scoreboard_helper")
	game_require("network", "unit_spawner", "unit_storage", "network_unit")
	game_require("utils", "table")
	game_require("utils", "util")
	game_require("utils", "loaded_dice")
	game_require("utils", "script_application")
	game_require("utils", "script_world")

	return 
end
Bulldozer._handle_graphics_quality = function (self)
	local graphics_quality = Application.user_setting("graphics_quality")

	if graphics_quality == nil then
		graphics_quality = script_data.settings.default_graphics_quality or "medium"

		Application.set_user_setting("graphics_quality", graphics_quality)
	end

	if LEVEL_EDITOR_TEST or graphics_quality == "custom" or not GraphicsQuality[graphics_quality] then
		return 
	end

	local settings = GraphicsQuality[graphics_quality]
	local user_settings = settings.user_settings

	for setting, value in pairs(user_settings) do
		if setting == "char_texture_quality" then
			local texture_settings = TextureQuality.characters[value]

			for i, texture_setting in ipairs(texture_settings) do
				Application.set_user_setting("texture_settings", texture_setting.texture_setting, texture_setting.mip_level)
			end
		elseif setting == "env_texture_quality" then
			local texture_settings = TextureQuality.environment[value]

			for i, texture_setting in ipairs(texture_settings) do
				Application.set_user_setting("texture_settings", texture_setting.texture_setting, texture_setting.mip_level)
			end
		elseif setting == "local_light_shadow_quality" then
			local local_light_shadow_quality_settings = LocalLightShadowQuality[value]

			for render_setting, key in pairs(local_light_shadow_quality_settings) do
				Application.set_user_setting("render_settings", render_setting, key)
			end
		elseif setting == "particles_quality" then
			local particle_quality_settings = ParticlesQuality[value]

			for render_setting, key in pairs(particle_quality_settings) do
				Application.set_user_setting("render_settings", render_setting, key)
			end
		elseif setting == "sun_shadow_quality" then
			local sun_shadow_quality_settings = SunShadowQuality[value]

			for render_setting, key in pairs(sun_shadow_quality_settings) do
				Application.set_user_setting("render_settings", render_setting, key)
			end
		end

		Application.set_user_setting(setting, value)
	end

	local render_settings = settings.render_settings

	for setting, value in pairs(render_settings) do
		Application.set_user_setting("render_settings", setting, value)
	end

	Application.apply_user_settings()
	Application.save_user_settings()

	return 
end
Bulldozer._init_random = function (self)
	local seed = (os.clock()*10000)%1000

	math.randomseed(seed)
	math.random(5, 30000)

	return 
end
Bulldozer._init_mouse = function (self)
	Window.set_cursor("gui/cursors/mouse_cursor")
	Window.set_clip_cursor(true)

	return 
end
Bulldozer._init_managers = function (self)
	self._setup_macros(self)
	parse_item_master_list()

	Managers.save = SaveManager:new(script_data.settings.disable_cloud_save)

	self._init_backend(self)

	if Application.platform() ~= "win32" then
		Managers.splitscreen = SplitscreenTester:new()
	end

	Managers.perfhud = PerfhudManager:new()
	Managers.debug_updator = Updator:new()
	Managers.music = MusicManager:new()
	Managers.transition = TransitionManager:new()
	Managers.play_go = PlayGoManager:new()
	Managers.telemetry = CreateTelemetryManager()
	Managers.player = PlayerManager:new()
	Managers.free_flight = FreeFlightManager:new()
	Managers.smoketest = SmoketestManager:new()
	Managers.invite = InviteManager:new()
	Managers.news_ticker = NewsTickerManager:new()
	Managers.light_fx = LightFXManager:new()
	Managers.unlock = UnlockManager:new()

	if GameSettingsDevelopment.use_leaderboards or Development.parameter("use_leaderboards") then
		Managers.leaderboards = LeaderboardManager:new()
	end

	return 
end
Bulldozer._init_backend = function (self)
	Managers.backend = BackendManager:new()

	return 
end
Bulldozer._load_user_settings = function (self)
	if Application.platform() ~= "win32" then
		return 
	end

	local max_fps = Application.user_setting("max_fps")

	if max_fps then
		if max_fps == 0 then
			Application.set_time_step_policy("no_throttle")
		else
			Application.set_time_step_policy("throttle", max_fps)
		end
	end

	local max_frames = Application.win32_user_setting("max_stacking_frames")

	if max_frames then
		Application.set_max_frame_stacking(max_frames)
	end

	return 
end
Bulldozer._init_localizer = function (self)
	local has_steam = rawget(_G, "Steam")
	local language_id = Application.user_setting("language_id") or (has_steam and Steam:language()) or "en"

	Application.set_resource_property_preference_order(language_id)
	Managers.package:load("resource_packages/post_localization_boot", "boot")
	Managers.package:load("resource_packages/strings", "boot")

	return 
end
Bulldozer._setup_macros = function (self)
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

		local key = input_service.get_keymapping(input_service, key_name)

		fassert(key, "[key_parser] There is no such key: %s in input service: %s", key_name, input_service_name)

		local key_locale_name = nil

		for j = 1, key.n, 3 do
			local device_type = key[j]
			local button_index = key[j + 1]

			if Managers.input:is_device_active("keyboard") or Managers.input:is_device_active("mouse") then
				if device_type == "keyboard" then
					key_locale_name = Keyboard.button_locale_name(button_index) or Keyboard.button_name(button_index)
				elseif device_type == "mouse" then
					key_locale_name = Mouse.button_name(button_index)
				end
			elseif Managers.input:is_device_active("gamepad") and device_type == "gamepad" then
				key_locale_name = Pad1.button_name(button_index)
			end
		end

		return key_locale_name
	end

	Managers.localizer:add_macro("KEY", key_parser)

	return 
end
Bulldozer.rift_start = function (self)
	local hmd_device = Oculus.create_device()
	local info = Oculus.hmd_info(hmd_device)
	Bulldozer.rift_info = info
	info.hmd_device = hmd_device
	local horizontal_shift = info.horizontal_screen_size*0.25 - info.lens_separation_distance*0.5
	local projection_center_offset = (horizontal_shift*4)/info.horizontal_screen_size
	Bulldozer.left_projection_transform = Matrix4x4Box(Matrix4x4.from_translation(Vector3(projection_center_offset, 0, 0)))
	Bulldozer.right_projection_transform = Matrix4x4Box(Matrix4x4.from_translation(Vector3(-projection_center_offset, 0, 0)))
	Bulldozer.half_eye_shift = info.interpupillary_distance*0.5*info.horizontal_screen_size*0.25
	Bulldozer.left_lens_center = Vector3Box(info.lens_separation_distance*2*info.horizontal_screen_size - 1, 0.5)
	Bulldozer.right_lens_center = Vector3Box(info.lens_separation_distance*2*info.horizontal_screen_size - 1, 0.5)

	return 
end
Bulldozer.entrypoint = function (self)
	local args = {
		Application.argv()
	}
	Bulldozer.rift = false

	for i = 1, #args, 1 do
		if args[i] == "-rift" then
			Bulldozer.rift = true
		elseif args[i] == "safe-mode" then
			Bulldozer.safe_mode = true

			assert(false)
		end
	end

	if Bulldozer.rift then
		Bulldozer.rift_start()
	end

	Managers.package:load("resource_packages/levels/debug_levels", "boot")
	Managers.package:load("resource_packages/levels/benchmark_levels", "boot")
	Managers.package:load("resource_packages/levels/dwarf_levels", "boot")
	Managers.package:load("resource_packages/dlcs/challenge_wizard/challenge_wizard", "boot")

	script_data.use_optimized_breed_units = false
	local breed_package = (script_data.use_optimized_breed_units and "resource_packages/ingame_breeds_optimized") or "resource_packages/ingame_breeds"

	print("[Boot] use baked enemy meshes:", script_data.use_optimized_breed_units, " package: ", breed_package)

	if GameSettingsDevelopment.start_state == "game" then
		local ingame_package = (LEVEL_EDITOR_TEST and "resource_packages/ingame_light") or "resource_packages/ingame"

		Managers.package:load("resource_packages/menu", "boot")
		Managers.package:load("resource_packages/menu_assets_common", "global")
		Managers.package:load(ingame_package, "global")
		Managers.package:load(breed_package, "global")
		Managers.package:load("resource_packages/inventory", "global")
		Managers.package:load("resource_packages/pickups", "global")
		Managers.package:load("resource_packages/decals", "global")
		Managers.package:load("resource_packages/common_level_resources", "global")

		local level_key = GameSettingsDevelopment.quicklaunch_params.level_key
		Boot.loading_context = {
			level_key = level_key
		}

		require("scripts/game_state/state_splash_screen")

		return StateSplashScreen
	elseif GameSettingsDevelopment.start_state == "menu" then
		Boot.loading_context = {
			show_splash_screens = true
		}

		Managers.package:load(breed_package, "global")
		require("scripts/game_state/state_splash_screen")

		return StateSplashScreen
	end

	return StateSplashScreen
end
script_data = script_data or {}
__dgaa = 11.59
__dgaa = 12.44

return 
