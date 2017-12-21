require("scripts/ui/ui_elements")
require("scripts/ui/ui_fonts")
require("scripts/ui/views/reward_ui")
require("scripts/ui/views/summary_screen_ui")
require("scripts/game_state/components/dice_roller")
require("scripts/utils/debug_key_handler")
require("scripts/settings/ui_settings")
require("scripts/ui/views/scoreboard_ui")
require("scripts/ui/views/contract_presentation_screen_ui")
require("scripts/game_state/components/dice_keeper")

local definitions = local_require("scripts/ui/views/end_of_level_ui_definitions")
EndOfLevelUI = class(EndOfLevelUI)
EndOfLevelUI.init = function (self, end_of_level_ui_context, game_won)
	self.game_won = game_won
	local ui_world_name = "top_ingame_view"
	local ui_world = end_of_level_ui_context.world_manager:world(ui_world_name)
	self.ui_world = ui_world
	self.wwise_world = Managers.world:wwise_world(ui_world)
	self.render_settings = {
		snap_pixel_positions = true
	}
	local input_manager = end_of_level_ui_context.input_manager
	self.input_manager = input_manager
	self.ingame_ui = end_of_level_ui_context.ingame_ui

	if not Managers.chat:chat_is_focused() then
		input_manager.block_device_except_service(input_manager, "ingame_menu", "mouse")
		input_manager.block_device_except_service(input_manager, "ingame_menu", "keyboard")
		input_manager.block_device_except_service(input_manager, "ingame_menu", "gamepad")
	end

	if Application.platform() == "win32" then
		self.ui_renderer = UIRenderer.create(ui_world, "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_popup", "material", "materials/ui/ui_1080p_level_images", "material", "materials/fonts/gw_fonts")
	else
		self.ui_renderer = UIRenderer.create(ui_world, "material", "materials/ui/ui_1080p_ingame_common", "material", "materials/ui/ui_1080p_ingame", "material", "materials/ui/ui_1080p_popup", "material", "materials/ui/ui_1080p_level_images_console", "material", "materials/fonts/gw_fonts")
	end

	end_of_level_ui_context.game_won = game_won
	end_of_level_ui_context.ui_renderer = self.ui_renderer
	local rewards = end_of_level_ui_context.rewards
	self.rewards = rewards
	local game_mode_key = Managers.state.game_mode:game_mode_key()
	self.game_mode_key = game_mode_key

	if game_won then
		Managers.state.event:trigger("event_enable_achievements", false)

		local level_dice_keeper = end_of_level_ui_context.level_dice_keeper

		self.award_mission_rewards(self, level_dice_keeper)

		if game_mode_key ~= "survival" then
			self.setup_level(self)

			local dice_game_hero = self._dice_game_hero(self)
			self.level_dice_roller = DiceRoller:new(self.world, level_dice_keeper, rewards, dice_game_hero)
			end_of_level_ui_context.dice_roller = self.level_dice_roller
		end
	end

	rewards.award_experience(rewards, game_won, game_mode_key)

	self.level_transition_handler = end_of_level_ui_context.level_transition_handler
	self.statistics_db = end_of_level_ui_context.statistics_db
	self.is_server = end_of_level_ui_context.is_server
	self.game_won = game_won

	self.create_ui_elements(self)
	rawset(_G, "GLOBAL_EOLUI", self)

	self.views = {
		scoreboard_screen = ScoreboardUI:new(end_of_level_ui_context),
		summary_screen = SummaryScreenUI:new(end_of_level_ui_context),
		dice_game = RewardUI:new(end_of_level_ui_context, self.ui_world),
		contract_presentation = ContractPresentationScreenUI:new(end_of_level_ui_context)
	}

	self.start_fade_in(self)

	return 
end
EndOfLevelUI._dice_game_hero = function (self)
	local profile_synchronizer = Managers.state.network.profile_synchronizer
	local player = Managers.player:local_player()
	local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, player.network_id(player), player.local_player_id(player))
	local hero_data = SPProfiles[profile_index]
	local hero_name = hero_data.display_name

	for i = 1, 3, 1 do
		local slot_name = "slot_trinket_" .. i
		local trinket = BackendUtils.get_loadout_item(hero_name, slot_name)

		if trinket then
			for _, trait_name in ipairs(trinket.traits) do
				local trait_config = BuffTemplates[trait_name]
				local roll_dice_as_hero = trait_config.roll_dice_as_hero

				if roll_dice_as_hero then
					return roll_dice_as_hero
				end
			end
		end
	end

	return 
end
EndOfLevelUI.start = function (self, ignore_input_blocking)
	ShowCursorStack.push()

	self.cursor_pushed = true

	self.handle_transition(self, "summary_screen", ignore_input_blocking)

	self.initialize_start_transition = nil
	self.start_transition_initialized = true

	return 
end
EndOfLevelUI.destroy = function (self)
	if self.cursor_pushed then
		ShowCursorStack.pop()
	end

	local input_manager = self.input_manager

	input_manager.device_unblock_all_services(input_manager, "mouse", 1)
	input_manager.device_unblock_all_services(input_manager, "gamepad", 1)
	input_manager.device_unblock_all_services(input_manager, "keyboard", 1)

	for view_name, view in pairs(self.views) do
		view.destroy(view)
	end

	self.views = nil

	UIRenderer.destroy(self.ui_renderer, self.ui_world)

	self.ui_renderer = nil

	if self.level_dice_roller then
		self.level_dice_roller:destroy()

		self.level_dice_roller = nil
	end

	if self.world_name then
		Managers.world:destroy_world(self.world_name)
	end

	local max_shadow_casting_lights = Application.user_setting("render_settings", "max_shadow_casting_lights")

	Application.set_render_setting("max_shadow_casting_lights", max_shadow_casting_lights)
	self.play_sound(self, "unmute_all_world_sounds")
	rawset(_G, "GLOBAL_EOLUI", nil)

	return 
end
EndOfLevelUI.setup_level = function (self)
	self.world_name = "dicegame_level"
	local layer = 1
	self.world = Managers.world:create_world(self.world_name, nil, callback(self, "shading_callback"), layer, Application.DISABLE_APEX_CLOTH)
	local physics_world = World.get_data(self.world, "physics_world")

	PhysicsWorld.set_gravity(physics_world, Vector3(0, 0, -39.28))

	local level_name = "levels/dicegame/world"
	local object_sets, position, rotation, shading_callback, mood_setting = nil
	local level = ScriptWorld.load_level(self.world, level_name, object_sets, position, rotation, shading_callback, mood_setting)

	World.set_flow_callback_object(self.world, self)
	Level.spawn_background(level)

	local viewport_name = "camera_1"
	self.viewport_name = viewport_name
	local position, rotation = nil

	ScriptWorld.create_viewport(self.world, viewport_name, "default", 1, position, rotation)

	local level_units = Level.units(level)

	for _, unit in ipairs(level_units) do
		if Unit.is_a(unit, "core/units/camera") then
			position = Unit.world_position(unit, 0)
			rotation = Unit.world_rotation(unit, 0)

			break
		end
	end

	Application.set_render_setting("max_shadow_casting_lights", 16)

	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)

	ScriptCamera.set_local_position(camera, position or Vector3(7, 12.5, 30))
	ScriptCamera.set_local_rotation(camera, rotation or Quaternion.look(Vector3.normalize(Vector3(0, -0.5, -1))))

	return 
end
EndOfLevelUI.deactivate_dice_world_viewport = function (self)
	local viewport = ScriptWorld.viewport(self.world, self.viewport_name)

	ScriptWorld.deactivate_viewport(self.world, viewport)

	self.dice_viewport_deactivated = true

	return 
end
EndOfLevelUI.award_mission_rewards = function (self, level_dice_keeper)
	local mission_system = Managers.state.entity:system("mission_system")
	local active_missions, _ = mission_system.get_missions(mission_system)

	for token_type, _ in pairs(ForgeSettings.token_types) do
		local amount = BackendUtils.get_tokens(token_type)

		print("Player owns", amount, token_type)
	end

	for mission_name, data in pairs(active_missions) do
		if not data.is_goal then
			local template = MissionTemplates[data.mission_data.mission_template_name]
			local done, amount = template.evaluate_mission(data)
			local bonus_dice = 0
			local bonus_tokens = 0
			local evaluation_type = data.evaluation_type

			if evaluation_type == "percent" then
				local dice_per_percent = data.dice_per_percent or 0
				local tokens_per_percent = data.dice_per_percent or 0
				local percent_completed = amount*100
				bonus_dice = math.floor(percent_completed*dice_per_percent)
				bonus_tokens = math.floor(percent_completed*tokens_per_percent)
			elseif evaluation_type == "amount" then
				if data.dice_per_amount then
					local dice_per_amount = data.dice_per_amount
					local collected_amount = amount
					bonus_dice = collected_amount*dice_per_amount
				elseif data.tokens_per_amount then
					local tokens_per_amount = data.tokens_per_amount
					local collected_amount = amount
					bonus_tokens = collected_amount*tokens_per_amount
				end
			end

			if 0 < bonus_dice and level_dice_keeper then
				local dice_type = data.dice_type

				level_dice_keeper.add_die(level_dice_keeper, dice_type, bonus_dice)
			end

			if 0 < bonus_tokens then
				local token_type = data.token_type

				print("Adding tokens", mission_name, bonus_tokens, token_type)
				BackendUtils.add_tokens(bonus_tokens, token_type)
			end
		end
	end

	for token_type, _ in pairs(ForgeSettings.token_types) do
		local amount = BackendUtils.get_tokens(token_type)

		print("Player owns", amount, token_type)
	end

	return 
end
local transitions = {
	summary_screen = function (self)
		self.current_view = "summary_screen"

		return 
	end,
	scoreboard_screen = function (self)
		Managers.state.event:trigger("event_enable_achievements", true)

		self.current_view = "scoreboard_screen"

		return 
	end,
	dice_game = function (self)
		self.current_view = "dice_game"

		return 
	end,
	contract_presentation = function (self)
		self.current_view = "contract_presentation"

		return 
	end
}
EndOfLevelUI.handle_transition = function (self, new_transition, ...)
	assert(transitions[new_transition])

	local old_view = self.current_view

	transitions[new_transition](self, ...)

	if old_view ~= self.current_view then
		if self.views[old_view] and self.views[old_view].on_exit then
			self.views[old_view]:on_exit(...)
		end

		if self.views[self.current_view] and self.views[self.current_view].on_enter then
			self.views[self.current_view]:on_enter(...)
		end
	end

	return 
end
EndOfLevelUI.enable_chat = function (self)
	return true
end
EndOfLevelUI.active_input_service = function (self)
	local input_service = nil

	if self.current_view then
		input_service = self.views[self.current_view]:input_service()
	else
		input_service = self.input_manager:get_service("ingame_menu")
	end

	return input_service
end
EndOfLevelUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.background_rect_widget = UIWidget.init(definitions.widgets.background_rect)
	self.dead_space_filler_widget = UIWidget.init(definitions.widgets.dead_space_filler)
	self.curtain_widgets = {
		left = UIWidget.init(definitions.widgets.curtain_left),
		right = UIWidget.init(definitions.widgets.curtain_right)
	}
	self.overlay_widget = UIWidget.init(UIWidgets.create_simple_texture("dice_game_overlay", "menu_root"))
	local dies_enabled = true
	local input_manager = self.input_manager
	local ui_renderer = self.ui_renderer
	dies_enabled = false

	if self.current_curtain_fraction then
		self.set_curtain_progress(self, self.current_curtain_fraction)
	end

	return 
end
EndOfLevelUI.play_sound = function (self, sound)
	WwiseWorld.trigger_event(self.wwise_world, sound)

	return 
end
EndOfLevelUI.update = function (self, dt)
	AccomodateViewport()

	local res_x = RESOLUTION_LOOKUP.res_w
	local res_y = RESOLUTION_LOOKUP.res_h

	if res_x ~= self.last_resolution_x or res_y ~= self.last_resolution_y then
		InitVideo()

		self.last_resolution_y = res_y
		self.last_resolution_x = res_x
	end

	local ingame_ui = self.ingame_ui
	local chat_gui = Managers.chat.chat_gui
	local ignore_input_blocking = false
	local game_won = self.game_won
	local game_mode_key = self.game_mode_key

	if self.initialize_start_transition and not Managers.backend:is_waiting_for_user_input() then
		self.start(self, ignore_input_blocking)
	elseif not self.start_transition_initialized then
		if game_won and game_mode_key ~= "survival" then
			self.initialize_start_transition = self.level_dice_roller:poll_for_backend_result()
		else
			self.initialize_start_transition = self.rewards:poll_upgrades_failed_game()
		end
	end

	self.update_fade_in(self, dt)
	self.update_curtains_animation(self, dt)

	local ui_renderer = self.ui_renderer
	local input_service = self.input_manager:get_service("ingame_menu")

	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)

	local curtain_widgets = self.curtain_widgets

	UIRenderer.draw_widget(ui_renderer, curtain_widgets.left)
	UIRenderer.draw_widget(ui_renderer, curtain_widgets.right)
	UIRenderer.draw_widget(ui_renderer, self.dead_space_filler_widget)
	UIRenderer.draw_widget(ui_renderer, self.background_rect_widget)
	UIRenderer.draw_widget(ui_renderer, self.overlay_widget)
	UIRenderer.end_pass(ui_renderer)

	local has_dice_results = nil

	if game_won and self.start_transition_initialized and self.game_mode_key ~= "survival" then
		has_dice_results = self.update_dice_rolling_results(self, dt)
	end

	local current_view = self.current_view

	if current_view then
		local active_view = self.views[current_view]

		active_view.update(active_view, dt)

		if self.animating_curtains(self) then
			return 
		end

		if active_view.is_complete then
			if current_view == "summary_screen" then
				self.handle_transition(self, "contract_presentation", ignore_input_blocking)
			elseif current_view == "contract_presentation" then
				if game_won and self.game_mode_key ~= "survival" then
					local function callback()
						self:handle_transition("dice_game", ignore_input_blocking)

						return 
					end

					self.animate_curtains(self, 0.5, callback)
					self.play_sound(self, "dice_game_curtain_open")
				else
					self.handle_transition(self, "scoreboard_screen", ignore_input_blocking)
				end
			elseif current_view == "dice_game" then
				local function callback()
					self:handle_transition("scoreboard_screen", ignore_input_blocking)

					return 
				end

				self.animate_curtains(self, 1, callback)
				self.play_sound(self, "dice_game_curtain_close")
			elseif current_view == "scoreboard_screen" then
				local session_state = ScriptBackendSession.get_state()

				if session_state == "UNINITIALIZED" then
					self.continue_to_game = true
				end
			end
		elseif current_view == "dice_game" then
			local level_dice_roller = self.level_dice_roller
			local is_rolling = level_dice_roller.is_rolling(level_dice_roller)
			local has_rerolls = level_dice_roller.has_rerolls(level_dice_roller)
			local level_dice_results = level_dice_roller.get_dice_results(level_dice_roller)
			local dice_rolling_completed = level_dice_roller.is_completed(level_dice_roller)

			if active_view.disable_dice_game and not self.dice_viewport_deactivated then
				self.deactivate_dice_world_viewport(self)
			end

			if dice_rolling_completed and not self.dice_rolling_completed then
				self.dice_rolling_completed = true

				active_view.set_reroll_state(active_view, false)
				active_view.set_roll_button_text(active_view, "loot_screen_continue_button")
				active_view.start_reward(active_view)

				local backend_manager = Managers.backend

				if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
					local stats_id = Managers.player:local_player():stats_id()
					local statistics_db = Managers.player:statistics_db()

					statistics_db.set_stat(statistics_db, stats_id, "dice_roll_successes", self._num_dice_successes)
				end
			end

			if has_dice_results and not is_rolling then
				if self.has_rolled and has_rerolls then
					active_view.set_roll_button_text(active_view, "loot_screen_reroll_button")
					active_view.set_reroll_state(active_view, true)
				end

				if active_view.is_roll_button_pressed(active_view) then
					if dice_rolling_completed then
						active_view.on_complete(active_view)
					else
						level_dice_roller.roll_dices(level_dice_roller)

						self.has_rolled = true

						active_view.set_draw_roll_button_enabled(active_view, false)
						self.play_sound(self, "Play_hud_select")
					end
				end
			end
		end
	end

	return 
end
EndOfLevelUI.update_dice_rolling_results = function (self, dt)
	local level_dice_roller = self.level_dice_roller

	level_dice_roller.update(level_dice_roller, dt)

	if not self.successes then
		local num_successes = level_dice_roller.num_successes(level_dice_roller)
		local win_list = level_dice_roller.win_list(level_dice_roller)
		self._num_dice_successes = num_successes
		self.successes = level_dice_roller.successes(level_dice_roller)
		self.dice_types = level_dice_roller.dice(level_dice_roller)
		self.reward_item_key = self.reward_item_key or level_dice_roller.reward_item_key(level_dice_roller)
		self.reward_item_backend_id = self.reward_item_backend_id or level_dice_roller.reward_backend_id(level_dice_roller)

		self.views.dice_game:set_reward_values(num_successes, self.dice_types, win_list, self.reward_item_key, self.reward_item_backend_id)
	end

	if not self.dice_simulation_complete then
		self.dice_simulation_complete = level_dice_roller.simulate_dice_rolls(level_dice_roller, self.successes)
	end

	return self.successes and self.dice_simulation_complete
end
EndOfLevelUI.shading_callback = function (self, world, shading_env, viewport)
	if world ~= self.world then
		return 
	end

	for name, settings in pairs(OutlineSettings.colors) do
		local c = settings.color
		local color = Vector3(c[2]/255, c[3]/255, c[4]/255)

		ShadingEnvironment.set_vector3(shading_env, settings.variable, color)
		ShadingEnvironment.set_scalar(shading_env, settings.outline_multiplier_variable, settings.outline_multiplier)
	end

	return 
end
EndOfLevelUI.start_fade_in = function (self)
	self.fade_in_timer = 0.7

	return 
end
EndOfLevelUI.update_fade_in = function (self, dt)
	local time = self.fade_in_timer

	if time then
		local total_time = 0.7
		time = time - dt
		local progress = math.max(time/total_time, 0)
		self.background_rect_widget.style.rect.color[1] = progress*255

		if time <= 0 then
			self.fade_in_timer = nil

			self.on_fade_complete(self)
		else
			self.fade_in_timer = time
		end
	end

	return 
end
EndOfLevelUI.on_fade_complete = function (self)
	return 
end
EndOfLevelUI.set_curtain_progress = function (self, value)
	local ui_scenegraph = self.ui_scenegraph
	local scenegraph_definition = definitions.scenegraph_definition
	local curtain_widgets = self.curtain_widgets
	local right_widget = curtain_widgets.right
	local right_default_definition = scenegraph_definition.curtain_right
	local right_scenegraph = ui_scenegraph.curtain_right
	right_scenegraph.size[1] = right_default_definition.size[1]*value
	local left_widget = curtain_widgets.left
	local left_default_definition = scenegraph_definition.curtain_left
	local left_scenegraph = ui_scenegraph.curtain_left
	left_scenegraph.size[1] = left_default_definition.size[1]*value

	return 
end
EndOfLevelUI.animate_curtains = function (self, open_fraction, callback)
	local current_curtain_fraction = self.current_curtain_fraction or 1

	if open_fraction == current_curtain_fraction then
		return 
	end

	self.curtain_anim_data = {
		time = 0,
		new_curtain_fraction = open_fraction,
		opening = open_fraction < current_curtain_fraction,
		callback = callback
	}

	return 
end
EndOfLevelUI.animating_curtains = function (self)
	if self.curtain_anim_data then
		return true
	end

	return false
end
EndOfLevelUI.update_curtains_animation = function (self, dt)
	local curtain_anim_data = self.curtain_anim_data

	if curtain_anim_data then
		local opening = curtain_anim_data.opening
		local new_curtain_fraction = curtain_anim_data.new_curtain_fraction
		local current_curtain_fraction = self.current_curtain_fraction or 1
		local fraction_diff = current_curtain_fraction - new_curtain_fraction
		local fraction_diff_abs = math.abs(new_curtain_fraction - current_curtain_fraction)
		local total_time = 2.5
		local scaled_opening_time = fraction_diff_abs*total_time
		local time = curtain_anim_data.time
		time = math.min(time + dt, scaled_opening_time)
		local progress = (scaled_opening_time ~= 0 and time/scaled_opening_time) or 1
		local curtain_progress = math.catmullrom(progress, 0, 0, 1, -1.5)
		local curtain_fraction = 0

		if opening then
			curtain_fraction = current_curtain_fraction - curtain_progress*fraction_diff_abs
		else
			curtain_fraction = current_curtain_fraction + curtain_progress*fraction_diff_abs
		end

		self.set_curtain_progress(self, curtain_fraction)

		if progress == 1 then
			local callback = self.curtain_anim_data.callback

			if callback then
				callback()
			end

			self.curtain_anim_data = nil
			self.current_curtain_fraction = curtain_fraction
		else
			curtain_anim_data.time = time
			curtain_anim_data.curtain_fraction = curtain_fraction
		end
	end

	return 
end

if rawget(_G, "GLOBAL_EOLUI") then
	rawget(_G, "GLOBAL_EOLUI"):create_ui_elements()
end

return 
