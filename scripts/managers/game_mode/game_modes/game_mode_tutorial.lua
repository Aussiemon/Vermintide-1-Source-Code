require("scripts/managers/game_mode/game_modes/game_mode_base")

script_data.disable_gamemode_end = script_data.disable_gamemode_end or Development.parameter("disable_gamemode_end")
GameModeTutorial = class(GameModeTutorial, GameModeBase)
local COMPLETE_LEVEL_VAR = false
local FAIL_LEVEL_VAR = false

GameModeTutorial.init = function (self, settings, world, ...)
	GameModeTutorial.super.init(self, settings, world, ...)

	self.about_to_lose = false
	self.lost_condition_timer = nil
end

GameModeTutorial.evaluate_end_conditions = function (self, round_started, dt, t)
	if COMPLETE_LEVEL_VAR then
		self:complete_level()

		COMPLETE_LEVEL_VAR = false
	end
end

GameModeTutorial.complete_level = function (self)
	print("YAY ITS WORKING")

	self._transition = "finish_tutorial"
end

GameModeTutorial.wanted_transition = function (self)
	return self._transition
end

GameModeTutorial.COMPLETE_LEVEL = function (self)
	COMPLETE_LEVEL_VAR = true
end

GameModeTutorial.FAIL_LEVEL = function (self)
	FAIL_LEVEL_VAR = true
end

return
