local font_size = 26
local font = "gw_arial_32"
local font_mtrl = "materials/fonts/" .. font
local fade_speed = 10
local console_width = 800

local function ease_out_quad(t, b, c, d)
	t = t/d

	return -c*t*(t - 2) + b
end

local indicator_offset = 0

local function update_option(cs, option_index, dont_save)
	local option = cs.options[option_index]
	cs.selected_id = option_index

	if option == "[clear value]" then
		option, cs.selected_id = nil
	end

	if cs.copy then
		cs.copy.selected_id = cs.selected_id
	end

	if cs.commands then
		local command_list = cs.commands[cs.hot_id]

		if command_list then
			for i = 1, #command_list, 1 do
				local command_table = command_list[i]

				Application.console_command(unpack(command_table))
			end
		end
	end

	Development.set_setting(cs.title, option)

	script_data[cs.title] = option

	Development.clear_param_cache(cs.title)

	if cs.callback then
		cs.callback(option)
	end

	if not dont_save then
		printf("DebugScreen: script_data.%-35s = %s", cs.title, tostring(cs.options[option_index]))
		Application.save_user_settings()
	end

	return 
end

local function activate_preset(cs)
	for preset_key, preset_value in pairs(cs.preset) do
		for cs2_i = 1, #DebugScreen.console_settings, 1 do
			local cs2 = DebugScreen.console_settings[cs2_i]

			if cs2.title == preset_key and cs2.is_boolean then
				update_option(cs2, (preset_value and 1) or 2)
			end
		end
	end

	cs.selected_id = nil

	Development.set_setting(cs.title, nil)

	script_data[cs.title] = nil

	Development.clear_param_cache(cs.title)

	return 
end

DebugScreen = DebugScreen or {}
local script_data_printed = false
DebugScreen.setup = function (world, settings, callbacks)
	Profiler.start("DebugScreen.setup")

	local DebugScreen = DebugScreen
	DebugScreen.world = world
	DebugScreen.gui = World.create_screen_gui(world, "material", "materials/fonts/gw_fonts", "material", "materials/menu/debug_screen", "immediate")
	DebugScreen.active = false
	local script_data = script_data
	DebugScreen.console_settings = {}

	for i = 1, #settings, 1 do
		local cs = {
			hot_id = 1,
			options = {}
		}
		local setting = settings[i]

		if setting.item_source then
			local item_source = setting.item_source

			for k, v in pairs(item_source) do
				local option = k
				cs.options[#cs.options + 1] = option
			end

			if setting.func then
				cs.func = setting.func
				cs.clear_setting = false
			end

			cs.load_items_source_func = setting.load_items_source_func
		elseif setting.is_boolean then
			cs.is_boolean = true
			cs.options[#cs.options + 1] = true
			cs.options[#cs.options + 1] = false

			if setting.func then
				cs.func = setting.func
			end
		elseif setting.command_list then
			cs.commands = {}

			for j = 1, #setting.command_list, 1 do
				local command = setting.command_list[j]
				cs.options[#cs.options + 1] = command.description
				cs.commands[#cs.commands + 1] = command.commands
			end
		elseif setting.func then
			cs.options[1] = "Activate function"
			cs.func = setting.func
		elseif setting.preset then
			cs.options[1] = "Activate preset"
			cs.preset = setting.preset
		end

		if setting.bitmap then
			cs.bitmap = setting.bitmap
			cs.bitmap_size = setting.bitmap_size
		end

		if setting.callback then
			cs.callback = callbacks[setting.callback]
		end

		cs.title = setting.setting_name
		cs.description = setting.description
		cs.category = setting.category
		cs.close_when_selected = setting.close_when_selected
		cs.clear_when_selected = setting.clear_when_selected

		for j = 1, #cs.options, 1 do
			local option = cs.options[j]

			if Development.parameter(cs.title) == option then
				cs.selected_id = j
				cs.hot_id = j

				update_option(cs, j, true)
			end
		end

		if 0 < #cs.options and not setting.no_nil and not setting.func and not setting.preset then
			cs.options[#cs.options + 1] = "[clear value]"
		end

		DebugScreen.console_settings[#DebugScreen.console_settings + 1] = cs
	end

	for i = 1, #DebugScreen.console_settings, 1 do
		local cs = DebugScreen.console_settings[i]

		if cs.preset and Development.parameter(cs.title) then
			activate_preset(cs)
		end
	end

	DebugScreen.shortcut_list = {}
	DebugScreen.shortcuts = Development.setting("debug_shortcuts") or {
		"numpad 0",
		"debug_weapons"
	}

	for i = 1, #DebugScreen.shortcuts, 1 do
		local shortcut_input = DebugScreen.shortcuts[i]
		local shortcut_setting = DebugScreen.shortcuts[i + 1]
		i = i + 1

		for j = 1, #DebugScreen.console_settings, 1 do
			local cs = DebugScreen.console_settings[j]

			if cs.title == shortcut_setting then
				DebugScreen.shortcut_list[shortcut_input] = cs

				break
			end
		end
	end

	DebugScreen.favorites = Development.setting("debug_favorites") or {}

	for i = 1, #DebugScreen.favorites, 1 do
		local favorite = DebugScreen.favorites[i]

		for j = 1, #DebugScreen.console_settings, 1 do
			local cs = DebugScreen.console_settings[j]

			if cs.title == favorite then
				local cs_copy = table.clone(cs)
				cs_copy.category = "Favorites"
				cs.copy = cs_copy
				cs_copy.copy = cs

				table.insert(DebugScreen.console_settings, 1, cs_copy)

				break
			end
		end
	end

	if not script_data.debug_enabled then
		script_data.disable_debug_draw = true
	end

	DebugScreen.active_id = nil
	DebugScreen.hot_id = 1
	DebugScreen.fade_timer = 0
	DebugScreen.closing = false
	DebugScreen.target_y_offset = 0
	DebugScreen.text_effects = {}
	DebugScreen.hold_to_move_timer = 0
	DebugScreen.is_holding = false
	DebugScreen.active_shortcut_data = {
		time = 0
	}
	DebugScreen.unblocked_services = {}
	DebugScreen.unblocked_services_n = 0
	DebugScreen.search_active = false
	DebugScreen.search_string = ""
	DebugScreen.filtered_console_settings = DebugScreen.console_settings

	Profiler.stop("DebugScreen.setup")

	return 
end
DebugScreen.destroy = function ()
	DebugScreen.world = nil
	DebugScreen.gui = nil

	return 
end
local accelerate_factor = 1
DebugScreen.update = function (dt, t, input_service, input_manager)
	if not script_data.debug_enabled or not input_service then
		return 
	end

	local gui = DebugScreen.gui
	local time_scale = GLOBAL_TIME_SCALE
	dt = dt/GLOBAL_TIME_SCALE
	DebugScreen.time = (DebugScreen.time or 0) + dt
	local t = DebugScreen.time
	local DebugScreen = DebugScreen
	local script_data = script_data
	local opened_this_frame = false
	local mod_key_down = input_service.get(input_service, "console_mod_key")

	if input_service.get(input_service, "console_open_key") then
		DebugScreen.active = not DebugScreen.active

		if DebugScreen.active then
			input_manager.device_block_service(input_manager, "keyboard", 1, "Debug")
		else
			input_manager.device_unblock_service(input_manager, "keyboard", 1, "Debug")
		end
	end

	if input_service.get(input_service, "right_key") and not DebugScreen.active then
		DebugScreen.active = not DebugScreen.active

		input_manager.device_block_service(input_manager, "keyboard", 1, "Debug", "debug_screen")

		opened_this_frame = true
	end

	if not DebugScreen.active and DebugScreen.fade_timer == 0 then
		for shortcut_input, cs in pairs(DebugScreen.shortcut_list) do
			if Keyboard.pressed(Keyboard.button_index(shortcut_input)) then
				if cs.hot_id == #cs.options then
					cs.hot_id = 1
				else
					cs.hot_id = cs.hot_id + 1
				end

				if cs.func then
					cs.func(cs, cs.hot_id)
				else
					update_option(cs, cs.hot_id)
				end

				DebugScreen.active_shortcut_data.time = t + 1
				DebugScreen.active_shortcut_data.cs = cs
			end
		end

		if t < DebugScreen.active_shortcut_data.time then
			local cs = DebugScreen.active_shortcut_data.cs

			Debug.text("Debug Screen: %s = %s", cs.title, tostring(cs.options[cs.selected_id]))
		end

		return 
	end

	DebugScreen.update_search(input_manager, input_service, gui, t, dt)

	if DebugScreen.active then
		DebugScreen.fade_timer = math.min(1, DebugScreen.fade_timer + dt*fade_speed)
	else
		DebugScreen.fade_timer = math.max(0, DebugScreen.fade_timer - dt*fade_speed)
	end

	local filtered_console_settings = DebugScreen.console_settings

	if DebugScreen.hot_id == nil then
	end

	local current_hot_cs = DebugScreen.filtered_console_settings[DebugScreen.hot_id]

	if DebugScreen.search_active and DebugScreen.search_string ~= "" then
		filtered_console_settings = {}

		for i = 1, #DebugScreen.console_settings, 1 do
			local cs = DebugScreen.console_settings[i]

			if cs.title:lower():find(DebugScreen.search_string) ~= nil then
				filtered_console_settings[#filtered_console_settings + 1] = cs
			end
		end
	end

	DebugScreen.hot_id = 1

	for i = 1, #filtered_console_settings, 1 do
		local cs = filtered_console_settings[i]

		if cs == current_hot_cs then
			DebugScreen.hot_id = i
		end
	end

	DebugScreen.filtered_console_settings = filtered_console_settings

	if input_service.get(input_service, "up_key") and DebugScreen.hold_to_move_timer < t then
		if DebugScreen.is_holding then
			DebugScreen.hold_to_move_timer = t + accelerate_factor*0.1
			accelerate_factor = accelerate_factor*0.95
		else
			DebugScreen.hold_to_move_timer = t + 0.1
			DebugScreen.is_holding = true
			accelerate_factor = 1
		end

		if DebugScreen.active_id == nil then
			if DebugScreen.hot_id == 1 then
				DebugScreen.hot_id = #filtered_console_settings
			elseif mod_key_down then
				local hot_id = DebugScreen.hot_id
				local cs_current = filtered_console_settings[hot_id]
				local category_current = cs_current.category
				local ignore_changed_cs = (not cs_current.is_boolean and cs_current.selected_id ~= nil) or cs_current.options[cs_current.selected_id]

				while 1 < hot_id do
					hot_id = hot_id - 1
					local cs = filtered_console_settings[hot_id]
					local cs_value_changed = (not cs.is_boolean and cs.selected_id ~= nil) or cs.options[cs.selected_id]

					if cs_value_changed and not ignore_changed_cs then
						break
					elseif not cs_value_changed then
						ignore_changed_cs = false
					end

					if cs.category ~= filtered_console_settings[math.max(1, hot_id - 1)].category then
						break
					end
				end

				DebugScreen.hot_id = hot_id
			else
				DebugScreen.hot_id = DebugScreen.hot_id - 1
			end
		else
			local cs = filtered_console_settings[DebugScreen.active_id]

			if cs.hot_id == 1 then
				cs.hot_id = #cs.options
			else
				cs.hot_id = cs.hot_id - 1
			end
		end
	end

	if input_service.get(input_service, "down_key") and DebugScreen.hold_to_move_timer < t then
		if DebugScreen.is_holding then
			DebugScreen.hold_to_move_timer = t + accelerate_factor*0.1
			accelerate_factor = accelerate_factor*0.95
		else
			DebugScreen.hold_to_move_timer = t + 0.1
			DebugScreen.is_holding = true
			accelerate_factor = 1
		end

		if DebugScreen.active_id == nil then
			if DebugScreen.hot_id == #filtered_console_settings then
				DebugScreen.hot_id = 1
			elseif mod_key_down then
				local hot_id = DebugScreen.hot_id
				local cs_current = filtered_console_settings[hot_id]
				local category_current = cs_current.category
				local ignore_changed_cs = (not cs_current.is_boolean and cs_current.selected_id ~= nil) or cs_current.options[cs_current.selected_id]

				while hot_id < #filtered_console_settings do
					hot_id = hot_id + 1
					local cs = filtered_console_settings[hot_id]
					local cs_value_changed = (not cs.is_boolean and cs.selected_id ~= nil) or cs.options[cs.selected_id]

					if cs_value_changed and not ignore_changed_cs then
						break
					elseif not cs_value_changed then
						ignore_changed_cs = false
					end

					if cs.category ~= filtered_console_settings[math.max(1, hot_id - 1)].category then
						break
					end
				end

				DebugScreen.hot_id = hot_id
			else
				DebugScreen.hot_id = DebugScreen.hot_id + 1
			end
		else
			local cs = filtered_console_settings[DebugScreen.active_id]

			if cs.hot_id == #cs.options then
				cs.hot_id = 1
			else
				cs.hot_id = cs.hot_id + 1
			end
		end
	end

	if not input_service.get(input_service, "down_key") and not input_service.get(input_service, "up_key") then
		DebugScreen.is_holding = false
	end

	if #filtered_console_settings < DebugScreen.hot_id then
		if #filtered_console_settings == 0 then
			DebugScreen.hot_id = 0
		else
			DebugScreen.hot_id = #filtered_console_settings
		end
	end

	local category_list_above = {}
	local category_list_total = {}

	for i = 1, DebugScreen.hot_id, 1 do
		category_list_above[filtered_console_settings[i].category] = true
	end

	for i = 1, #filtered_console_settings, 1 do
		category_list_total[filtered_console_settings[i].category] = true
	end

	local num_categories_above = table.size(category_list_above) - 1
	local num_categories_total = table.size(category_list_total) - 1
	local offset_lerp = ease_out_quad(DebugScreen.fade_timer, 0, 1, 1)
	local offset_x = offset_lerp*console_width
	local res_x = RESOLUTION_LOOKUP.res_w
	local res_y = RESOLUTION_LOOKUP.res_h
	local pos_y = res_y - 100
	local pos_x = -console_width + offset_x
	local wanted_y_offset = 0

	if 5 < DebugScreen.hot_id then
		wanted_y_offset = (DebugScreen.hot_id - 5)*(font_size + 2) + num_categories_above*font_size*1.4
	end

	if DebugScreen.active_id ~= nil then
		local cs = filtered_console_settings[DebugScreen.active_id]

		if 5 < cs.hot_id then
			wanted_y_offset = wanted_y_offset + (cs.hot_id - 5)*(font_size + 2)
		end
	end

	DebugScreen.target_y_offset = math.lerp(DebugScreen.target_y_offset, wanted_y_offset, 0.1)
	pos_y = pos_y + DebugScreen.target_y_offset
	indicator_offset = indicator_offset + dt*10

	if 10 < indicator_offset then
		indicator_offset = 0
	end

	local indicator_offset_anim = indicator_offset

	if 5 < indicator_offset_anim then
		indicator_offset_anim = indicator_offset_anim - 10
	end

	local hacky_offset_pls_calculate_this_better = 500
	local total_height = #DebugScreen.console_settings*(font_size + 2) + num_categories_total*font_size*1.4 + hacky_offset_pls_calculate_this_better
	local current_height = (DebugScreen.hot_id - 1)*(font_size + 2) + num_categories_above*font_size*1.4
	local scrollbar_size = (res_y*res_y)/total_height
	local scrollarea_size = total_height - res_y
	local scrollposition_ratio = current_height/scrollarea_size
	local scrollbar_pos = (res_y*current_height)/total_height

	Gui.rect(gui, Vector3(0, 0, 800), Vector2(offset_x, res_y), Color(offset_lerp*220, 25, 50, 25))
	Gui.rect(gui, Vector3(0, res_y - scrollbar_pos - scrollbar_size, 900), Vector2(3, scrollbar_size), Color(offset_lerp*150, 200, 200, 25))

	local hot_anim_t = (math.sin(t*10) + 1)*0.5
	local white = Color(offset_lerp*250, 255, 255, 255)
	local text_color = Color(offset_lerp*250, 120, 120, 0)
	local text_color_overridden = Color(offset_lerp*255, 200, 200, 0)
	local text_color_hot = Color(offset_lerp*255, hot_anim_t*25 + 230, hot_anim_t*25 + 230, hot_anim_t*200)
	local text_color_active = Color(offset_lerp*255, 100, 255, 100)
	local text_color_option_default_value = Color(offset_lerp*255, 50, 150, 50)
	local text_color_option_overridden = Color(offset_lerp*255, 100, 255, 100)
	local text_color_option_hot = Color(offset_lerp*255, 200, 255, 200)
	local text_color_description = Color(offset_lerp*255, 150, 150, 150)
	local row_highlight_color = Color(offset_lerp*150, 100, 100, 50)
	local setting_x = 30
	local option_x = 50
	local category_current = nil

	for i = 1, #filtered_console_settings, 1 do
		local is_active = i == DebugScreen.active_id
		local is_hot = i == DebugScreen.hot_id
		local cs = filtered_console_settings[i]
		local text = cs.title

		if cs.category ~= category_current then
			pos_y = pos_y - font_size*0.4
			category_current = cs.category

			Gui.text(gui, cs.category, font_mtrl, font_size, font, Vector3(10, pos_y, 900), white)

			pos_y = pos_y - font_size
		end

		local current_selected_option_position = Vector3(offset_x - 400, pos_y, 900)
		local option_text = nil

		if cs.selected_id ~= nil then
			option_text = string.format("< %s >", tostring(cs.options[cs.selected_id]))

			if is_hot then
				Gui.text(gui, option_text, font_mtrl, font_size, font, current_selected_option_position, text_color_option_hot)
			elseif not cs.is_boolean or cs.options[cs.selected_id] then
				Gui.text(gui, option_text, font_mtrl, font_size, font, current_selected_option_position, text_color_option_overridden)
			else
				Gui.text(gui, option_text, font_mtrl, font_size, font, current_selected_option_position, text_color_option_default_value)
			end
		end

		for temp_shortcut_input, temp_cs in pairs(DebugScreen.shortcut_list) do
			if cs == temp_cs or cs == temp_cs.copy then
				Gui.text(gui, "[" .. temp_shortcut_input .. "]", font_mtrl, font_size, font, Vector3(offset_x - 100, pos_y, 900), white)
			end
		end

		if is_active then
			Gui.text(gui, ">", font_mtrl, font_size, font, Vector3(10, pos_y, 900), text_color_active)
			Gui.text(gui, text, font_mtrl, font_size, font, Vector3(setting_x, pos_y, 900), text_color_active)

			pos_y = pos_y - (font_size + 2)
			local reuse_global_table = true
			local description_word_wrapped = Gui.word_wrap(gui, cs.description, font_mtrl, font_size, 500, " ", "", "\n", reuse_global_table)

			for j = 1, #description_word_wrapped, 1 do
				local description = description_word_wrapped[j]

				Gui.text(gui, description, font_mtrl, font_size, font, Vector3(setting_x, pos_y, 900), text_color_description)

				pos_y = pos_y - (font_size + 2)
			end

			for j = 1, #cs.options, 1 do
				local option = cs.options[j]
				local is_hot_sub = j == cs.hot_id
				local is_selected_sub = j == cs.selected_id
				local text_sub = tostring(option)

				if is_hot_sub then
				end

				if is_selected_sub then
					if is_hot_sub then
						Gui.rect(gui, Vector3(0, pos_y - 5, 810), Vector2(offset_x, 25), row_highlight_color)
						Gui.text(gui, ">", font_mtrl, font_size, font, Vector3(setting_x + indicator_offset_anim, pos_y, 900), text_color_hot)
					end

					Gui.text(gui, text_sub, font_mtrl, font_size, font, Vector3(option_x, pos_y, 900), text_color_active)
				elseif is_hot_sub then
					if (input_service.get(input_service, "right_key") or (input_service.has(input_service, "exclusive_right_key") and input_service.get(input_service, "exclusive_right_key"))) and not opened_this_frame then
						update_option(cs, j)

						if current_selected_option_position then
							DebugScreen.text_effects[#DebugScreen.text_effects + 1] = {
								time = 0,
								start_position = {
									option_x,
									pos_y,
									900
								},
								end_position = {
									current_selected_option_position.x,
									current_selected_option_position.y,
									current_selected_option_position.z
								},
								text = tostring(option)
							}

							if cs.close_when_selected then
								DebugScreen.active = false
								opened_this_frame = true

								input_manager.device_unblock_service(input_manager, "keyboard", 1, "Debug")
							end

							if cs.clear_when_selected then
								cs.selected_id = nil
							end
						end
					end

					Gui.rect(gui, Vector3(0, pos_y - 5, 810), Vector2(offset_x, 25), row_highlight_color)
					Gui.text(gui, ">", font_mtrl, font_size, font, Vector3(setting_x + indicator_offset_anim, pos_y, 900), text_color_hot)
					Gui.text(gui, text_sub, font_mtrl, font_size, font, Vector3(option_x, pos_y, 900), text_color_hot)
				else
					Gui.text(gui, text_sub, font_mtrl, font_size, font, Vector3(option_x, pos_y, 900), text_color)
				end

				pos_y = pos_y - (font_size + 2)
			end

			if cs.func and (input_service.get(input_service, "right_key") or (input_service.has(input_service, "exclusive_right_key") and input_service.get(input_service, "exclusive_right_key"))) and not opened_this_frame then
				cs.func(cs.options, cs.hot_id)

				if cs.clear_setting then
					cs.selected_id = nil

					Development.set_setting(cs.title, nil)

					script_data[cs.title] = nil

					Development.clear_param_cache(cs.title)
				end

				Application.save_user_settings()
			end

			if cs.preset and (input_service.get(input_service, "right_key") or (input_service.has(input_service, "exclusive_right_key") and input_service.get(input_service, "exclusive_right_key"))) and not opened_this_frame then
				activate_preset(cs)
				Application.save_user_settings()
			end

			if input_service.get(input_service, "left_key") then
				DebugScreen.active_id = nil
			end

			if cs.bitmap then
				local bitmap_size = Vector2(1, 1)*cs.bitmap_size

				Gui.bitmap(gui, cs.bitmap, Vector3(offset_x/2 - cs.bitmap_size/2, pos_y - cs.bitmap_size, 900), bitmap_size, Color(offset_lerp*250, 255, 255, 255))

				pos_y = pos_y - cs.bitmap_size
			end
		elseif is_hot then
			Gui.rect(gui, Vector3(0, pos_y - 5, 810), Vector2(offset_x, 25), row_highlight_color)
			Gui.text(gui, ">", font_mtrl, font_size, font, Vector3(indicator_offset_anim + 10, pos_y, 900), text_color_hot)
			Gui.text(gui, text, font_mtrl, font_size, font, Vector3(setting_x, pos_y, 900), text_color_hot)

			if input_service.get(input_service, "left_key") and DebugScreen.active_id == nil then
				if mod_key_down and 0 < #cs.options then
					if cs.is_boolean then
						cs.hot_id = 3
					elseif cs.hot_id == 1 then
						cs.hot_id = #cs.options
					else
						cs.hot_id = cs.hot_id - 1
					end

					local option = cs.options[cs.hot_id]

					update_option(cs, cs.hot_id)
				else
					DebugScreen.active = false

					input_manager.device_unblock_service(input_manager, "keyboard", 1, "Debug")
				end
			end

			if (input_service.get(input_service, "right_key") or (input_service.has(input_service, "exclusive_right_key") and input_service.get(input_service, "exclusive_right_key"))) and not opened_this_frame then
				if cs.load_items_source_func then
					cs.load_items_source_func(cs.options)
				end

				if mod_key_down and 0 < #cs.options then
					if cs.is_boolean then
						cs.hot_id = (cs.selected_id == 1 and 2) or 1
					elseif cs.hot_id == #cs.options then
						cs.hot_id = 1
					else
						cs.hot_id = cs.hot_id + 1
					end

					local option = cs.options[cs.hot_id]

					update_option(cs, cs.hot_id)
				else
					DebugScreen.active_id = i
				end
			end

			if not DebugScreen.search_active and input_service.get(input_service, "console_favorite_key") then
				if cs.category == "Favorites" then
					cs.copy.copy = nil
					local unfiltered_index = table.find(DebugScreen.console_settings, cs)

					table.remove(DebugScreen.console_settings, unfiltered_index)

					local favorite_index = table.find(DebugScreen.favorites, cs.title)

					if favorite_index then
						table.remove(DebugScreen.favorites, favorite_index)
						Development.set_setting("debug_favorites", DebugScreen.favorites)
						Application.save_user_settings()
					end

					break
				elseif not cs.copy then
					local cs_copy = table.clone(cs)
					cs_copy.category = "Favorites"
					cs.copy = cs_copy
					cs_copy.copy = cs

					table.insert(DebugScreen.console_settings, 1, cs_copy)

					DebugScreen.hot_id = DebugScreen.hot_id + 1
					DebugScreen.target_y_offset = DebugScreen.target_y_offset + font_size
					DebugScreen.favorites[#DebugScreen.favorites + 1] = cs.title

					Development.set_setting("debug_favorites", DebugScreen.favorites)
					Application.save_user_settings()

					break
				end
			end

			for i = 0, 9, 1 do
				local shortcut_input = "numpad " .. tostring(i)

				if Keyboard.pressed(Keyboard.button_index(shortcut_input)) then
					local remove = false

					for temp_shortcut_input, temp_cs in pairs(DebugScreen.shortcut_list) do
						if cs == temp_cs or cs == temp_cs.copy then
							DebugScreen.shortcut_list[temp_shortcut_input] = nil

							if temp_shortcut_input == shortcut_input then
								remove = true
							end
						end
					end

					if remove then
						break
					end

					if cs.category == "Favorites" then
						DebugScreen.shortcut_list[shortcut_input] = cs.copy
					else
						DebugScreen.shortcut_list[shortcut_input] = cs
					end

					local shortcuts = {}

					for temp_shortcut_input, temp_cs in pairs(DebugScreen.shortcut_list) do
						shortcuts[#shortcuts + 1] = temp_shortcut_input
						shortcuts[#shortcuts + 1] = temp_cs.title
					end

					Development.set_setting("debug_shortcuts", shortcuts)
					Application.save_user_settings()
				end
			end
		elseif (not cs.is_boolean and cs.selected_id ~= nil) or cs.options[cs.selected_id] then
			Gui.text(gui, text, font_mtrl, font_size, font, Vector3(setting_x, pos_y, 900), text_color_overridden)
		else
			Gui.text(gui, text, font_mtrl, font_size, font, Vector3(setting_x, pos_y, 900), text_color)
		end

		pos_y = pos_y - (font_size + 2)
	end

	local i = 1
	local text_effects = DebugScreen.text_effects
	local num_effects = #text_effects

	while i <= num_effects do
		local effect = text_effects[i]
		effect.time = effect.time + dt

		if 0.5 < effect.time then
			text_effects[i] = text_effects[num_effects]
			text_effects[num_effects] = nil
			num_effects = num_effects - 1
		else
			local start_position = Vector3(effect.start_position[1], effect.start_position[2], effect.start_position[3])
			local end_position = Vector3(effect.end_position[1], effect.end_position[2], effect.end_position[3])
			local t = ease_out_quad(effect.time, 0, 1, 0.5)
			local positon = math.lerp(start_position, end_position, t)

			Gui.text(gui, effect.text, font_mtrl, font_size, font, positon, text_color_option_hot)

			i = i + 1
		end
	end

	return 
end
DebugScreen.reset_settings = function ()
	local all_false = true

	for i = 1, #DebugScreen.console_settings, 1 do
		local cs = DebugScreen.console_settings[i]

		if cs.is_boolean then
			if cs.selected_id == 1 then
				all_false = false

				update_option(cs, 2, true)
			end
		elseif cs.item_source then
		elseif cs.bitmap then
		elseif cs.func then
		end
	end

	if all_false then
		for i = 1, #DebugScreen.console_settings, 1 do
			local cs = DebugScreen.console_settings[i]

			if cs.is_boolean and cs.selected_id == 2 then
				all_false = false

				update_option(cs, 3, true)
			end
		end
	end

	Application.save_user_settings()

	return 
end
DebugScreen.set_texture_quality = function (value)
	Application.set_user_setting("texture_settings", "texture_categories/character_df", value)
	Application.set_user_setting("texture_settings", "texture_categories/character_gsm", value)
	Application.set_user_setting("texture_settings", "texture_categories/character_ma", value)
	Application.set_user_setting("texture_settings", "texture_categories/character_nm", value)
	Application.set_user_setting("texture_settings", "texture_categories/coat_of_arms", value)
	Application.set_user_setting("texture_settings", "texture_categories/color_grading", value)
	Application.set_user_setting("texture_settings", "texture_categories/decals", value)
	Application.set_user_setting("texture_settings", "texture_categories/detail_textures", value)
	Application.set_user_setting("texture_settings", "texture_categories/environment_df", value)
	Application.set_user_setting("texture_settings", "texture_categories/environment_dfa", value)
	Application.set_user_setting("texture_settings", "texture_categories/environment_gsm", value)
	Application.set_user_setting("texture_settings", "texture_categories/environment_hm", value)
	Application.set_user_setting("texture_settings", "texture_categories/environment_ma", value)
	Application.set_user_setting("texture_settings", "texture_categories/environment_nm", value)
	Application.set_user_setting("texture_settings", "texture_categories/fx", value)
	Application.set_user_setting("texture_settings", "texture_categories/gui", value)
	Application.set_user_setting("texture_settings", "texture_categories/skydome", value)
	Application.set_user_setting("texture_settings", "texture_categories/weapon_ao", value)
	Application.set_user_setting("texture_settings", "texture_categories/weapon_df", value)
	Application.set_user_setting("texture_settings", "texture_categories/weapon_dfo", value)
	Application.set_user_setting("texture_settings", "texture_categories/weapon_gsm", value)
	Application.set_user_setting("texture_settings", "texture_categories/weapon_nm", value)
	Application.set_user_setting("texture_settings", "texture_categories/weapon_scr", value)
	Application.save_user_settings()

	return 
end
DebugScreen.update_search = function (input_manager, input_service, gui, t, dt)
	local exit_using_backspace = input_service.get(input_service, "console_search_key") and DebugScreen.search_string == ""
	local exit_due_to_exiting_debugscreen = not DebugScreen.active and DebugScreen.search_active
	local exit_with_no_search_hits_hack = DebugScreen.search_active and DebugScreen.hot_id == 0 and input_service.get(input_service, "left_key")

	if exit_using_backspace or exit_due_to_exiting_debugscreen or exit_with_no_search_hits_hack then
		if not DebugScreen.search_active then
			DebugScreen.unblocked_services_n = input_manager.get_unblocked_services(input_manager, nil, nil, DebugScreen.unblocked_services)

			input_manager.device_block_services(input_manager, "keyboard", 1, DebugScreen.unblocked_services, DebugScreen.unblocked_services_n, "debug_screen")
			input_manager.device_unblock_service(input_manager, "keyboard", 1, "DebugMenu")

			DebugScreen.search_active = true
		else
			input_manager.device_block_service(input_manager, "keyboard", 1, "DebugMenu")
			input_manager.device_unblock_services(input_manager, "keyboard", 1, DebugScreen.unblocked_services, DebugScreen.unblocked_services_n)

			DebugScreen.search_active = false
			DebugScreen.search_string = ""
		end
	end

	local hot_anim_t = (math.sin(t*10) + 1)*0.5
	local res_x = RESOLUTION_LOOKUP.res_w
	local res_y = RESOLUTION_LOOKUP.res_h
	local search_title_box_pos = Vector3(50, res_y - 60, 950)
	local search_text_box_pos = Vector3(250, res_y - 60, 950)
	local search_title_pos = Vector3(60, res_y - 50, 1000)
	local search_text_pos = Vector3(260, res_y - 50, 1000)
	DebugScreen.search_text_box_width = DebugScreen.search_text_box_width or 0

	if not DebugScreen.search_active then
		DebugScreen.search_text_box_width = math.max(0, DebugScreen.search_text_box_width - dt*2000)

		if 5 < DebugScreen.hot_id then
		else
			Gui.rect(gui, search_text_box_pos, Vector2(DebugScreen.search_text_box_width, 35), Colors.get_color_with_alpha("dark_olive_green", math.cos(hot_anim_t)*25 + 100))
			Gui.rect(gui, search_title_box_pos, Vector2(200, 35), Colors.get_color_with_alpha("orange", math.cos(hot_anim_t)*5 + 15))
			Gui.text(gui, "Search (backspace) ", font_mtrl, font_size, font, search_title_pos, Colors.get_color_with_alpha("white", math.cos(hot_anim_t)*100 + 100))
		end

		return 
	end

	DebugScreen.search_text_box_width = math.min(400, DebugScreen.search_text_box_width + dt*2000)
	local keystrokes = Keyboard.keystrokes()

	for i = 1, #keystrokes, 1 do
		local stroke = keystrokes[i]

		if type(stroke) == "string" then
			DebugScreen.active_id = nil
			DebugScreen.search_string = DebugScreen.search_string .. stroke
		elseif stroke == Keyboard.BACKSPACE and 0 < #DebugScreen.search_string then
			local string_length = string.len(DebugScreen.search_string)
			local character_index = Utf8.location(DebugScreen.search_string, string_length)
			DebugScreen.search_string = DebugScreen.search_string:sub(1, character_index - 1)
		end
	end

	Gui.rect(gui, search_text_box_pos, Vector2(DebugScreen.search_text_box_width, 35), Colors.get_color_with_alpha("dark_olive_green", math.cos(hot_anim_t)*25 + 225))
	Gui.rect(gui, search_title_box_pos, Vector2(200, 35), Colors.get_color_with_alpha("olive", 225))
	Gui.text(gui, "Search: ", font_mtrl, font_size, font, search_title_pos, Colors.get("white"))
	Gui.text(gui, DebugScreen.search_string, font_mtrl, font_size, font, search_text_pos, Colors.get("yellow"))

	local min, max = Gui.text_extents(gui, DebugScreen.search_string, font_mtrl, font_size)
	local width = max.x - min.x

	Gui.rect(gui, search_text_pos + Vector3(width + 1, -2, 0), Vector2(10, 20), Colors.get_color_with_alpha("white", math.cos(hot_anim_t)*250 + -50))

	return 
end

return 
