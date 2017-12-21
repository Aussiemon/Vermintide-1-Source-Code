require("scripts/managers/game_mode/game_modes/game_mode_base")

script_data.disable_gamemode_end = script_data.disable_gamemode_end or Development.parameter("disable_gamemode_end")
GameModeCoop = class(GameModeCoop, GameModeBase)
GameModeCoop.init = function (self, settings, world, ...)
	GameModeCoop.super.init(self, settings, world, ...)

	self.about_to_lose = false
	self.lost_condition_timer = nil

	return 
end
GameModeCoop.evaluate_end_conditions = function (self, round_started, dt, t)
	if script_data.disable_gamemode_end then
		return false
	end

	local spawn_manager = Managers.state.spawn
	local humans_dead = spawn_manager.all_humans_dead(spawn_manager)
	local players_disabled = spawn_manager.all_players_disabled(spawn_manager)
	local lost = humans_dead or players_disabled or self._level_failed

	if self.about_to_lose then
		if lost then
			if self.lost_condition_timer < t then
				return true, "lost"
			else
				return false
			end
		else
			self.about_to_lose = nil
			self.lost_condition_timer = nil
		end
	end

	if lost then
		self.about_to_lose = true
		self.lost_condition_timer = t + GameModeSettings.coop.lose_condition_time
	elseif self._level_completed and not self.level_complete_timer then
		self.level_complete_timer = t + 0.4

		return false
	elseif self._level_completed and self.level_complete_timer <= t then
		self.level_complete_timer = nil

		return true, "won"
	else
		return false
	end

	return 
end

return 
