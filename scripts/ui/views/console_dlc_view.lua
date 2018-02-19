local definitions = local_require("scripts/ui/views/console_dlc_view_definitions")
local gamepad_frame_widget_definitions = definitions.gamepad_frame_widget_definitions
local widget_definitions = definitions.widget_definitions
local background_widget_definitions = definitions.background_widget_definitions
local generic_input_actions = definitions.generic_input_actions
local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
local DLC_STRINGS = {
	witch_hunter_skin_01 = "igs_saltzpyre_skin",
	dwarf_ranger_skin_01 = "igs_bardin_skin",
	wood_elf_skin_01 = "igs_kerillian_skin",
	empire_soldier_skin_01 = "igs_kruber_skin",
	skin_info = "igs_skin_info",
	dwarfs = "igs_karak_azgaraz_desc",
	dlc_info = "igs_map_info",
	bright_wizard_skin_01 = "igs_sienna_skin",
	drachenfels = "igs_drachenfels_desc",
	survival_ruins = "igs_last_stand_desc",
	stromdorf = "igs_stromdorf_desc",
	reikwald = "igs_death_on_the_reik_desc"
}
ConsoleDLCView = class(ConsoleDLCView)
ConsoleDLCView.init = function (self, ui_context, is_sub_menu, parent)
	self._ui_renderer = ui_context.ui_renderer
	self._input_manager = ui_context.input_manager
	self._render_settings = {
		snap_pixel_positions = false
	}
	self._ui_context = ui_context
	self._skins_changed = false
	self._is_sub_menu = is_sub_menu
	self._parent = parent

	self._setup_input(self)
	self._create_ui_elements(self)

	return 
end
ConsoleDLCView._setup_input = function (self)
	self._input_manager:create_input_service("console_dlc", "IngameMenuKeymaps", "IngameMenuFilters")
	self._input_manager:map_device_to_service("console_dlc", "keyboard")
	self._input_manager:map_device_to_service("console_dlc", "mouse")
	self._input_manager:map_device_to_service("console_dlc", "gamepad")

	return 
end
ConsoleDLCView._reset = function (self)
	self._create_ui_elements(self)

	return 
end
ConsoleDLCView._create_ui_elements = function (self)
	self._ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self._ui_animations = {}
	self._animation_cbs = {}
	self._dlc_widgets = {}
	self._skin_widgets = {}
	self._dlc_index = 1
	self._video_delay = definitions.video_delay
	self._old_menu_description = nil
	self._widgets = {}

	for name, widget_definition in pairs(widget_definitions) do
		self._widgets[name] = UIWidget.init(widget_definition)
	end

	local widget = self._widgets.tab_widget

	self._setup_tabs(self, widget)

	self._dlcs = {}
	self._skin_dlcs = {}
	local unlocks = UnlockSettings[1].unlocks

	for name, unlock_data in pairs(unlocks) do
		if unlock_data.purchase_type == "dlc" then
			self._dlcs[#self._dlcs + 1] = {
				name = name,
				id = unlock_data.id,
				index = unlock_data.index
			}
		elseif unlock_data.purchase_type == "skin" then
			self._skin_dlcs[#self._skin_dlcs + 1] = {
				name = name,
				id = unlock_data.id,
				index = unlock_data.index
			}
		end
	end

	table.sort(self._dlcs, function (a, b)
		return b.index < a.index
	end)
	table.sort(self._skin_dlcs, function (a, b)
		return a.index < b.index
	end)
	self._create_dlc_widgets(self)

	self._menu_input_description = MenuInputDescriptionUI:new(self._ui_context, self._ui_renderer, Managers.input:get_service("console_dlc"), 10, UILayer.default, generic_input_actions)
	self._background_widgets = {}

	for name, widget_definition in pairs(background_widget_definitions) do
		self._background_widgets[name] = UIWidget.init(widget_definition)
	end

	UIRenderer.clear_scenegraph_queue(self._ui_renderer)

	return 
end
ConsoleDLCView._create_dlc_widgets = function (self)
	table.clear(self._dlc_widgets)
	self._reset_animations(self)
	self._destroy_data_entry(self, true)
	self._destroy_video(self)

	self._entry_offset = definitions.entry_size
	self._dlc_index = math.min(self._dlc_index, #self._dlcs)
	self._num_dlcs = #self._dlcs
	self._current_dlcs = self._dlcs
	local offset_y = 0
	local spacing = definitions.spacing

	for idx, dlc_data in ipairs(self._dlcs) do
		local name = dlc_data.name
		local has_trailer = true
		local entry = definitions.create_dlc_entry("dlc_image_entry", offset_y, name .. "_dlc_image", name, has_trailer and name .. "_trailer", name .. "_bg", dlc_data.id)
		self._dlc_widgets["dlc_entry_" .. idx] = UIWidget.init(entry)
		offset_y = offset_y - self._entry_offset[2] - spacing
	end

	self._dlc_widgets.dlc_entry_1.style.color[1] = 255
	self._dlc_widgets.dlc_entry_1.style.bg_overlay.color[1] = 255

	self._setup_scrollbar(self, self._dlcs)
	self._update_selection(self, self._dlc_index)

	local scenegraph_entry = self._ui_scenegraph.dlc_image_entry
	self._ui_animations.clear = UIAnimation.init(UIAnimation.function_by_time, scenegraph_entry.position, 1, scenegraph_entry.position[1], 0, 0.5, math.easeOutCubic)
	self._animation_cbs.clear = function ()
		table.clear(self._skin_widgets)
		print("Deleting skins")

		return 
	end
	local tab_widget = self._widgets.tab_widget
	local tab_widget_style = tab_widget.style
	local tab_widget_content = tab_widget.content
	local ui_scenegraph = self._ui_scenegraph
	local scenegraph_size = ui_scenegraph[tab_widget.scenegraph_id].size
	local style_left = tab_widget_style.dlc_left_text
	local style_right = tab_widget_style.dlc_right_text
	self._ui_animations.selection_offset = UIAnimation.init(UIAnimation.function_by_time, tab_widget_style.selection.offset, 1, tab_widget_style.selection.offset[1], scenegraph_size[1]*0.5 - tab_widget_content.spacing*0.5 - style_left.width, 0.5, math.easeOutCubic)
	self._ui_animations.selection_size = UIAnimation.init(UIAnimation.function_by_time, tab_widget_style.selection.rect_size, 1, tab_widget_style.selection.rect_size[1], style_left.width, 0.5, math.easeOutCubic)

	return 
end
ConsoleDLCView._create_skins_widgets = function (self)
	table.clear(self._skin_widgets)
	self._reset_animations(self)
	self._destroy_data_entry(self)
	self._destroy_video(self)

	self._entry_offset = definitions.entry_size
	self._dlc_index = math.min(self._dlc_index, #self._skin_dlcs)
	self._num_dlcs = #self._skin_dlcs
	self._current_dlcs = self._skin_dlcs
	local offset_y = 0
	local spacing = definitions.spacing

	for idx, dlc_data in ipairs(self._skin_dlcs) do
		local name = dlc_data.name
		local entry = definitions.create_dlc_entry("dlc_skin_image_entry", offset_y, name .. "_dlc_image", name, nil, "arrogance_lost_bg", dlc_data.id)
		self._skin_widgets["dlc_entry_" .. idx] = UIWidget.init(entry)
		offset_y = offset_y - self._entry_offset[2] - spacing
	end

	self._skin_widgets.dlc_entry_1.style.color[1] = 255
	self._skin_widgets.dlc_entry_1.style.bg_overlay.color[1] = 255

	self._setup_scrollbar(self, self._skin_dlcs)
	self._update_selection(self, self._dlc_index)

	local scenegraph_entry = self._ui_scenegraph.dlc_image_entry
	self._ui_animations.clear = UIAnimation.init(UIAnimation.function_by_time, scenegraph_entry.position, 1, scenegraph_entry.position[1], -definitions.entry_size[1]*1.25, 0.5, math.easeOutCubic)
	self._animation_cbs.clear = function ()
		table.clear(self._dlc_widgets)
		print("Deleting dlcs")

		return 
	end
	local tab_widget = self._widgets.tab_widget
	local tab_widget_style = tab_widget.style
	local tab_widget_content = tab_widget.content
	local ui_scenegraph = self._ui_scenegraph
	local scenegraph_size = ui_scenegraph[tab_widget.scenegraph_id].size
	local style_left = tab_widget_style.dlc_left_text
	local style_right = tab_widget_style.dlc_right_text
	self._ui_animations.selection_offset = UIAnimation.init(UIAnimation.function_by_time, tab_widget_style.selection.offset, 1, tab_widget_style.selection.offset[1], scenegraph_size[1]*0.5 + tab_widget_content.spacing*0.5, 0.5, math.easeOutCubic)
	self._ui_animations.selection_size = UIAnimation.init(UIAnimation.function_by_time, tab_widget_style.selection.rect_size, 1, tab_widget_style.selection.rect_size[1], style_right.width, 0.5, math.easeOutCubic)

	return 
end
ConsoleDLCView._setup_tabs = function (self, widget)
	local ui_scenegraph = self._ui_scenegraph
	local tab_widget_content = widget.content
	local tab_widget_style = widget.style
	local style_left = tab_widget_style.dlc_left_text
	local style_right = tab_widget_style.dlc_right_text
	local text_left = Localize(tab_widget_content.dlc_left_id)
	local text_right = Localize(tab_widget_content.dlc_right_id)
	local scengraph_size = ui_scenegraph[widget.scenegraph_id].size
	local font, size = UIFontByResolution(style_left)
	local font_material, font_size, font_name = unpack(font)
	font_size = size
	local left_width = UIRenderer.text_size(self._ui_renderer, text_left, font_material, font_size)
	style_left.offset[1] = -scengraph_size[1]*0.5 - tab_widget_content.spacing*0.5
	style_left.width = left_width
	local font, size = UIFontByResolution(style_right)
	local font_material, font_size, font_name = unpack(font)
	font_size = size
	local right_width = UIRenderer.text_size(self._ui_renderer, text_right, font_material, font_size)
	style_right.offset[1] = scengraph_size[1]*0.5 + tab_widget_content.spacing*0.5
	style_right.width = right_width
	tab_widget_style.selection.offset[1] = scengraph_size[1]*0.5 - tab_widget_content.spacing*0.5 - style_left.width
	tab_widget_style.selection.rect_size[1] = style_left.width
	tab_widget_style.selection.offset[1] = scengraph_size[1]*0.5 + tab_widget_content.spacing*0.5
	tab_widget_style.selection.rect_size[1] = style_right.width

	return 
end
ConsoleDLCView._setup_scrollbar = function (self, dlcs)
	local scrollbar_widget = UIWidget.init(definitions.scrollbar_definition)
	self._widgets.scrollbar = scrollbar_widget
	local percentage = #dlcs/1
	scrollbar_widget.content.scroll_bar_info.bar_height_percentage = percentage
	scrollbar_widget.content.disable_frame = true

	self._set_scrollbar_value(self, 0)

	return 
end
ConsoleDLCView._set_scrollbar_value = function (self, value)
	local widget_scroll_bar_info = self._widgets.scrollbar.content.scroll_bar_info
	widget_scroll_bar_info.value = value

	return 
end
ConsoleDLCView.input_service = function (self)
	return self._input_manager:get_service("console_dlc")
end
ConsoleDLCView.on_enter = function (self)
	local input_manager = Managers.input

	input_manager.block_device_except_service(input_manager, "console_dlc", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "console_dlc", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "console_dlc", "gamepad", 1)
	Managers.music:trigger_event("Play_hud_button_open")

	if not PlayerData.additional_content_data.dlc_menu_shown then
		PlayerData.additional_content_data.dlc_menu_shown = true

		Managers.save:auto_save(SaveFileName, SaveData)
	end

	self._active = true

	Managers.transition:force_fade_in()
	Managers.transition:fade_out(3)

	if self._parent and self._parent.set_mask_enabled then
		self._parent:set_mask_enabled(false)
	end

	self._skip_input = true

	return 
end
ConsoleDLCView.active = function (self)
	return self._active
end
ConsoleDLCView.on_exit = function (self)
	self._reset(self)

	self._active = false

	if self._popup_id then
		Managers.popup:cancel_popup(self._popup_id)

		self._popup_id = nil
	end

	if self._skins_changed then
		Managers.save:auto_save(SaveFileName, SaveData)

		self._skins_changed = false
	end

	Managers.music:trigger_event("Play_hud_button_close")

	local input_manager = Managers.input

	input_manager.block_device_except_service(input_manager, "map_menu", "keyboard", 1)
	input_manager.block_device_except_service(input_manager, "map_menu", "mouse", 1)
	input_manager.block_device_except_service(input_manager, "map_menu", "gamepad", 1)
	Managers.transition:force_fade_in()
	Managers.transition:fade_out(3)

	if self._parent and self._parent.set_mask_enabled then
		self._parent:set_mask_enabled(true)
	end

	return 
end
ConsoleDLCView.transitioning = function (self)
	if self._exiting then
		return true
	else
		return not self._active
	end

	return 
end
local DO_RELOAD = true
ConsoleDLCView.update = function (self, dt, t)
	if DO_RELOAD then
		self._create_ui_elements(self)

		DO_RELOAD = false
	end

	if not self._active then
		return 
	end

	script_data.console_dlc = self

	self._update_menu_description(self, dt, t)
	self._update_scrollbar(self, dt, t)
	self._update_input(self, dt, t)
	self._update_animations(self, dt, t)
	self._update_video(self, dt, t)
	self._draw(self, dt, t)
	self._handle_popup(self, dt, t)

	return 
end
ConsoleDLCView._handle_popup = function (self, dt, t)
	if self._popup_id then
		local popup_result = Managers.popup:query_result(self._popup_id)

		if popup_result then
			self._popup_id = nil
		end
	end

	return 
end
ConsoleDLCView._update_scrollbar = function (self, dt, t)
	local ui_scenegraph = self._ui_scenegraph
	local scenegraph_entry = ui_scenegraph.dlc_image_entry
	local entry_size = definitions.entry_size
	local spacing = definitions.spacing
	local num_dlcs = self._num_dlcs
	local pos_y = scenegraph_entry.position[2]
	local max_y = (num_dlcs - 1)*entry_size[2] + (num_dlcs - 1)*spacing
	local value = pos_y/max_y

	self._set_scrollbar_value(self, value)

	return 
end
ConsoleDLCView._play_sound = function (self, event_name)
	Managers.music:trigger_event(event_name)

	return 
end
ConsoleDLCView._update_input = function (self, dt, t)
	if self._skip_input then
		self._skip_input = nil

		return 
	end

	local input_service = Managers.input:get_service("console_dlc")

	if input_service.get(input_service, "move_up") and 1 < self._dlc_index then
		self._update_selection(self, self._dlc_index - 1)
		self._play_sound(self, "Play_hud_next_tab")
	elseif input_service.get(input_service, "move_down") and self._dlc_index < self._num_dlcs then
		self._update_selection(self, self._dlc_index + 1)
		self._play_sound(self, "Play_hud_next_tab")
	elseif input_service.get(input_service, "toggle_menu") then
		self.exit(self)
	elseif input_service.get(input_service, "cycle_next") then
		local content = self._widgets.tab_widget.content
		local old_selection = content.selected
		content.selected = "skin"

		if old_selection ~= "skin" then
			self._create_skins_widgets(self)
			self._play_sound(self, "Play_hud_next_tab")
		end
	elseif input_service.get(input_service, "cycle_previous") then
		local content = self._widgets.tab_widget.content
		local old_selection = content.selected
		content.selected = "dlc"

		if old_selection ~= "dlc" then
			self._create_dlc_widgets(self)
			self._play_sound(self, "Play_hud_next_tab")
		end
	elseif input_service.get(input_service, "special_1") then
		local content = self._widgets.tab_widget.content

		if content.selected == "dlc" then
			local widget = self._dlc_widgets["dlc_entry_" .. self._dlc_index]

			if not widget then
				return 
			end

			local widget_content = widget.content
			local video_content = widget_content.video_content

			if video_content.material_name then
				widget_content.video_active = not widget_content.video_active
				video_content.video_completed = false
				self._video_delay = nil

				self._play_sound(self, "Play_hud_select")
			end
		else
			local widget = self._skin_widgets["dlc_entry_" .. self._dlc_index]

			if not widget then
				return 
			end

			local widget_content = widget.content

			if Managers.unlock:is_dlc_unlocked(widget_content.dlc_name) and widget_content.skin_settings then
				local skin_settings = SkinSettings[widget_content.skin_settings.name]

				if skin_settings then
					local profile_name = skin_settings.profile_name
					local current_skin = PlayerData.skins_activated_data[profile_name]

					if current_skin == widget_content.skin_settings.name then
						PlayerData.skins_activated_data[profile_name] = nil
					else
						PlayerData.skins_activated_data[profile_name] = widget_content.skin_settings.name
					end

					self._play_sound(self, "Play_hud_select")

					self._skins_changed = true
				end
			end
		end
	elseif input_service.get(input_service, "back") then
		self.exit(self)
	elseif input_service.get(input_service, "refresh") then
		if not self._popup_id then
			local content = self._widgets.tab_widget.content

			if content.selected == "dlc" then
				self._popup_id = Managers.popup:queue_popup(Localize("igs_map_info"), Localize("input_description_information"), "ok", Localize("button_ok"))
			elseif content.selected == "skin" then
				self._popup_id = Managers.popup:queue_popup(Localize("igs_skin_info"), Localize("input_description_information"), "ok", Localize("button_ok"))
			end
		end
	elseif input_service.get(input_service, "confirm") then
		local dlc = self._current_dlcs[self._dlc_index]
		local dlc_name = dlc.name

		if not Managers.unlock:is_dlc_unlocked(dlc.name) and dlc.id then
			if PLATFORM == "win32" then
				local dlc_id = Managers.unlock:dlc_id(dlc_name)

				if rawget(_G, "Steam") then
					Steam.open_overlay_store(dlc_id)
				end
			elseif PLATFORM == "xb1" then
				local user_id = Managers.account:user_id()
				local product_id = Managers.unlock:dlc_id(dlc_name)

				XboxLive.show_product_details(user_id, product_id)
			elseif PLATFORM == "ps4" then
				local user_id = Managers.account:user_id()
				local product_label = Managers.unlock:ps4_dlc_product_label(dlc_name)

				Managers.system_dialog:open_commerce_dialog(NpCommerceDialog.MODE_PRODUCT, user_id, {
					product_label
				})
			end
		end
	end

	return 
end
ConsoleDLCView._update_menu_description = function (self)
	local tab_widget = self._widgets.tab_widget
	local tab_widget_content = tab_widget.content
	local widgets = (tab_widget_content.selected == "dlc" and self._dlc_widgets) or self._skin_widgets
	local widget = widgets["dlc_entry_" .. self._dlc_index]
	local widget_content = widget.content
	local dlc_name = widget_content.dlc_name

	if Managers.unlock:is_dlc_unlocked(dlc_name) or not widget_content.id then
		if widget_content.video_content.video_name then
			if widget_content.video_active then
				self._menu_description = "owned_video_stop"
			else
				self._menu_description = "owned_video_play"
			end
		elseif widget_content.skin_settings and widget_content.skin_settings.name then
			local skin_settings = widget_content.skin_settings

			if skin_settings and PlayerData.skins_activated_data[skin_settings.profile_name] == widget_content.skin_settings.name then
				self._menu_description = "owned_unequip_skin"
			elseif skin_settings then
				self._menu_description = "owned_equip_skin"
			else
				self._menu_description = "owned"
			end
		else
			self._menu_description = "owned"
		end
	elseif widget_content.video_content.video_name then
		if widget_content.video_active then
			self._menu_description = "not_owned_video_stop"
		else
			self._menu_description = "not_owned_video_play"
		end
	else
		self._menu_description = "not_owned"
	end

	if self._menu_description ~= self._old_menu_description then
		self._menu_input_description:set_input_description(definitions.menu_descriptions_input_actions[self._menu_description])
	end

	self._old_menu_description = self._menu_description

	return 
end
ConsoleDLCView._update_selection = function (self, index)
	local ui_scenegraph = self._ui_scenegraph
	local scenegraph_entry = ui_scenegraph.dlc_image_entry
	local entry_size = definitions.entry_size
	local spacing = definitions.spacing

	self._reset_animations(self)
	self._destroy_data_entry(self)
	self._destroy_video(self)

	local tab_widget = self._widgets.tab_widget
	local tab_widget_content = tab_widget.content
	local widgets = (tab_widget_content.selected == "dlc" and self._dlc_widgets) or self._skin_widgets
	local old_widget = widgets["dlc_entry_" .. self._dlc_index]
	self._dlc_index = index
	local end_pos = (self._dlc_index - 1)*entry_size[2] + (self._dlc_index - 1)*spacing
	self._ui_animations.selection = UIAnimation.init(UIAnimation.function_by_time, scenegraph_entry.position, 2, scenegraph_entry.position[2], end_pos, 0.5, math.easeOutCubic)

	if tab_widget_content.selected == "dlc" then
		self._animation_cbs.selection = callback(self, "cb_create_dlc_info", self._dlcs[self._dlc_index])
	else
		self._animation_cbs.selection = callback(self, "cb_create_skin_info", self._skin_dlcs[self._dlc_index])
	end

	local new_widget = widgets["dlc_entry_" .. self._dlc_index]
	self._ui_animations.color = UIAnimation.init(UIAnimation.function_by_time, new_widget.style.color, 1, new_widget.style.color[1], 255, 0.5, math.easeOutCubic)
	self._ui_animations.bg_fade_in = UIAnimation.init(UIAnimation.function_by_time, new_widget.style.bg_overlay.color, 1, new_widget.style.bg_overlay.color[1], 255, 0.5, math.easeOutCubic)

	if old_widget ~= new_widget then
		self._ui_animations.bg_fade_out = UIAnimation.init(UIAnimation.function_by_time, old_widget.style.bg_overlay.color, 1, old_widget.style.bg_overlay.color[1], 0, 0.5, math.easeOutCubic)
		self._ui_animations.color_fade = UIAnimation.init(UIAnimation.function_by_time, old_widget.style.color, 1, old_widget.style.color[1], 60, 0.5, math.easeOutCubic)
	end

	self._video_delay = definitions.video_delay

	return 
end
ConsoleDLCView.exit = function (self)
	if self._is_sub_menu then
		self.on_exit(self)
	else
		self._ui_context.ingame_ui:handle_transition("exit_menu")
	end

	return 
end
ConsoleDLCView._reset_animations = function (self)
	local color_fade_animation = self._ui_animations.color_fade
	local color_animation = self._ui_animations.color
	local bg_fade_in_animation = self._ui_animations.bg_fade_in
	local bg_fade_out_animation = self._ui_animations.bg_fade_out

	if color_fade_animation then
		UIAnimation.update(color_fade_animation, math.huge)
	end

	if color_animation then
		UIAnimation.update(color_animation, math.huge)
	end

	if bg_fade_in_animation then
		UIAnimation.update(bg_fade_in_animation, math.huge)
	end

	if bg_fade_out_animation then
		UIAnimation.update(bg_fade_out_animation, math.huge)
	end

	table.clear(self._animation_cbs)

	return 
end
ConsoleDLCView._destroy_data_entry = function (self, destroy_skins)
	self._dlc_widgets.dlc_data_entry = nil

	if destroy_skins then
		self._skin_widgets.dlc_data_entry = nil
	else
		local widget = self._skin_widgets.dlc_data_entry

		if widget then
			widget.style.text.text_color[1] = 0
		end
	end

	self._ui_animations.text_fade = nil
	self._ui_animations.logo_fade = nil

	return 
end
ConsoleDLCView.cb_create_dlc_info = function (self, dlc_data)
	local name = dlc_data.name
	local entry = definitions.create_dlc_data_entry(name .. "_dlc_logo", DLC_STRINGS[name])
	local widget = UIWidget.init(entry)

	self._play_sound(self, "hud_menu_select")

	self._dlc_widgets.dlc_data_entry = widget
	self._ui_animations.text_fade = UIAnimation.init(UIAnimation.function_by_time, widget.style.text.text_color, 1, widget.style.text.text_color[1], 255, 0.5, math.easeOutCubic)
	self._ui_animations.logo_fade = UIAnimation.init(UIAnimation.function_by_time, widget.style.logo.color, 1, widget.style.logo.color[1], 255, 0.5, math.easeOutCubic)

	return 
end
ConsoleDLCView.cb_create_skin_info = function (self, dlc_data, do_logo_fade)
	local name = dlc_data.name
	local entry = definitions.create_dlc_data_entry("arrogance_lost_logo", DLC_STRINGS[name] or "")
	local widget = UIWidget.init(entry)

	self._play_sound(self, "hud_menu_select")

	self._skin_widgets.dlc_data_entry = widget
	self._ui_animations.text_fade = UIAnimation.init(UIAnimation.function_by_time, widget.style.text.text_color, 1, widget.style.text.text_color[1], 255, 0.5, math.easeOutCubic)

	if do_logo_fade then
		self._ui_animations.logo_fade = UIAnimation.init(UIAnimation.function_by_time, widget.style.logo.color, 1, widget.style.logo.color[1], 255, 0.5, math.easeOutCubic)
	else
		widget.style.logo.color[1] = 255
	end

	return 
end
ConsoleDLCView._update_animations = function (self, dt, t)
	for name, animation in pairs(self._ui_animations) do
		UIAnimation.update(animation, dt)

		if UIAnimation.completed(animation) then
			self._ui_animations[name] = nil
			local cb = self._animation_cbs[name]

			if cb then
				cb()
			end

			self._animation_cbs[name] = nil
		end
	end

	return 
end
ConsoleDLCView._destroy_video = function (self)
	local widget = self._dlc_widgets["dlc_entry_" .. self._dlc_index]

	if widget then
		local widget_content = widget.content
		local video_content = widget_content.video_content
		widget_content.video_active = false
		video_content.video_completed = false
		video_content.video_player_created = false
	end

	self._video_delay = definitions.video_delay

	if self._ui_renderer.video_player then
		UIRenderer.destroy_video_player(self._ui_renderer, Application.main_world())
	end

	return 
end
ConsoleDLCView._update_video = function (self, dt, t)
	local widget = self._dlc_widgets["dlc_entry_" .. self._dlc_index]

	if not widget then
		return 
	end

	local widget_content = widget.content
	local video_content = widget_content.video_content

	if not video_content.video_name then
		return 
	end

	if not widget_content.video_active and self._video_delay then
		self._video_delay = self._video_delay - dt

		if self._video_delay <= 0 then
			widget_content.video_active = true
			self._video_delay = nil
		else
			return 
		end
	end

	if widget_content.video_active then
		if not self._ui_renderer.video_player then
			UIRenderer.create_video_player(self._ui_renderer, Application.main_world(), video_content.video_name, false)
		else
			local video_complete = video_content.video_completed

			if video_complete then
				UIRenderer.destroy_video_player(self._ui_renderer, Application.main_world())

				video_content.video_player_created = false
				widget_content.video_active = false
			else
				video_content.video_player_created = true
			end
		end
	elseif self._ui_renderer.video_player then
		UIRenderer.destroy_video_player(self._ui_renderer, Application.main_world())

		video_content.video_player_created = false
		widget_content.video_active = false
	end

	return 
end
ConsoleDLCView._draw = function (self, dt, t)
	local ui_renderer = self._ui_renderer
	local ui_scenegraph = self._ui_scenegraph
	local input_service = Managers.input:get_service("console_dlc") or fake_input_service

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self._render_settings)

	for _, widget in pairs(self._widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in pairs(self._dlc_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in pairs(self._skin_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	for _, widget in pairs(self._background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.end_pass(ui_renderer)
	self._menu_input_description:draw(ui_renderer, dt)

	return 
end
ConsoleDLCView.destroy = function (self)
	if self._popup_id then
		Managers.popup:cancel_popup(self._popup_id)

		self._popup_id = nil
	end

	return 
end

return 
