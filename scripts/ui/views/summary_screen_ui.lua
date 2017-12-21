require("scripts/settings/progression_unlocks")
require("scripts/ui/reward_ui/reward_popup_handler")

local definitions = local_require("scripts/ui/views/summary_screen_ui_definitions")
local get_atlas_settings_by_texture_name = UIAtlasHelper.get_atlas_settings_by_texture_name
local NUM_OF_SUMMARY_WIDGETS = 7
local SUMMARY_WIDGET_SPACING = 5
local NUM_OF_BONUS_WIDGETS = 10
local bar_glow_textures = {
	"glow_effect_01",
	"glow_effect_02",
	"glow_effect_03"
}
local REWARD_SCREEN_STATES = {
	"intro",
	"preperation",
	"open",
	"reward_text_in",
	"waiting",
	"reward_text_out",
	"close",
	"exit"
}
local dice_textures = {
	gold = "dice_04",
	metal = "dice_02",
	warpstone = "dice_05",
	wood = "dice_01"
}
SummaryScreenUI = class(SummaryScreenUI)
SummaryScreenUI.init = function (self, end_of_level_ui_context)
	self.ui_renderer = end_of_level_ui_context.ui_renderer
	self.timers = {}
	self.ui_animations = {}
	local game_won = end_of_level_ui_context.game_won
	local game_mode_key = Managers.state.game_mode:game_mode_key()
	self.game_won = game_won
	self.game_mode_key = game_mode_key
	self.rewards = end_of_level_ui_context.rewards
	self._reward_stack = {}
	self.dice_roller = end_of_level_ui_context.dice_roller
	local input_manager = end_of_level_ui_context.input_manager
	self.world_manager = end_of_level_ui_context.world_manager
	self.input_manager = input_manager
	self.last_level_key = end_of_level_ui_context.last_level_key

	input_manager.create_input_service(input_manager, "summary_screen_ui", IngameMenuKeymaps)
	input_manager.map_device_to_service(input_manager, "summary_screen_ui", "keyboard")
	input_manager.map_device_to_service(input_manager, "summary_screen_ui", "mouse")
	input_manager.map_device_to_service(input_manager, "summary_screen_ui", "gamepad")
	rawset(_G, "SummaryScreenUI_pointer", self)
	self.create_ui_elements(self)

	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	self.item_reward_popup = RewardPopupHandler:new(self.input_manager, self.ui_renderer, 2, "summary_screen_ui")

	return 
end
SummaryScreenUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph)
	self.summary_window_widget = UIWidget.init(definitions.widgets.summary_window)
	self.experience_window_widget = UIWidget.init(definitions.widgets.experience_bars_window)
	self.experience_bar_hero_widget = UIWidget.init(definitions.widgets.experience_bar_hero)
	self.reward_widget = UIWidget.init(definitions.widgets.reward_widget)
	self.summary_entries_mask_widget = UIWidget.init(definitions.widgets.summary_entries_mask_widget)
	self.summary_entries_top_mask_widget = UIWidget.init(definitions.widgets.summary_entries_top_mask_widget)
	self.summary_entries_top_mask_widget.style.texture_id.color[1] = 0
	local bonus_widgets = {}
	local bonus_widgets_definitions = definitions.bonus_widgets

	for i = 1, NUM_OF_BONUS_WIDGETS, 1 do
		bonus_widgets[i] = UIWidget.init(bonus_widgets_definitions[i])
	end

	self.bonus_widgets = bonus_widgets
	local summary_widgets = {}
	local summary_widgets_definitions = definitions.summary_widgets
	local num_summary_widgets = #summary_widgets_definitions

	for i = 1, num_summary_widgets, 1 do
		summary_widgets[i] = UIWidget.init(summary_widgets_definitions[i])
	end

	self.summary_widgets = summary_widgets

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
SummaryScreenUI.update = function (self, dt)
	if not self.is_active then
		return 
	elseif self.is_complete then
		self.is_active = nil
	end

	self.skip_current_step(self)
	self.update_timers(self, dt)

	if self.timer_done(self, "start_timer") then
		self.playing = true

		self.remove_timer(self, "start_timer")
		self.tween_in(self)
	end

	self.update_summary_screen(self, dt)
	self.update_bar_progress(self)

	if self.reward_widget_open_animation_time then
		self.reward_widget_open_animation_time = self.update_reward_screen_animations(self, self.reward_widget_open_animation_time, dt)
	end

	if self.playing then
		self.draw(self, dt)
	end

	if self.draw_item_popup then
		self.item_reward_popup:update(dt)

		if self.item_reward_popup:is_animation_completed() then
			self.on_hide_item_popup(self)
		end
	end

	return 
end
SummaryScreenUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("summary_screen_ui")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
	UIRenderer.draw_widget(ui_renderer, self.summary_window_widget)
	UIRenderer.draw_widget(ui_renderer, self.experience_window_widget)
	UIRenderer.draw_widget(ui_renderer, self.summary_entries_mask_widget)
	UIRenderer.draw_widget(ui_renderer, self.summary_entries_top_mask_widget)
	UIRenderer.draw_widget(ui_renderer, self.experience_bar_hero_widget)
	self.update_bar_glow_locations(self, dt)

	if self.show_reward_widget then
		UIRenderer.draw_widget(ui_renderer, self.reward_widget)

		local size = UISceneGraph.get_size_scaled(ui_scenegraph, "screen")

		UIRenderer.draw_texture(ui_renderer, "gradient_dice_game_reward", Vector3(0, 0, UILayer.end_screen_reward), Vector2(size[1], size[2]))
	end

	local visible_summary_entry_widgets = self.visible_summary_entry_widgets

	if visible_summary_entry_widgets then
		for index, widget in ipairs(visible_summary_entry_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	local visible_bonus_widgets = self.visible_bonus_widgets

	if visible_bonus_widgets then
		for index, widget in ipairs(visible_bonus_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
SummaryScreenUI.input_service = function (self)
	return self.input_manager:get_service("summary_screen_ui")
end
SummaryScreenUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end
SummaryScreenUI.update_bar_glow_locations = function (self, dt)
	local hero_widget = self.experience_bar_hero_widget
	local hero_content = hero_widget.content
	local hero_style = hero_widget.style

	return 
end
SummaryScreenUI.destroy = function (self)
	self.item_reward_popup:destroy()

	self.item_reward_popup = nil
	self.summary_widgets = nil
	self.summary_presentations = nil

	rawset(_G, "SummaryScreenUI_pointer", nil)
	GarbageLeakDetector.register_object(self, "SummaryScreenUI")

	return 
end
SummaryScreenUI.skip_current_step = function (self)
	if self.can_skip then
		local input_service = self.input_manager:get_service("summary_screen_ui")

		if input_service.get(input_service, "skip") then
			self.skip_step = true
		elseif self.skip_step then
			self.skip_step = nil
		end
	end

	return 
end
SummaryScreenUI.on_complete = function (self)
	self.is_complete = true
	self.playing = nil

	return 
end
SummaryScreenUI.active = function (self)
	return self.is_active
end
SummaryScreenUI.on_enter = function (self, ignore_input_blocking)
	self.is_active = true
	local chat_focused = Managers.chat:chat_is_focused()
	local input_manager = self.input_manager

	if not ignore_input_blocking and not chat_focused then
		input_manager.block_device_except_service(input_manager, "summary_screen_ui", "keyboard")
		input_manager.block_device_except_service(input_manager, "summary_screen_ui", "mouse")
		input_manager.block_device_except_service(input_manager, "summary_screen_ui", "gamepad")
	end

	local player_level, experience = self.rewards:get_level_start()
	local backend_manager = Managers.backend

	self.set_experience_bar_by_experience(self, self.experience_bar_hero_widget, experience)

	if self.has_gained_rewards(self) then
		local delay_time = UISettings.summary_screen.start_delay_time

		self.add_timer(self, "start_timer", delay_time, 0, 1)
	else
		self.on_complete(self)
	end

	if self.game_won and self.game_mode_key ~= "survival" then
		local level_key = self.last_level_key
		self.level_up_rewards = self.dice_roller:level_up_rewards()
		self.quests_unlocked_reward = ProgressionUnlocks.get_quests_unlocked(level_key)
	else
		local level_up_rewards, failed_game_rewards = self.rewards:get_upgrades_failed_game()
		self.level_up_rewards = level_up_rewards

		if self.game_mode_key ~= "survival" then
			self.failed_game_rewards = failed_game_rewards
		end
	end

	self._show_failed_game_popup = not self.game_won

	return 
end
SummaryScreenUI.add_bonus = function (self, icon_texture, value)
	if not self.visible_bonus_widgets then
		self.visible_bonus_widgets = {}
		self.bonus_icons_added = {}
	end

	local added_bonus_icons = self.bonus_icons_added
	local bonus_widgets = self.bonus_widgets
	local visible_bonus_widgets = self.visible_bonus_widgets
	local next_bonus_index = added_bonus_icons[icon_texture]
	local initialize = false

	if not next_bonus_index then
		next_bonus_index = #visible_bonus_widgets + 1
		initialize = true
	end

	local bonus_widget = bonus_widgets[next_bonus_index]
	local widget_content = bonus_widget.content
	local icon_settings = get_atlas_settings_by_texture_name(icon_texture)
	local icon_default_size = icon_settings.size

	if initialize then
		visible_bonus_widgets[next_bonus_index] = bonus_widget
		added_bonus_icons[icon_texture] = next_bonus_index
		local widget_style = bonus_widget.style
		local icon_scenegraph_id = widget_style.icon_texture.scenegraph_id
		local icon_size = self.ui_scenegraph[icon_scenegraph_id].size
		icon_size[1] = icon_default_size[1]
		icon_size[2] = icon_default_size[2]
	end

	local total_value = widget_content.value + value
	widget_content.icon_texture = icon_texture
	widget_content.value_text = "x" .. tostring(total_value)
	widget_content.value = total_value

	self.tween_in_bonus_widget(self, "bonus_icon_" .. next_bonus_index, bonus_widget, initialize, icon_default_size)
	self.play_sound(self, "Play_hud_end_screen_unlock_dice")

	return 
end
SummaryScreenUI.add_bar_progress = function (self, bar_name, current_experience, widget, experience_gained)
	if not self.bar_progress_data then
		self.bar_progress_data = {}
	end

	local min_time = UISettings.summary_screen.bar_progress_min_time
	local max_time = UISettings.summary_screen.bar_progress_max_time
	local time_multiplier = UISettings.summary_screen.bar_progress_experience_time_multiplier
	local time = math.min(math.max(time_multiplier*experience_gained, min_time), max_time)
	local total_experience = current_experience + experience_gained
	local current_level, start_progress = ExperienceSettings.get_level(current_experience)
	local resulting_level, end_progress = ExperienceSettings.get_level(total_experience)
	local progress_length = math.max(0, resulting_level - current_level - 1)
	progress_length = (resulting_level - current_level + end_progress) - start_progress
	local progress_data = {
		name = bar_name,
		widget = widget,
		current_level = current_level,
		experience_to_add = experience_gained,
		total_progress = progress_length,
		start_progress = start_progress
	}
	self.bar_progress_data[#self.bar_progress_data + 1] = progress_data

	self.add_timer(self, bar_name, time, 0, 1)
	self.play_sound(self, "Play_hud_end_screen_big_counter_loop")

	return 
end
SummaryScreenUI.update_bar_progress = function (self)
	local bar_progress_data = self.bar_progress_data

	if not bar_progress_data then
		return 
	end

	local reward_added = false

	for index, bar_data in ipairs(bar_progress_data) do
		local name = bar_data.name
		local progress = self.get_timer_progress(self, name)
		local smoothstep = self.get_timer_smoothstep(self, name)

		if progress and 0 < progress and not self.timer_paused(self, name) then
			local bar_widget = bar_data.widget
			local current_level = bar_data.current_level
			local experience_to_add = bar_data.experience_to_add
			local widget_content = bar_widget.content
			local widget_style = bar_widget.style
			local last_bar_fraction = bar_data.last_bar_fraction
			local start_progress = bar_data.start_progress
			local total_progress = bar_data.total_progress
			local bar_fraction = math.max(0, math.min((start_progress + smoothstep*total_progress)%1, 1))

			if last_bar_fraction and bar_fraction < last_bar_fraction then
				current_level = current_level + 1
				bar_data.current_level = current_level
				local level_up_rewards = self.level_up_rewards
				local unlock_template = ProgressionUnlocks.get_level_unlock(current_level)
				local reward_backend_item = false

				if unlock_template and not unlock_template.item_key then
					local reward_data = {
						reward_type = "misc",
						bar_name = name,
						title_text = Localize("reward_popup_title"),
						icon_name = unlock_template.icon,
						description_text = Localize(unlock_template.description)
					}

					self.add_reward(self, reward_data)

					reward_added = true
					reward_backend_item = unlock_template.backend_item
				elseif level_up_rewards then
					reward_backend_item = true
				end

				if reward_backend_item and level_up_rewards then
					local index, item_key = next(level_up_rewards)

					if index then
						level_up_rewards[index] = nil
						local reward_data = {
							reward_type = "item",
							item_key = item_key
						}

						self.add_reward(self, reward_data)

						reward_added = true
					end
				end
			end

			self.set_experience_bar_by_fraction(self, bar_widget, current_level, bar_fraction)

			bar_data.last_bar_fraction = bar_fraction
			widget_style.level_box_bg_lit.color[1] = bar_fraction*255
			local glow_alpha_value_turn_progress = 0.97
			local glow_alpha_fraction = 0

			if glow_alpha_value_turn_progress < smoothstep then
				glow_alpha_fraction = (smoothstep - glow_alpha_value_turn_progress)/(glow_alpha_value_turn_progress - 1) - 1
			else
				glow_alpha_fraction = math.min(smoothstep/(glow_alpha_value_turn_progress - 1), 1)
			end

			widget_style.bar_glow.color[1] = (0.03 < bar_fraction and glow_alpha_fraction*255) or 0
			widget_style.bar_glow.offset[1] = bar_fraction*widget_style.bar.size[1] - 6
			local current_glow_texture = widget_content.bar_glow

			while widget_content.bar_glow == current_glow_texture do
				local index = math.ceil(Math.random_range(0, 3))
				widget_content.bar_glow = bar_glow_textures[index]
			end

			if progress == 1 then
				local quests_unlocked_reward = self.quests_unlocked_reward

				if quests_unlocked_reward then
					local icon_name = quests_unlocked_reward.icon
					local description_text = quests_unlocked_reward.description
					local reward_data = {
						reward_type = "misc",
						bar_name = name,
						title_text = Localize("reward_popup_title"),
						icon_name = icon_name,
						description_text = Localize(description_text)
					}

					self.add_reward(self, reward_data)

					reward_added = true
					self.quests_unlocked_reward = nil
				end

				local failed_game_rewards = self.failed_game_rewards

				if self._show_failed_game_popup and failed_game_rewards then
					self._show_failed_game_popup = false
					self.failed_game_rewards = nil
					local token_type = failed_game_rewards.token_type
					local token_texture = ForgeSettings.token_textures_by_type[token_type] .. "_large"
					local token_tooltip = ForgeSettings.token_type_tooltips[token_type]
					local token_amount = failed_game_rewards.token_amount
					local token_amount_text = "x" .. tostring(token_amount)
					local title_text = "summary_screen_token_rewarded"
					local description_text = token_tooltip or ""
					local reward_data = {
						reward_type = "misc",
						bar_name = name,
						title_text = Localize(title_text),
						icon_name = token_texture,
						description_text = Localize(description_text) .. " " .. token_amount_text
					}

					self.add_reward(self, reward_data)

					reward_added = true
				elseif not reward_added then
					self.bar_progress_data[index] = nil

					if #self.bar_progress_data < 1 then
						self.play_sound(self, "Stop_hud_end_screen_big_counter_loop")
						self.tween_out(self)
					end
				end
			end
		end
	end

	return 
end
SummaryScreenUI.set_experience_bar_by_experience = function (self, bar_widget, current_experience)
	local level, progress, experience_into_level = ExperienceSettings.get_level(current_experience)
	local next_level = level + 1
	local needed_experience = ExperienceSettings.get_experience_required_for_level(next_level)
	local bar_content = bar_widget.content
	bar_content.bar_value = progress
	bar_content.level_text = level
	bar_content.experience_text = string.format("%d/%d", experience_into_level, needed_experience)

	return 
end
SummaryScreenUI.set_experience_bar_by_fraction = function (self, bar_widget, level, fraction)
	local next_level = level + 1
	local max_exp = ExperienceSettings.get_experience_required_for_level(next_level)
	local level_experience = fraction*max_exp
	local bar_content = bar_widget.content
	bar_content.bar_value = fraction
	bar_content.level_text = level
	bar_content.experience_text = string.format("%d/%d", level_experience, max_exp)

	return 
end
SummaryScreenUI.display_total_experience = function (self, value)
	local summary_window_widget = self.summary_window_widget
	local summary_window_content = summary_window_widget.content
	summary_window_content.total_experience_text = value

	return 
end
SummaryScreenUI.setup_summary_entries = function (self)
	self.can_skip = true
	self.visible_summary_entry_widgets = {}
	self.summary_presentation_entries = {}
	local widget_index = 0
	local start_delay_time = UISettings.summary_screen.summary_entry_start_delay
	local mission_rewards = self.rewards:get_mission_results(self.game_won, self.game_mode_key)
	local summary_widgets = self.summary_widgets
	local start_time = 0

	for index, mission_reward in ipairs(mission_rewards) do
		widget_index = widget_index%NUM_OF_SUMMARY_WIDGETS + 1
		local name = "entry_" .. index
		local text = mission_reward.text
		local experience = mission_reward.experience or 0
		local value = mission_reward.value or 0
		local bonus = mission_reward.bonus
		local icon = mission_reward.icon
		local start_timer_name = name
		local widget = summary_widgets[widget_index]
		local entry = {
			start_counter_sound = true,
			name = name,
			title_text = text and Localize(text),
			start_timer_name = start_timer_name,
			experience = experience,
			value = value,
			bonus = bonus,
			widget = widget,
			icon = icon
		}
		local entry_time = ((text or NUM_OF_SUMMARY_WIDGETS <= index) and start_delay_time) or 0
		start_time = start_time + entry_time

		self.add_timer(self, start_timer_name, start_time, 0, 1)

		self.summary_presentation_entries[index] = entry

		if not self.summary_entry_widget_height then
			local scenegraph_id = widget.scenegraph_id
			local current_size = self.ui_scenegraph[scenegraph_id].size
			self.summary_entry_widget_height = current_size[2]
		end
	end

	return 
end
SummaryScreenUI.has_gained_rewards = function (self)
	local mission_rewards = self.rewards:get_mission_results(self.game_won, self.game_mode_key)
	local gained_xp = 0
	local gained_values = 0

	for index, mission_reward in ipairs(mission_rewards) do
		local experience = mission_reward.experience or 0
		local value = mission_reward.value or 0

		if experience then
			gained_xp = gained_xp + experience
		end

		if value then
			gained_values = gained_values + value
		end
	end

	if 0 < gained_xp or 0 < gained_values then
		return true
	end

	return false
end
SummaryScreenUI.update_summary_entries = function (self, dt)
	local entries = self.summary_presentation_entries

	if not entries then
		return 
	end

	if self.update_summary_widgets_position_animation(self, dt) then
		return 
	end

	for index, entry in ipairs(entries) do
		local start_timer_name = entry.start_timer_name
		local update = entry.update

		if update then
			if entry.start_counter_sound then
				if 1 < index then
					self.play_sound(self, "Stop_hud_end_screen_small_counter_loop")
				end

				self.play_sound(self, "Play_hud_end_screen_small_counter_loop")

				entry.start_counter_sound = false
			end

			local widget = entry.widget
			local widget_content = widget.content
			local widget_style = widget.style
			local experience = entry.experience
			local presentation_amount = 0
			local value = entry.value
			local icon = entry.icon
			local value_timer_name = string.format("%s%s", entry.name, "_value_timer")

			if not entry.initialized then
				local count_time = UISettings.summary_screen.summary_entry_experience_count_time

				self.add_timer(self, value_timer_name, count_time, 0, 1)

				widget.content.title_text = entry.title_text or ""
				local total_value_text = ""

				if 0 < experience then
					total_value_text = tostring(experience) .. "xp"
				elseif 0 < value then
					total_value_text = "x" .. tostring(value)
				end

				local value_text_style = widget_style.value_text
				local text_width, text_height = self.get_text_size(self, total_value_text, value_text_style)
				local value_text_scenegraph_id = value_text_style.scenegraph_id
				local text_size = self.ui_scenegraph[value_text_scenegraph_id].size
				text_size[1] = text_width

				if icon then
					self.set_entry_widget_icon(self, widget, icon)
				end

				local entry_fade_in_name = string.format("%s%s", entry.name, "_fade_in")

				self.tween_in_entry_passes(self, entry_fade_in_name, entry.widget)

				entry.initialized = true

				self.set_summary_entries_paused_state(self, true)
			end

			if self.has_timer(self, value_timer_name) then
				local timer_done = self.timer_done(self, value_timer_name)
				local smoothstep = self.get_timer_smoothstep(self, value_timer_name)

				if 0 < experience then
					presentation_amount = math.round(experience*smoothstep)
					widget_content.value_text = presentation_amount .. "xp"
				elseif 0 < value then
					local scalar = math.round(value*smoothstep)
					local value_amount = scalar + 1

					if value == scalar and not (value_amount - 1) then
					end

					widget_content.value_text = "x" .. value_amount
				end

				if timer_done then
					self.remove_timer(self, value_timer_name)

					update = false
					local total_experience_gained = self.total_experience_gained or 0
					local total_display_experience = total_experience_gained + presentation_amount
					self.total_experience_gained = total_display_experience

					self.display_total_experience(self, total_display_experience)

					if entry.bonus and icon then
						self.add_bonus(self, icon, value)
					end

					if index == #entries then
						self.play_sound(self, "Stop_hud_end_screen_small_counter_loop")
						self.display_bar_progress(self)
					else
						self.set_summary_entries_paused_state(self, false)
					end
				end
			end
		elseif self.timer_done(self, start_timer_name) then
			entry.update = true

			self.remove_timer(self, start_timer_name)

			if index <= NUM_OF_SUMMARY_WIDGETS then
				self.visible_summary_entry_widgets[index] = entry.widget

				self.align_summary_entry_widgets(self)
			else
				local is_next_entry_empty = entry.title_text == nil
				local num_animation_steps = self.summary_entries_animation_steps or 1

				if is_next_entry_empty then
					for i = index + 1, #entries, 1 do
						local next_entry = entries[i]
						next_entry.update = true

						self.remove_timer(self, next_entry.start_timer_name)

						num_animation_steps = num_animation_steps + 1

						if next_entry.title_text then
							break
						end
					end
				end

				self.set_summary_entries_paused_state(self, true)

				self.summary_entries_animation_steps = num_animation_steps

				if not self.summary_entries_animation_time then
					self.summary_entries_animation_time = 0
				end

				break
			end
		end
	end

	return 
end
SummaryScreenUI.set_summary_entries_paused_state = function (self, pause)
	local entries = self.summary_presentation_entries

	for _, entry in ipairs(entries) do
		if not entry.update then
			local start_timer_name = entry.start_timer_name

			self.set_timer_paused(self, start_timer_name, pause)
		end
	end

	return 
end
local set_local_position = UISceneGraph.set_local_position
SummaryScreenUI.align_summary_entry_widgets = function (self)
	local start_position = self.summary_entries_animation_position or 0
	local ui_scenegraph = self.ui_scenegraph
	local visible_entry_widgets = self.visible_summary_entry_widgets

	for index, widget in ipairs(visible_entry_widgets) do
		local scenegraph_id = widget.scenegraph_id
		local current_position = ui_scenegraph[scenegraph_id].local_position
		local current_size = ui_scenegraph[scenegraph_id].size
		local offset_index = index - 1
		local widget_height = -(current_size[2]*offset_index + SUMMARY_WIDGET_SPACING*offset_index)
		current_position[2] = start_position + widget_height
	end

	return 
end
SummaryScreenUI.update_summary_widgets_position_animation = function (self, dt)
	local time = self.summary_entries_animation_time

	if time then
		local position = self.summary_entries_animation_position or 0
		local steps = self.summary_entries_animation_steps
		local end_position = steps*(self.summary_entry_widget_height + SUMMARY_WIDGET_SPACING)

		if position == end_position then
			local visible_entry_widgets = self.visible_summary_entry_widgets

			for i = 1, self.summary_entries_animation_steps, 1 do
				local widget_to_move = table.remove(visible_entry_widgets, 1)
				local num_visible_entry_widgets = #visible_entry_widgets
				visible_entry_widgets[num_visible_entry_widgets + 1] = widget_to_move

				self.reset_summary_entry_widget(self, widget_to_move)
			end

			self.set_summary_entries_paused_state(self, false)

			self.summary_entries_animation_time = nil
			self.summary_entries_animation_position = nil
			self.summary_entries_animation_steps = nil
		else
			local duration = 0.5
			time = math.min(time + dt, duration)
			local progress = math.easeCubic(time/duration)
			self.summary_entries_animation_time = time
			self.summary_entries_animation_position = progress*end_position
		end

		self.align_summary_entry_widgets(self)

		return true
	end

	return 
end
SummaryScreenUI.reset_summary_entry_widget = function (self, widget)
	local widget_content = widget.content
	local widget_style = widget.style
	widget_content.title_text = ""
	widget_content.value_text = ""
	widget_content.icon_texture = nil
	widget_style.icon_texture.color[1] = 0
	widget_style.title_text.text_color[1] = 0
	widget_style.value_text.text_color[1] = 0

	return 
end
SummaryScreenUI.get_text_size = function (self, text, text_style)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, text, font[1], scaled_font_size)

	return text_width, text_height
end
SummaryScreenUI.set_entry_widget_icon = function (self, widget, icon_texture)
	local widget_content = widget.content
	local widget_style = widget.style
	local icon_settings = get_atlas_settings_by_texture_name(icon_texture)
	widget_content.icon_texture = icon_texture
	local icon_style = widget_style.icon_texture
	local scenegraph_id = icon_style.scenegraph_id
	local icon_scenegraph = self.ui_scenegraph[scenegraph_id]
	local size = icon_scenegraph.size
	local position = icon_scenegraph.local_position
	local default_size = icon_settings.size
	size[1] = default_size[1]
	size[2] = default_size[2]
	position[1] = -(size[1] + 2)

	return 
end
SummaryScreenUI.update_summary_screen = function (self, dt)
	local ui_animations = self.ui_animations
	local summary_screen_animation = self.summary_screen_animation
	local experience_bar_screen_animation = self.experience_bar_screen_animation

	if experience_bar_screen_animation then
		UIAnimation.update(experience_bar_screen_animation, dt)

		if UIAnimation.completed(experience_bar_screen_animation) then
			self.experience_bar_screen_animation = nil
		end
	end

	if ui_animations then
		for name, animation in pairs(ui_animations) do
			UIAnimation.update(animation, dt)

			if UIAnimation.completed(animation) then
				self.ui_animations[name] = nil
			end
		end
	end

	if summary_screen_animation then
		UIAnimation.update(summary_screen_animation, dt)

		if UIAnimation.completed(summary_screen_animation) and not self.reward_widget_open_animation_time then
			self.summary_screen_animation = nil

			if self.end_on_tween_complete then
				self.on_complete(self)
			else
				self.setup_summary_entries(self)
			end
		end
	else
		self.update_summary_entries(self, dt)
	end

	return 
end
SummaryScreenUI.display_bar_progress = function (self)
	local total_experience_gained = self.total_experience_gained
	local experience = 0
	local backend_manager = Managers.backend

	if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
		local player_level = nil
		player_level, experience = self.rewards:get_level_start()
		local new_experience = experience + total_experience_gained

		if GameSettingsDevelopment.use_telemetry then
			local player_manager = Managers.player
			local player = player_manager.local_player(player_manager)
			local hero = player.profile_display_name(player)
			local player_id = player.telemetry_id(player)

			self._add_experience_gain_telemetry(self, total_experience_gained, player_id, hero)
		end
	else
		print("Failed initialized experience for experience bar")
	end

	self.add_bar_progress(self, "hero_bar", experience, self.experience_bar_hero_widget, total_experience_gained)

	return 
end
local telemetry_data = {}
SummaryScreenUI._add_experience_gain_telemetry = function (self, gained_experience, player_id, hero)
	table.clear(telemetry_data)

	telemetry_data.gained_experience = gained_experience
	telemetry_data.player_id = player_id
	telemetry_data.hero = hero

	Managers.telemetry:register_event("player_experience_gain", telemetry_data)

	return 
end
SummaryScreenUI.add_reward = function (self, reward_data)
	local reward_stack = self._reward_stack

	table.insert(reward_stack, 1, reward_data)

	if not self.draw_item_popup and not self.show_reward_widget then
		self.start_next_reward(self)
	end

	return 
end
SummaryScreenUI.start_next_reward = function (self)
	local reward_stack = self._reward_stack
	local num_rewards = #reward_stack

	if 0 < num_rewards then
		local reward_data = reward_stack[num_rewards]
		reward_stack[num_rewards] = nil
		local reward_type = reward_data.reward_type

		if reward_type == "item" then
			self.display_item_popup(self, reward_data.item_key)
		else
			self.display_reward_screen(self, reward_data.bar_name, reward_data.title_text, reward_data.icon_name, reward_data.description_text, reward_data.icon_text)
		end
	end

	return 
end
SummaryScreenUI.display_item_popup = function (self, item_key)
	local bar_progress_data = self.bar_progress_data

	if bar_progress_data then
		for index, bar_data in ipairs(bar_progress_data) do
			local name = bar_data.name

			self.set_timer_paused(self, name, true)
		end
	end

	self.item_reward_popup:start_animation(item_key)

	self.draw_item_popup = true

	self.play_sound(self, "Pause_hud_end_screen_big_counter_loop")

	return 
end
SummaryScreenUI.on_hide_item_popup = function (self)
	local bar_progress_data = self.bar_progress_data

	if bar_progress_data then
		for index, bar_data in ipairs(bar_progress_data) do
			local name = bar_data.name

			self.set_timer_paused(self, name, false)
		end
	end

	self.play_sound(self, "Resume_hud_end_screen_big_counter_loop")

	self.draw_item_popup = nil

	self.start_next_reward(self)

	return 
end
SummaryScreenUI.display_reward_screen = function (self, bar_name, title_text, icon_name, description_text, icon_text)
	if bar_name == "hero_bar" then
		local bar_progress_data = self.bar_progress_data

		if bar_progress_data then
			for index, bar_data in ipairs(bar_progress_data) do
				local name = bar_data.name

				self.set_timer_paused(self, name, true)
			end
		end

		self.show_reward_widget = true
		self.reward_screen_state_index = 1
		self.reward_widget_open_animation_time = 0
		local ui_scenegraph = self.ui_scenegraph
		local widget_content = self.reward_widget.content
		local widget_style = self.reward_widget.style

		if icon_name then
			local icon_texture_atlas_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(icon_name)
			local icon_size = icon_texture_atlas_settings.size
			self.ui_scenegraph.reward_window_icon.size = icon_size
			widget_content.icon = icon_name
		end

		widget_content.title_text = title_text

		if description_text then
			widget_content.description_text = description_text
		end

		widget_content.icon_text = icon_text or ""
		ui_scenegraph.reward_window_bg.size[1] = 0
		ui_scenegraph.reward_window_glow_bg.size[1] = 0
		widget_style.title_text.text_color[1] = 0
		widget_style.description_text.text_color[1] = 0
		widget_style.glow_middle.color[1] = 255
		widget_style.glow_left.color[1] = 255
		widget_style.glow_right.color[1] = 255

		self.play_sound(self, "Pause_hud_end_screen_big_counter_loop")
		self.play_sound(self, "Play_hud_end_screen_unlock_item")
	end

	return 
end
SummaryScreenUI.on_hide_reward_screen = function (self)
	local bar_progress_data = self.bar_progress_data

	if bar_progress_data then
		for index, bar_data in ipairs(bar_progress_data) do
			local name = bar_data.name

			self.set_timer_paused(self, name, false)
		end
	end

	self.play_sound(self, "Resume_hud_end_screen_big_counter_loop")

	self.show_reward_widget = nil

	self.start_next_reward(self)

	return 
end
SummaryScreenUI.update_reward_screen_animations = function (self, time, dt)
	local state_index = self.reward_screen_state_index
	local reward_state = REWARD_SCREEN_STATES[state_index]
	local total_time = 1
	local progress = 0
	local multiplier = 1

	if self.skip_step then
		multiplier = UISettings.summary_screen.speed_up_experience_time_multiplier
	end

	time = time + dt*multiplier

	if reward_state == "intro" then
		total_time = 0.2
		progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -2, 0, 1, 0)
		local alpha = catmullrom_value*255
		self.reward_widget.style.sun_left.color[1] = alpha
		self.reward_widget.style.sun_right.color[1] = alpha
	elseif reward_state == "preperation" then
		total_time = 0.2
		progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -0.1, 0, 0, 0)
		local widget_content = self.reward_widget.content
		local new_size = catmullrom_value*definitions.scenegraph.reward_window_bg.size[1]
		widget_content.background.fraction = catmullrom_value
		widget_content.glow_middle.fraction = catmullrom_value
		self.ui_scenegraph.reward_window_bg.size[1] = new_size
		self.ui_scenegraph.reward_window_glow_bg.size[1] = new_size
	elseif reward_state == "open" then
		total_time = 0.4
		progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, 0, 0, 1, 1)
		local widget_content = self.reward_widget.content
		local new_size = catmullrom_value*definitions.scenegraph.reward_window_bg.size[1]
		widget_content.background.fraction = catmullrom_value
		widget_content.glow_middle.fraction = catmullrom_value
		self.ui_scenegraph.reward_window_bg.size[1] = new_size
		self.ui_scenegraph.reward_window_glow_bg.size[1] = new_size
	elseif reward_state == "reward_text_in" then
		total_time = 0.35
		progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -11, 0, 0, -4)
		local alpha = catmullrom_value*255
		local widget_style = self.reward_widget.style
		widget_style.highlight_glow.color[1] = alpha

		if 0.4 < progress then
			widget_style.glow_middle.color[1] = alpha
			widget_style.glow_left.color[1] = alpha
			widget_style.glow_right.color[1] = alpha

			if widget_style.icon.color[1] ~= 255 then
				widget_style.icon.color[1] = 255
				widget_style.icon_bg.color[1] = 255
				widget_style.title_text.text_color[1] = 255
				widget_style.description_text.text_color[1] = 255
			end
		end
	elseif reward_state == "waiting" then
		total_time = 2
		progress = math.min(time/total_time, 1)
	elseif reward_state == "reward_text_out" then
		total_time = 0.3
		progress = math.min(time/total_time, 1)
		local alpha = (progress - 1)*255
		self.reward_widget.style.title_text.text_color[1] = alpha
		self.reward_widget.style.description_text.text_color[1] = alpha
		self.reward_widget.style.icon.color[1] = alpha
		self.reward_widget.style.icon_bg.color[1] = alpha
	elseif reward_state == "close" then
		total_time = 0.4
		progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, 1, 1, 0, 0)
		local widget_content = self.reward_widget.content
		local new_size = catmullrom_value*definitions.scenegraph.reward_window_bg.size[1]
		widget_content.background.fraction = catmullrom_value
		widget_content.glow_middle.fraction = catmullrom_value
		self.ui_scenegraph.reward_window_bg.size[1] = new_size
		self.ui_scenegraph.reward_window_glow_bg.size[1] = new_size
	elseif reward_state == "exit" then
		total_time = 0.5
		progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, 0, 1, 0, -2)
		local alpha = catmullrom_value*255
		self.reward_widget.style.sun_left.color[1] = alpha
		self.reward_widget.style.sun_right.color[1] = alpha
	end

	if 1 <= progress then
		local next_reward_state = REWARD_SCREEN_STATES[state_index + 1]

		if next_reward_state then
			time = 0
			self.reward_screen_state_index = state_index + 1

			if next_reward_state == "close" then
				self.play_sound(self, "Play_hud_end_screen_unlock_item_close")
			end

			return time
		end

		self.on_hide_reward_screen(self)

		return nil
	else
		return time
	end

	return 
end
SummaryScreenUI.tween_in = function (self)
	self.play_sound(self, "Play_hud_end_screen_enter")
	self.tween_in_summary_screen(self)
	self.tween_in_experience_bar_screen(self)

	return 
end
SummaryScreenUI.tween_out = function (self)
	self.play_sound(self, "Play_hud_end_screen_exit")
	self.tween_out_summary_screen(self)
	self.tween_out_experience_bar_screen(self)

	self.end_on_tween_complete = true

	return 
end
SummaryScreenUI.tween_in_bonus_widget = function (self, name, widget, first_time, icon_target_size)
	local widget_style = widget.style
	local icon_scenegraph_id = widget_style.icon_texture.scenegraph_id
	local icon_size = self.ui_scenegraph[icon_scenegraph_id].size
	local time = UISettings.summary_screen.summary_dice_fade_in_time
	local p1, p2, p3, p4 = nil

	if first_time then
		p1 = -8
		p2 = 0
		p3 = 1
		p4 = -2
	else
		p1 = -1
		p2 = 1
		p3 = 1
		p4 = -1
	end

	self.ui_animations[name .. "_icon_size_x"] = UIAnimation.init(UIAnimation.catmullrom, icon_size, 1, icon_target_size[1], p1, p2, p3, p4, time)
	self.ui_animations[name .. "_icon_size_y"] = UIAnimation.init(UIAnimation.catmullrom, icon_size, 2, icon_target_size[2], p1, p2, p3, p4, time)
	local value = widget.content.value

	if 0 < value then
		local value_text_style = widget.style.value_text
		local text_size = 20
		self.ui_animations[name .. "_title_text"] = UIAnimation.init(UIAnimation.catmullrom, value_text_style, "font_size", text_size, p1, p2, p3, p4, time)
	end

	return 
end
SummaryScreenUI.tween_in_entry_passes = function (self, name, widget)
	local widget_style = widget.style
	local title_text_style = widget_style.title_text
	local value_text_style = widget_style.value_text
	local icon_style = widget_style.icon_texture
	local target_index = 1
	local from = 0
	local to = 255
	local time = UISettings.summary_screen.summary_entry_fade_in_time
	self.ui_animations[name .. "_title_text"] = UIAnimation.init(UIAnimation.function_by_time, title_text_style.text_color, target_index, from, to, time, math.easeInCubic)
	self.ui_animations[name .. "_value_text"] = UIAnimation.init(UIAnimation.function_by_time, value_text_style.text_color, target_index, from, to, time, math.easeInCubic)
	self.ui_animations[name .. "_icon_textures"] = UIAnimation.init(UIAnimation.function_by_time, icon_style.color, target_index, from, to, time, math.easeInCubic)

	self.play_sound(self, "Play_hud_end_screen_small_counter_headers")

	return 
end
SummaryScreenUI.tween_in_experience_bar_screen = function (self)
	local destination = self.ui_scenegraph.experience_bars_window.local_position
	local destination_index = 2
	local from = -1200
	local to = 40
	local time = UISettings.summary_screen.tween_in_time
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, destination, destination_index, from, to, time, math.ease_out_quad)
	self.experience_bar_screen_animation = new_animation

	return 
end
SummaryScreenUI.tween_in_summary_screen = function (self)
	local destination = self.ui_scenegraph.summary_window.local_position
	local destination_index = 2
	local from = 1200
	local to = -10
	local time = UISettings.summary_screen.tween_in_time
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, destination, destination_index, from, to, time, math.ease_out_quad)
	self.summary_screen_animation = new_animation

	return 
end
SummaryScreenUI.tween_out_experience_bar_screen = function (self)
	local destination = self.ui_scenegraph.experience_bars_window.local_position
	local destination_index = 2
	local from = 40
	local to = -1200
	local time = UISettings.summary_screen.tween_out_time
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, destination, destination_index, from, to, time, math.easeInCubic)
	self.experience_bar_screen_animation = new_animation

	return 
end
SummaryScreenUI.tween_out_summary_screen = function (self)
	local destination = self.ui_scenegraph.summary_window.local_position
	local destination_index = 2
	local from = -10
	local to = 1200
	local time = UISettings.summary_screen.tween_out_time
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, destination, destination_index, from, to, time, math.easeInCubic)
	self.summary_screen_animation = new_animation

	return 
end
SummaryScreenUI.add_timer = function (self, name, total_time, from, to)
	local timers = self.timers

	if not timers[name] and 0 < total_time then
		local new_timer = {
			current_time = 0,
			multiplier = 1,
			total_time = total_time,
			from = from,
			to = to
		}
		self.timers[name] = new_timer
	end

	return 
end
SummaryScreenUI.restart_timer = function (self, name)
	local timer = self.timers[name]
	timer.current_time = 0
	timer.progress = 0
	timer.finnished = nil

	return 
end
SummaryScreenUI.set_timer_multiplier = function (self, name, time_multiplier)
	local timer = self.timers[name]
	timer.multiplier = time_multiplier

	return 
end
SummaryScreenUI.get_timer_multiplier = function (self, name)
	local timer = self.timers[name]

	return timer.multiplier
end
SummaryScreenUI.set_timer_paused = function (self, name, is_paused)
	local timer = self.timers[name]
	timer.paused = is_paused

	return 
end
SummaryScreenUI.remove_timer = function (self, name)
	self.timers[name] = nil

	return 
end
SummaryScreenUI.update_timers = function (self, dt)
	local timers = self.timers

	for name, smoothstep in pairs(timers) do
		if not smoothstep.paused and not smoothstep.finnished then
			local total_time = smoothstep.total_time
			local current_time = smoothstep.current_time
			local multiplier = 1

			if self.skip_step then
				multiplier = UISettings.summary_screen.speed_up_experience_time_multiplier
			end

			current_time = math.min(current_time + dt*multiplier, total_time)
			smoothstep.current_time = current_time
			smoothstep.progress = current_time/total_time

			if current_time == total_time then
				smoothstep.finnished = true
			end
		end
	end

	return 
end
SummaryScreenUI.get_timer_smoothstep = function (self, name)
	local smoothstep_timer = self.timers[name]

	if smoothstep_timer then
		if smoothstep_timer.progress then
			return math.smoothstep(smoothstep_timer.progress, smoothstep_timer.from, smoothstep_timer.to)
		else
			return 0
		end
	end

	return 
end
SummaryScreenUI.get_timer_progress = function (self, name)
	local smoothstep_timer = self.timers[name]

	if smoothstep_timer then
		if smoothstep_timer.progress then
			return smoothstep_timer.progress
		else
			return 0
		end
	end

	return 
end
SummaryScreenUI.has_timer = function (self, name)
	local smoothstep_timer = self.timers[name]

	if smoothstep_timer then
		return true
	end

	return 
end
SummaryScreenUI.timer_paused = function (self, name)
	local smoothstep_timer = self.timers[name]

	if smoothstep_timer then
		return smoothstep_timer.paused
	end

	return 
end
SummaryScreenUI.timer_done = function (self, name)
	local smoothstep_timer = self.timers[name]

	if smoothstep_timer then
		return smoothstep_timer.finnished
	end

	return 
end

return 
