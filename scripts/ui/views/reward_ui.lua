require("scripts/ui/views/menu_input_description_ui")

local definitions = local_require("scripts/ui/views/reward_ui_definitions")
local scenegraph_definition = definitions.scenegraph_definition
local animation_definitions = definitions.animations
local widgets = definitions.widgets
local ENABLE_DEBUG = false
local debug_item_key = "we_shortbow_0001"
local TOTAL_NUMBERS_OF_LOOT_BOXES = 8
local continue_timers = {
	roll_dice = 20,
	reward_display = 25,
	intro_description = 25
}
local loot_box_textures = {
	"dice_game_icon_01",
	"dice_game_icon_02",
	"dice_game_icon_03",
	"dice_game_icon_04"
}
local loot_box_textures_by_type = {
	ranged = "dice_game_icon_02",
	melee = "dice_game_icon_01",
	hat = "dice_game_icon_03",
	trinket = "dice_game_icon_04"
}
local dice_types = {
	"wood",
	"metal",
	"gold",
	"warpstone"
}
local dice_textures = {
	gold = "dice_04",
	metal = "dice_02",
	warpstone = "dice_05",
	wood = "dice_01"
}
local loot_reward_sound_by_rarity = {
	common = "dice_game_reward_item_displayed_2",
	plentiful = "dice_game_reward_item_displayed_1",
	exotic = "dice_game_reward_item_displayed_3",
	rare = "dice_game_reward_item_displayed_2",
	unique = "dice_game_reward_item_displayed_3"
}
local fake_input_service = {
	get = function ()
		return
	end,
	has = function ()
		return
	end
}
local generic_input_actions = {
	default = {
		{
			input_action = "cycle_previous_hold",
			priority = 1,
			description_text = "input_description_show_traits"
		},
		{
			input_action = "confirm",
			priority = 2,
			description_text = "input_description_continue"
		}
	},
	no_traits = {
		{
			input_action = "confirm",
			priority = 1,
			description_text = "input_description_continue"
		}
	}
}
RewardUI = class(RewardUI)

RewardUI.init = function (self, end_of_level_ui_context, ui_world)
	local input_manager = end_of_level_ui_context.input_manager
	self.ui_renderer = end_of_level_ui_context.ui_renderer
	self.render_settings = {
		snap_pixel_positions = true
	}
	self.input_manager = input_manager

	input_manager:create_input_service("reward_ui", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service("reward_ui", "keyboard")
	input_manager:map_device_to_service("reward_ui", "mouse")
	input_manager:map_device_to_service("reward_ui", "gamepad")

	self.wwise_world = Managers.world:wwise_world(ui_world)

	rawset(_G, "my_global_pointer", self)

	self.ui_dice_animations = {}
	self.handle_transition_calls = {}

	self:create_ui_elements()

	self.loaded_packages = {}
	self.ui_animator = UIAnimator:new(self.ui_scenegraph, animation_definitions)
	self.unit_auto_rotate_speed_multiplier = 0.5
	self.unit_auto_rotate_value = 0

	if not SaveData.dice_game_intro_displayed then
		self.draw_intro_description = true
		self.continue_timer = continue_timers.intro_description
	end

	local gui_layer = scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(end_of_level_ui_context, self.ui_renderer, self:input_service(), 2, gui_layer, generic_input_actions.default)

	self.menu_input_description:set_input_description(nil)
end

RewardUI.create_ui_elements = function (self)
	self.roll_button_eye_glow_widget = UIWidget.init(widgets.roll_button_eye_glow)
	self.roll_button_widget = UIWidget.init(widgets.roll_button)
	self.gamepad_continue_text_widget = UIWidget.init(widgets.gamepad_continue_text)
	self.gamepad_continue_text_widget.style.text.localize = false

	self:set_roll_button_text("loot_screen_roll_button")

	self.dices_widget = UIWidget.init(widgets.dices)
	self.loot_box_widgets = {}
	self.loot_box_scenegraph_ids = {}

	for i = 1, TOTAL_NUMBERS_OF_LOOT_BOXES, 1 do
		local scenegraph_id = "reward_box_" .. i
		self.loot_box_widgets[i] = UIWidget.init(widgets[scenegraph_id])
		self.loot_box_scenegraph_ids[i] = scenegraph_id
	end

	self.reward_text_widgets = {
		title_text = UIWidget.init(widgets.reward_title_text),
		name_text = UIWidget.init(widgets.reward_name_text),
		type_text = UIWidget.init(widgets.reward_type_text)
	}
	self.reward_box_slot_widgets = {
		UIWidget.init(widgets.reward_box_bg_1),
		UIWidget.init(widgets.reward_box_bg_2),
		UIWidget.init(widgets.reward_box_bg_3),
		UIWidget.init(widgets.reward_box_bg_4),
		UIWidget.init(widgets.reward_box_bg_5),
		UIWidget.init(widgets.reward_box_bg_6),
		UIWidget.init(widgets.reward_box_bg_7),
		UIWidget.init(widgets.reward_box_bg_8)
	}
	self.loot_table_holder_widget = UIWidget.init(widgets.loot_table_holder)
	self.rules_widgets = {
		banner = UIWidget.init(widgets.banner),
		rules_dice_1 = UIWidget.init(widgets.rules_dice_1),
		rules_dice_2 = UIWidget.init(widgets.rules_dice_2),
		rules_dice_3 = UIWidget.init(widgets.rules_dice_3),
		rules_dice_4 = UIWidget.init(widgets.rules_dice_4),
		rules_dice_successes_wood = UIWidget.init(widgets.rules_dice_successes_1),
		rules_dice_successes_metal = UIWidget.init(widgets.rules_dice_successes_2),
		rules_dice_successes_gold = UIWidget.init(widgets.rules_dice_successes_3),
		rules_dice_successes_warpstone = UIWidget.init(widgets.rules_dice_successes_4),
		banner_title = UIWidget.init(widgets.banner_title),
		banner_ratio_title = UIWidget.init(widgets.banner_ratio_title),
		banner_description = UIWidget.init(widgets.banner_description)
	}
	self.lock_widgets = {
		lock_bg_left = UIWidget.init(widgets.lock_bg_left),
		lock_bg_right = UIWidget.init(widgets.lock_bg_right),
		lock_pillar_top = UIWidget.init(widgets.lock_pillar_top),
		lock_pillar_left = UIWidget.init(widgets.lock_pillar_left),
		lock_pillar_right = UIWidget.init(widgets.lock_pillar_right),
		lock_pillar_bottom = UIWidget.init(widgets.lock_pillar_bottom),
		lock_cogwheel_bg_left = UIWidget.init(widgets.lock_cogwheel_bg_left),
		lock_cogwheel_bg_right = UIWidget.init(widgets.lock_cogwheel_bg_right),
		lock_cogwheel_left = UIWidget.init(widgets.lock_cogwheel_left),
		lock_cogwheel_right = UIWidget.init(widgets.lock_cogwheel_right),
		lock_stick_top_left = UIWidget.init(widgets.lock_stick_top_left),
		lock_stick_top_right = UIWidget.init(widgets.lock_stick_top_right),
		lock_stick_bottom_left = UIWidget.init(widgets.lock_stick_bottom_left),
		lock_stick_bottom_right = UIWidget.init(widgets.lock_stick_bottom_right),
		lock_block_left = UIWidget.init(widgets.lock_block_left),
		lock_block_right = UIWidget.init(widgets.lock_block_right),
		lock_cover_top_left = UIWidget.init(widgets.lock_cover_top_left),
		lock_cover_top_right = UIWidget.init(widgets.lock_cover_top_right),
		lock_cover_bottom_left = UIWidget.init(widgets.lock_cover_bottom_left),
		lock_cover_bottom_right = UIWidget.init(widgets.lock_cover_bottom_right),
		lock_slot_holder_left = UIWidget.init(widgets.lock_slot_holder_left),
		lock_slot_holder_right = UIWidget.init(widgets.lock_slot_holder_right),
		reward_box_final_widget = UIWidget.init(widgets.reward_box_final)
	}
	self.door_widgets = {
		left = UIWidget.init(widgets.door_left),
		right = UIWidget.init(widgets.door_right)
	}
	self.fake_lock_widgets = {
		left = UIWidget.init(widgets.fake_lock_left),
		right = UIWidget.init(widgets.right_fake_lock)
	}
	self.box_holder_widgets = {
		left = UIWidget.init(widgets.box_holder_left),
		right = UIWidget.init(widgets.box_holder_right),
		background = UIWidget.init(widgets.box_holder_bg)
	}
	self.description_text_widgets = {
		description_background = UIWidget.init(widgets.description_background),
		title = UIWidget.init(widgets.description_title),
		description = UIWidget.init(widgets.description_text),
		input_description_text = UIWidget.init(widgets.input_description_text)
	}
	self.trait_icon_widgets = {
		UIWidget.init(widgets.trait_button_1),
		UIWidget.init(widgets.trait_button_2),
		UIWidget.init(widgets.trait_button_3),
		UIWidget.init(widgets.trait_button_4)
	}
	self.tooltip_widgets = {
		UIWidget.init(widgets.trait_tooltip_1),
		UIWidget.init(widgets.trait_tooltip_2),
		UIWidget.init(widgets.trait_tooltip_3),
		UIWidget.init(widgets.trait_tooltip_4)
	}
	self.hero_icon_widgets = {
		icon = UIWidget.init(widgets.hero_icon),
		tooltip = UIWidget.init(widgets.hero_icon_tooltip)
	}
	self.preview_widgets_by_name = {
		background_widgets = {
			preview_frame = UIWidget.init(widgets.preview_frame),
			preview_frame_background = UIWidget.init(widgets.preview_frame_background)
		},
		trait_widgets = {
			trait_preview_1 = UIWidget.init(widgets.trait_preview_1),
			trait_preview_2 = UIWidget.init(widgets.trait_preview_2),
			trait_preview_3 = UIWidget.init(widgets.trait_preview_3),
			trait_preview_4 = UIWidget.init(widgets.trait_preview_4)
		}
	}
	self.viewport_widget = UIWidget.init(widgets.reward_viewport)
	local preview_pass_data = self.viewport_widget.element.pass_data[1]
	self.reward_world = preview_pass_data.world
	self.reward_viewport = preview_pass_data.viewport
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.ui_scenegraph.door_left.size[1] = 0
	self.ui_scenegraph.door_right.size[1] = 0
	self.ui_dice_animations.eye_glow = UIAnimation.init(UIAnimation.pulse_animation, self.roll_button_eye_glow_widget.style.texture_id.color, 1, 150, 255, 2)
	self.lock_widgets.reward_box_final_widget.style.fg.color[1] = 0
	self.lock_widgets.reward_box_final_widget.style.frame.color[1] = 0
	self.lock_widgets.reward_box_final_widget.style.background.color[1] = 0
	self.hero_icon_widgets.icon.style.texture_id.color[1] = 0
	local num_total_traits = ForgeSettings.num_traits
	local trait_icon_widgets = self.trait_icon_widgets

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		trait_widget_style.texture_id.color[1] = 0
		trait_widget_style.texture_bg_id.color[1] = 0
		trait_widget_style.texture_lock_id.color[1] = 0
	end

	local dice_type_success_sides = UISettings.dice_type_success_sides

	self:set_number_of_successes_by_dice_type(dice_types[1], dice_type_success_sides[dice_types[1]])
	self:set_number_of_successes_by_dice_type(dice_types[2], dice_type_success_sides[dice_types[2]])
	self:set_number_of_successes_by_dice_type(dice_types[3], dice_type_success_sides[dice_types[3]])
	self:set_number_of_successes_by_dice_type(dice_types[4], dice_type_success_sides[dice_types[4]])
end

RewardUI.set_number_of_successes_by_dice_type = function (self, type, successes)
	local widgets = self.rules_widgets
	local widget_name = "rules_dice_successes_" .. type
	local widget = widgets[widget_name]

	for i = 1, successes, 1 do
		widget.content.texture[i] = "dice_game_success_icon"
	end
end

RewardUI.input_service = function (self)
	return self.input_manager:get_service("reward_ui")
end

RewardUI.on_enter = function (self, ignore_input_blocking)
	local chat_focused = Managers.chat:chat_is_focused()
	local input_manager = self.input_manager

	if not ignore_input_blocking and not chat_focused then
		input_manager:block_device_except_service("reward_ui", "keyboard")
		input_manager:block_device_except_service("reward_ui", "mouse")
		input_manager:block_device_except_service("reward_ui", "gamepad")
	end

	if not self.draw_intro_description then
		self:handle_animation_transitions("start")
	end
end

RewardUI.exit = function (self)
	return
end

RewardUI.on_exit = function (self)
	local reward_world = self.reward_world

	if self.reward_units then
		for i = 1, #self.reward_units, 1 do
			local unit = self.reward_units[i]

			if unit then
				World.destroy_unit(reward_world, unit)
			end
		end

		table.clear(self.reward_units)
	end

	if self.link_unit then
		World.destroy_unit(reward_world, self.link_unit)

		self.link_unit = nil
	end

	if self.viewport_widget then
		UIWidget.destroy(self.ui_renderer, self.viewport_widget)

		self.viewport_widget = nil
	end

	self.reward_world = nil

	if self.menu_input_description then
		self.menu_input_description:destroy()

		self.menu_input_description = nil
	end

	self:unload_packages()
	table.clear(self.loaded_packages)
end

RewardUI.destroy = function (self)
	rawset(_G, "my_global_pointer", self)
	self:on_exit()
end

RewardUI.set_traits_info = function (self, item, traits)
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local trait_icon_widgets = self.trait_icon_widgets
	local tooltip_widgets = self.tooltip_widgets
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local slot_type = item.slot_type
	local is_trinket = slot_type == "trinket"
	local never_locked = is_trinket or slot_type == "hat"

	for i = 1, num_total_traits, 1 do
		local trait_name = traits and traits[i]
		local trait_widget = trait_icon_widgets[i]
		local tooltip_trait_widget = tooltip_widgets[i]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local rairty = item.rarity
				local description_text = BackendUtils.get_trait_description(trait_name, rairty)

				if not is_trinket and never_locked then
					tooltip_trait_widget.content.tooltip_text = Localize(display_name) .. "\n" .. description_text
					tooltip_trait_widget.style.tooltip_text.last_line_color = nil
				else
					if is_trinket then
						tooltip_trait_widget.content.tooltip_text = Localize(display_name) .. "\n" .. description_text .. "\n" .. tooltip_trait_unique_text
					else
						tooltip_trait_widget.content.tooltip_text = Localize(display_name) .. "\n" .. description_text .. "\n" .. tooltip_trait_locked_text
					end

					tooltip_trait_widget.style.tooltip_text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
				end

				trait_widget_hotspot.locked = not never_locked
				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				trait_widget_content.use_background = true
				trait_widget_content.use_glow = false
			end

			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	self.number_of_traits_on_item = number_of_traits_on_item

	self:update_trait_alignment(number_of_traits_on_item)

	if number_of_traits_on_item > 0 then
		self.menu_input_description:change_generic_actions(generic_input_actions.default)
	else
		self.menu_input_description:change_generic_actions(generic_input_actions.no_traits)
	end

	self:_set_preview_traits(traits, item.rarity)
end

RewardUI.update_trait_alignment = function (self, number_of_traits)
	local ui_scenegraph = self.ui_scenegraph
	local width = 40
	local spacing = 80
	local half_trait_amount = (number_of_traits - 1) * 0.5
	local start_x_position = -((width + spacing) * half_trait_amount)

	for i = 1, number_of_traits, 1 do
		local trait_scenegraph_name = "trait_button_" .. i
		local trait_tooltip_scenegraph_name = "trait_tooltip_" .. i
		local position = ui_scenegraph[trait_scenegraph_name].local_position
		local tooltip_position = ui_scenegraph[trait_tooltip_scenegraph_name].local_position
		position[1] = start_x_position
		tooltip_position[1] = position[1]
		tooltip_position[2] = position[2]
		start_x_position = start_x_position + width + spacing
	end

	local trait_icon_widgets = self.trait_icon_widgets
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local widget = trait_icon_widgets[i]
		widget.content.visible = (i <= number_of_traits and true) or false
	end
end

RewardUI.on_complete = function (self)
	self.is_complete = true
end

RewardUI.start_reward = function (self)
	self:handle_animation_transitions("present_roll_successes")
end

RewardUI.set_reward_values = function (self, num_successes, dice_types, win_list, item_key, backend_id)
	if num_successes <= 0 then
		self.no_reward_gained = true
	else
		self.reward_results = {
			total_number_of_successes = num_successes,
			successes_to_present = num_successes,
			dice_types = dice_types,
			item_key = (ENABLE_DEBUG and debug_item_key) or item_key,
			backend_id = backend_id,
			win_list = win_list
		}
		local item = ItemMasterList[item_key]
		self.reward_item_rarity = item.rarity

		self:load_reward_units()
	end

	self:set_player_dice_pool(dice_types)
end

local rarity_level = {
	"wood",
	"metal",
	"gold",
	"warpstone"
}

RewardUI.set_player_dice_pool = function (self, dice_types)
	local dices_widget = self.dices_widget
	local widget_content = dices_widget.content
	local widget_textures = widget_content.dice_textures
	local texture_index = 1

	for _, dice_type in ipairs(rarity_level) do
		local amount = dice_types[dice_type]
		local dice_type_texture = dice_textures[dice_type]

		for i = 1, amount, 1 do
			widget_textures[texture_index] = dice_type_texture or "dice_01"
			texture_index = texture_index + 1
		end
	end
end

RewardUI.set_reward_display_info = function (self, item_key)
	local item = ItemMasterList[item_key]
	local ratity_color = Colors.get_color_table_with_alpha(item.rarity, 0)
	local reward_text_widgets = self.reward_text_widgets
	reward_text_widgets.name_text.content.text = item.display_name
	reward_text_widgets.name_text.style.text.text_color = ratity_color
	reward_text_widgets.type_text.content.text = item.item_type
	local draw_hero_icon = (#item.can_wield == 1 and true) or false

	if draw_hero_icon then
		local key = item.can_wield[1]
		local hero_icon_texture = UISettings.hero_icons.medium[key]
		local hero_icon_tooltip = UISettings.hero_tooltips[key]
		local hero_icon_widgets = self.hero_icon_widgets
		hero_icon_widgets.icon.content.texture_id = hero_icon_texture
		hero_icon_widgets.tooltip.content.tooltip_text = Localize(hero_icon_tooltip)
	end

	self.draw_hero_icon = draw_hero_icon
	local traits = item.traits

	self:set_traits_info(item, traits)
end

RewardUI.handle_animation_transitions = function (self, transition_name)
	self.transition_name = transition_name

	if transition_name == "start" then
		self.continue_timer = continue_timers.roll_dice
		local reward_results = self.reward_results

		if reward_results then
			local num_successes = reward_results.total_number_of_successes
			local win_list = reward_results.win_list

			for i = 1, #self.loot_box_widgets, 1 do
				local item_data = ItemMasterList[win_list[i]]
				local slot_type = item_data.slot_type
				local item_type = item_data.item_type
				local box_texture = nil

				if slot_type == "hat" then
					box_texture = "forge_icon_hat"
				elseif slot_type == "trinket" then
					box_texture = "forge_icon_trinket"
				else
					box_texture = "forge_icon_" .. item_type
				end

				local box_rarity = item_data.rarity

				self:set_loot_box_data(i, box_texture, box_rarity)
			end
		end

		self.draw_roll_button = nil
		self.reward_box_spawn_index = 0

		self:handle_animation_transitions("reward_entry")
	elseif transition_name == "reward_entry" then
		self:play_sound("dice_game_loot_entry")

		local reward_box_spawn_index = (self.reward_box_spawn_index + 1 <= TOTAL_NUMBERS_OF_LOOT_BOXES and self.reward_box_spawn_index + 1) or nil

		if reward_box_spawn_index then
			self.reward_box_spawn_index = reward_box_spawn_index

			self:start_loot_box_entry_animations(reward_box_spawn_index)
		else
			self:handle_animation_transitions("roll_dices")
		end
	elseif transition_name == "roll_dices" then
		self.draw_roll_button = true
		self.reward_entry_done = true
	elseif transition_name == "present_roll_successes" then
		self.draw_roll_button = false

		if self.no_reward_gained then
			self:on_complete()
		else
			local reward_results = self.reward_results
			local successes_to_present = reward_results.successes_to_present

			if successes_to_present then
				self:start_presenting_roll_results(successes_to_present)

				reward_results.successes_to_present = nil
				self.reward_box_index = successes_to_present
			end
		end
	elseif transition_name == "animate_door_close" then
		self:animate_door_close()
	elseif transition_name == "animate_lock_open" then
		self.disable_dice_game = true

		self:animate_lock_open()
	elseif transition_name == "animate_reward_box" then
		local reward_box_index = self.reward_box_index

		self:start_reward_box_presentation(reward_box_index, self.reward_results.item_key)
	elseif transition_name == "animate_lock_close" then
		self:animate_lock_close()
	elseif transition_name == "animate_door_open" then
		self:animate_door_open()

		self.display_reward_world = true
	elseif transition_name == "present_reward" then
		self:spawn_link_unit()
		self:spawn_reward_units()
		self:set_reward_display_info(self.reward_results.item_key)
		self:animate_reward_info()

		self.draw_roll_button = true
		self.continue_timer = continue_timers.reward_display
	end
end

RewardUI.set_loot_box_data = function (self, box_index, icon_texture, rarity)
	local loot_box_widgets = self.loot_box_widgets
	local widget = loot_box_widgets[box_index]
	widget.style.frame.color = Colors.get_color_table_with_alpha(rarity, 255)
	widget.content.background = icon_texture
end

RewardUI.start_loot_box_entry_animations = function (self, reward_entry_index)
	local ui_scenegraph = self.ui_scenegraph
	local loot_box_scenegraph_ids = self.loot_box_scenegraph_ids
	local loot_box_widgets = self.loot_box_widgets
	local animation_time = 0.3
	local color_animation_time = 0.2
	local default_wait_time = animation_time
	local total_wait_time = 0
	local scenegraph_id = loot_box_scenegraph_ids[reward_entry_index]
	local widget = loot_box_widgets[reward_entry_index]
	local fg_widget_style = widget.style.fg
	local fg_widget_style_color = fg_widget_style.color
	local animation_name = "loot_box_entry"
	self.ui_dice_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, fg_widget_style_color, 1, 255, 0, color_animation_time, math.easeInCubic)
end

RewardUI.start_presenting_roll_results = function (self, current_success_index)
	local ui_scenegraph = self.ui_scenegraph
	local loot_box_scenegraph_ids = self.loot_box_scenegraph_ids
	local loot_box_widgets = self.loot_box_widgets
	local index = current_success_index
	local widget = loot_box_widgets[index]
	local animation_name = "roll_presentation"
	local reward_box_scenegraph_id = loot_box_scenegraph_ids[current_success_index]
	local box_holder_widgets = self.box_holder_widgets
	local reward_box_position = ui_scenegraph[reward_box_scenegraph_id].position
	local default_box_holder_left_position = scenegraph_definition.box_holder_left.position
	local default_box_holder_right_position = scenegraph_definition.box_holder_right.position
	local current_box_holder_left_position = ui_scenegraph.box_holder_left.local_position
	local current_box_holder_right_position = ui_scenegraph.box_holder_right.local_position
	local current_box_holder_parent_position = ui_scenegraph.box_holder_parent.local_position
	local open_side_holder_timer = 0.4
	local close_side_holder_timer = 0.4
	local move_parent_holder_timer = 0.5
	local wait_to_move_parent_timer = 0.2
	local wait_to_fade_timer = 0.2
	local wait_to_continue_timer = 0.5
	self.ui_dice_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, current_box_holder_left_position, 1, default_box_holder_left_position[1], default_box_holder_left_position[1] - 15, open_side_holder_timer, math.easeOutCubic, UIAnimation.wait, wait_to_move_parent_timer, UIAnimation.function_by_time, current_box_holder_parent_position, 2, current_box_holder_parent_position[2], reward_box_position[2], move_parent_holder_timer, math.easeOutCubic, UIAnimation.function_by_time, current_box_holder_left_position, 1, default_box_holder_left_position[1], default_box_holder_left_position[1], close_side_holder_timer, math.easeCubic, UIAnimation.wait, wait_to_continue_timer)
	self.ui_dice_animations[animation_name .. "_right"] = UIAnimation.init(UIAnimation.function_by_time, current_box_holder_right_position, 1, default_box_holder_right_position[1], default_box_holder_right_position[1] + 15, open_side_holder_timer, math.easeOutCubic, UIAnimation.wait, wait_to_move_parent_timer, UIAnimation.wait, move_parent_holder_timer, UIAnimation.function_by_time, current_box_holder_right_position, 1, default_box_holder_right_position[1], default_box_holder_right_position[1], close_side_holder_timer, math.easeCubic)
	local fade_wait_time = wait_to_move_parent_timer + close_side_holder_timer + move_parent_holder_timer

	self:fade_out_rewards_except(index, fade_wait_time)
	self:play_sound("dice_game_holder_unlock")

	self.ui_dice_animations.play_holder_lock = UIAnimation.init(UIAnimation.wait, fade_wait_time)
end

RewardUI.fade_out_rewards_except = function (self, index, wait_time)
	local animation_name = "fade_out_rewards"
	local fade_out_timer = 0.2
	local loot_box_widgets = self.loot_box_widgets

	for i = 1, TOTAL_NUMBERS_OF_LOOT_BOXES, 1 do
		if i ~= index then
			local icon_fade_name = animation_name .. "_icon_" .. i
			local frame_fade_name = animation_name .. "_frame_" .. i
			local widget = loot_box_widgets[i]
			self.ui_dice_animations[icon_fade_name] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, widget.style.fg.color, 1, 0, 255, fade_out_timer, math.easeCubic)
		end
	end
end

RewardUI.start_reward_box_presentation = function (self, reward_index, item_key)
	local item = ItemMasterList[item_key]
	local slot_type = item.slot_type
	local item_type = item.item_type
	local rarity = item.rarity
	local reward_box_texture, box_texture = nil

	if slot_type == "hat" then
		reward_box_texture = "forge_icon_hat"
	elseif slot_type == "trinket" then
		reward_box_texture = "forge_icon_trinket"
	else
		reward_box_texture = "forge_icon_" .. item_type
	end

	local rarity_color = Colors.get_color_table_with_alpha(rarity, 0)
	local widget = self.lock_widgets.reward_box_final_widget
	local widget_frame_style = widget.style.frame
	local widget_background_style = widget.style.background
	widget.style.frame.color = rarity_color
	widget.content.background = reward_box_texture
	local animation_name = "reward_box_presentation"
	local fade_out_timer = 0.2
	local start_wait_time = 0.3
	local end_wait_time = 0.3
	self.ui_dice_animations[animation_name] = UIAnimation.init(UIAnimation.wait, start_wait_time, UIAnimation.function_by_time, widget_background_style.color, 1, 0, 255, fade_out_timer, math.easeCubic, UIAnimation.wait, end_wait_time)
	self.ui_dice_animations[animation_name .. "_2"] = UIAnimation.init(UIAnimation.wait, start_wait_time, UIAnimation.function_by_time, widget_frame_style.color, 1, 0, 255, fade_out_timer, math.easeCubic, UIAnimation.wait, end_wait_time)
end

RewardUI.animate_door_close = function (self)
	self:play_sound("dice_game_doors_close")

	local ui_scenegraph = self.ui_scenegraph
	local door_widgets = self.door_widgets
	local left_door_widget = door_widgets.left
	local right_door_widget = door_widgets.right
	local animation_name = "doors_close"
	local left_scenegraph_id = "door_left"
	local left_widget_scenegraph = ui_scenegraph[left_scenegraph_id]
	local left_widget_size = left_widget_scenegraph.size
	local right_scenegraph_id = "door_right"
	local right_widget_scenegraph = ui_scenegraph[right_scenegraph_id]
	local right_widget_size = right_widget_scenegraph.size
	local left_uvs = left_door_widget.content.background.uvs
	local right_uvs = right_door_widget.content.background.uvs
	local animation_time = 1.3
	self.ui_dice_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, right_widget_size, 1, 0, 960, animation_time, math.easeInCubic)
	self.ui_dice_animations[animation_name .. "_left_uvs"] = UIAnimation.init(UIAnimation.function_by_time, right_uvs[2], 1, 0, 1, animation_time, math.easeInCubic)
	self.ui_dice_animations[animation_name .. "_left"] = UIAnimation.init(UIAnimation.function_by_time, left_widget_size, 1, 0, 1080, animation_time, math.easeInCubic)
	self.ui_dice_animations[animation_name .. "_right_uvs"] = UIAnimation.init(UIAnimation.function_by_time, left_uvs[1], 1, 1, 0, animation_time, math.easeInCubic)
	self.ui_dice_animations.show_fake_lock = UIAnimation.init(UIAnimation.wait, animation_time * 0.7)
end

RewardUI.animate_door_open = function (self)
	self:play_sound("dice_game_doors_open")

	local ui_scenegraph = self.ui_scenegraph
	local door_widgets = self.door_widgets
	local left_door_widget = door_widgets.left
	local right_door_widget = door_widgets.right
	local animation_name = "doors_open"
	local left_scenegraph_id = "door_left"
	local left_widget_scenegraph = ui_scenegraph[left_scenegraph_id]
	local left_widget_size = left_widget_scenegraph.size
	local left_widget_position = left_widget_scenegraph.position
	local right_scenegraph_id = "door_right"
	local right_widget_scenegraph = ui_scenegraph[right_scenegraph_id]
	local right_widget_position = right_widget_scenegraph.position
	local right_widget_size = right_widget_scenegraph.size
	local left_uvs = left_door_widget.content.background.uvs
	local right_uvs = right_door_widget.content.background.uvs
	local animation_time = 0.5
	local teaser_animation_time = 0.6
	local teaser_value = 0
	self.ui_dice_animations[animation_name] = UIAnimation.init(UIAnimation.function_by_time, left_widget_size, 1, 1080, 0, animation_time, math.easeInCubic)
	self.ui_dice_animations[animation_name .. "_left_uvs"] = UIAnimation.init(UIAnimation.function_by_time, left_uvs[1], 1, 0, 1, animation_time, math.easeInCubic)
	self.ui_dice_animations[animation_name .. "_right"] = UIAnimation.init(UIAnimation.function_by_time, right_widget_size, 1, 960, 0, animation_time, math.easeInCubic)
	self.ui_dice_animations[animation_name .. "_right_uvs"] = UIAnimation.init(UIAnimation.function_by_time, right_uvs[2], 1, 1, 0, animation_time, math.easeInCubic)
	self.ui_dice_animations.hide_fake_lock = UIAnimation.init(UIAnimation.wait, animation_time * 0.8)
end

RewardUI.animate_lock_open = function (self)
	self:play_sound("dice_game_lock_open")

	self.lock_open_anim_id = self.ui_animator:start_animation("lock_open", self.lock_widgets, scenegraph_definition)
end

RewardUI.animate_lock_close = function (self)
	self:play_sound("dice_game_lock_close")

	self.lock_close_anim_id = self.ui_animator:start_animation("lock_close", self.lock_widgets, scenegraph_definition)
end

RewardUI.animate_reward_info = function (self)
	local reward_text_widgets = self.reward_text_widgets
	local name_text_style = reward_text_widgets.name_text.style.text
	local type_text_style = reward_text_widgets.type_text.style.text
	local title_text_style = reward_text_widgets.title_text.style.text
	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_style = hero_icon_widgets.icon.style.texture_id
	local icon_widget = self.lock_widgets.reward_box_final_widget
	local widget_frame_style = icon_widget.style.frame
	local widget_background_style = icon_widget.style.background
	local animation_name = "animate_reward_info"
	local animation_time = 0.3
	local wait_time = 0.2
	local from = 0
	local to = 255
	local ui_dice_animations = self.ui_dice_animations
	ui_dice_animations[animation_name] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, name_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_dice_animations[animation_name .. "_2"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, type_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_dice_animations[animation_name .. "_3"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_dice_animations[animation_name .. "_4"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, widget_frame_style.color, 1, from, to, animation_time, math.easeInCubic)
	ui_dice_animations[animation_name .. "_5"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, widget_background_style.color, 1, from, to, animation_time, math.easeInCubic)
	ui_dice_animations[animation_name .. "_6"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, hero_icon_style.color, 1, from, to, animation_time, math.easeInCubic)
	local num_total_traits = ForgeSettings.num_traits
	local trait_icon_widgets = self.trait_icon_widgets

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		ui_dice_animations[animation_name .. "_trait_icon_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_id.color, 1, from, to, animation_time, math.easeInCubic)
		ui_dice_animations[animation_name .. "_trait_bg_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_bg_id.color, 1, from, to, animation_time, math.easeInCubic)
		ui_dice_animations[animation_name .. "_trait_lock_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_lock_id.color, 1, from, to, animation_time, math.easeInCubic)
	end

	self.display_reward_texts = true
end

RewardUI.on_loot_box_entry_complete = function (self)
	self.draw_roll_button = true
end

RewardUI.set_reroll_state = function (self, enabled)
	self.reroll_needed = enabled
end

RewardUI.update_continue_timer = function (self, dt)
	local continue_timer = self.continue_timer

	if continue_timer then
		continue_timer = continue_timer - dt

		if continue_timer <= 0 then
			self.continue_timer = nil

			return true
		else
			self.continue_timer = continue_timer
		end
	end
end

RewardUI.update = function (self, dt)
	local auto_continue = self:update_continue_timer(dt)

	self:auto_rotate(dt)

	local ui_animator = self.ui_animator

	ui_animator:update(dt)

	if self.lock_open_anim_id and ui_animator:is_animation_completed(self.lock_open_anim_id) then
		self.lock_open_anim_id = nil

		self:play_sound("dice_game_add_item_to_lock")
		self:handle_animation_transitions("animate_reward_box")
	elseif self.lock_close_anim_id and ui_animator:is_animation_completed(self.lock_close_anim_id) then
		self.lock_close_anim_id = nil
		self.draw_lock = false

		self:handle_animation_transitions("animate_door_open")
	end

	for name, ui_animation in pairs(self.ui_dice_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_dice_animations[name] = nil

			if name == "loot_box_entry" then
				self.handle_transition_calls[#self.handle_transition_calls + 1] = "reward_entry"
			elseif name == "play_holder_lock" then
				self:play_sound("dice_game_holder_lock")
			elseif name == "roll_presentation" then
				self.handle_transition_calls[#self.handle_transition_calls + 1] = "animate_door_close"
			elseif name == "doors_close" then
				self.draw_lock = true
				self.handle_transition_calls[#self.handle_transition_calls + 1] = "animate_lock_open"
			elseif name == "reward_box_presentation" then
				self.handle_transition_calls[#self.handle_transition_calls + 1] = "animate_lock_close"
			elseif name == "doors_open" then
				self.handle_transition_calls[#self.handle_transition_calls + 1] = "present_reward"
			elseif name == "show_fake_lock" then
				self.show_fake_lock = true
			elseif name == "hide_fake_lock" then
				self.show_fake_lock = nil
			end
		end
	end

	local handle_transition_calls = self.handle_transition_calls

	if handle_transition_calls then
		for index, value in ipairs(handle_transition_calls) do
			self:handle_animation_transitions(value)

			handle_transition_calls[index] = nil
		end
	end

	if self.sound_timers then
		local prev_sound_timer = self.sound_timer
		local new_sound_timer = prev_sound_timer + dt

		for sound, timer in pairs(self.sound_timers) do
			if prev_sound_timer <= timer and timer < new_sound_timer then
				WwiseWorld.trigger_event(self.wwise_world, sound)

				self.sound_timers[sound] = nil
			end
		end

		self.sound_timer = new_sound_timer
	end

	local draw_intro_description = self.draw_intro_description
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("reward_ui")
	local gamepad_active = input_manager:is_device_active("gamepad")
	local ui_renderer = self.ui_renderer

	UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, (draw_intro_description and fake_input_service) or input_service, dt, nil, self.render_settings)

	if gamepad_active and input_service:get("cycle_previous_hold") then
		self._show_traits_preview = true
	else
		self._show_traits_preview = nil
	end

	if draw_intro_description then
		local description_text_widgets = self.description_text_widgets
		description_text_widgets.input_description_text.content.text = (gamepad_active and "press_any_button_to_continue") or "press_any_key_to_continue"

		for key, text_widget in pairs(description_text_widgets) do
			UIRenderer.draw_widget(ui_renderer, text_widget)
		end

		if input_manager:any_input_pressed() or auto_continue then
			self.continue_timer = nil
			self.draw_intro_description = false

			self:save_game_info_read()
			self:handle_animation_transitions("start")
		end
	elseif auto_continue then
		self.auto_roll = true
	end

	if not self.is_complete then
		UIRenderer.draw_widget(ui_renderer, self.loot_table_holder_widget)

		local rules_widgets = self.rules_widgets

		for key, widget in pairs(rules_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end

		local reward_box_slot_widgets = self.reward_box_slot_widgets

		for i = 1, #reward_box_slot_widgets, 1 do
			UIRenderer.draw_widget(ui_renderer, reward_box_slot_widgets[i])
		end

		local door_widgets = self.door_widgets

		for key, door_widget in pairs(door_widgets) do
			UIRenderer.draw_widget(ui_renderer, door_widget)
		end

		if self.draw_lock then
			local lock_widgets = self.lock_widgets

			for key, lock_widget in pairs(lock_widgets) do
				UIRenderer.draw_widget(ui_renderer, lock_widget)
			end
		elseif self.show_fake_lock then
			local fake_lock_widgets = self.fake_lock_widgets

			for key, door_widget in pairs(fake_lock_widgets) do
				UIRenderer.draw_widget(ui_renderer, door_widget)
			end
		end

		local box_holder_widgets = self.box_holder_widgets

		for key, holder_widget in pairs(box_holder_widgets) do
			UIRenderer.draw_widget(ui_renderer, holder_widget)
		end

		UIRenderer.draw_widget(ui_renderer, self.dices_widget)

		if not self.ui_dice_animations.animate_reward_info and (self.reroll_needed or (self.draw_roll_button and self.reward_entry_done)) then
			local roll_button_widget = self.roll_button_widget
			local roll_button_hotspot = roll_button_widget.content.button_hotspot

			if gamepad_active then
				if self.display_reward_texts then
					if input_service:get("confirm_press") then
						roll_button_hotspot.on_release = true
					end
				else
					if input_manager:any_input_pressed() then
						roll_button_hotspot.on_release = true
					end

					UIRenderer.draw_widget(ui_renderer, self.gamepad_continue_text_widget)
				end
			else
				UIRenderer.draw_widget(ui_renderer, roll_button_widget)
				UIRenderer.draw_widget(ui_renderer, self.roll_button_eye_glow_widget)

				if roll_button_hotspot.on_hover_enter then
					self:play_sound("Play_hud_hover")
				end
			end
		end

		local loot_box_widgets = self.loot_box_widgets

		for i = 1, TOTAL_NUMBERS_OF_LOOT_BOXES, 1 do
			UIRenderer.draw_widget(ui_renderer, loot_box_widgets[i])
		end
	end

	if self.display_reward_texts then
		local reward_text_widgets = self.reward_text_widgets

		for key, text_widget in pairs(reward_text_widgets) do
			UIRenderer.draw_widget(ui_renderer, text_widget)
		end

		local number_of_traits_on_item = self.number_of_traits_on_item

		if number_of_traits_on_item then
			local trait_icon_widgets = self.trait_icon_widgets

			for i = 1, number_of_traits_on_item, 1 do
				UIRenderer.draw_widget(ui_renderer, trait_icon_widgets[i])
			end

			local tooltip_widgets = self.tooltip_widgets

			for i = 1, number_of_traits_on_item, 1 do
				UIRenderer.draw_widget(ui_renderer, tooltip_widgets[i])
			end
		end

		if self.draw_hero_icon then
			local hero_icon_widgets = self.hero_icon_widgets

			for key, widget in pairs(hero_icon_widgets) do
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end

		if self.number_of_traits_on_item > 0 and self._show_traits_preview then
			local preview_widgets = self.preview_widgets_by_name

			for list_name, widget_list in pairs(preview_widgets) do
				for key, widget in pairs(widget_list) do
					UIRenderer.draw_widget(ui_renderer, widget)
				end
			end
		end
	end

	if self.display_reward_world then
		local viewport_widget = self.viewport_widget

		if viewport_widget then
			UIRenderer.draw_widget(ui_renderer, viewport_widget)
		end
	end

	UIRenderer.end_pass(ui_renderer)

	if self.display_reward_texts and self.continue_timer ~= nil and gamepad_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end
end

RewardUI.set_draw_roll_button_enabled = function (self, enabled)
	self.draw_roll_button = enabled
end

RewardUI.is_roll_button_pressed = function (self)
	local button_hotspot = self.roll_button_widget.content.button_hotspot
	local on_release = button_hotspot.on_release or self.auto_roll
	button_hotspot.on_release = nil
	self.auto_roll = nil

	if on_release then
		self.continue_timer = nil
	end

	return on_release
end

RewardUI.set_roll_button_text = function (self, text)
	local localized_text = Localize(text)
	self.roll_button_widget.content.text_field = localized_text
	self.gamepad_continue_text_widget.content.text = Localize("press_any_button_prefix") .. " " .. localized_text
end

RewardUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

RewardUI.load_reward_units = function (self)
	local item_key = self.reward_results.item_key
	local item_data = ItemMasterList[item_key]
	local item_template = ItemHelper.get_template_by_item_name(item_key)
	local units_to_spawn_data = {}
	local slot_type = item_data.slot_type

	if slot_type == "melee" or slot_type == "ranged" then
		local left_hand_unit = item_data.left_hand_unit
		local right_hand_unit = item_data.right_hand_unit

		if left_hand_unit then
			local left_unit = left_hand_unit .. "_3p"

			self:load_package(left_unit)

			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = left_unit,
				unit_attachment_node_linking = item_template.left_hand_attachment_node_linking.third_person.display
			}
		end

		if right_hand_unit then
			local right_unit = right_hand_unit .. "_3p"

			if right_hand_unit ~= left_hand_unit then
				self:load_package(right_unit)
			end

			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = right_unit,
				unit_attachment_node_linking = item_template.right_hand_attachment_node_linking.third_person.display
			}
		end
	else
		local unit = item_data.unit

		if unit then
			self:load_package(unit)

			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = unit,
				unit_attachment_node_linking = (slot_type == "trinket" and item_template.attachment_node_linking.slot_trinket_1) or item_template.attachment_node_linking.slot_hat
			}
		end
	end

	self.units_to_spawn_data = units_to_spawn_data
end

RewardUI.load_package = function (self, package_name)
	local package_manager = Managers.package
	local cb = callback(self, "on_load_complete", package_name)

	package_manager:load(package_name, "RewardUI", cb, true)
end

RewardUI.on_load_complete = function (self, package_name)
	self.loaded_packages[package_name] = true

	if self.spawn_reward_units_when_ready and self:ready_to_spawn() then
		self:spawn_reward_units()
	end
end

RewardUI.unload_packages = function (self)
	local loaded_packages = self.loaded_packages

	if loaded_packages then
		local package_manager = Managers.package

		for package_name, _ in pairs(loaded_packages) do
			package_manager:unload(package_name, "RewardUI")
		end
	end
end

RewardUI.ready_to_spawn = function (self)
	local units_to_spawn_data = self.units_to_spawn_data
	local loaded_packages = self.loaded_packages

	for i = 1, #units_to_spawn_data, 1 do
		local unit_spawn_data = units_to_spawn_data[i]

		if not loaded_packages[unit_spawn_data.unit_name] then
			return false
		end
	end

	return true
end

RewardUI.spawn_link_unit = function (self)
	local item_key = self.reward_results.item_key
	local item_template = ItemHelper.get_template_by_item_name(item_key)
	local item_data = ItemMasterList[item_key]
	local unit_name = item_template.display_unit
	local camera_rotation = self:get_camera_rotation()
	local camera_forward_vector = Quaternion.forward(camera_rotation)
	local camera_look_rotation = Quaternion.look(camera_forward_vector, Vector3.up())
	local horizontal_rotation = Quaternion.axis_angle(Vector3.up(), math.pi * 1)
	local unit_spawn_rotation = Quaternion.multiply(camera_look_rotation, horizontal_rotation)
	local camera_position = self:get_camera_position()
	local unit_spawn_position = camera_position + camera_forward_vector
	local world = self.reward_world
	local link_unit = World.spawn_unit(world, unit_name, unit_spawn_position, unit_spawn_rotation)
	local unit_box, box_dimension = Unit.box(link_unit)
	local unit_center_position = Matrix4x4.translation(unit_box)
	local unit_root_position = Unit.world_position(link_unit, 0)
	local offset = unit_center_position - unit_root_position

	if box_dimension then
		local max_value = 0.2
		local largest_value = 0

		if largest_value < box_dimension.x then
			largest_value = box_dimension.x
		end

		if largest_value < box_dimension.z then
			largest_value = box_dimension.z
		end

		if largest_value < box_dimension.y then
			largest_value = box_dimension.y
		end

		if max_value < largest_value then
			local diff = largest_value - max_value
			local scale_fraction = 1 - diff / largest_value
			local scale = Vector3(scale_fraction, scale_fraction, scale_fraction)

			Unit.set_local_scale(link_unit, 0, scale)

			offset = offset * scale_fraction
		end

		local display_position = unit_spawn_position - offset

		Unit.set_local_position(link_unit, 0, display_position)

		self.link_unit = link_unit
	end
end

RewardUI.spawn_reward_units = function (self)
	local link_unit = self.link_unit

	if self:ready_to_spawn() and link_unit then
		local scene_graph_links = {}
		local world = self.reward_world
		local units_to_spawn_data = self.units_to_spawn_data
		local loaded_packages = self.loaded_packages
		local reward_units = {}
		local reward_units_default_position = {}
		local reward_units_position_offset = {}

		for i = 1, #units_to_spawn_data, 1 do
			local spawn_unit_data = units_to_spawn_data[i]
			local unit_name = spawn_unit_data.unit_name
			local unit_attachment_node_linking = spawn_unit_data.unit_attachment_node_linking
			local reward_unit = World.spawn_unit(world, unit_name)
			reward_units[#reward_units + 1] = reward_unit

			GearUtils.link(world, unit_attachment_node_linking, scene_graph_links, link_unit, reward_unit)
		end

		self.reward_units = reward_units
		self.reward_units_position_offset = reward_units_position_offset
		self.reward_units_default_position = reward_units_default_position
		self.spawn_reward_units_when_ready = nil

		Unit.flow_event(link_unit, "lua_spin")

		local item_rarity = self.reward_item_rarity
		local sound_event = loot_reward_sound_by_rarity[item_rarity]

		self:play_sound(sound_event)
	else
		self.spawn_reward_units_when_ready = true
	end
end

RewardUI.get_camera_position = function (self)
	local reward_viewport = self.reward_viewport
	local camera = ScriptViewport.camera(reward_viewport)

	return ScriptCamera.position(camera)
end

RewardUI.get_camera_rotation = function (self)
	local reward_viewport = self.reward_viewport
	local camera = ScriptViewport.camera(reward_viewport)

	return ScriptCamera.rotation(camera)
end

RewardUI.auto_rotate = function (self, dt)
	local link_unit = self.link_unit

	if link_unit and Unit.alive(link_unit) then
		local speed_multiplier = self.unit_auto_rotate_speed_multiplier or 0.5
		local current_value = self.unit_auto_rotate_value or 0
		local value = (current_value + dt * speed_multiplier) % (math.pi * 2)
		local unit_rotation = Quaternion.axis_angle(Vector3(0, 0, 1), -value)

		Unit.set_local_rotation(link_unit, 0, unit_rotation)

		self.unit_auto_rotate_value = value
	end
end

RewardUI.save_game_info_read = function (self)
	local save_manager = Managers.save
	SaveData.dice_game_intro_displayed = true

	save_manager:auto_save(SaveFileName, SaveData, callback(self, "on_save_ended_callback"))
end

RewardUI.on_save_ended_callback = function (self)
	print("[RewardUI] - dice game intro shown saved")
end

RewardUI._set_preview_traits = function (self, traits, rarity)
	local widgets_by_name = self.widgets_by_name
	local num_traits = ForgeSettings.num_traits
	local trait_locked_text = Localize("tooltip_trait_locked")
	local traits_data = {}

	for i = 1, num_traits, 1 do
		local trait_name = traits and traits[i]

		if trait_name then
			local trait_template = BuffTemplates[trait_name]
			local item_has_trait = false

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local description_text = BackendUtils.get_trait_description(trait_name, rarity)

				if not item_has_trait then
					description_text = description_text .. "\n" .. trait_locked_text
				end

				local icon = trait_template.icon or "icons_placeholder"
				traits_data[i] = {
					trait_name = trait_name,
					display_name = display_name,
					description_text = description_text,
					icon = icon or "trait_icon_empty",
					locked = not item_has_trait
				}
			end
		end
	end

	self:set_preview_traits_info(traits_data, 1, num_traits)
end

RewardUI.set_preview_traits_info = function (self, traits_data, start_index, end_index)
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local is_trinket = false
	local never_locked = false
	local trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local total_traits_height = 0
	local trait_start_spacing = 25
	local trait_end_spacing = 25
	local icon_height = 40
	local divider_height = 60
	local description_text_spacing = 15
	local trait_preview_widgets_by_name = self.preview_widgets_by_name.trait_widgets
	local ui_scenegraph = self.ui_scenegraph

	for i = start_index, end_index, 1 do
		local is_first_widget = i == start_index
		local trait_data = traits_data[i]
		local trait_name = trait_data and trait_data.trait_name
		local trait_widget = trait_preview_widgets_by_name["trait_preview_" .. i]
		local trait_widget_style = trait_widget.style
		local trait_widget_content = trait_widget.content
		trait_widget_content.visible = (trait_name and true) or false

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local trait_unlocked = not trait_data.locked
				local display_name = trait_data.display_name or "Unknown"
				local description_text = trait_data.description_text
				local trait_display_name = Localize(display_name)
				local description_text = description_text

				if not is_trinket and trait_unlocked then
					trait_widget_style.description_text.last_line_color = nil
				else
					trait_widget_style.description_text.last_line_color = Colors.get_color_table_with_alpha("red", trait_widget_style.description_text.text_color[1])
				end

				local icon = trait_data.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_content.use_background = false
				trait_widget_content.use_glow = false
				trait_widget_content.use_divider = not is_first_widget
				trait_widget.content.locked = not trait_unlocked
				trait_widget.content.title_text = trait_display_name
				trait_widget.content.description_text = description_text
				local trait_scenegraph_name = "trait_preview_" .. i
				local description_scenegraph_id = "trait_description_" .. i
				local description_field_scenegraph = ui_scenegraph[description_scenegraph_id]
				local _, description_text_height = self:get_word_wrap_size(description_text, trait_widget_style.description_text, description_field_scenegraph.size[1])
				local trait_total_height = icon_height + description_text_spacing + description_text_height

				if not is_first_widget then
					trait_total_height = trait_total_height + divider_height
				end

				local position = ui_scenegraph[trait_scenegraph_name].local_position
				position[2] = (is_first_widget and 0) or -(total_traits_height + divider_height)
				total_traits_height = total_traits_height + trait_total_height
			end

			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	total_traits_height = total_traits_height + 120
	local height_percentage = total_traits_height / 819
	local new_uvs = {
		{
			0,
			1 - height_percentage
		},
		{
			1,
			height_percentage
		}
	}
	local background_widgets = self.preview_widgets_by_name.background_widgets
	background_widgets.preview_frame_background.content.uvs = new_uvs
	ui_scenegraph.preview_frame_background.size[2] = total_traits_height
	ui_scenegraph.preview_frame.size[2] = total_traits_height
end

RewardUI.get_text_size = function (self, localized_text, text_style)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, localized_text, font[1], scaled_font_size)

	return text_width, text_height
end

RewardUI.get_word_wrap_size = function (self, localized_text, text_style, text_area_width)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local lines = UIRenderer.word_wrap(self.ui_renderer, localized_text, font[1], scaled_font_size, text_area_width)
	local text_width, text_height = self:get_text_size(localized_text, text_style)

	return text_width, text_height * #lines
end

return
