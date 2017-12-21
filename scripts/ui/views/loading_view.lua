require("scripts/ui/ui_renderer")
require("scripts/ui/ui_elements")
require("scripts/ui/views/subtitle_timed_gui")

local definitions = local_require("scripts/ui/views/loading_view_definitions")
local DO_RELOAD = true
local survival_tip_list = {
	"dlc1_2_survival_tip_01",
	"dlc1_2_survival_tip_02",
	"dlc1_2_survival_tip_03",
	"dlc1_2_survival_tip_04",
	"dlc1_2_survival_tip_05",
	"dlc1_2_survival_tip_06"
}
local tip_type_prefix_list = {
	tip = "loading_screen_tip",
	ferry_lady = "infoslate_ferry_lady",
	khazalid = "loading_screen_khazalid",
	lore = "loading_screen_lore"
}
local tip_type_max_range = {
	tip = 42,
	ferry_lady = 2,
	khazalid = 33,
	lore = 41
}
local tip_type_list = {
	"lore",
	"khazalid",
	"tip",
	"ferry_lady"
}
LoadingView = class(LoadingView)
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
LoadingView.init = function (self, ui_context)
	local level_key = ui_context.level_key
	local world = ui_context.world
	local game_difficulty = ui_context.game_difficulty
	local act_progression_index = ui_context.act_progression_index
	self.input_manager = ui_context.input_manager
	self.news_ticker_speed = 100
	self.news_ticker_manager = Managers.news_ticker

	self.news_ticker_manager:refresh_loading_screen_message()

	self.world = world
	self.level_key = level_key
	self.wwise_event = ui_context.wwise_event
	local level_settings = LevelSettings[level_key]
	local loading_image_material = level_settings.loading_bg_image
	local has_multiple_loading_images = level_settings.has_multiple_loading_images
	local game_mode = level_settings.game_mode or "adventure"

	VisualAssertLog.setup(world)

	local bg_material = "materials/ui/loading_screens/" .. loading_image_material

	if has_multiple_loading_images and act_progression_index and 1 <= act_progression_index then
		bg_material = bg_material .. "_" .. act_progression_index
	end

	self.ui_renderer = UIRenderer.create(self.world, "material", bg_material, "material", "materials/fonts/arial", "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts", "material", "materials/ui/ui_1080p_popup", "material", "materials/ui/ui_1080p_chat")

	self.create_ui_elements(self)

	if level_key ~= "inn_level" and level_settings.level_type ~= "survival" then
		self.setup_difficulty_text(self, game_difficulty)
	end

	self.setup_tip_text(self, act_progression_index, game_mode)

	DO_RELOAD = false
	self.active = false

	return 
end
LoadingView.activate = function (self)
	self.active = true

	return 
end
LoadingView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.bg_widget = UIWidget.init(definitions.background_image)
	self.subtitle_widget = UIWidget.init(definitions.subtitle)
	self.tip_title_widget = UIWidget.init(definitions.tip_title_widget)
	self.tip_text_prefix_widget = UIWidget.init(definitions.tip_text_prefix_widget)
	self.tip_text_suffix_widget = UIWidget.init(definitions.tip_text_suffix_widget)
	self.gamepad_input_icon = UIWidget.init(definitions.gamepad_input_icon)
	self.second_row_tip_text_prefix_widget = UIWidget.init(definitions.second_row_tip_text_prefix_widget)
	self.second_row_tip_text_suffix_widget = UIWidget.init(definitions.second_row_tip_text_suffix_widget)
	self.second_row_gamepad_input_icon = UIWidget.init(definitions.second_row_gamepad_input_icon)
	self.news_ticker_text_widget = UIWidget.init(definitions.news_ticker_text_widget)
	self.game_difficulty_widget = UIWidget.init(definitions.game_difficulty_widget)
	self.widgets = {
		self.bg_widget,
		self.tip_title_widget,
		self.tip_text_prefix_widget,
		self.tip_text_suffix_widget,
		self.gamepad_input_icon,
		self.second_row_tip_text_prefix_widget,
		self.second_row_tip_text_suffix_widget,
		self.second_row_gamepad_input_icon,
		self.news_ticker_text_widget,
		self.game_difficulty_widget,
		UIWidget.init(definitions.news_ticker_mask_widget),
		UIWidget.init(definitions.dead_space_filler)
	}
	local subtitle_row_widgets = {}
	local NUM_SUBTITLE_ROWS = definitions.NUM_SUBTITLE_ROWS

	for i = 1, NUM_SUBTITLE_ROWS, 1 do
		local subtitle_row_widget = UIWidget.init(definitions.subtitle_row_widgets[i])
		subtitle_row_widgets[i] = subtitle_row_widget
		self.widgets[#self.widgets + 1] = subtitle_row_widget
	end

	if self.wwise_event then
		self.subtitle_timed_gui = SubtitleTimedGui:new(self.wwise_event, subtitle_row_widgets)
	end

	local level_key = self.level_key
	local level_settings = LevelSettings[level_key]
	self.bg_widget.content.bg_texture = level_settings.loading_bg_image

	return 
end
LoadingView.setup_tip_text = function (self, act_progression_index, game_mode)
	if game_mode == "survival" then
		local text = survival_tip_list[math.random(1, #survival_tip_list)]
		self.tip_text_prefix_widget.content.text = Localize(text)
		self.tip_text_prefix_widget.style.text.horizontal_alignment = "center"
		self.tip_text_prefix_widget.style.text.word_wrap = true
	else
		local index_table = {}

		if act_progression_index and act_progression_index < 4 then
			local tip_count = act_progression_index*2 - 9

			for i = 1, tip_count, 1 do
				index_table[i] = 3
			end

			index_table[#index_table + 1] = 1
			index_table[#index_table + 1] = 2
			index_table[#index_table + 1] = 4
		else
			index_table[#index_table + 1] = 1
			index_table[#index_table + 1] = 1
			index_table[#index_table + 1] = 2
			index_table[#index_table + 1] = 2
			index_table[#index_table + 1] = 3
			index_table[#index_table + 1] = 4
			index_table[#index_table + 1] = 4
		end

		local read_index = math.random(1, #index_table)
		local tip_type_index = index_table[read_index]
		local tip_type = tip_type_list[tip_type_index]
		local tip_prefix = tip_type_prefix_list[tip_type]
		local typ_max_range = tip_type_max_range[tip_type]
		local tip_random_index = math.random(1, typ_max_range)
		local tip_index = (tip_random_index < 10 and "0" .. tostring(tip_random_index)) or tostring(tip_random_index)
		local tip_localization_key = tip_prefix .. "_" .. tip_index
		local input_manager = self.input_manager
		local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")
		local localized_tip = nil

		if gamepad_active then
			local input_action = Managers.localizer:get_input_action(tip_localization_key)

			if input_action then
				local button_texture_data = UISettings.get_gamepad_input_texture_data(input_manager.get_service(input_manager, "Player"), input_action)

				if button_texture_data then
					local macro_replacement = "______"
					localized_tip = Managers.localizer:replace_macro_in_string(tip_localization_key, macro_replacement)

					if string.find(localized_tip, "%[") then
						localized_tip = string.gsub(localized_tip, "%[", "")
					end

					if string.find(localized_tip, "%]") then
						localized_tip = string.gsub(localized_tip, "%]", "")
					end

					local start_index, end_index = string.find(localized_tip, macro_replacement)
					local prefix_text = string.sub(localized_tip, 1, start_index - 1)
					local suffix_text = string.sub(localized_tip, end_index + 1)
					local text_tip_widget_style = self.tip_text_prefix_widget.style.text
					local font, scaled_font_size = UIFontByResolution(text_tip_widget_style)
					local prefix_text_width = UIRenderer.text_size(self.ui_renderer, prefix_text, font[1], scaled_font_size)
					local icon_width = button_texture_data.size[1]
					local suffix_text_width = UIRenderer.text_size(self.ui_renderer, suffix_text, font[1], scaled_font_size)
					local total_width = prefix_text_width + icon_width + suffix_text_width
					local prefix_text_offset = (-total_width*0.5 + prefix_text_width*0.5) - icon_width*0.5
					local input_icon_offset = -total_width*0.5 + prefix_text_width + icon_width*0.05
					local suffix_text_offset = -total_width*0.5 + prefix_text_width + icon_width*0.5 + suffix_text_width*0.5

					if definitions.MAXIMUM_TIP_WIDTH < prefix_text_width then
						local text_rows = UIRenderer.word_wrap(self.ui_renderer, prefix_text, font[1], scaled_font_size, definitions.MAXIMUM_TIP_WIDTH)
						prefix_text = text_rows[2]
						prefix_text_width = UIRenderer.text_size(self.ui_renderer, prefix_text, font[1], scaled_font_size)
						total_width = prefix_text_width + icon_width + suffix_text_width
						prefix_text_offset = (-total_width*0.5 + prefix_text_width*0.5) - icon_width*0.5
						input_icon_offset = -total_width*0.5 + prefix_text_width + icon_width*0.05
						suffix_text_offset = -total_width*0.5 + prefix_text_width + icon_width*0.5 + suffix_text_width*0.5
						self.tip_text_prefix_widget.content.text = text_rows[1]
						self.tip_text_prefix_widget.style.text.horizontal_alignment = "center"
						self.tip_text_prefix_widget.style.text.word_wrap = true
						self.second_row_tip_text_prefix_widget.style.text.offset[1] = prefix_text_offset
						self.second_row_gamepad_input_icon.style.texture_id.offset[1] = input_icon_offset
						self.second_row_tip_text_suffix_widget.style.text.offset[1] = suffix_text_offset
						self.tip_text_prefix_widget.style.text.offset[2] = 11
						self.second_row_tip_text_prefix_widget.style.text.offset[2] = 11
						self.second_row_gamepad_input_icon.style.texture_id.offset[2] = 11
						self.second_row_tip_text_suffix_widget.style.text.offset[2] = 11
						self.second_row_tip_text_prefix_widget.content.text = prefix_text
						self.second_row_gamepad_input_icon.content.texture_id = button_texture_data.texture
						self.second_row_tip_text_suffix_widget.content.text = suffix_text
						self.ui_scenegraph.second_row_tip_text_prefix.size[1] = prefix_text_width
						self.ui_scenegraph.second_row_gamepad_input_icon.size = button_texture_data.size
						self.ui_scenegraph.second_row_tip_text_suffix.size[1] = suffix_text_width
					elseif definitions.MAXIMUM_TIP_WIDTH < suffix_text_width then
						local text_rows = UIRenderer.word_wrap(self.ui_renderer, suffix_text, font[1], scaled_font_size, definitions.MAXIMUM_TIP_WIDTH - prefix_text_width - icon_width)
						suffix_text = text_rows[1]
						suffix_text_width = UIRenderer.text_size(self.ui_renderer, suffix_text, font[1], scaled_font_size)
						total_width = prefix_text_width + icon_width + suffix_text_width
						prefix_text_offset = (-total_width*0.5 + prefix_text_width*0.5) - icon_width*0.5
						input_icon_offset = -total_width*0.5 + prefix_text_width + icon_width*0.05
						suffix_text_offset = -total_width*0.5 + prefix_text_width + icon_width*0.5 + suffix_text_width*0.5
						self.second_row_tip_text_prefix_widget.content.text = text_rows[2]
						self.second_row_tip_text_prefix_widget.style.text.horizontal_alignment = "center"
						self.second_row_tip_text_prefix_widget.style.text.word_wrap = true
						self.tip_text_prefix_widget.style.text.offset[1] = prefix_text_offset
						self.gamepad_input_icon.style.texture_id.offset[1] = input_icon_offset
						self.tip_text_suffix_widget.style.text.offset[1] = suffix_text_offset
						self.second_row_tip_text_prefix_widget.style.text.offset[2] = 11
						self.tip_text_prefix_widget.style.text.offset[2] = 11
						self.gamepad_input_icon.style.texture_id.offset[2] = 11
						self.tip_text_suffix_widget.style.text.offset[2] = 11
						self.tip_text_prefix_widget.content.text = prefix_text
						self.gamepad_input_icon.content.texture_id = button_texture_data.texture
						self.tip_text_suffix_widget.content.text = suffix_text
						self.ui_scenegraph.tip_text_prefix.size[1] = prefix_text_width
						self.ui_scenegraph.gamepad_input_icon.size = button_texture_data.size
						self.ui_scenegraph.tip_text_suffix.size[1] = suffix_text_width
					else
						self.ui_scenegraph.tip_text_prefix.size[1] = prefix_text_width
						self.ui_scenegraph.gamepad_input_icon.size = button_texture_data.size
						self.ui_scenegraph.tip_text_suffix.size[1] = suffix_text_width
						self.tip_text_prefix_widget.style.text.offset[1] = prefix_text_offset
						self.gamepad_input_icon.style.texture_id.offset[1] = input_icon_offset
						self.tip_text_suffix_widget.style.text.offset[1] = suffix_text_offset
						self.tip_text_prefix_widget.content.text = prefix_text
						self.gamepad_input_icon.content.texture_id = button_texture_data.texture
						self.tip_text_suffix_widget.content.text = suffix_text
					end
				end
			end
		end

		if not localized_tip then
			localized_tip = Localize(tip_localization_key)
			self.tip_text_prefix_widget.content.text = localized_tip
			self.tip_text_prefix_widget.style.text.horizontal_alignment = "center"
			self.tip_text_prefix_widget.style.text.word_wrap = true
		end
	end

	return 
end
LoadingView.setup_act_text = function (self, level_key)
	local level_act_key = nil

	for act_key, act_levels in pairs(GameActs) do
		if table.find(act_levels, level_key) then
			level_act_key = act_key

			break
		end
	end

	local act_text = ""

	if level_act_key then
		local act_text_key = GameActsDisplayNames[level_act_key]
		act_text = Localize(act_text_key)
	end

	self.act_title_widget.content.text = act_text

	return 
end
LoadingView.setup_difficulty_text = function (self, game_difficulty)
	if game_difficulty then
		local difficulty_settings = DifficultySettings[game_difficulty]
		local display_name = difficulty_settings.display_name
		local prefix_text = Localize("prefix_difficulty") .. ":"
		self.game_difficulty_widget.content.text = prefix_text .. " " .. Localize(display_name)
	end

	return 
end
LoadingView.setup_news_ticker = function (self, text)
	local widget = self.news_ticker_text_widget
	local widget_content = widget.content
	local widget_style = widget.style
	widget_content.text = text
	local text_style = widget_style.text
	local font_type = text_style.font_type
	local font, scaled_font_size = UIFontByResolution(text_style)
	local fonts = DynamicFonts[font_type]
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, text, font[1], scaled_font_size)
	self.news_ticker_text_width = text_width
	self.news_ticker_started = true

	return 
end
LoadingView.update = function (self, dt)
	if not self.active then
		return 
	end

	VisualAssertLog.update(dt)

	local news_ticker_started = self.news_ticker_started

	if not news_ticker_started then
		local news_ticker_text = self.news_ticker_manager:loading_screen_text()

		if news_ticker_text then
			self.setup_news_ticker(self, news_ticker_text)
		end
	end

	if DO_RELOAD then
		DO_RELOAD = false

		self.create_ui_elements(self)
	end

	if self.subtitle_timed_gui then
		self.subtitle_timed_gui:update(dt)
	end

	self.draw(self, dt)

	return 
end
LoadingView.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local news_ticker_started = self.news_ticker_started

	if news_ticker_started then
		local news_ticker_widget_position = ui_scenegraph.news_ticker_text.local_position

		if news_ticker_widget_position[1] + self.news_ticker_text_width <= 0 then
			news_ticker_widget_position[1] = 1920
		end

		news_ticker_widget_position[1] = news_ticker_widget_position[1] - dt*self.news_ticker_speed
	end

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, fake_input_service, dt)

	for i = 1, #self.widgets, 1 do
		UIRenderer.draw_widget(ui_renderer, self.widgets[i])
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
LoadingView.destroy = function (self)
	VisualAssertLog.cleanup()
	UIRenderer.destroy(self.ui_renderer, self.world)

	return 
end
LoadingView.is_done = function (self)
	return true
end

return 
