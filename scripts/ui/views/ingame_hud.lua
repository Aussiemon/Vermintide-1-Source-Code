require("scripts/ui/views/subtitle_gui")
require("scripts/ui/views/damage_indicator_gui")
require("scripts/ui/views/tutorial_ui")
require("scripts/ui/views/interaction_ui")
require("scripts/ui/views/unit_frames_ui")
require("scripts/ui/views/area_indicator_ui")
require("scripts/ui/views/mission_objective_ui")
require("scripts/ui/views/crosshair_ui")
require("scripts/ui/views/fatigue_ui")
require("scripts/ui/views/player_inventory_ui")
require("scripts/ui/views/bonus_dice_ui")
require("scripts/ui/views/gdc_start_ui")
require("scripts/ui/views/ingame_player_list_ui")
require("scripts/ui/views/ingame_voting_ui")
require("scripts/ui/hud_ui/wait_for_rescue_ui")
require("scripts/ui/views/positive_reinforcement_ui")
require("scripts/ui/hud_ui/input_helper_ui")
require("scripts/ui/hud_ui/observer_ui")
require("scripts/ui/hud_ui/ingame_news_ticker_ui")
require("scripts/ui/hud_ui/game_timer_ui")
require("scripts/ui/hud_ui/endurance_badge_ui")
require("scripts/ui/hud_ui/difficulty_unlock_ui")
require("scripts/ui/hud_ui/difficulty_notification_ui")
require("scripts/ui/hud_ui/boon_ui")
require("scripts/ui/hud_ui/contract_log_ui")
require("scripts/ui/gift_popup/gift_popup_ui")

local definitions = local_require("scripts/ui/views/ingame_hud_definitions")
IngameHud = class(IngameHud)
IngameHud.init = function (self, ingame_ui_context)
	self.is_in_inn = ingame_ui_context.is_in_inn
	self.gdc_build = Development.parameter("gdc")
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager

	self.create_ui_elements(self)

	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager
	self.mission_system = Managers.state.entity:system("mission_system")
	self.subtitle_gui = SubtitleGui:new(ingame_ui_context)
	self.damage_indicator_gui = DamageIndicatorGui:new(ingame_ui_context)
	self.interaction_ui = InteractionUI:new(ingame_ui_context)
	self.tutorial_ui = TutorialUI:new(ingame_ui_context)
	self.unit_frames = UnitFramesUI:new(ingame_ui_context)
	self.area_indicator = AreaIndicatorUI:new(ingame_ui_context)
	self.mission_objective = MissionObjectiveUI:new(ingame_ui_context)
	self.crosshair = CrosshairUI:new(ingame_ui_context)
	self.fatigue_ui = FatigueUI:new(ingame_ui_context)
	self.player_inventory_ui = PlayerInventoryUI:new(ingame_ui_context)
	self.bonus_dice_ui = BonusDiceUI:new(ingame_ui_context)
	self.ingame_player_list_ui = IngamePlayerListUI:new(ingame_ui_context)
	self.ingame_voting_ui = IngameVotingUI:new(ingame_ui_context)
	self.wait_for_rescue_ui = WaitForRescueUI:new(ingame_ui_context)
	self.positive_reinforcement_ui = PositiveReinforcementUI:new(ingame_ui_context)
	self.input_helper_ui = InputHelperUI:new(ingame_ui_context)
	self.observer_ui = ObserverUI:new(ingame_ui_context)
	self.ingame_news_ticker_ui = IngameNewsTickerUI:new(ingame_ui_context)
	self.gift_popup_ui = GiftPopupUI:new(ingame_ui_context)
	local game_mode_key = Managers.state.game_mode:game_mode_key()
	self.boon_ui = BoonUI:new(ingame_ui_context)
	local backend_settings = GameSettingsDevelopment.backend_settings

	if not self.is_in_inn and backend_settings.quests_enabled then
		self.contract_log_ui = ContractLogUI:new(ingame_ui_context)
	end

	self.game_timer_ui = GameTimerUI:new(ingame_ui_context)

	if game_mode_key == "survival" then
		self.game_timer_ui = GameTimerUI:new(ingame_ui_context)
		self.difficulty_unlock_ui = DifficultyUnlockUI:new(ingame_ui_context)
		self.difficulty_notification_ui = DifficultyNotificationUI:new(ingame_ui_context)
	end

	if self.gdc_build then
		self.gdc_start_ui = GDCStartUI:new(ingame_ui_context)
	end

	return 
end
IngameHud.destroy = function (self)
	if self.game_timer_ui then
		self.game_timer_ui:destroy()
	end

	if self.endurance_badge_ui then
		self.endurance_badge_ui:destroy()
	end

	if self.difficulty_unlock_ui then
		self.difficulty_unlock_ui:destroy()
	end

	if self.difficulty_notification_ui then
		self.difficulty_notification_ui:destroy()
	end

	if self.boon_ui then
		self.boon_ui:destroy()
	end

	if self.contract_log_ui then
		self.contract_log_ui:destroy()
	end

	self.subtitle_gui:destroy()
	self.damage_indicator_gui:destroy()
	self.tutorial_ui:destroy()
	self.interaction_ui:destroy()
	self.unit_frames:destroy()
	self.area_indicator:destroy()
	self.mission_objective:destroy()
	self.crosshair:destroy()
	self.fatigue_ui:destroy()
	self.player_inventory_ui:destroy()
	self.bonus_dice_ui:destroy()
	self.ingame_player_list_ui:destroy()
	self.ingame_voting_ui:destroy()
	self.wait_for_rescue_ui:destroy()
	self.positive_reinforcement_ui:destroy()
	self.input_helper_ui:destroy()
	self.observer_ui:destroy()

	if self.gdc_build then
		self.gdc_start_ui:destroy()
	end

	self.gift_popup_ui:destroy()

	return 
end
IngameHud.create_ui_elements = function (self)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)

	return 
end
IngameHud.set_visible = function (self, visible)
	self.unit_frames:set_visible(visible)
	self.player_inventory_ui:set_visible(visible)

	if self.game_timer_ui then
		self.game_timer_ui:set_visible(visible)
	end

	if self.endurance_badge_ui then
		self.endurance_badge_ui:set_visible(visible)
	end

	local difficulty_unlock_ui = self.difficulty_unlock_ui

	if difficulty_unlock_ui then
		difficulty_unlock_ui.set_visible(difficulty_unlock_ui, visible)
	end

	local difficulty_notification_ui = self.difficulty_notification_ui

	if difficulty_notification_ui then
		difficulty_notification_ui.set_visible(difficulty_notification_ui, visible)
	end

	if self.boon_ui then
		self.boon_ui:set_visible(visible)
	end

	if self.contract_log_ui then
		self.contract_log_ui:set_visible(visible)
	end

	if self.tutorial_ui then
		self.tutorial_ui:set_visible(visible)
	end

	return 
end
IngameHud.is_own_player_dead = function (self)
	local peer_id = self.peer_id
	local my_player = self.player_manager:player_from_peer_id(peer_id)
	local player_unit = my_player.player_unit

	if not player_unit or not Unit.alive(player_unit) then
		return true
	else
		local status_extension = ScriptUnit.extension(player_unit, "status_system")

		return status_extension.is_ready_for_assisted_respawn(status_extension)
	end

	return 
end
IngameHud._update_survival_ui = function (self, dt, t)
	local game_timer_ui = self.game_timer_ui

	if game_timer_ui then
		local mission_system = self.mission_system
		local active_missions, completed_missions = mission_system.get_missions(mission_system)

		if active_missions then
			local mission_data = active_missions.survival_wave

			if mission_data then
				Profiler.start("game timer")
				game_timer_ui.update(game_timer_ui, dt, mission_data)
				Profiler.stop()
				Profiler.start("endurance badges")

				local endurance_badge_ui = self.endurance_badge_ui

				if endurance_badge_ui then
					endurance_badge_ui.update(endurance_badge_ui, dt)
				end

				Profiler.stop()
				Profiler.start("Difficulty unlock")

				local difficulty_unlock_ui = self.difficulty_unlock_ui

				if difficulty_unlock_ui then
					difficulty_unlock_ui.update(difficulty_unlock_ui, dt, mission_data)
				end

				Profiler.stop()
				Profiler.start("Difficulty notification")

				local difficulty_notification_ui = self.difficulty_notification_ui

				if difficulty_notification_ui then
					difficulty_notification_ui.update(difficulty_notification_ui, dt, mission_data)
				end

				Profiler.stop()
			end
		end
	end

	return 
end
IngameHud.update = function (self, dt, t, active_cutscene)
	Profiler.start("IngameHud")

	local ui_scenegraph = self.ui_scenegraph
	local peer_id = self.peer_id
	local my_player = self.player_manager:player_from_peer_id(peer_id)
	local is_own_player_dead = self.is_own_player_dead(self)
	local gift_popup_ui = self.gift_popup_ui

	if not self.input_helper_ui.active then
		gift_popup_ui.update(gift_popup_ui, dt, t)
	end

	local gift_popup_active = gift_popup_ui.active(gift_popup_ui)
	local input_service = self.input_manager:get_service("ingame_menu")
	local ui_renderer = self.ui_renderer

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if my_player then
		Profiler.start("subtitle_gui")
		self.subtitle_gui:update(dt)
		Profiler.stop()

		if not active_cutscene then
			Profiler.start("damage_indicator_gui")
			self.damage_indicator_gui:update(dt)
			Profiler.stop()
		end
	end

	UIRenderer.end_pass(ui_renderer)

	local show_hud = not is_own_player_dead and not active_cutscene and not gift_popup_active

	if show_hud ~= self.show_hud then
		self.set_visible(self, show_hud)
	end

	self.show_hud = show_hud

	if not active_cutscene and not gift_popup_active then
		self._update_survival_ui(self, dt, t)
		Profiler.start("Player List")

		local ingame_player_list_ui = self.ingame_player_list_ui

		ingame_player_list_ui.update(ingame_player_list_ui, dt)
		Profiler.stop()
		Profiler.start("Voting")
		self.ingame_voting_ui:update(dt, t)
		Profiler.stop()
		Profiler.start("Wait For Rescue")
		self.wait_for_rescue_ui:update(dt, t)
		Profiler.stop()
		Profiler.start("Input Helper")

		local input_helper_ui = self.input_helper_ui

		input_helper_ui.update(input_helper_ui, dt, t)
		Profiler.stop()
		Profiler.start("Observer")
		self.observer_ui:update(dt, t, is_own_player_dead, self.is_in_inn)
		Profiler.stop()

		if not is_own_player_dead then
			Profiler.start("Unit Frames")
			self.unit_frames:update(dt, t, my_player)
			Profiler.stop()
			Profiler.start("Player Inventory")
			self.player_inventory_ui:update(dt, t, my_player)
			Profiler.stop()
			Profiler.start("Interaction")
			self.interaction_ui:update(dt, t, my_player)
			Profiler.stop()
			Profiler.start("Crosshair")
			self.crosshair:update(dt)
			Profiler.stop()
			Profiler.start("Fatigue")
			self.fatigue_ui:update(dt)
			Profiler.stop()
			Profiler.start("Bonus Dice")
			self.bonus_dice_ui:update(dt)
			Profiler.stop()
			Profiler.start("Positive Reinforcement Messages")
			self.positive_reinforcement_ui:update(dt, t)
			Profiler.stop()

			if self.boon_ui then
				Profiler.start("Boon UI")
				self.boon_ui:update(dt, t)
				Profiler.stop()
			end

			if self.contract_log_ui then
				Profiler.start("Contract Log")
				self.contract_log_ui:update(dt, t)
				Profiler.stop()
			end
		end
	else
		self.observer_ui:update(dt, t, false, false)
	end

	if not is_own_player_dead and not gift_popup_active then
		Profiler.start("mission_objective")
		self.mission_objective:update(dt)
		Profiler.stop()
	end

	Profiler.start("area_indicator")
	self.area_indicator:update(dt)
	Profiler.stop()
	Profiler.start("News Ticker")
	self.ingame_news_ticker_ui:update(dt, t)
	Profiler.stop()
	Profiler.start("gdc")

	if self.gdc_build then
		self.gdc_start_ui:update(dt)
	end

	Profiler.stop()
	Profiler.stop()

	return 
end
IngameHud.post_update = function (self, dt, t, active_cutscene)
	Profiler.start("Tutorial")
	self.tutorial_ui:update(dt, t)
	Profiler.stop()

	if not self.input_helper_ui.active then
		self.gift_popup_ui:post_update(dt, t)
	end

	return 
end

return 
