require("scripts/managers/game_mode/game_modes/game_mode_base")

GameModeInn = class(GameModeInn, GameModeBase)
GameModeInn.init = function (self, settings, world, ...)
	GameModeInn.super.init(self, settings, world, ...)

	return 
end
GameModeInn.evaluate_end_conditions = function (self, round_started)
	if self._level_completed then
		return true, "start_game"
	else
		return false
	end

	return 
end

return 
