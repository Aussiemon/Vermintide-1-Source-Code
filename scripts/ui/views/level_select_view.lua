require("scripts/settings/level_settings")
require("scripts/settings/level_unlock_settings")

local level_array = {}
local only_release = GameSettingsDevelopment.release_levels_only

for name, data in pairs(LevelSettings) do
	if type(data) == "table" then
		local debug_level = string.match(data.package_name, "resource_packages/levels/debug/")

		if not only_release or not debug_level then
			level_array[#level_array + 1] = name
		end
	end
end

LevelSelectView = class(LevelSelectView)

LevelSelectView.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.level_transition_handler = ingame_ui_context.level_transition_handler
end

local font_size = 26
local font = "gw_arial_32"
local font_mtrl = "materials/fonts/" .. font
local text_color = {
	255,
	255,
	255,
	255
}
local select_color = {
	255,
	0,
	255,
	0
}

LevelSelectView.on_enter = function (self)
	self.input_manager:block_device_except_service("ingame_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("ingame_menu", "mouse", 1)
	self.input_manager:block_device_except_service("ingame_menu", "gamepad", 1)
end

LevelSelectView.update = function (self, dt)
	local current_selection = self.current_selection or 1

	if Keyboard.pressed(Keyboard.button_index("down")) then
		current_selection = current_selection + 1

		if current_selection > #level_array then
			current_selection = 1
		end
	end

	if Keyboard.pressed(Keyboard.button_index("up")) then
		current_selection = current_selection - 1

		if current_selection <= 0 then
			current_selection = #level_array or current_selection
		end
	end

	local screen_width = 1920
	local screen_height = 1080
	local ui_renderer = self.ui_renderer

	for i, name in ipairs(level_array) do
		local level_data = LevelSettings[name]
		local width, height = UIRenderer.text_size(ui_renderer, level_data.display_name, font_mtrl, font_size)
		local x_pos = screen_width / 2 - width / 2
		local y_pos = screen_height - 50 - i * font_size

		UIRenderer.draw_text(ui_renderer, level_data.display_name, font_mtrl, font_size, font, {
			x_pos,
			y_pos,
			999
		}, (current_selection == i and select_color) or text_color)
	end

	self.current_selection = current_selection

	if Keyboard.pressed(Keyboard.button_index("enter")) then
		self.level_transition_handler:set_next_level(level_array[current_selection])
		self.ingame_ui:handle_transition("exit_menu")
	end
end

LevelSelectView.event_enable_level_select = function (self)
	if not Managers.player.is_server then
		return
	end

	local players = Managers.player:players()
	local player = nil

	for _, player_data in pairs(players) do
		if player_data.local_player then
			player = player_data

			break
		end
	end

	if player then
		self.ingame_ui:handle_transition("select_level")
	end
end

return
