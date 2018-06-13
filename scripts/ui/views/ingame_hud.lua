require("scripts/ui/views/subtitle_gui")
require("scripts/ui/views/damage_indicator_gui")
require("scripts/ui/views/tutorial_ui")
require("scripts/ui/views/interaction_ui")
require("scripts/ui/views/area_indicator_ui")
require("scripts/ui/views/mission_objective_ui")
require("scripts/ui/views/crosshair_ui")
require("scripts/ui/views/fatigue_ui")
require("scripts/ui/views/player_inventory_ui")
require("scripts/ui/views/bonus_dice_ui")
require("scripts/ui/views/gdc_start_ui")
require("scripts/ui/views/ingame_player_list_ui")
require("scripts/ui/hud_ui/wait_for_rescue_ui")
require("scripts/ui/views/positive_reinforcement_ui")
require("scripts/ui/hud_ui/observer_ui")
require("scripts/ui/hud_ui/ingame_news_ticker_ui")
require("scripts/ui/hud_ui/game_timer_ui")
require("scripts/ui/hud_ui/endurance_badge_ui")
require("scripts/ui/hud_ui/difficulty_unlock_ui")
require("scripts/ui/hud_ui/difficulty_notification_ui")
require("scripts/ui/hud_ui/gamepad_consumable_ui")
require("scripts/ui/hud_ui/unit_frames_handler")
require("scripts/ui/hud_ui/boon_ui")
require("scripts/ui/hud_ui/contract_log_ui")
require("scripts/ui/hud_ui/overcharge_bar_ui")
require("scripts/ui/gift_popup/gift_popup_ui")

local definitions = local_require("scripts/ui/views/ingame_hud_definitions")
IngameHud = class(IngameHud)

IngameHud.init = function (self, ingame_ui_context)
	self.is_in_inn = ingame_ui_context.is_in_inn
	local cutscene_system = Managers.state.entity:system("cutscene_system")
	self.cutscene_system = cutscene_system
	self.gdc_build = Development.parameter("gdc")
	ingame_ui_context.cleanui = UICleanUI.create()
	self.cleanui = ingame_ui_context.cleanui
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager

	self:create_ui_elements()

	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager
	self.mission_system = Managers.state.entity:system("mission_system")
	self.subtitle_gui = SubtitleGui:new(ingame_ui_context)
	self.damage_indicator_gui = DamageIndicatorGui:new(ingame_ui_context)
	self.interaction_ui = InteractionUI:new(ingame_ui_context)
	self.tutorial_ui = TutorialUI:new(ingame_ui_context)
	self.area_indicator = AreaIndicatorUI:new(ingame_ui_context)
	self.mission_objective = MissionObjectiveUI:new(ingame_ui_context)
	self.crosshair = CrosshairUI:new(ingame_ui_context)
	self.fatigue_ui = FatigueUI:new(ingame_ui_context)
	self.bonus_dice_ui = BonusDiceUI:new(ingame_ui_context)
	self.ingame_player_list_ui = IngamePlayerListUI:new(ingame_ui_context)
	self.wait_for_rescue_ui = WaitForRescueUI:new(ingame_ui_context)
	self.positive_reinforcement_ui = PositiveReinforcementUI:new(ingame_ui_context)
	self.observer_ui = ObserverUI:new(ingame_ui_context)
	self.overcharge_bar_ui = OverchargeBarUI:new(ingame_ui_context)

	if PLATFORM == "win32" then
		self.player_inventory_ui = PlayerInventoryUI:new(ingame_ui_context)
	end

	if not script_data.disable_news_ticker then
		self.ingame_news_ticker_ui = IngameNewsTickerUI:new(ingame_ui_context)
	end

	self.gift_popup_ui = GiftPopupUI:new(ingame_ui_context)
	self.unit_frames_handler = UnitFramesHandler:new(ingame_ui_context)
	local game_mode_key = Managers.state.game_mode:game_mode_key()
	self.boon_ui = BoonUI:new(ingame_ui_context)
	local backend_settings = GameSettingsDevelopment.backend_settings

	if backend_settings.quests_enabled then
		self.contract_log_ui = ContractLogUI:new(ingame_ui_context)
	end

	if game_mode_key == "survival" then
		self.game_timer_ui = GameTimerUI:new(ingame_ui_context)
		self.difficulty_unlock_ui = DifficultyUnlockUI:new(ingame_ui_context)
		self.difficulty_notification_ui = DifficultyNotificationUI:new(ingame_ui_context)
	end

	if self.gdc_build then
		self.gdc_start_ui = GDCStartUI:new(ingame_ui_context)
	end
end

IngameHud.destroy = function (self)
	if self.unit_frames_handler then
		self.unit_frames_handler:destroy()
	end

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
	self.area_indicator:destroy()
	self.mission_objective:destroy()
	self.crosshair:destroy()
	self.fatigue_ui:destroy()

	if self.player_inventory_ui then
		self.player_inventory_ui:destroy()
	end

	self.overcharge_bar_ui:destroy()
	self.bonus_dice_ui:destroy()
	self.ingame_player_list_ui:destroy()
	self.wait_for_rescue_ui:destroy()
	self.positive_reinforcement_ui:destroy()
	self.observer_ui:destroy()

	if self.gdc_build then
		self.gdc_start_ui:destroy()
	end

	self.gift_popup_ui:destroy()
end

IngameHud.create_ui_elements = function (self)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
end

IngameHud.set_visible = function (self, visible)
	if self.player_inventory_ui then
		self.player_inventory_ui:set_visible(visible)
	end

	if self.unit_frames_handler then
		self.unit_frames_handler:set_visible(visible)
	end

	if self.game_timer_ui then
		self.game_timer_ui:set_visible(visible)
	end

	if self.endurance_badge_ui then
		self.endurance_badge_ui:set_visible(visible)
	end

	local difficulty_unlock_ui = self.difficulty_unlock_ui

	if difficulty_unlock_ui then
		difficulty_unlock_ui:set_visible(visible)
	end

	local difficulty_notification_ui = self.difficulty_notification_ui

	if difficulty_notification_ui then
		difficulty_notification_ui:set_visible(visible)
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

	local observer_ui = self.observer_ui

	if observer_ui then
		local observer_ui_visibility = self:is_own_player_dead() and not self.ingame_player_list_ui.active and visible

		if observer_ui and observer_ui:is_visible() ~= observer_ui_visibility then
			observer_ui:set_visible(observer_ui_visibility)
		end
	end
end

IngameHud.is_own_player_dead = function (self)
	local peer_id = self.peer_id
	local my_player = self.player_manager:player_from_peer_id(peer_id)
	local player_unit = my_player and my_player.player_unit

	if not player_unit or not Unit.alive(player_unit) then
		return true
	else
		local status_extension = ScriptUnit.extension(player_unit, "status_system")

		return status_extension:is_ready_for_assisted_respawn()
	end
end

IngameHud._update_survival_ui = function (self, dt, t)
	local game_timer_ui = self.game_timer_ui

	if game_timer_ui then
		local mission_system = self.mission_system
		local active_missions, completed_missions = mission_system:get_missions()

		if active_missions then
			local mission_data = active_missions.survival_wave

			if mission_data then
				Profiler.start("game timer")
				game_timer_ui:update(dt, mission_data)
				Profiler.stop("game timer")
				Profiler.start("endurance badges")

				local endurance_badge_ui = self.endurance_badge_ui

				if endurance_badge_ui then
					endurance_badge_ui:update(dt)
				end

				Profiler.stop("endurance badges")
				Profiler.start("Difficulty notification")

				local difficulty_notification_ui = self.difficulty_notification_ui
				local active_presentation = false

				if difficulty_notification_ui then
					difficulty_notification_ui:update(dt, mission_data)

					active_presentation = difficulty_notification_ui:is_presentation_active()
				end

				Profiler.stop("Difficulty notification")
				Profiler.start("Difficulty unlock")

				local difficulty_unlock_ui = self.difficulty_unlock_ui

				if difficulty_unlock_ui then
					difficulty_unlock_ui:update(dt, mission_data, active_presentation)
				end

				Profiler.stop("Difficulty unlock")
			end
		end
	end
end

IngameHud.is_cutscene_active = function (self)
	local cutscene_system = self.cutscene_system

	return cutscene_system.active_camera and not cutscene_system.ingame_hud_enabled
end

IngameHud.update = function (self, dt, t, menu_active)
	Profiler.start("IngameHud")

	local active_cutscene = self:is_cutscene_active()
	local ui_scenegraph = self.ui_scenegraph
	local peer_id = self.peer_id
	local my_player = self.player_manager:player_from_peer_id(peer_id)

	Profiler.start("Access Player Extensions")

	local my_inventory_extension = nil
	local player_unit = my_player and my_player.player_unit

	if player_unit then
		my_inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
	end

	Profiler.stop("Access Player Extensions")

	local is_own_player_dead = self:is_own_player_dead()
	local gift_popup_ui = self.gift_popup_ui

	if not menu_active then
		gift_popup_ui:update(dt, t)
	end

	local gift_popup_active = gift_popup_ui:active()
	local input_manager = self.input_manager
	local gamepad_active = input_manager:is_device_active("gamepad")
	local input_service = input_manager:get_service("ingame_menu")
	local ui_renderer = self.ui_renderer

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UICleanUI.update(self.cleanui, dt)

	if my_player then
		Profiler.start("subtitle_gui")
		self.subtitle_gui:update(dt)
		Profiler.stop("subtitle_gui")

		if not active_cutscene then
			Profiler.start("damage_indicator_gui")
			self.damage_indicator_gui:update(dt)
			Profiler.stop("damage_indicator_gui")
		end
	end

	UIRenderer.end_pass(ui_renderer)

	local gamepad_player_list_active = self.ingame_player_list_ui.active and gamepad_active
	local show_hud = not is_own_player_dead and not active_cutscene and not gift_popup_active and not gamepad_player_list_active

	if show_hud ~= self.show_hud then
		self:set_visible(show_hud)
	end

	self.show_hud = show_hud

	if show_hud then
		self:_update_survival_ui(dt, t)
		Profiler.start("Wait For Rescue")
		self.wait_for_rescue_ui:update(dt, t)
		Profiler.stop("Wait For Rescue")
		Profiler.start("Unit Frames")

		if self.unit_frames_handler then
			self.unit_frames_handler:update(dt, t, my_player)
		end

		Profiler.stop("Unit Frames")

		if self.player_inventory_ui then
			Profiler.start("Player Inventory")
			self.player_inventory_ui:update(dt, t, my_player)
			Profiler.stop("Player Inventory")
		end

		Profiler.start("Overcharge Bar")
		self.overcharge_bar_ui:update(dt, t, my_player)
		Profiler.stop("Overcharge Bar")
		Profiler.start("Interaction")
		self.interaction_ui:update(dt, t, my_player)
		Profiler.stop("Interaction")
		Profiler.start("Crosshair")
		self.crosshair:update(dt)
		Profiler.stop("Crosshair")
		Profiler.start("Fatigue")
		self.fatigue_ui:update(dt)
		Profiler.stop("Fatigue")
		Profiler.start("Bonus Dice")
		self.bonus_dice_ui:update(dt)
		Profiler.stop("Bonus Dice")
		Profiler.start("Positive Reinforcement Messages")
		self.positive_reinforcement_ui:update(dt, t)
		Profiler.stop("Positive Reinforcement Messages")
		Profiler.start("Boon UI")

		if self.boon_ui then
			self.boon_ui:update(dt, t)
		end

		Profiler.stop("Boon UI")
		Profiler.start("Contract Log")

		if self.contract_log_ui then
			self.contract_log_ui:update(dt, t)
		end

		Profiler.stop("Contract Log")
		Profiler.start("mission_objective")
		self.mission_objective:update(dt)
		Profiler.stop("mission_objective")
	end

	local observer_ui_visibility = is_own_player_dead and not self.ingame_player_list_ui.active and not menu_active and not self.is_in_inn
	local observer_ui = self.observer_ui

	if observer_ui and observer_ui:is_visible() ~= observer_ui_visibility then
		observer_ui:set_visible(observer_ui_visibility)
	end

	if not show_hud and observer_ui_visibility then
		Profiler.start("Observer")

		local observer_ui = self.observer_ui

		if observer_ui then
			self.observer_ui:update(dt, t)
		end

		Profiler.stop("Observer")
	end

	Profiler.start("Player List")

	local ingame_player_list_ui = self.ingame_player_list_ui

	ingame_player_list_ui:update(dt)
	Profiler.stop("Player List")
	Profiler.start("area_indicator")
	self.area_indicator:update(dt)
	Profiler.stop("area_indicator")
	Profiler.start("News Ticker")

	if not script_data.disable_news_ticker then
		self.ingame_news_ticker_ui:update(dt, t)
	end

	Profiler.stop("News Ticker")
	Profiler.start("gdc")

	if self.gdc_build then
		self.gdc_start_ui:update(dt)
	end

	Profiler.stop("gdc")
	Profiler.stop("IngameHud")
end

IngameHud.post_update = function (self, dt, t, menu_active)
	local is_own_player_dead = self:is_own_player_dead()

	if not menu_active then
		self.gift_popup_ui:post_update(dt, t)
	end
end

return
