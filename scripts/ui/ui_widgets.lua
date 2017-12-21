UIWidgets = {
	create_hover_button = function (scenegraph_id, normal_texture, hover_texture)
		return {
			element = UIElements.SimpleButton,
			content = {
				texture_id = normal_texture,
				texture_hover_id = hover_texture,
				button_hotspot = {}
			},
			style = {},
			scenegraph_id = scenegraph_id
		}
	end,
	create_menu_button = function (text_field_id, scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and 0 < button_hotspot.is_clicked and not button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_selected and button_hotspot.is_hover and 0 < button_hotspot.is_clicked
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_click_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_clicked == 0
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_selected_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_selected and 0 < button_hotspot.is_clicked
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_disabled_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					},
					{
						pass_type = "texture_uv",
						style_id = "left_detail",
						texture_id = "left_texture_id"
					},
					{
						pass_type = "texture",
						style_id = "right_detail",
						texture_id = "right_texture_id"
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and not button_hotspot.is_selected and 0 < button_hotspot.is_clicked
						end
					},
					{
						style_id = "text_hover",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_selected and button_hotspot.is_hover and 0 < button_hotspot.is_clicked
						end
					},
					{
						style_id = "text_click",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_clicked == 0
						end
					},
					{
						style_id = "text_selected",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_selected and button_hotspot.is_clicked ~= 0
						end
					},
					{
						style_id = "text_disabled",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					}
				}
			},
			content = {
				texture_disabled_id = "medium_button_disabled",
				right_texture_id = "medium_button_selected_detail",
				texture_hover_id = "medium_button_hover",
				texture_click_id = "medium_button_selected",
				texture_id = "medium_button_normal",
				left_texture_id = "medium_button_selected_detail",
				texture_selected_id = "medium_button_hover",
				button_hotspot = {
					is_hover = false,
					is_clicked = 10
				},
				text_field = text_field_id,
				hover_color = {
					0,
					255,
					255,
					255
				},
				uvs = {
					{
						1,
						0
					},
					{
						0,
						1
					}
				}
			},
			style = {
				text = {
					font_size = 24,
					localize = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					font_type = "hell_shark",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					text_color_enabled = table.clone(Colors.color_definitions.cheeseburger),
					text_color_disabled = table.clone(Colors.color_definitions.gray)
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_click = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("gray", 255)
				},
				right_detail = {
					offset = {
						294,
						12,
						-1
					},
					size = {
						24,
						60
					}
				},
				left_detail = {
					offset = {
						1,
						12,
						-1
					},
					size = {
						24,
						60
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_menu_button_medium = function (text_field_id, scenegraph_id, disable_localization)
		return {
			element = UIElements.ButtonMenuSteps,
			content = {
				texture_click_id = "medium_button_selected",
				texture_id = "medium_button_normal",
				texture_hover_id = "medium_button_hover",
				texture_selected_id = "medium_button_hover",
				texture_disabled_id = "medium_button_disabled",
				text_field = text_field_id,
				button_hotspot = {}
			},
			style = {
				texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				text = {
					font_size = 24,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					text_color_enabled = table.clone(Colors.color_definitions.cheeseburger),
					text_color_disabled = table.clone(Colors.color_definitions.gray)
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("gray", 255)
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_popup_button_long = function (text_field_id, scenegraph_id, disable_localization)
		return {
			element = UIElements.ButtonMenuSteps,
			content = {
				texture_click_id = "popup_button_selected",
				texture_id = "popup_button_normal",
				texture_hover_id = "popup_button_hover",
				texture_selected_id = "popup_button_hover",
				texture_disabled_id = "popup_button_disabled",
				text_field = text_field_id,
				button_hotspot = {}
			},
			style = {
				texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				text = {
					font_size = 32,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					text_color_enabled = table.clone(Colors.color_definitions.cheeseburger),
					text_color_disabled = table.clone(Colors.color_definitions.gray)
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 32,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 32,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 32,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("gray", 255)
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_quest_screen_button = function (text_field_id, scenegraph_id, disable_localization)
		return {
			element = UIElements.ButtonMenuSteps,
			content = {
				texture_click_id = "quest_screen_button_selected",
				texture_id = "quest_screen_button_normal",
				texture_hover_id = "quest_screen_button_hover",
				texture_selected_id = "quest_screen_button_hover",
				texture_disabled_id = "quest_screen_button_disabled",
				text_field = text_field_id,
				button_hotspot = {}
			},
			style = {
				texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				text = {
					font_size = 24,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					text_color_enabled = table.clone(Colors.color_definitions.cheeseburger),
					text_color_disabled = table.clone(Colors.color_definitions.gray)
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					localize = not disable_localization and true,
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("gray", 255)
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_menu_button_small = function (text_field_id, scenegraph_id)
		return {
			element = UIElements.ButtonMenuSteps,
			content = {
				texture_click_id = "small_button_02_selected",
				texture_id = "small_button_02_normal",
				texture_hover_id = "small_button_02_hover",
				texture_selected_id = "small_button_02_hover",
				texture_disabled_id = "small_button_02_disabled",
				text_field = text_field_id,
				button_hotspot = {}
			},
			style = {
				texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				text = {
					font_size = 24,
					localize = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					font_type = "hell_shark",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					text_color_enabled = table.clone(Colors.color_definitions.cheeseburger),
					text_color_disabled = table.clone(Colors.color_definitions.gray)
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("gray", 255)
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_octagon_button = function (icons, tooltips, scenegraph_id)
		return {
			element = UIElements.ToggleIconButton,
			content = {
				click_texture = "octagon_button_clicked",
				toggle_hover_texture = "octagon_button_toggled_hover",
				toggle_texture = "octagon_button_toggled",
				hover_texture = "octagon_button_hover",
				normal_texture = "octagon_button_normal",
				icon_texture = icons[1] or "map_icon_friends_01",
				icon_hover_texture = icons[2] or "map_icon_friends_02",
				tooltip_text = tooltips[1] or "",
				toggled_tooltip_text = tooltips[2] or "",
				button_hotspot = {}
			},
			style = {
				normal_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				hover_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				click_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				toggle_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				toggle_hover_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				icon_texture = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						1
					}
				},
				icon_hover_texture = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						1
					}
				},
				icon_click_texture = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						-1,
						1
					}
				},
				tooltip_text = {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						20
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_menu_button_medium_with_timer = function (text_field_id, timer_text_field_id, timer_scenegraph_id, scenegraph_id)
		return {
			element = UIElements.ButtonMenuStepsWithTimer,
			content = {
				texture_click_id = "medium_button_selected",
				texture_id = "medium_button_normal",
				texture_hover_id = "medium_button_hover",
				texture_selected_id = "medium_button_hover",
				texture_disabled_id = "medium_button_disabled",
				text_field = text_field_id,
				button_hotspot = {},
				timer_text_field = timer_text_field_id
			},
			style = {
				text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("white", 255)
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						-2,
						2
					},
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255)
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					localize = true,
					font_size = 24,
					horizontal_alignment = "center",
					offset = {
						0,
						0,
						2
					},
					text_color = Colors.get_color_table_with_alpha("gray", 255)
				},
				timer_text_field = {
					horizontal_alignment = "right",
					font_size = 18,
					pixel_perfect = true,
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						0,
						4
					},
					scenegraph_id = timer_scenegraph_id
				},
				timer_text_field_hover = {
					horizontal_alignment = "right",
					font_size = 18,
					pixel_perfect = true,
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						4
					},
					scenegraph_id = timer_scenegraph_id
				},
				timer_text_field_selected = {
					horizontal_alignment = "right",
					font_size = 18,
					pixel_perfect = true,
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-2,
						4
					},
					scenegraph_id = timer_scenegraph_id
				},
				timer_text_field_disabled = {
					horizontal_alignment = "right",
					font_size = 18,
					pixel_perfect = true,
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("gray", 255),
					offset = {
						0,
						0,
						4
					},
					scenegraph_id = timer_scenegraph_id
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_scrollbar = function (height, scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "scroll_bar_bottom",
						texture_id = "scroll_bar_bottom"
					},
					{
						pass_type = "texture",
						style_id = "scroll_bar_bottom_bg",
						texture_id = "scroll_bar_bottom_bg"
					},
					{
						pass_type = "tiled_texture",
						style_id = "scroll_bar_middle",
						texture_id = "scroll_bar_middle"
					},
					{
						pass_type = "tiled_texture",
						style_id = "scroll_bar_middle_bg",
						texture_id = "scroll_bar_middle_bg"
					},
					{
						pass_type = "texture",
						style_id = "scroll_bar_top",
						texture_id = "scroll_bar_top"
					},
					{
						pass_type = "texture",
						style_id = "scroll_bar_top_bg",
						texture_id = "scroll_bar_top_bg"
					},
					{
						style_id = "button_down",
						pass_type = "hotspot",
						content_id = "button_down_hotspot"
					},
					{
						style_id = "button_up",
						pass_type = "hotspot",
						content_id = "button_up_hotspot"
					},
					{
						pass_type = "local_offset",
						offset_function = function (ui_scenegraph, ui_style, ui_content, input_service)
							local scroll_bar_info = ui_content.scroll_bar_info
							local scroll_bar_box = ui_style.scroll_bar_box
							local scroll_size_y = scroll_bar_box.scroll_size_y
							local percentage = math.max(scroll_bar_info.bar_height_percentage, 0.05)
							scroll_bar_box.size[2] = scroll_size_y*percentage
							local button_up_hotspot = ui_content.button_up_hotspot

							if button_up_hotspot.is_hover and button_up_hotspot.is_clicked == 0 then
								ui_content.button_up = "scroll_bar_button_up_clicked"
							else
								ui_content.button_up = "scroll_bar_button_up"
							end

							local button_down_hotspot = ui_content.button_down_hotspot

							if button_down_hotspot.is_hover and button_down_hotspot.is_clicked == 0 then
								ui_content.button_down = "scroll_bar_button_down_clicked"
							else
								ui_content.button_down = "scroll_bar_button_down"
							end

							local button_scroll_step = ui_content.button_scroll_step or 0.1

							if button_up_hotspot.on_release then
								local size_y = scroll_bar_box.size[2]
								local scroll_size_y = scroll_bar_box.scroll_size_y
								local start_y = scroll_bar_box.start_offset[2]
								local end_y = (start_y + scroll_size_y) - size_y
								local step = size_y/(start_y + end_y)
								scroll_bar_info.value = math.max(scroll_bar_info.value - button_scroll_step, 0)
							elseif button_down_hotspot.on_release then
								local size_y = scroll_bar_box.size[2]
								local scroll_size_y = scroll_bar_box.scroll_size_y
								local start_y = scroll_bar_box.start_offset[2]
								local end_y = (start_y + scroll_size_y) - size_y
								local step = size_y/(start_y + end_y)
								scroll_bar_info.value = math.min(scroll_bar_info.value + button_scroll_step, 1)
							end

							return 
						end
					},
					{
						pass_type = "texture",
						style_id = "button_down",
						texture_id = "button_down"
					},
					{
						pass_type = "texture",
						style_id = "button_up",
						texture_id = "button_up"
					},
					{
						style_id = "scroll_bar_box",
						pass_type = "hotspot",
						content_id = "scroll_bar_info"
					},
					{
						style_id = "scroll_bar_box",
						pass_type = "held",
						content_id = "scroll_bar_info",
						held_function = function (ui_scenegraph, ui_style, ui_content, input_service)
							local cursor = UIInverseScaleVectorToResolution(input_service.get(input_service, "cursor"))
							local cursor_y = cursor[2]
							local world_pos = UISceneGraph.get_world_position(ui_scenegraph, ui_content.scenegraph_id)
							local world_pos_y = world_pos[2]
							local offset = ui_style.offset
							local scroll_box_start = world_pos_y + offset[2]
							local cursor_y_norm = cursor_y - scroll_box_start

							if not ui_content.click_pos_y then
								ui_content.click_pos_y = cursor_y_norm
							end

							local click_pos_y = ui_content.click_pos_y
							local delta = cursor_y_norm - click_pos_y
							local start_y = ui_style.start_offset[2]
							local end_y = (start_y + ui_style.scroll_size_y) - ui_style.size[2]
							local offset_y = math.clamp(offset[2] + delta, start_y, end_y)
							local scroll_size = end_y - start_y
							local scroll = end_y - offset_y
							ui_content.value = (scroll ~= 0 and scroll/scroll_size) or 0

							return 
						end,
						release_function = function (ui_scenegraph, ui_style, ui_content, input_service)
							ui_content.click_pos_y = nil

							return 
						end
					},
					{
						pass_type = "local_offset",
						content_id = "scroll_bar_info",
						offset_function = function (ui_scenegraph, ui_style, ui_content, input_service)
							local box_style = ui_style.scroll_bar_box
							local box_size_y = box_style.size[2]
							local start_y = box_style.start_offset[2]
							local end_y = (start_y + box_style.scroll_size_y) - box_size_y
							local scroll_size = end_y - start_y
							local value = ui_content.value
							local offset_y = start_y + scroll_size*(value - 1)
							box_style.offset[2] = offset_y
							local box_bottom = ui_style.scroll_bar_box_bottom
							local box_middle = ui_style.scroll_bar_box_middle
							local box_top = ui_style.scroll_bar_box_top
							local box_bottom_size_y = box_bottom.size[2]
							local box_top_size_y = box_top.size[2]
							box_bottom.offset[2] = offset_y
							box_top.offset[2] = (offset_y + box_size_y) - box_top_size_y
							box_middle.offset[2] = offset_y + box_bottom_size_y
							box_middle.size[2] = box_size_y - box_bottom_size_y - box_top_size_y

							return 
						end
					},
					{
						pass_type = "texture",
						style_id = "scroll_bar_box_bottom",
						texture_id = "scroll_bar_box_bottom"
					},
					{
						pass_type = "tiled_texture",
						style_id = "scroll_bar_box_middle",
						texture_id = "scroll_bar_box_middle"
					},
					{
						pass_type = "texture",
						style_id = "scroll_bar_box_top",
						texture_id = "scroll_bar_box_top"
					}
				}
			},
			content = {
				scroll_bar_top_bg = "scroll_bar_top_bg",
				scroll_bar_box_bottom = "scroll_bar_box_bottom",
				scroll_bar_middle = "scroll_bar_middle",
				button_up = "scroll_bar_button_up",
				scroll_bar_box_middle = "scroll_bar_box_middle",
				scroll_bar_middle_bg = "scroll_bar_middle_bg",
				scroll_bar_bottom = "scroll_bar_bottom",
				scroll_bar_bottom_bg = "scroll_bar_bottom_bg",
				scroll_bar_box_top = "scroll_bar_box_top",
				button_down = "scroll_bar_button_down",
				scroll_bar_top = "scroll_bar_top",
				scroll_bar_info = {
					button_scroll_step = 0.1,
					value = 0,
					bar_height_percentage = 1,
					scenegraph_id = scenegraph_id
				},
				button_up_hotspot = {},
				button_down_hotspot = {}
			},
			style = {
				scroll_bar_bottom = {
					size = {
						26,
						116
					}
				},
				scroll_bar_bottom_bg = {
					offset = {
						0,
						0,
						-1
					},
					size = {
						26,
						116
					}
				},
				scroll_bar_middle = {
					offset = {
						0,
						116,
						0
					},
					size = {
						26,
						height - 232
					},
					texture_tiling_size = {
						26,
						44
					}
				},
				scroll_bar_middle_bg = {
					offset = {
						0,
						116,
						-1
					},
					size = {
						26,
						height - 232
					},
					texture_tiling_size = {
						26,
						44
					}
				},
				scroll_bar_top = {
					offset = {
						0,
						height - 116,
						0
					},
					size = {
						26,
						116
					}
				},
				scroll_bar_top_bg = {
					offset = {
						0,
						height - 116,
						-1
					},
					size = {
						26,
						116
					}
				},
				button_down = {
					offset = {
						5,
						4,
						0
					},
					size = {
						16,
						18
					}
				},
				button_up = {
					offset = {
						5,
						height - 22,
						0
					},
					size = {
						16,
						18
					}
				},
				scroll_bar_box = {
					offset = {
						4,
						22,
						100
					},
					size = {
						18,
						height - 44
					},
					color = {
						255,
						255,
						255,
						255
					},
					start_offset = {
						4,
						22,
						0
					},
					scroll_size_y = height - 44
				},
				scroll_bar_box_bottom = {
					offset = {
						4,
						0,
						0
					},
					size = {
						18,
						8
					}
				},
				scroll_bar_box_middle = {
					offset = {
						4,
						0,
						0
					},
					size = {
						18,
						26
					},
					texture_tiling_size = {
						18,
						26
					}
				},
				scroll_bar_box_top = {
					offset = {
						4,
						0,
						0
					},
					size = {
						18,
						8
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_lock_icon = function (scenegraph_id, level)
		return {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "unlock_texture",
						texture_id = "unlock_texture"
					},
					{
						style_id = "level_text",
						pass_type = "text",
						text_id = "level_text"
					}
				}
			},
			content = {
				unlock_texture = "locked_icon_01",
				level_text = tostring(level)
			},
			style = {
				unlock_texture = {
					size = {
						30,
						38
					},
					offset = {
						0,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				level_text = {
					vertical_alignment = "center",
					word_wrap = false,
					horizontal_alignment = "center",
					font_size = 28,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						15,
						-15,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_quest_navigation_button = function (scenegraph_id, uvs, tooltip_text)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "hotspot",
						content_id = "tooltip_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture_uv",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_id = "texture_id",
						content_check_function = function (content)
							local button_hotspot = content.parent.button_hotspot

							return not button_hotspot.is_hover and button_hotspot.is_clicked ~= 0 and not button_hotspot.disabled
						end
					},
					{
						pass_type = "texture_uv",
						style_id = "texture_hover_id",
						texture_id = "texture_hover_id",
						content_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.parent.button_hotspot

							return button_hotspot.is_selected or (button_hotspot.is_hover and button_hotspot.is_clicked ~= 0 and not button_hotspot.disabled)
						end
					},
					{
						pass_type = "texture_uv",
						style_id = "texture_click_id",
						texture_id = "texture_click_id",
						content_id = "texture_click_id",
						content_check_function = function (content)
							return content.parent.button_hotspot.is_clicked == 0 and not content.parent.button_hotspot.disabled
						end
					},
					{
						pass_type = "texture_uv",
						style_id = "texture_disabled_id",
						texture_id = "texture_disabled_id",
						content_id = "texture_disabled_id",
						content_check_function = function (content)
							return content.parent.button_hotspot.disabled
						end
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (content)
							return content.tooltip_text and content.button_hotspot.is_hover and content.tooltip_hotspot.is_hover and not content.button_hotspot.disabled
						end
					}
				}
			},
			content = {
				texture_id = {
					texture_id = "quest_board_arrow_normal",
					uvs = uvs
				},
				texture_hover_id = {
					texture_hover_id = "quest_board_arrow_hover",
					uvs = uvs
				},
				texture_click_id = {
					texture_click_id = "quest_board_arrow_hover",
					uvs = uvs
				},
				texture_disabled_id = {
					texture_disabled_id = "quest_board_arrow_hover",
					uvs = uvs
				},
				tooltip_text = tooltip_text,
				button_hotspot = {},
				tooltip_hotspot = {}
			},
			style = {
				texture_id = {
					size = {
						42,
						64
					},
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_hover_id = {
					size = {
						42,
						64
					},
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_click_id = {
					size = {
						38,
						58
					},
					offset = {
						2,
						3,
						0
					},
					color = {
						255,
						200,
						200,
						200
					}
				},
				texture_disabled_id = {
					size = {
						42,
						64
					},
					offset = {
						0,
						0,
						0
					},
					color = {
						190,
						120,
						120,
						120
					}
				},
				tooltip_text = {
					font_size = 18,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_gold_button_3_state = function (text, scenegraph_id, normal_texture, hover_texture, click_texture)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							return not content.button_hotspot.is_hover and 0 < content.button_hotspot.is_clicked
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							return content.button_hotspot.is_selected or (content.button_hotspot.is_hover and 0 < content.button_hotspot.is_clicked)
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_click_id",
						content_check_function = function (content)
							return content.button_hotspot.is_clicked == 0
						end
					},
					{
						localize = true,
						style_id = "text",
						pass_type = "text",
						text_id = "text_field"
					}
				}
			},
			content = {
				texture_id = normal_texture or "small_button_gold_normal",
				texture_hover_id = hover_texture or "small_button_gold_hover",
				texture_click_id = click_texture or "small_button_gold_selected",
				text_field = Localize(text),
				button_hotspot = {}
			},
			style = {
				text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						2
					},
					scenegraph_id = scenegraph_id
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_forge_merge_button = function (scenegraph_id, text_scenegraph_id, token_scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked))
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked))
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_click_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled and button_hotspot.is_clicked and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_disabled_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					},
					{
						texture_id = "texture_token_type",
						style_id = "texture_token_type",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return content.show_tokens and content.texture_token_type and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						texture_id = "texture_token_type",
						style_id = "texture_token_type_selected",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (content.show_tokens and content.texture_token_type and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.is_hover and content.show_tokens and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_hover",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_hover and content.show_tokens and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_selected",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (content.show_tokens and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						style_id = "text_disabled",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled and content.is_disabled
						end
					},
					{
						style_id = "text_center",
						pass_type = "text",
						text_id = "text_field_center",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and not button_hotspot.is_selected and not content.show_tokens
						end
					},
					{
						style_id = "text_hover_center",
						pass_type = "text",
						text_id = "text_field_center",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and 0 < button_hotspot.is_clicked and not content.show_tokens
						end
					},
					{
						style_id = "text_selected_center",
						pass_type = "text",
						text_id = "text_field_center",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not content.is_disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected) and not content.show_tokens
						end
					},
					{
						style_id = "token_text",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.is_hover and content.show_tokens and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text_hover",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_hover and content.show_tokens and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text_selected",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (content.show_tokens and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					}
				}
			},
			content = {
				texture_disabled_id = "forge_button_03_disabled",
				texture_hover_id = "forge_button_03_hover",
				is_disabled = true,
				show_tokens = false,
				texture_click_id = "forge_button_03_selected",
				texture_id = "forge_button_03_normal",
				token_text = "",
				text_field = Localize("merge"),
				text_field_center = Localize("merge"),
				button_hotspot = {}
			},
			style = {
				texture_token_type = {
					scenegraph_id = token_scenegraph_id
				},
				texture_token_type_selected = {
					offset = {
						0,
						-2,
						0
					},
					scenegraph_id = token_scenegraph_id
				},
				text = {
					font_size = 24,
					horizontal_alignment = "left",
					pixel_perfect = true,
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						10,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "left",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						10,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "left",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						10,
						-2,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_center = {
					vertical_alignment = "center",
					dynamic_font = true,
					horizontal_alignment = "center",
					font_size = 24,
					pixel_perfect = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-10,
						2
					}
				},
				text_hover_center = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						-10,
						2
					}
				},
				text_selected_center = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-10,
						2
					}
				},
				token_text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						180,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						180,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						180,
						-2,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("gray", 255),
					offset = {
						0,
						-10,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_altar_button = function (button_text, scenegraph_id, text_scenegraph_id, token_scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked))
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked))
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_click_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled and button_hotspot.is_clicked and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_disabled_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					},
					{
						texture_id = "texture_token_type",
						style_id = "texture_token_type",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled or (button_hotspot.disabled and content.default_text_on_disable)) and content.texture_token_type and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						texture_id = "texture_token_type",
						style_id = "texture_token_type_selected",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and content.texture_token_type and (button_hotspot.is_selected or (button_hotspot.is_clicked and button_hotspot.is_clicked == 0))
						end
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled or (button_hotspot.disabled and content.default_text_on_disable)) and not button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_hover",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_selected",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						style_id = "text_disabled",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled and not content.default_text_on_disable
						end
					},
					{
						style_id = "token_text",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled or (button_hotspot.disabled and content.default_text_on_disable)) and not button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text_hover",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text_selected",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						style_id = "button_frame_texture",
						texture_id = "button_frame_texture",
						content_check_function = function (content)
							return content.show_frame
						end
					},
					{
						pass_type = "texture",
						style_id = "button_frame_glow_texture",
						texture_id = "button_frame_glow_texture",
						content_check_function = function (content)
							return content.show_glow
						end
					}
				}
			},
			content = {
				texture_hover_id = "medium_button_hover",
				show_frame = false,
				default_text_on_disable = false,
				show_glow = true,
				button_frame_texture = "button_frame_large",
				texture_disabled_id = "medium_button_disabled",
				texture_click_id = "medium_button_selected",
				texture_id = "medium_button_normal",
				token_text = "",
				button_frame_glow_texture = "reroll_glow_button",
				text_field = Localize(button_text),
				button_hotspot = {}
			},
			style = {
				button_frame_texture = {
					size = {
						343,
						106
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-12,
						-15,
						0
					}
				},
				button_frame_glow_texture = {
					size = {
						400,
						140
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-42,
						-29,
						0
					}
				},
				texture_token_type = {
					scenegraph_id = token_scenegraph_id
				},
				texture_token_type_selected = {
					offset = {
						0,
						-2,
						0
					},
					scenegraph_id = token_scenegraph_id
				},
				text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					horizontal_alignment = (text_scenegraph_id and "left") or "center",
					offset = {
						(text_scenegraph_id and 10) or 0,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					text_color = Colors.get_color_table_with_alpha("white", 255),
					horizontal_alignment = (text_scenegraph_id and "left") or "center",
					offset = {
						(text_scenegraph_id and 10) or 0,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					horizontal_alignment = (text_scenegraph_id and "left") or "center",
					offset = {
						(text_scenegraph_id and 10) or 0,
						-2,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						180,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						180,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						180,
						-2,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("gray", 255),
					offset = {
						0,
						-4,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_dice_game_button = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and button_hotspot.is_clicked and 0 < button_hotspot.is_clicked
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and button_hotspot.is_clicked and 0 < button_hotspot.is_clicked
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_click_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled and button_hotspot.is_clicked and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_disabled_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_hover",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and 0 < button_hotspot.is_clicked
						end
					},
					{
						style_id = "text_selected",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and button_hotspot.is_clicked == 0
						end
					},
					{
						style_id = "text_disabled",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					}
				}
			},
			content = {
				texture_click_id = "forge_button_03_selected",
				texture_id = "forge_button_03_normal",
				texture_hover_id = "forge_button_03_hover",
				texture_disabled_id = "forge_button_03_disabled",
				text_field = Localize("merge"),
				button_hotspot = {}
			},
			style = {
				text = {
					vertical_alignment = "center",
					dynamic_font = true,
					horizontal_alignment = "center",
					font_size = 24,
					pixel_perfect = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-10,
						2
					}
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						-10,
						2
					}
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-12,
						2
					}
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("gray", 255),
					offset = {
						0,
						-10,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_altar_craft_reagent_button = function (scenegraph_id, texture, required_hover_scenegraph_id, tooltip_text, masked)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						style_id = "required_hover_hotspot",
						pass_type = "hotspot",
						content_id = "required_hover_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (ui_content)
							return ui_content.tooltip_text and ui_content.button_hotspot.is_hover and ui_content.required_hover_hotspot.is_hover
						end
					}
				}
			},
			content = {
				texture_id = texture,
				button_hotspot = {},
				required_hover_hotspot = {},
				tooltip_text = tooltip_text
			},
			style = {
				required_hover_hotspot = {
					scenegraph_id = required_hover_scenegraph_id
				},
				texture_id = {
					masked = masked,
					color = {
						255,
						255,
						255,
						255
					}
				},
				tooltip_text = {
					vertical_alignment = "top",
					font_type = "hell_shark",
					horizontal_alignment = "left",
					font_size = 18,
					max_width = 500,
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_forge_upgrade_button = function (scenegraph_id, text_scenegraph_id, token_scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked))
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked))
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_click_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not button_hotspot.disabled and button_hotspot.is_clicked and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_disabled_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled
						end
					},
					{
						texture_id = "texture_token_type",
						style_id = "texture_token_type",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not content.show_title and content.texture_token_type and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						texture_id = "texture_token_type",
						style_id = "texture_token_type_selected",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not content.show_title and content.texture_token_type and button_hotspot.is_selected) or (button_hotspot.is_clicked and button_hotspot.is_clicked == 0)
						end
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.is_hover and not content.show_title and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_hover",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_hover and not content.show_title and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.is_hover and not content.show_title and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text_hover",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_hover and not content.show_title and (not button_hotspot.is_clicked or (button_hotspot.is_clicked and 0 < button_hotspot.is_clicked)) and not button_hotspot.is_selected
						end
					},
					{
						style_id = "text_selected",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not content.show_title and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						style_id = "token_text_selected",
						pass_type = "text",
						text_id = "token_text",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return (not content.show_title and button_hotspot.is_clicked == 0) or button_hotspot.is_selected
						end
					},
					{
						style_id = "text_disabled",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.disabled and content.show_title
						end
					}
				}
			},
			content = {
				texture_hover_id = "forge_button_03_hover",
				texture_click_id = "forge_button_03_selected",
				texture_id = "forge_button_03_normal",
				token_text = "",
				show_title = true,
				texture_disabled_id = "forge_button_03_disabled",
				text_field = Localize("upgrade"),
				button_hotspot = {}
			},
			style = {
				texture_token_type = {
					scenegraph_id = token_scenegraph_id
				},
				texture_token_type_selected = {
					offset = {
						0,
						-2,
						0
					},
					scenegraph_id = token_scenegraph_id
				},
				text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "left",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						10,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "left",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						10,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "left",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						10,
						-2,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						180,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text_hover = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						180,
						0,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				token_text_selected = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "right",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						180,
						-2,
						2
					},
					scenegraph_id = text_scenegraph_id
				},
				text_disabled = {
					vertical_alignment = "center",
					font_type = "hell_shark",
					font_size = 24,
					horizontal_alignment = "center",
					text_color = Colors.get_color_table_with_alpha("gray", 255),
					offset = {
						0,
						-10,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_menu_selection_bar = function (scenegraph_definition, textures, icons, tooltips, offset, scenegraph_base, size, icon_size)
		local passes = {}
		local element = {
			passes = passes
		}
		local style = {}
		local content_data = {}

		assert(textures.texture_hover_id, "missing texture")
		assert(textures.texture_click_id, "missing texture")

		local widget = {
			style = style,
			content = content_data,
			element = element,
			scenegraph_id = scenegraph_base
		}
		local num_buttons = #icons

		for i = 1, num_buttons, 1 do
			local button_hotspot_name = i
			local tooltip_text = "tooltip_text_" .. i
			local button_style_name = string.format("button_style_%d", i)
			local button_click_style_name = string.format("button_click_style_%d", i)
			local icon_texture_id = string.format("icon_%d", i)
			local icon_click_texture_id = string.format("icon_click_%d", i)
			local disabled_overlay_name = string.format("disabled_overlay_%d", i)

			table.append_varargs(passes, {
				pass_type = "hotspot",
				content_id = button_hotspot_name,
				style_id = button_hotspot_name
			}, {
				pass_type = "texture",
				texture_id = button_click_style_name,
				style_id = button_click_style_name
			}, {
				pass_type = "texture",
				texture_id = button_style_name,
				style_id = button_style_name
			}, {
				pass_type = "texture",
				texture_id = icon_texture_id,
				style_id = icon_texture_id
			}, {
				pass_type = "texture",
				texture_id = icon_click_texture_id,
				style_id = icon_click_texture_id
			}, {
				pass_type = "tooltip_text",
				text_id = tooltip_text,
				style_id = tooltip_text,
				content_check_function = function (content)
					return content[button_hotspot_name].is_hover
				end
			}, {
				pass_type = "rect",
				style_id = disabled_overlay_name,
				content_check_function = function (content)
					return content[button_hotspot_name].disable_button
				end
			})

			local scenegraph_id = string.format("%s_%d", scenegraph_base, i)
			scenegraph_definition[scenegraph_id] = {
				parent = (i == 1 and scenegraph_base) or string.format("%s_%d", scenegraph_base, i - 1),
				size = size,
				offset = (i ~= 1 and offset) or nil
			}
			local style_scenegraph_id = string.format("%s_icon_%d", scenegraph_base, i)
			scenegraph_definition[style_scenegraph_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				parent = scenegraph_id,
				size = icon_size,
				offset = {
					0,
					0,
					5
				}
			}
			content_data[button_hotspot_name] = {}
			content_data[tooltip_text] = tooltips[i]
			content_data[button_style_name] = textures.texture_hover_id
			content_data[icon_texture_id] = icons[i].texture_hover_id
			content_data[button_click_style_name] = textures.texture_click_id
			content_data[icon_click_texture_id] = icons[i].texture_click_id
			style[tooltip_text] = {
				font_size = 24,
				max_width = 500,
				localize = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				line_colors = {},
				offset = {
					0,
					0,
					250
				}
			}
			style[disabled_overlay_name] = {
				scenegraph_id = scenegraph_id,
				size = {
					size[1] - 12,
					size[2] - 12
				},
				offset = {
					6,
					6,
					5
				},
				color = {
					178,
					0,
					0,
					0
				}
			}
			style[button_hotspot_name] = {
				scenegraph_id = scenegraph_id,
				size = {
					size[1] - 12,
					size[2] - 12
				},
				offset = {
					6,
					6,
					0
				}
			}
			style[button_style_name] = {
				scenegraph_id = scenegraph_id,
				color = {
					178.5,
					255,
					255,
					255
				},
				size = size
			}
			style[icon_texture_id] = {
				scenegraph_id = style_scenegraph_id,
				color = {
					178.5,
					255,
					255,
					255
				},
				size = icon_size
			}
			style[button_click_style_name] = {
				scenegraph_id = scenegraph_id,
				color = {
					0,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					1
				},
				size = size
			}
			style[icon_click_texture_id] = {
				scenegraph_id = style_scenegraph_id,
				color = {
					0,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					2
				},
				size = icon_size
			}
		end

		return widget
	end,
	create_tiled_texture = function (scenegraph_id, texture, texture_size, offset)
		return {
			element = {
				passes = {
					{
						pass_type = "tiled_texture",
						style_id = "tiling_texture",
						texture_id = "tiling_texture"
					}
				}
			},
			content = {
				tiling_texture = texture
			},
			style = {
				tiling_texture = {
					offset = offset or {
						0,
						0,
						0
					},
					texture_tiling_size = texture_size,
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_texture_with_text = function (texture, text, scenegraph_id, text_scenegraph_id, text_style)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture"
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					}
				}
			},
			content = {
				texture_id = texture,
				text = text
			},
			style = {
				text = text_style or {
					vertical_alignment = "center",
					horizontal_alignment = "left",
					word_wrap = true,
					font_size = 20,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					scenegraph_id = text_scenegraph_id
				},
				texture_id = {
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_texture_with_text_and_tooltip = function (texture, text, tooltip_text, scenegraph_id, text_scenegraph_id, text_style, tooltip_style)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture"
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					},
					{
						pass_type = "hotspot",
						content_id = "tooltip_hotspot",
						content_check_function = function (ui_content)
							return not ui_content.disabled
						end
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (ui_content)
							return ui_content.tooltip_hotspot.is_hover
						end
					}
				}
			},
			content = {
				tooltip_hotspot = {},
				texture_id = texture,
				tooltip_text = tooltip_text,
				text = text
			},
			style = {
				text = text_style or {
					vertical_alignment = "center",
					horizontal_alignment = "left",
					word_wrap = true,
					font_size = 20,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					scenegraph_id = text_scenegraph_id
				},
				tooltip_text = tooltip_style or {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					}
				},
				texture_id = {
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_tooltip = function (text, scenegraph_id, max_width, optional_style)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "tooltip_hotspot"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (ui_content)
							return ui_content.tooltip_hotspot.is_hover
						end
					}
				}
			},
			content = {
				tooltip_text = text,
				tooltip_hotspot = {}
			},
			style = {
				tooltip_text = optional_style or {
					font_size = 24,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					max_width = max_width,
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						3
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_hotspot = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "hotspot"
					}
				}
			},
			content = {
				hotspot = {}
			},
			style = {},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_rect = function (scenegraph_id, color)
		return {
			element = {
				passes = {
					{
						pass_type = "rect",
						style_id = "rect"
					}
				}
			},
			content = {},
			style = {
				rect = {
					color = color or {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_texture = function (texture, scenegraph_id, masked, retained)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture",
						retained_mode = retained
					}
				}
			},
			content = {
				texture_id = texture
			},
			style = {
				texture_id = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_multi_texture = function (textures, texture_sizes, axis, direction, spacing, scenegraph_id, masked)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "multi_texture"
					}
				}
			},
			content = {
				texture_id = textures or {}
			},
			style = {
				texture_id = {
					axis = axis or 1,
					spacing = spacing or {
						0,
						0
					},
					direction = direction or 1,
					texture_sizes = texture_sizes or {},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_texture_with_style = function (texture, scenegraph_id, style)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture"
					}
				}
			},
			content = {
				texture_id = texture
			},
			style = {
				texture_id = style
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_gradient_mask_texture = function (texture, scenegraph_id)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "gradient_mask_texture"
					}
				}
			},
			content = {
				texture_id = texture
			},
			style = {
				texture_id = {
					gradient_threshold = 0,
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_rotated_texture = function (texture, angle, pivot, scenegraph_id, masked)
		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "rotated_texture"
					}
				}
			},
			content = {
				texture_id = texture
			},
			style = {
				texture_id = {
					masked = masked,
					angle = angle,
					pivot = pivot,
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_uv_texture = function (texture, uvs, scenegraph_id)
		return {
			element = {
				passes = {
					{
						style_id = "texture_id",
						pass_type = "texture_uv",
						content_id = "texture_id"
					}
				}
			},
			content = {
				texture_id = {
					uvs = uvs,
					texture_id = texture
				}
			},
			style = {
				texture_id = {
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_frame = function (texture, texture_size, corner_size, vertical_size, horizontal_size, scenegraph_id, optional_style)
		if not optional_style then
			local style = {
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				}
			}
		end

		style.texture_size = texture_size
		style.texture_sizes = {
			corner = corner_size,
			vertical = vertical_size,
			horizontal = horizontal_size
		}

		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture_frame"
					}
				}
			},
			content = {
				texture_id = texture
			},
			style = {
				texture_id = style
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_frame = function (texture, texture_size, corner_size, vertical_size, horizontal_size, scenegraph_id, optional_style)
		if not optional_style then
			local style = {
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				}
			}
		end

		style.texture_size = texture_size
		style.texture_sizes = {
			corner = corner_size,
			vertical = vertical_size,
			horizontal = horizontal_size
		}

		return {
			element = {
				passes = {
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture_frame"
					}
				}
			},
			content = {
				texture_id = texture
			},
			style = {
				texture_id = style
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_uv_texture_with_style = function (texture, uvs, scenegraph_id, style)
		return {
			element = {
				passes = {
					{
						style_id = "texture_id",
						pass_type = "texture_uv",
						content_id = "texture_id"
					}
				}
			},
			content = {
				texture_id = {
					uvs = uvs,
					texture_id = texture
				}
			},
			style = {
				texture_id = style
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_simple_text = function (text, scenegraph_id, size, color, text_style, optional_font_style, retained)
		slot7 = {
			element = {
				passes = {
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text",
						retained_mode = retained
					}
				}
			},
			content = {
				text = text,
				color = (text_style and text_style.text_color) or color
			}
		}
		slot8 = {}

		if not text_style then
			slot9 = {
				vertical_alignment = "center",
				localize = true,
				horizontal_alignment = "center",
				word_wrap = true,
				font_size = size,
				font_type = optional_font_style or "hell_shark",
				text_color = color,
				offset = {
					0,
					0,
					2
				}
			}
		end

		slot8.text = slot9
		slot7.style = slot8
		slot7.scenegraph_id = scenegraph_id

		return slot7
	end,
	create_simple_text_tooltip = function (text, tooltip_text, scenegraph_id, size, color, text_style, tooltip_style)
		return {
			element = {
				passes = {
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					},
					{
						pass_type = "hotspot",
						content_id = "tooltip_hotspot"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (ui_content)
							return ui_content.tooltip_hotspot.is_hover
						end
					}
				}
			},
			content = {
				text = text,
				tooltip_text = tooltip_text,
				tooltip_hotspot = {},
				color = (text_style and text_style.text_color) or color
			},
			style = {
				text = text_style or {
					vertical_alignment = "center",
					localize = true,
					horizontal_alignment = "center",
					word_wrap = true,
					font_type = "hell_shark",
					font_size = size,
					text_color = color,
					offset = {
						0,
						0,
						2
					}
				},
				tooltip_text = tooltip_style or {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_forge_toggle_button = function (normal_texture, normal_hover_texture, selected_texture, selected_hover_texture, scenegraph_id, hotspot_scenegraph_id)
		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							return not content.is_selected and not content.button_hotspot.is_hover
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							return not content.is_selected and content.button_hotspot.is_hover
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_selected_id",
						content_check_function = function (content)
							return content.is_selected and not content.button_hotspot.is_hover
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_selected_hover_id",
						content_check_function = function (content)
							return content.is_selected and content.button_hotspot.is_hover
						end
					}
				}
			},
			content = {
				button_hotspot = {},
				texture_id = normal_texture,
				texture_hover_id = normal_hover_texture,
				texture_selected_id = selected_texture,
				texture_selected_hover_id = selected_hover_texture
			},
			style = {
				button_hotspot = {
					scenegraph_id = hotspot_scenegraph_id
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_button_2_state = function (normal_texture, selected_texture, scenegraph_id, hotspot_scenegraph_id)
		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						texture_id = "texture_id",
						content_check_function = function (content)
							return not content.is_selected
						end
					},
					{
						pass_type = "texture",
						texture_id = "texture_selected_id",
						content_check_function = function (content)
							return content.is_selected
						end
					}
				}
			},
			content = {
				button_hotspot = {},
				texture_id = normal_texture,
				texture_selected_id = selected_texture
			},
			style = {
				button_hotspot = {
					scenegraph_id = hotspot_scenegraph_id
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_title_text = function (text, scenegraph_id)
		return {
			element = {
				passes = {
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					}
				}
			},
			content = {
				text = text
			},
			style = {
				text = {
					font_size = 36,
					localize = true,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark_header",
					text_color = Colors.get_table("cheeseburger"),
					offset = {
						0,
						0,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_matchmaking_portrait = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						texture_id = "portrait",
						style_id = "portrait",
						pass_type = "texture",
						content_check_function = function (content)
							return content.portrait and not content.is_connecting
						end
					},
					{
						texture_id = "connection_portrait",
						style_id = "connection_portrait",
						pass_type = "texture",
						content_check_function = function (content)
							return content.is_connecting
						end
					},
					{
						texture_id = "connecting_icon",
						style_id = "connecting_icon",
						pass_type = "rotated_texture",
						content_check_function = function (content)
							return content.is_connecting
						end
					},
					{
						texture_id = "default_portrait",
						style_id = "default_portrait",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.is_connecting and not content.portrait
						end
					},
					{
						pass_type = "texture",
						style_id = "overlay",
						texture_id = "overlay",
						content_check_function = function (content)
							return content.is_ready
						end
					},
					{
						pass_type = "texture",
						style_id = "ready_marker",
						texture_id = "ready_marker",
						content_check_function = function (content)
							return content.is_ready
						end
					},
					{
						pass_type = "texture",
						style_id = "frame",
						texture_id = "frame"
					}
				}
			},
			content = {
				connection_portrait = "unit_frame_portrait_matchmaking_03",
				default_portrait = "unit_frame_portrait_matchmaking_02",
				connecting_icon = "matchmaking_connecting_icon",
				overlay = "unit_frame_portrait_matchmaking_01",
				frame = "unit_frame_02",
				ready_marker = "matchmaking_checkbox",
				is_connecting = false,
				is_ready = false
			},
			style = {
				portrait = {
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				default_portrait = {
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				connection_portrait = {
					offset = {
						0,
						0,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				connecting_icon = {
					angle = 0,
					size = {
						50,
						50
					},
					offset = {
						9,
						22,
						1
					},
					color = {
						255,
						255,
						255,
						255
					},
					pivot = {
						25,
						25
					}
				},
				overlay = {
					offset = {
						0,
						0,
						1
					},
					color = {
						255,
						0,
						255,
						0
					}
				},
				ready_marker = {
					size = {
						37,
						31
					},
					offset = {
						10,
						10,
						2
					},
					color = {
						255,
						0,
						255,
						0
					}
				},
				frame = {
					size = {
						141,
						198
					},
					offset = {
						-37.5,
						-48.5,
						3
					},
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_small_trait_button = function (scenegraph_id, hotspot_scenegraph_id, masked)
		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled and not content.is_selected
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_bg_id",
						texture_id = "texture_bg_id",
						content_check_function = function (content)
							return content.use_background
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content)
							return content.texture_id
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_hover_id",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_hover and not button_hotspot.is_selected and not button_hotspot.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_selected_id",
						texture_id = "texture_selected_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_selected and not button_hotspot.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_lock_id",
						texture_id = "texture_lock_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.locked and not button_hotspot.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_glow_id",
						texture_id = "texture_glow_id",
						content_check_function = function (content)
							return content.use_glow
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_trait_cover_id",
						texture_id = "texture_trait_cover_id",
						content_check_function = function (content)
							return content.button_hotspot.disabled and content.use_trait_cover and content.texture_id
						end
					}
				}
			},
			content = {
				use_glow = true,
				texture_lock_id = "trait_icon_selected_frame_locked",
				use_trait_cover = false,
				texture_glow_id = "item_slot_glow_03",
				texture_hover_id = "trait_icon_mouseover_frame",
				texture_selected_id = "trait_icon_selected_frame",
				use_background = true,
				texture_bg_id = "trait_slot",
				texture_id = "trait_icon_empty",
				texture_trait_cover_id = "trait_slot_cover",
				button_hotspot = {
					disabled = false,
					locked = false
				}
			},
			style = {
				button_hotspot = {
					scenegraph_id = hotspot_scenegraph_id
				},
				texture_bg_id = {
					masked = masked,
					size = {
						54,
						58
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-7,
						-10,
						-1
					}
				},
				texture_id = {
					masked = masked,
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_hover_id = {
					masked = masked,
					offset = {
						0,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_selected_id = {
					masked = masked,
					offset = {
						0,
						0,
						2
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_lock_id = {
					masked = masked,
					offset = {
						0,
						0,
						3
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_glow_id = {
					masked = masked,
					size = {
						104,
						104
					},
					offset = {
						-32,
						-32,
						4
					},
					color = {
						0,
						255,
						255,
						255
					}
				},
				texture_trait_cover_id = {
					masked = masked,
					size = {
						40,
						41
					},
					offset = {
						0,
						0,
						5
					},
					color = {
						255,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_small_reroll_trait_button = function (scenegraph_id, hotspot_scenegraph_id)
		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disabled and not content.is_selected
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_bg_id",
						texture_id = "texture_bg_id",
						content_check_function = function (content)
							return content.use_background
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_slot_id",
						texture_id = "texture_slot_id",
						content_check_function = function (content)
							return content.use_background
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content)
							return content.texture_id
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_hover_id",
						texture_id = "texture_hover_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_hover and not button_hotspot.is_selected and not button_hotspot.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_selected_id",
						texture_id = "texture_selected_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_selected and not button_hotspot.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_lock_id",
						texture_id = "texture_lock_id",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.locked and content.texture_id
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_glow_id",
						texture_id = "texture_glow_id",
						content_check_function = function (content)
							return content.use_glow
						end
					}
				}
			},
			content = {
				use_glow = true,
				texture_slot_id = "reroll_trait_slot_01",
				texture_glow_id = "reroll_glow_small",
				texture_hover_id = "trait_icon_mouseover_frame",
				use_background = true,
				texture_bg_id = "reroll_trait_slot_01_bg",
				texture_id = "trait_icon_empty",
				texture_selected_id = "trait_icon_selected_frame",
				texture_lock_id = "trait_icon_selected_frame_locked",
				button_hotspot = {
					disabled = false,
					locked = false
				}
			},
			style = {
				button_hotspot = {
					scenegraph_id = hotspot_scenegraph_id
				},
				texture_bg_id = {
					size = {
						68,
						68
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-14,
						-15,
						-1
					}
				},
				texture_slot_id = {
					size = {
						58,
						58
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-9,
						-9,
						0
					}
				},
				texture_id = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_hover_id = {
					offset = {
						0,
						0,
						2
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_selected_id = {
					offset = {
						0,
						0,
						3
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_lock_id = {
					offset = {
						0,
						0,
						4
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_glow_id = {
					size = {
						140,
						140
					},
					offset = {
						-50,
						-50,
						5
					},
					color = {
						0,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_attach_icon_button = function (background_texture, scenegraph_id, icon_scenegraph_id, drag_texture_size, animation_scenegraph_id, animation_glow_texture, disable_interaction)
		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content)
							return not content.disable_interaction
						end
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (content)
							return content.icon_texture_id and content.tooltip_enabled and content.button_hotspot.is_hover and not content.button_hotspot.disable_interaction
						end
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text_no_item",
						content_check_function = function (content)
							return not content.icon_texture_id and content.tooltip_enabled and content.button_hotspot.is_hover and not content.button_hotspot.disable_interaction
						end
					},
					{
						texture_id = "background_texture_id",
						style_id = "background_texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.background_texture_id
						end
					},
					{
						texture_id = "bg_overlay_texture_id",
						style_id = "bg_overlay_texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.bg_overlay_texture_id
						end
					},
					{
						texture_id = "icon_texture_id",
						style_id = "icon_texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.icon_texture_id
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_frame_texture_id",
						texture_id = "icon_frame_texture_id",
						content_check_function = function (ui_content)
							return ui_content.icon_texture_id or ui_content.bg_overlay_texture_id
						end
					},
					{
						texture_id = "glow_animation",
						style_id = "glow_animation",
						pass_type = "texture"
					},
					{
						texture_id = "icon_texture_id",
						style_id = "background_texture_id",
						pass_type = "drag",
						content_check_function = function (content)
							return not content.button_hotspot.disable_interaction
						end
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							return content.button_hotspot.is_hover and content.icon_texture_id and not content.is_dragging
						end
					},
					{
						pass_type = "texture",
						style_id = "drag_select_frame",
						texture_id = "drag_select_frame"
					}
				}
			},
			content = {
				tooltip_enabled = true,
				drag_select_frame = "item_slot_drag",
				tooltip_text_no_item = "forge_screen_merge_empy_slot_tooltip",
				hover_texture = "item_slot_hover",
				icon_frame_texture_id = "frame_01",
				tooltip_text = "forge_screen_merge_full_slot_tooltip",
				drag_texture_size = drag_texture_size,
				button_hotspot = {
					disable_interaction = disable_interaction
				},
				background_texture_id = background_texture,
				glow_animation = animation_glow_texture or "item_slot_glow"
			},
			style = {
				background_texture_id = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				bg_overlay_texture_id = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				icon_texture_id = {
					color = {
						255,
						255,
						255,
						255
					},
					scenegraph_id = icon_scenegraph_id
				},
				icon_frame_texture_id = {
					offset = {
						0,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					},
					scenegraph_id = icon_scenegraph_id
				},
				glow_animation = {
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = animation_scenegraph_id
				},
				hover_texture = {
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						4
					}
				},
				drag_select_frame = {
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						-24.5,
						-24,
						3
					},
					size = {
						127,
						127
					}
				},
				tooltip_text = {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						250
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_input_description_widgets = function (scenegraph_definition, parent_scenegraph_id, amount)
		local input_description_widgets = {}

		for i = 1, amount, 1 do
			local scenegraph_root_id = "input_description_root_" .. i
			local scenegraph_id = "input_description_" .. i
			local scenegraph_icon_id = "input_description_icon_" .. i
			local scenegraph_text_id = "input_description_text_" .. i
			scenegraph_definition[scenegraph_root_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = parent_scenegraph_id,
				size = {
					1,
					1
				},
				postion = {
					0,
					0,
					1
				}
			}
			scenegraph_definition[scenegraph_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = scenegraph_root_id,
				size = {
					200,
					40
				},
				postion = {
					0,
					0,
					1
				}
			}
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = scenegraph_id,
				size = {
					40,
					40
				},
				postion = {
					0,
					0,
					1
				}
			}
			scenegraph_definition[scenegraph_text_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "left",
				parent = scenegraph_icon_id,
				size = {
					160,
					40
				},
				postion = {
					40,
					0,
					1
				}
			}
			local widget_definition = {
				element = {
					passes = {
						{
							style_id = "text",
							pass_type = "text",
							text_id = "text"
						},
						{
							pass_type = "texture",
							style_id = "icon",
							texture_id = "icon"
						}
					}
				},
				content = {
					text = "",
					icon = "xbone_button_icon_a"
				},
				style = {
					text = {
						font_size = 24,
						word_wrap = true,
						pixel_perfect = true,
						horizontal_alignment = "left",
						vertical_alignment = "center",
						dynamic_font = true,
						font_type = "hell_shark",
						text_color = Colors.get_color_table_with_alpha("white", 255),
						offset = {
							0,
							0,
							1
						},
						scenegraph_id = scenegraph_text_id
					},
					icon = {
						scenegraph_id = scenegraph_icon_id
					}
				},
				scenegraph_id = scenegraph_id
			}
			input_description_widgets[#input_description_widgets + 1] = UIWidget.init(widget_definition)
		end

		return input_description_widgets
	end,
	create_hero_button = function (hero, scenegraph_id, hero_scenegraph_id)
		local hero_texture_normal_id = "tabs_class_icon_" .. hero .. "_normal"
		local hero_texture_hover_id = "tabs_class_icon_" .. hero .. "_hover"
		local hero_texture_selected_id = "tabs_class_icon_" .. hero .. "_selected"
		local hero_text = nil

		if hero == "all_heroes" then
			hero_texture_normal_id, hero_texture_hover_id, hero_texture_selected_id = nil
			hero_text = "ALL"
		end

		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.button_hotspot.is_hover and not content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "texture_hover_id",
						style_id = "texture_hover_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.button_hotspot.is_hover and not content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "texture_selected_id",
						style_id = "texture_selected_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "hero_texture_normal_id",
						style_id = "hero_texture_normal_id",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return content.hero_texture_normal_id and not button_hotspot.is_hover and not button_hotspot.is_selected
						end
					},
					{
						texture_id = "hero_texture_hover_id",
						style_id = "hero_texture_hover_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.hero_texture_hover_id and content.button_hotspot.is_hover
						end
					},
					{
						texture_id = "hero_texture_selected_id",
						style_id = "hero_texture_selected_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.hero_texture_selected_id and content.button_hotspot.is_selected
						end
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text",
						content_check_function = function (content)
							return content.text
						end
					}
				}
			},
			content = {
				texture_id = "tab_normal",
				texture_hover_id = "tab_hover",
				texture_selected_id = "tab_selected",
				button_hotspot = {},
				hero_texture_normal_id = hero_texture_normal_id,
				hero_texture_hover_id = hero_texture_hover_id,
				hero_texture_selected_id = hero_texture_selected_id,
				text = hero_text
			},
			style = {
				texture_id = {},
				texture_hover_id = {},
				texture_selected_id = {},
				hero_texture_normal_id = {
					scenegraph_id = hero_scenegraph_id
				},
				hero_texture_hover_id = {
					scenegraph_id = hero_scenegraph_id
				},
				hero_texture_selected_id = {
					scenegraph_id = hero_scenegraph_id
				},
				text = {
					font_size = 24,
					localize = true,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_table("cheeseburger"),
					offset = {
						0,
						0,
						2
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_trait_button = function (text, scenegraph_id, text_scenegraph_id, icon_scenegraph_id, animation_scenegraph_id)
		return {
			element = {
				passes = {
					{
						style_id = "button_hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						texture_id = "trait_owned_normal",
						style_id = "trait_owned_normal",
						pass_type = "texture",
						content_check_function = function (content)
							return content.owned and not content.button_hotspot.is_hover and not content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "trait_owned_hover",
						style_id = "trait_owned_hover",
						pass_type = "texture",
						content_check_function = function (content)
							return content.owned and content.button_hotspot.is_hover and not content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "trait_owned_selected",
						style_id = "trait_owned_selected",
						pass_type = "texture",
						content_check_function = function (content)
							return content.owned and content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "trait_purchase_normal",
						style_id = "trait_purchase_normal",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.button_hotspot.is_hover and not content.button_hotspot.is_selected and not content.owned and not content.locked
						end
					},
					{
						texture_id = "trait_purchase_hover",
						style_id = "trait_purchase_hover",
						pass_type = "texture",
						content_check_function = function (content)
							return content.button_hotspot.is_hover and not content.button_hotspot.is_selected and not content.owned and not content.locked
						end
					},
					{
						texture_id = "trait_purchase_selected",
						style_id = "trait_purchase_selected",
						pass_type = "texture",
						content_check_function = function (content)
							return content.button_hotspot.is_selected and not content.owned and not content.locked
						end
					},
					{
						texture_id = "trait_locked_normal",
						style_id = "trait_locked_normal",
						pass_type = "texture",
						content_check_function = function (content)
							return content.locked and not content.button_hotspot.is_hover and not content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "trait_locked_hover",
						style_id = "trait_locked_hover",
						pass_type = "texture",
						content_check_function = function (content)
							return content.locked and content.button_hotspot.is_hover and not content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "trait_locked_selected",
						style_id = "trait_locked_selected",
						pass_type = "texture",
						content_check_function = function (content)
							return content.locked and content.button_hotspot.is_selected
						end
					},
					{
						texture_id = "trait_icon",
						style_id = "trait_icon",
						pass_type = "texture"
					},
					{
						texture_id = "trait_unlock_animation",
						style_id = "trait_unlock_animation",
						pass_type = "texture"
					},
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						style_id = "description_text",
						pass_type = "text",
						text_id = "description_text"
					}
				}
			},
			content = {
				trait_purchase_normal = "forge_item_box_rock_normal",
				trait_purchase_hover = "forge_item_box_rock_hover",
				trait_locked_normal = "forge_item_box_locked_normal",
				trait_icon = "icons_placeholder",
				trait_unlock_animation = "forge_item_box_glow_effect",
				trait_owned_normal = "forge_item_box_gold_normal",
				trait_locked_hover = "forge_item_box_locked_hover",
				trait_owned_hover = "forge_item_box_gold_hover",
				owned = false,
				trait_locked_selected = "forge_item_box_locked_selected",
				locked = false,
				description_text = "description",
				trait_owned_selected = "forge_item_box_gold_selected",
				trait_purchase_selected = "forge_item_box_rock_selected",
				button_hotspot = {},
				title_text = text
			},
			style = {
				trait_owned_selected = {},
				trait_owned_hover = {},
				trait_owned_normal = {},
				trait_purchase_selected = {},
				trait_purchase_hover = {},
				trait_purchase_normal = {},
				trait_locked_selected = {},
				trait_locked_hover = {},
				trait_locked_normal = {},
				trait_icon = {
					scenegraph_id = icon_scenegraph_id
				},
				title_text = {
					vertical_alignment = "center",
					dynamic_font = true,
					horizontal_alignment = "right",
					font_size = 32,
					pixel_perfect = true,
					font_type = "hell_shark",
					text_color = Colors.get_table("white"),
					scenegraph_id = text_scenegraph_id
				},
				description_text = {
					font_size = 16,
					pixel_perfect = true,
					horizontal_alignment = "right",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_table("white"),
					scenegraph_id = text_scenegraph_id,
					offset = {
						0,
						-20,
						0
					}
				},
				trait_unlock_animation = {
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = animation_scenegraph_id
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_scoreboard_topic_widget = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "on_click",
						click_check_content_id = "button_hotspot",
						click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
							ui_content.button_hotspot.is_selected = true

							return 
						end
					},
					{
						texture_id = "texture_hover_id",
						style_id = "background_hover",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						texture_id = "texture_select_id",
						style_id = "background_select",
						pass_type = "texture",
						content_check_function = function (content)
							return not content.disabled
						end
					},
					{
						style_id = "background",
						pass_type = "texture_uv_dynamic_color_uvs_size_offset",
						content_id = "background",
						dynamic_function = function (content, style, size, dt)
							local fraction = content.fraction
							local direction = content.direction
							local color = style.color
							local uv_start_pixels = style.uv_start_pixels
							local uv_scale_pixels = style.uv_scale_pixels
							local uv_pixels = uv_start_pixels + uv_scale_pixels*fraction
							local uvs = style.uvs
							local uv_scale_axis = style.scale_axis

							if direction == 1 then
								uvs[1][uv_scale_axis] = 0
								uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
								size[uv_scale_axis] = uv_pixels
								compact_topic_offset[uv_scale_axis] = 0
							else
								uvs[2][uv_scale_axis] = 1
								uvs[1][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels) - 1
								size[uv_scale_axis] = uv_pixels
								compact_topic_offset[uv_scale_axis] = -(uv_pixels - (uv_start_pixels + uv_scale_pixels))
							end

							return style.color, uvs, size, compact_topic_offset
						end
					},
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						style_id = "player_name",
						pass_type = "text",
						text_id = "player_name"
					},
					{
						style_id = "score_text",
						pass_type = "text",
						text_id = "score_text"
					}
				}
			},
			content = {
				score_text = "score_text",
				title_text = "title_text",
				player_name = "player_name",
				texture_hover_id = "scoreboard_topic_button_hover",
				texture_select_id = "scoreboard_topic_button_highlight",
				background = {
					texture_id = "scoreboard_topic_button_normal",
					direction = 1,
					fraction = 1
				},
				button_hotspot = {}
			},
			style = {
				background_hover = {
					scenegraph_id = "compact_preview_background_1",
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						1
					}
				},
				background_select = {
					scenegraph_id = "compact_preview_background_1",
					size = {
						350,
						260
					},
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						-23,
						-23,
						-1
					}
				},
				background = {
					uv_start_pixels = 0,
					scenegraph_id = "compact_preview_background_1",
					uv_scale_pixels = 304,
					offset_scale = 1,
					scale_axis = 1,
					color = {
						255,
						255,
						255,
						255
					},
					uvs = {
						{
							0,
							0
						},
						{
							1,
							1
						}
					}
				},
				score_text = {
					font_size = 56,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						5,
						5
					}
				},
				title_text = {
					font_size = 36,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "top",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						0,
						-30,
						5
					}
				},
				player_name = {
					font_size = 24,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "bottom",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						50,
						5
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_splash_video = function (input)
		return {
			element = {
				passes = {
					{
						style_id = "background",
						scenegraph_id = "background",
						pass_type = "rect",
						content_check_function = function (content)
							local w, h = Gui.resolution()
							local aspect_ratio = w/h
							local default_aspect_ratio = 1.7777777777777777
							local height = h
							local width = w

							if 0.005 < math.abs(aspect_ratio - default_aspect_ratio) then
								return true
							end

							return 
						end
					},
					{
						style_id = "video_style",
						pass_type = "splash_video",
						content_id = "video_content"
					}
				}
			},
			content = {
				video_content = {
					video_completed = false,
					material_name = input.material_name
				}
			},
			style = {
				background = {
					color = Colors.color_definitions.black
				},
				video_style = {}
			},
			scenegraph_id = input.scenegraph_id
		}
	end,
	create_splash_texture = function (input)
		return {
			element = {
				passes = {
					{
						style_id = "foreground",
						scenegraph_id = "foreground",
						pass_type = "rect",
						content_check_function = function (content)
							return content.foreground.disable_foreground ~= true
						end
					},
					{
						style_id = "background",
						scenegraph_id = "background",
						pass_type = "rect",
						content_check_function = function (content)
							return content.foreground.disable_background ~= true
						end
					},
					{
						texture_id = "material_name",
						style_id = "texture_style",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						style_id = "texts_style",
						pass_type = "multiple_texts",
						texts_id = "texts",
						content_id = "texts_content",
						scenegraph_id = input.texts_scenegraph_id,
						content_check_function = function (content)
							return content.texts.texts ~= nil
						end
					}
				}
			},
			content = {
				texture_content = {
					material_name = input.material_name
				},
				texts = {
					texts = input.texts
				},
				foreground = {
					disable_foreground = input.disable_foreground
				}
			},
			style = {
				foreground = {
					color = Colors.color_definitions.black
				},
				background = {
					color = Colors.color_definitions.black
				},
				texture_style = {
					size = input.texture_size,
					offset = input.texture_offset or {
						0,
						0,
						0
					}
				},
				texts_style = {
					scenegraph_id = "texts",
					text_color = Colors.color_definitions.white,
					font_size = input.font_size,
					dynamic_font = input.dynamic_font,
					pixel_perfect = input.pixel_perfect,
					font_type = input.font_type,
					localize = input.localize,
					horizontal_alignment = input.text_horizontal_alignment,
					vertical_alignment = input.text_vertical_alignment,
					spacing = input.spacing,
					size = input.size,
					axis = input.axis,
					direction = input.direction,
					offset = input.offset
				}
			},
			scenegraph_id = input.scenegraph_id
		}
	end,
	create_loader_icon = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "loader_icon",
						texture_id = "loader_icon"
					},
					{
						pass_type = "rotated_texture",
						style_id = "loader_part_1",
						texture_id = "loader_part_1"
					},
					{
						pass_type = "rotated_texture",
						style_id = "loader_part_2",
						texture_id = "loader_part_2"
					}
				}
			},
			content = {
				loader_part_1 = "matchmaking_loading_icon_part_01",
				loader_part_2 = "matchmaking_loading_icon_part_02",
				loader_icon = "matchmaking_loading_icon_part_03"
			},
			style = {
				loader_icon = {
					offset = {
						10,
						10,
						3
					},
					size = {
						52,
						52
					}
				},
				loader_part_1 = {
					angle = 0,
					offset = {
						10,
						10,
						1
					},
					size = {
						52,
						52
					},
					pivot = {
						26,
						26
					}
				},
				loader_part_2 = {
					angle = 0,
					offset = {
						10,
						10,
						2
					},
					size = {
						52,
						52
					},
					pivot = {
						26,
						26
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_partner_splash_widget = function (input)
		return {
			element = {
				passes = {
					{
						style_id = "foreground",
						scenegraph_id = "foreground",
						pass_type = "rect",
						content_check_function = function (content)
							return content.foreground.disable_foreground ~= true
						end
					},
					{
						style_id = "background",
						scenegraph_id = "background",
						pass_type = "rect"
					},
					{
						style_id = "texts_style",
						pass_type = "multiple_texts",
						texts_id = "texts",
						content_id = "texts_content",
						scenegraph_id = input.texts_scenegraph_id,
						content_check_function = function (content)
							return content.texts.texts ~= nil
						end
					},
					{
						texture_id = "material_name_1",
						style_id = "texture_style_1",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						texture_id = "material_name_2",
						style_id = "texture_style_2",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						texture_id = "material_name_3",
						style_id = "texture_style_3",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						texture_id = "material_name_4",
						style_id = "texture_style_4",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						texture_id = "material_name_5",
						style_id = "texture_style_5",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						texture_id = "material_name_6",
						style_id = "texture_style_6",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					},
					{
						texture_id = "material_name_7",
						style_id = "texture_style_7",
						pass_type = "texture",
						content_id = "texture_content",
						scenegraph_id = input.scenegraph_id
					}
				}
			},
			content = {
				texture_content = {
					material_name_1 = input.texture_materials[1],
					material_name_2 = input.texture_materials[2],
					material_name_3 = input.texture_materials[3],
					material_name_4 = input.texture_materials[4],
					material_name_5 = input.texture_materials[5],
					material_name_6 = input.texture_materials[6],
					material_name_7 = input.texture_materials[7]
				},
				texts = {
					texts = input.texts
				},
				foreground = {
					disable_foreground = input.disable_foreground
				}
			},
			style = {
				foreground = {
					color = Colors.color_definitions.black
				},
				background = {
					color = Colors.color_definitions.black
				},
				texture_style_1 = {
					scenegraph_id = input.texture_scenegraph_ids[1]
				},
				texture_style_2 = {
					scenegraph_id = input.texture_scenegraph_ids[2]
				},
				texture_style_3 = {
					scenegraph_id = input.texture_scenegraph_ids[3]
				},
				texture_style_4 = {
					scenegraph_id = input.texture_scenegraph_ids[4]
				},
				texture_style_5 = {
					scenegraph_id = input.texture_scenegraph_ids[5]
				},
				texture_style_6 = {
					scenegraph_id = input.texture_scenegraph_ids[6]
				},
				texture_style_7 = {
					scenegraph_id = input.texture_scenegraph_ids[7]
				},
				texts_style = {
					scenegraph_id = "texts",
					text_color = Colors.color_definitions.white,
					font_size = input.font_size,
					dynamic_font = input.dynamic_font,
					pixel_perfect = input.pixel_perfect,
					font_type = input.font_type,
					localize = input.localize,
					horizontal_alignment = input.text_horizontal_alignment,
					vertical_alignment = input.text_vertical_alignment,
					spacing = input.spacing,
					size = input.size,
					axis = input.axis,
					direction = input.direction,
					offset = input.offset
				}
			},
			scenegraph_id = input.scenegraph_id
		}
	end,
	create_map_player_entry = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text"
					},
					{
						style_id = "hero_icon",
						pass_type = "hotspot",
						content_id = "hero_icon_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "host_icon",
						texture_id = "host_icon_texture",
						content_check_function = function (content)
							return content.is_host
						end
					},
					{
						pass_type = "texture",
						style_id = "hero_icon",
						texture_id = "hero_icon_texture"
					},
					{
						style_id = "hero_icon_tooltip_text",
						pass_type = "tooltip_text",
						text_id = "hero_icon_tooltip_text",
						content_check_function = function (content)
							return content.hero_icon_hotspot.is_hover
						end
					},
					{
						style_id = "kick_button_texture",
						pass_type = "hotspot",
						content_id = "kick_button_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "kick_button_texture",
						texture_id = "kick_button_texture",
						content_check_function = function (content)
							return content.kick_enabled and content.button_hotspot.is_hover and not content.kick_button_hotspot.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "kick_button_texture_hover",
						texture_id = "kick_button_texture",
						content_check_function = function (content)
							return content.kick_enabled and content.button_hotspot.is_hover and content.kick_button_hotspot.is_hover
						end
					},
					{
						style_id = "kick_button_tooltip_text",
						pass_type = "tooltip_text",
						text_id = "kick_button_tooltip_text",
						content_check_function = function (content)
							return content.kick_button_hotspot.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							return content.button_hotspot.is_selected or content.button_hotspot.is_hover
						end
					}
				}
			},
			content = {
				kick_button_tooltip_text = "map_setting_kick_player",
				kick_enabled = true,
				hero_icon_texture = "tabs_class_icon_dwarf_ranger_normal",
				hero_icon_tooltip_text = "hero_icon",
				is_host = false,
				kick_button_texture = "kick_player_icon",
				hover_texture = "map_setting_bg_fade",
				text = "Unknown Player",
				host_icon_texture = "host_icon",
				button_hotspot = {},
				hero_icon_hotspot = {},
				kick_button_hotspot = {}
			},
			style = {
				text = {
					vertical_alignment = "center",
					font_size = 24,
					localize = false,
					horizontal_alignment = "left",
					word_wrap = true,
					font_type = "hell_shark",
					text_color = Colors.get_table("white"),
					offset = {
						40,
						0,
						2
					}
				},
				hero_icon = {
					size = {
						34,
						34
					},
					offset = {
						0,
						3,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				host_icon = {
					size = {
						18,
						14
					},
					offset = {
						343,
						13,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				hero_icon_tooltip_text = {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					size = {
						34,
						34
					},
					offset = {
						0,
						3,
						4
					}
				},
				hover_texture = {
					size = {
						308,
						28
					},
					offset = {
						26,
						6,
						-1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				kick_button_texture = {
					size = {
						34,
						34
					},
					offset = {
						336,
						6,
						1
					},
					color = {
						180,
						255,
						255,
						255
					}
				},
				kick_button_texture_hover = {
					size = {
						34,
						34
					},
					offset = {
						336,
						6,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				kick_button_tooltip_text = {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					size = {
						26,
						26
					},
					offset = {
						344,
						0,
						4
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_map_settings_stepper = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_selected or button_hotspot.is_hover
						end
					},
					{
						style_id = "left_button_texture",
						pass_type = "hotspot",
						content_id = "left_button_hotspot"
					},
					{
						style_id = "right_button_texture",
						pass_type = "hotspot",
						content_id = "right_button_hotspot"
					},
					{
						style_id = "setting_text",
						pass_type = "text",
						text_id = "setting_text"
					},
					{
						pass_type = "texture",
						style_id = "left_button_texture",
						texture_id = "left_button_texture"
					},
					{
						pass_type = "rotated_texture",
						style_id = "right_button_texture",
						texture_id = "right_button_texture"
					},
					{
						pass_type = "texture",
						style_id = "left_button_texture_clicked",
						texture_id = "left_button_texture_clicked"
					},
					{
						pass_type = "rotated_texture",
						style_id = "right_button_texture_clicked",
						texture_id = "right_button_texture_clicked"
					}
				}
			},
			content = {
				left_button_texture = "settings_arrow_normal",
				hover_texture = "map_setting_bg_fade",
				setting_text = "test_text",
				right_button_texture_clicked = "settings_arrow_clicked",
				right_button_texture = "settings_arrow_normal",
				left_button_texture_clicked = "settings_arrow_clicked",
				button_hotspot = {},
				left_button_hotspot = {},
				right_button_hotspot = {}
			},
			style = {
				hover_texture = {
					size = {
						410,
						50
					},
					offset = {
						-55,
						-8,
						0
					}
				},
				left_button_texture = {
					size = {
						28,
						34
					},
					offset = {
						-40,
						-3,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				right_button_texture = {
					angle = 3.1415926499999998,
					pivot = {
						14,
						17
					},
					size = {
						28,
						34
					},
					offset = {
						315,
						-3,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				left_button_texture_clicked = {
					color = {
						0,
						255,
						255,
						255
					},
					size = {
						28,
						34
					},
					offset = {
						-40,
						-3,
						1
					}
				},
				right_button_texture_clicked = {
					angle = 3.1415926499999998,
					color = {
						0,
						255,
						255,
						255
					},
					pivot = {
						14,
						17
					},
					size = {
						28,
						34
					},
					offset = {
						315,
						-3,
						1
					}
				},
				setting_text = {
					font_size = 28,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						4
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_map_settings_title_stepper = function (tooltip_text, scenegraph_id, text_scenegraph_id, tooltip_scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_selected or button_hotspot.is_hover
						end
					},
					{
						style_id = "left_button_texture",
						pass_type = "hotspot",
						content_id = "left_button_hotspot"
					},
					{
						style_id = "right_button_texture",
						pass_type = "hotspot",
						content_id = "right_button_hotspot"
					},
					{
						texture_id = "background_texture",
						style_id = "background_texture",
						pass_type = "texture"
					},
					{
						style_id = "setting_text",
						pass_type = "text",
						text_id = "setting_text"
					},
					{
						pass_type = "texture",
						style_id = "left_button_texture",
						texture_id = "left_button_texture"
					},
					{
						pass_type = "rotated_texture",
						style_id = "right_button_texture",
						texture_id = "right_button_texture"
					},
					{
						pass_type = "texture",
						style_id = "left_button_texture_clicked",
						texture_id = "left_button_texture_clicked"
					},
					{
						pass_type = "rotated_texture",
						style_id = "right_button_texture_clicked",
						texture_id = "right_button_texture_clicked"
					},
					{
						pass_type = "hotspot",
						content_id = "tooltip_hotspot"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (ui_content)
							return ui_content.tooltip_hotspot.is_hover
						end
					}
				}
			},
			content = {
				left_button_texture = "settings_arrow_normal",
				hover_texture = "map_setting_bg_fade",
				setting_text = "test_text",
				right_button_texture_clicked = "settings_arrow_clicked",
				right_button_texture = "settings_arrow_normal",
				left_button_texture_clicked = "settings_arrow_clicked",
				background_texture = "title_bar",
				button_hotspot = {},
				left_button_hotspot = {},
				right_button_hotspot = {},
				tooltip_hotspot = {},
				tooltip_text = tooltip_text
			},
			style = {
				hover_texture = {
					size = {
						410,
						50
					},
					offset = {
						-20,
						0,
						0
					}
				},
				background_texture = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				left_button_texture = {
					size = {
						28,
						34
					},
					offset = {
						55,
						10,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				right_button_texture = {
					angle = 3.1415926499999998,
					pivot = {
						14,
						17
					},
					size = {
						28,
						34
					},
					offset = {
						287,
						10,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				left_button_texture_clicked = {
					color = {
						0,
						255,
						255,
						255
					},
					size = {
						28,
						34
					},
					offset = {
						55,
						10,
						1
					}
				},
				right_button_texture_clicked = {
					angle = 3.1415926499999998,
					color = {
						0,
						255,
						255,
						255
					},
					pivot = {
						14,
						17
					},
					size = {
						28,
						34
					},
					offset = {
						287,
						10,
						1
					}
				},
				setting_text = {
					vertical_alignment = "center",
					localize = true,
					font_size = 28,
					horizontal_alignment = "center",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					scenegraph_id = text_scenegraph_id
				},
				tooltip_text = {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_lobby_browser_stepper = function (scenegraph_id)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_selected or button_hotspot.is_hover
						end
					},
					{
						style_id = "left_button_texture",
						pass_type = "hotspot",
						content_id = "left_button_hotspot"
					},
					{
						style_id = "right_button_texture",
						pass_type = "hotspot",
						content_id = "right_button_hotspot"
					},
					{
						style_id = "setting_text",
						pass_type = "text",
						text_id = "setting_text"
					},
					{
						pass_type = "texture",
						style_id = "left_button_texture",
						texture_id = "left_button_texture"
					},
					{
						pass_type = "rotated_texture",
						style_id = "right_button_texture",
						texture_id = "right_button_texture"
					},
					{
						pass_type = "texture",
						style_id = "left_button_texture_clicked",
						texture_id = "left_button_texture_clicked"
					},
					{
						pass_type = "rotated_texture",
						style_id = "right_button_texture_clicked",
						texture_id = "right_button_texture_clicked"
					}
				}
			},
			content = {
				left_button_texture = "settings_arrow_normal",
				hover_texture = "map_setting_bg_fade",
				setting_text = "test_text",
				right_button_texture_clicked = "settings_arrow_clicked",
				right_button_texture = "settings_arrow_normal",
				left_button_texture_clicked = "settings_arrow_clicked",
				button_hotspot = {},
				left_button_hotspot = {},
				right_button_hotspot = {}
			},
			style = {
				hover_texture = {
					size = {
						340,
						50
					},
					offset = {
						-55,
						-8,
						0
					}
				},
				left_button_texture = {
					size = {
						28,
						34
					},
					offset = {
						-40,
						-3,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				right_button_texture = {
					angle = 3.1415926499999998,
					pivot = {
						14,
						17
					},
					size = {
						28,
						34
					},
					offset = {
						255,
						-3,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				left_button_texture_clicked = {
					color = {
						0,
						255,
						255,
						255
					},
					size = {
						28,
						34
					},
					offset = {
						-40,
						-3,
						1
					}
				},
				right_button_texture_clicked = {
					angle = 3.1415926499999998,
					color = {
						0,
						255,
						255,
						255
					},
					pivot = {
						14,
						17
					},
					size = {
						28,
						34
					},
					offset = {
						255,
						-3,
						1
					}
				},
				setting_text = {
					font_size = 22,
					word_wrap = true,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						4
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_map_hero_list_widget = function (scenegraph_id)
		local icons = UISettings.hero_icons.small

		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "texture",
						style_id = "hover_texture",
						texture_id = "hover_texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return button_hotspot.is_selected or button_hotspot.is_hover
						end
					},
					{
						style_id = "icon_1",
						pass_type = "hotspot",
						content_id = "hotspot_1"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text_icon_1",
						content_check_function = function (ui_content)
							return ui_content.hotspot_1.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_1",
						texture_id = "icon_1",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return not content.hotspot_1.is_hover and (not is_selected or internal_index ~= 1)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_1",
						texture_id = "icon_1_hover",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return content.hotspot_1.is_hover or (is_selected and internal_index == 1)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_1",
						texture_id = "selected_texture",
						content_check_function = function (content)
							return content.hotspot_1.selected
						end
					},
					{
						style_id = "icon_2",
						pass_type = "hotspot",
						content_id = "hotspot_2"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text_icon_2",
						content_check_function = function (ui_content)
							return ui_content.hotspot_2.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_2",
						texture_id = "icon_2",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return not content.hotspot_2.is_hover and (not is_selected or internal_index ~= 2)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_2",
						texture_id = "icon_2_hover",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return content.hotspot_2.is_hover or (is_selected and internal_index == 2)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_2",
						texture_id = "selected_texture",
						content_check_function = function (content)
							return content.hotspot_2.selected
						end
					},
					{
						style_id = "icon_3",
						pass_type = "hotspot",
						content_id = "hotspot_3"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text_icon_3",
						content_check_function = function (ui_content)
							return ui_content.hotspot_3.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_3",
						texture_id = "icon_3",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return not content.hotspot_3.is_hover and (not is_selected or internal_index ~= 3)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_3",
						texture_id = "icon_3_hover",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return content.hotspot_3.is_hover or (is_selected and internal_index == 3)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_3",
						texture_id = "selected_texture",
						content_check_function = function (content)
							return content.hotspot_3.selected
						end
					},
					{
						style_id = "icon_4",
						pass_type = "hotspot",
						content_id = "hotspot_4"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text_icon_4",
						content_check_function = function (ui_content)
							return ui_content.hotspot_4.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_4",
						texture_id = "icon_4",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return not content.hotspot_4.is_hover and (not is_selected or internal_index ~= 4)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_4",
						texture_id = "icon_4_hover",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return content.hotspot_4.is_hover or (is_selected and internal_index == 4)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_4",
						texture_id = "selected_texture",
						content_check_function = function (content)
							return content.hotspot_4.selected
						end
					},
					{
						style_id = "icon_5",
						pass_type = "hotspot",
						content_id = "hotspot_5"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text_icon_5",
						content_check_function = function (ui_content)
							return ui_content.hotspot_5.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_5",
						texture_id = "icon_5",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return not content.hotspot_5.is_hover and (not is_selected or internal_index ~= 5)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_5",
						texture_id = "icon_5_hover",
						content_check_function = function (content)
							local is_selected = content.button_hotspot.is_selected
							local internal_index = content.internal_index

							return content.hotspot_5.is_hover or (is_selected and internal_index == 5)
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_5",
						texture_id = "selected_texture",
						content_check_function = function (content)
							return content.hotspot_5.selected
						end
					}
				}
			},
			content = {
				internal_index = 1,
				icon_5 = "tabs_class_icon_empire_soldier_normal",
				icon_3 = "tabs_class_icon_dwarf_ranger_normal",
				hover_texture = "map_setting_bg_fade",
				icon_2_hover = "tabs_class_icon_way_watcher_selected",
				icon_4 = "tabs_class_icon_bright_wizard_normal",
				icon_3_hover = "tabs_class_icon_dwarf_ranger_selected",
				icon_1 = "tabs_class_icon_witch_hunter_normal",
				icon_4_hover = "tabs_class_icon_bright_wizard_selected",
				selected_texture = "tab_menu_icon_03",
				icon_1_hover = "tabs_class_icon_witch_hunter_selected",
				icon_5_hover = "tabs_class_icon_empire_soldier_selected",
				icon_2 = "tabs_class_icon_way_watcher_normal",
				button_hotspot = {},
				hotspot_1 = {},
				hotspot_2 = {},
				hotspot_3 = {},
				hotspot_4 = {},
				hotspot_5 = {},
				tooltip_text_icon_1 = UISettings.hero_tooltips.witch_hunter,
				tooltip_text_icon_2 = UISettings.hero_tooltips.wood_elf,
				tooltip_text_icon_3 = UISettings.hero_tooltips.dwarf_ranger,
				tooltip_text_icon_4 = UISettings.hero_tooltips.bright_wizard,
				tooltip_text_icon_5 = UISettings.hero_tooltips.empire_soldier
			},
			style = {
				hover_texture = {
					size = {
						410,
						50
					},
					offset = {
						-55,
						-8,
						0
					}
				},
				icon_1 = {
					size = {
						34,
						34
					},
					offset = {
						25,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				icon_2 = {
					size = {
						34,
						34
					},
					offset = {
						79,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				icon_3 = {
					size = {
						34,
						34
					},
					offset = {
						133,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				icon_4 = {
					size = {
						34,
						34
					},
					offset = {
						187,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				icon_5 = {
					size = {
						34,
						34
					},
					offset = {
						241,
						0,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				tooltip_text = {
					font_size = 24,
					max_width = 500,
					localize = true,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_checkbox_widget = function (text, tooltip_text, scenegraph_id, checkbox_offset, optional_text_offset)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						style_id = "tooltip_text",
						pass_type = "tooltip_text",
						text_id = "tooltip_text",
						content_check_function = function (ui_content)
							return ui_content.button_hotspot.is_hover and ui_content.tooltip_text ~= ""
						end
					},
					{
						style_id = "setting_text",
						pass_type = "text",
						text_id = "setting_text",
						content_check_function = function (content)
							return not content.button_hotspot.is_hover
						end
					},
					{
						style_id = "setting_text_hover",
						pass_type = "text",
						text_id = "setting_text",
						content_check_function = function (content)
							return content.button_hotspot.is_hover
						end
					},
					{
						pass_type = "texture",
						style_id = "checkbox_style",
						texture_id = "checkbox_unchecked_texture",
						content_check_function = function (content)
							return not content.checked
						end
					},
					{
						pass_type = "texture",
						style_id = "checkbox_style",
						texture_id = "checkbox_checked_texture",
						content_check_function = function (content)
							return content.checked
						end
					}
				}
			},
			content = {
				checkbox_unchecked_texture = "checkbox_unchecked",
				checked = false,
				checkbox_checked_texture = "checkbox_checked",
				button_hotspot = {},
				tooltip_text = tooltip_text,
				setting_text = text
			},
			style = {
				checkbox_style = {
					size = {
						16,
						16
					},
					offset = {
						checkbox_offset,
						9,
						1
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				setting_text = {
					vertical_alignment = "center",
					font_size = 18,
					localize = true,
					horizontal_alignment = "left",
					word_wrap = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = optional_text_offset or {
						0,
						0,
						4
					}
				},
				setting_text_hover = {
					vertical_alignment = "center",
					font_size = 18,
					localize = true,
					horizontal_alignment = "left",
					word_wrap = true,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = optional_text_offset or {
						0,
						0,
						4
					}
				},
				tooltip_text = {
					font_size = 18,
					max_width = 500,
					localize = true,
					cursor_side = "left",
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					line_colors = {},
					offset = {
						0,
						0,
						50
					},
					cursor_offset = {
						-10,
						-27
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_story_level_map_widget = function (scenegraph_id, level_key, debug_level)
		local show_debug_levels = UISettings.map.show_debug_levels
		local level_data_list = {}
		local debug_level_counter = 0
		local widget_template = {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						pass_type = "on_click",
						click_check_content_id = "button_hotspot",
						click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
							ui_content.button_hotspot.is_selected = true

							return 
						end
					},
					{
						pass_type = "texture",
						style_id = "background",
						texture_id = "background"
					},
					{
						pass_type = "texture",
						style_id = "selected",
						texture_id = "selected"
					},
					{
						pass_type = "texture",
						style_id = "hover",
						texture_id = "hover"
					},
					{
						pass_type = "tiled_texture",
						style_id = "text_background_center",
						texture_id = "text_background_center"
					},
					{
						pass_type = "texture",
						style_id = "text_background_left",
						texture_id = "text_background_left"
					},
					{
						pass_type = "texture",
						style_id = "text_background_right",
						texture_id = "text_background_right"
					},
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						pass_type = "texture",
						style_id = "difficulty_icon_1",
						texture_id = "difficulty_icon_1"
					},
					{
						pass_type = "texture",
						style_id = "difficulty_icon_2",
						texture_id = "difficulty_icon_2"
					},
					{
						pass_type = "texture",
						style_id = "difficulty_icon_3",
						texture_id = "difficulty_icon_3"
					},
					{
						pass_type = "texture",
						style_id = "difficulty_icon_4",
						texture_id = "difficulty_icon_4"
					},
					{
						pass_type = "texture",
						style_id = "difficulty_icon_5",
						texture_id = "difficulty_icon_5"
					},
					{
						pass_type = "texture",
						style_id = "new_flag",
						texture_id = "new_flag"
					}
				}
			},
			content = {
				text_background_center = "level_title_banner_middle",
				hover = "level_location_long_icon_hover",
				text_background_right = "level_title_banner_right",
				selected = "level_location_long_icon_selected",
				unlocked = "menu_map_level_unlocked_icon",
				difficulty_icon_3 = "difficulty_icon_small_02",
				difficulty_icon_2 = "difficulty_icon_small_02",
				difficulty_icon_4 = "difficulty_icon_small_02",
				difficulty_icon_1 = "difficulty_icon_small_02",
				background = "level_location_icon_01",
				difficulty_icon_5 = "difficulty_icon_small_02",
				new_flag = "list_item_tag_new",
				text_background_left = "level_title_banner_left",
				button_hotspot = {},
				title_text = level_key
			},
			style = {
				new_flag = {
					size = {
						126,
						51
					},
					offset = {
						-21,
						-25,
						10
					},
					color = {
						0,
						255,
						255,
						255
					}
				},
				difficulty_icon_1 = {
					size = {
						15,
						21
					},
					offset = {
						-5,
						54,
						4
					}
				},
				difficulty_icon_2 = {
					size = {
						15,
						21
					},
					offset = {
						10,
						66,
						4
					}
				},
				difficulty_icon_3 = {
					size = {
						15,
						21
					},
					offset = {
						29,
						69,
						4
					}
				},
				difficulty_icon_4 = {
					size = {
						15,
						21
					},
					offset = {
						48,
						66,
						4
					}
				},
				difficulty_icon_5 = {
					size = {
						15,
						21
					},
					offset = {
						63,
						54,
						4
					}
				},
				background = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				selected = {
					color = {
						0,
						255,
						255,
						255
					}
				},
				hover = {
					color = {
						0,
						255,
						255,
						255
					}
				},
				unlocked = {
					color = {
						255,
						255,
						255,
						255
					}
				},
				text_background_left = {},
				text_background_right = {},
				text_background_center = {
					offset = {
						0,
						0,
						0
					},
					texture_tiling_size = {
						26,
						35
					}
				},
				title_text = {
					localize = false,
					font_size = 28,
					pixel_perfect = true,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					dynamic_font = true,
					font_type = "hell_shark_no_outline",
					text_color = Colors.get_color_table_with_alpha("black", 255),
					offset = {
						0,
						0,
						1
					}
				},
				title_text_highlight = {
					vertical_alignment = "center",
					horizontal_alignment = "center",
					localize = false,
					font_size = 28,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("yellow", 255),
					offset = {
						0,
						-35,
						5
					}
				}
			},
			scenegraph_id = scenegraph_id
		}

		return {
			game_type = "long",
			level_key = level_key,
			widget = UIWidget.init(widget_template)
		}
	end,
	create_text_button = function (scenegraph_id, text, font_size, optional_offset)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_text"
					},
					{
						style_id = "text_hover",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							return content.button_text.is_hover
						end
					},
					{
						style_id = "text",
						pass_type = "text",
						text_id = "text_field",
						content_check_function = function (content)
							return not content.button_text.is_hover
						end
					}
				}
			},
			content = {
				button_text = {},
				text_field = text
			},
			style = {
				text = {
					vertical_alignment = "center",
					localize = true,
					horizontal_alignment = "left",
					word_wrap = true,
					font_type = "hell_shark",
					font_size = font_size,
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = optional_offset or {
						0,
						0,
						4
					}
				},
				text_hover = {
					vertical_alignment = "center",
					localize = true,
					horizontal_alignment = "left",
					word_wrap = true,
					font_type = "hell_shark",
					font_size = font_size,
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = optional_offset or {
						0,
						0,
						4
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_compare_menu_trait_widget = function (scenegraph_id, description_scenegraph_id, masked, use_divider)
		return {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "texture_bg_id",
						texture_id = "texture_bg_id",
						content_check_function = function (content)
							return content.use_background
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_id",
						texture_id = "texture_id",
						content_check_function = function (content)
							return content.texture_id
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_lock_id",
						texture_id = "texture_lock_id",
						content_check_function = function (content)
							return content.locked and not content.disabled
						end
					},
					{
						pass_type = "texture",
						style_id = "texture_glow_id",
						texture_id = "texture_glow_id",
						content_check_function = function (content)
							return content.use_glow
						end
					},
					{
						style_id = "title_text",
						pass_type = "text",
						text_id = "title_text"
					},
					{
						style_id = "description_text",
						pass_type = "text",
						text_id = "description_text"
					},
					{
						pass_type = "texture",
						style_id = "text_divider_texture",
						texture_id = "text_divider_texture",
						content_check_function = function (content)
							return content.use_divider
						end
					}
				}
			},
			content = {
				use_glow = true,
				locked = false,
				texture_lock_id = "trait_icon_selected_frame_locked",
				texture_glow_id = "item_slot_glow_03",
				title_text = "test_title_text",
				use_background = true,
				texture_bg_id = "trait_slot",
				texture_id = "trait_icon_empty",
				disabled = false,
				description_text = "test_description_text",
				text_divider_texture = "summary_screen_line_breaker",
				use_divider = use_divider
			},
			style = {
				text_divider_texture = {
					masked = masked,
					size = {
						386,
						22
					},
					offset = {
						40,
						60,
						0
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				title_text = {
					vertical_alignment = "center",
					horizontal_alignment = "left",
					localize = false,
					font_size = 20,
					font_type = (masked and "hell_shark_masked") or "hell_shark",
					text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
					offset = {
						55,
						0,
						1
					}
				},
				description_text = {
					word_wrap = true,
					localize = false,
					font_size = 18,
					horizontal_alignment = "left",
					vertical_alignment = "top",
					font_type = (masked and "hell_shark_masked") or "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					offset = {
						0,
						0,
						0
					},
					scenegraph_id = description_scenegraph_id
				},
				texture_bg_id = {
					masked = masked,
					size = {
						54,
						58
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-7,
						-10,
						-1
					}
				},
				texture_id = {
					masked = masked,
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_lock_id = {
					masked = masked,
					offset = {
						0,
						0,
						3
					},
					color = {
						255,
						255,
						255,
						255
					}
				},
				texture_glow_id = {
					masked = masked,
					size = {
						104,
						104
					},
					offset = {
						-32,
						-32,
						4
					},
					color = {
						0,
						255,
						255,
						255
					}
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_corner_frame_animation_widget = function (scenegraph_id, scenegraph_id_top_left, scenegraph_id_top_right, scenegraph_id_bottom_left, scenegraph_id_bottom_right)
		local texture_color = {
			0,
			255,
			255,
			255
		}
		local glow_skull_color = {
			0,
			255,
			255,
			255
		}
		local glow_corner_color = {
			0,
			255,
			255,
			255
		}

		return {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "top_left_texture_id",
						global_color_id = "texture_color",
						texture_id = "top_left_texture_id"
					},
					{
						pass_type = "texture",
						style_id = "top_right_texture_id",
						global_color_id = "texture_color",
						texture_id = "top_right_texture_id"
					},
					{
						pass_type = "texture",
						style_id = "bottom_left_texture_id",
						global_color_id = "texture_color",
						texture_id = "bottom_left_texture_id"
					},
					{
						pass_type = "texture",
						style_id = "bottom_right_texture_id",
						global_color_id = "texture_color",
						texture_id = "bottom_right_texture_id"
					},
					{
						pass_type = "texture",
						style_id = "top_left_skull_glow",
						texture_id = "skull_eye_glow_texture",
						global_color_id = "glow_skull_color",
						content_check_function = function (content)
							return content.draw_skull_glow
						end
					},
					{
						pass_type = "texture",
						style_id = "top_right_skull_glow",
						texture_id = "skull_eye_glow_texture",
						global_color_id = "glow_skull_color",
						content_check_function = function (content)
							return content.draw_skull_glow
						end
					},
					{
						pass_type = "texture",
						style_id = "bottom_left_skull_glow",
						texture_id = "skull_eye_glow_texture",
						global_color_id = "glow_skull_color",
						content_check_function = function (content)
							return content.draw_skull_glow
						end
					},
					{
						pass_type = "texture",
						style_id = "bottom_right_skull_glow",
						texture_id = "skull_eye_glow_texture",
						global_color_id = "glow_skull_color",
						content_check_function = function (content)
							return content.draw_skull_glow
						end
					},
					{
						style_id = "top_left_corner_glow",
						pass_type = "texture_uv",
						global_color_id = "glow_corner_color",
						content_id = "top_left_corner_glow",
						content_check_function = function (content)
							return content.draw_corner_glow
						end
					},
					{
						style_id = "top_right_corner_glow",
						pass_type = "texture_uv",
						global_color_id = "glow_corner_color",
						content_id = "top_right_corner_glow",
						content_check_function = function (content)
							return content.draw_corner_glow
						end
					},
					{
						style_id = "bottom_left_corner_glow",
						pass_type = "texture_uv",
						global_color_id = "glow_corner_color",
						content_id = "bottom_left_corner_glow",
						content_check_function = function (content)
							return content.draw_corner_glow
						end
					},
					{
						style_id = "bottom_right_corner_glow",
						pass_type = "texture_uv",
						global_color_id = "glow_corner_color",
						content_id = "bottom_right_corner_glow",
						content_check_function = function (content)
							return content.draw_corner_glow
						end
					}
				}
			},
			content = {
				skull_eye_glow_texture = "reroll_glow_skull",
				top_right_texture_id = "corner_detail_03",
				draw_skull_glow = true,
				top_left_texture_id = "corner_detail_01",
				bottom_right_texture_id = "corner_detail_04",
				bottom_left_texture_id = "corner_detail_02",
				top_left_corner_glow = {
					texture_id = "reroll_glow_corner",
					draw_corner_glow = true,
					uvs = {
						{
							0,
							0
						},
						{
							1,
							1
						}
					}
				},
				top_right_corner_glow = {
					texture_id = "reroll_glow_corner",
					draw_corner_glow = true,
					uvs = {
						{
							1,
							0
						},
						{
							0,
							1
						}
					}
				},
				bottom_left_corner_glow = {
					texture_id = "reroll_glow_corner",
					draw_corner_glow = true,
					uvs = {
						{
							0,
							1
						},
						{
							1,
							0
						}
					}
				},
				bottom_right_corner_glow = {
					texture_id = "reroll_glow_corner",
					draw_corner_glow = true,
					uvs = {
						{
							1,
							1
						},
						{
							0,
							0
						}
					}
				}
			},
			style = {
				top_left_texture_id = {
					offset = {
						0,
						0,
						0
					},
					scenegraph_id = scenegraph_id_top_left
				},
				top_right_texture_id = {
					offset = {
						0,
						0,
						0
					},
					scenegraph_id = scenegraph_id_top_right
				},
				bottom_left_texture_id = {
					offset = {
						0,
						0,
						0
					},
					scenegraph_id = scenegraph_id_bottom_left
				},
				bottom_right_texture_id = {
					offset = {
						0,
						0,
						0
					},
					scenegraph_id = scenegraph_id_bottom_right
				},
				top_left_skull_glow = {
					size = {
						60,
						60
					},
					offset = {
						-10,
						188,
						0
					},
					scenegraph_id = scenegraph_id_top_left
				},
				top_right_skull_glow = {
					size = {
						60,
						60
					},
					offset = {
						104,
						188,
						0
					},
					scenegraph_id = scenegraph_id_top_right
				},
				bottom_left_skull_glow = {
					size = {
						60,
						60
					},
					offset = {
						-10,
						-7,
						0
					},
					scenegraph_id = scenegraph_id_bottom_left
				},
				bottom_right_skull_glow = {
					size = {
						60,
						60
					},
					offset = {
						104,
						-7,
						0
					},
					scenegraph_id = scenegraph_id_bottom_right
				},
				top_left_corner_glow = {
					size = {
						180,
						200
					},
					offset = {
						22.5,
						19,
						-1
					},
					scenegraph_id = scenegraph_id_top_left
				},
				top_right_corner_glow = {
					size = {
						180,
						200
					},
					offset = {
						-42,
						19,
						-1
					},
					scenegraph_id = scenegraph_id_top_right
				},
				bottom_left_corner_glow = {
					size = {
						180,
						200
					},
					offset = {
						22.5,
						22.5,
						-1
					},
					scenegraph_id = scenegraph_id_bottom_left
				},
				bottom_right_corner_glow = {
					size = {
						180,
						200
					},
					offset = {
						-42,
						22.5,
						-1
					},
					scenegraph_id = scenegraph_id_bottom_right
				}
			},
			style_global = {
				texture_color = texture_color,
				glow_skull_color = glow_skull_color,
				glow_corner_color = glow_corner_color
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_journal_tab = function (scenegraph_id, texture, masked)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture"
					},
					{
						texture_id = "texture_hover_id",
						style_id = "texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover
						end
					},
					{
						texture_id = "texture_selected_id",
						style_id = "texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
						end
					},
					{
						texture_id = "new_texture_id",
						style_id = "new_texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							return content.new
						end
					}
				}
			},
			content = {
				new = false,
				new_texture_id = "journal_icon_02",
				button_hotspot = {},
				texture_id = texture,
				texture_hover_id = texture .. "_selected",
				texture_selected_id = texture .. "_hover"
			},
			style = {
				texture_id = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				},
				new_texture_id = {
					size = {
						30,
						30
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						5,
						105,
						1
					},
					masked = masked
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_journal_page_arrow_button = function (scenegraph_id, uvs, masked)
		local passes = nil
		local content = {
			texture_hover_id = "journal_arrow_01",
			texture_selected_id = "journal_arrow_01_clicked",
			texture_id = "journal_arrow_01",
			button_hotspot = {}
		}

		if uvs then
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					texture_id = "texture_id",
					style_id = "texture_id",
					pass_type = "texture_uv",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.disabled and not button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)
					end
				},
				{
					texture_id = "texture_hover_id",
					style_id = "texture_hover_id",
					pass_type = "texture_uv",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)
					end
				},
				{
					texture_id = "texture_selected_id",
					style_id = "texture_selected_id",
					pass_type = "texture_uv",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				}
			}
			content.uvs = uvs
		else
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					texture_id = "texture_id",
					style_id = "texture_id",
					pass_type = "texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.disabled and not button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)
					end
				},
				{
					texture_id = "texture_hover_id",
					style_id = "texture_hover_id",
					pass_type = "texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)
					end
				},
				{
					texture_id = "texture_selected_id",
					style_id = "texture_selected_id",
					pass_type = "texture",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
					end
				}
			}
		end

		return {
			element = {
				passes = passes
			},
			content = content,
			style = {
				texture_id = {
					color = {
						200,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				},
				texture_hover_id = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				},
				texture_selected_id = {
					size = {
						41,
						33
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-4,
						-5,
						0
					},
					masked = masked
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_journal_back_arrow_button = function (scenegraph_id, masked)
		return {
			element = {
				passes = {
					{
						pass_type = "hotspot",
						content_id = "button_hotspot"
					},
					{
						texture_id = "texture_id",
						style_id = "texture_id",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and not button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)
						end
					},
					{
						texture_id = "texture_hover_id",
						style_id = "texture_hover_id",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and button_hotspot.is_hover and (not button_hotspot.is_clicked or button_hotspot.is_clicked ~= 0)
						end
					},
					{
						texture_id = "texture_selected_id",
						style_id = "texture_selected_id",
						pass_type = "texture",
						content_check_function = function (content)
							local button_hotspot = content.button_hotspot

							return not button_hotspot.disabled and (button_hotspot.is_clicked == 0 or button_hotspot.is_selected)
						end
					}
				}
			},
			content = {
				texture_hover_id = "journal_arrow_02",
				texture_selected_id = "journal_arrow_02_clicked",
				texture_id = "journal_arrow_02",
				button_hotspot = {}
			},
			style = {
				texture_id = {
					color = {
						200,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				},
				texture_hover_id = {
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					masked = masked
				},
				texture_selected_id = {
					size = {
						100,
						100
					},
					color = {
						255,
						255,
						255,
						255
					},
					offset = {
						-25,
						-25,
						0
					},
					masked = masked
				}
			},
			scenegraph_id = scenegraph_id
		}
	end,
	create_journal_reveal_mask = function (textures, scenegraph_ids, scenegraph_id)
		local passes = {}
		local content = {}
		local style = {}
		local num_textures = #textures

		for i = 1, num_textures + 1, 1 do
			local is_last_pass = i == num_textures + 1

			if is_last_pass then
				local texture_id = "cover_rect"
				passes[i] = {
					pass_type = "texture",
					texture_id = texture_id,
					style_id = texture_id
				}
				content[texture_id] = "mask_rect"
				style[texture_id] = {
					color = {
						0,
						0,
						0,
						0
					},
					offset = {
						0,
						0,
						0
					}
				}
			else
				local texture_id = "texture_" .. i
				local texture_scenegraph_id = scenegraph_ids[i]
				passes[i] = {
					pass_type = "texture",
					style_id = texture_id,
					texture_id = texture_id
				}
				style[texture_id] = {
					color = {
						0,
						255,
						255,
						255
					},
					offset = {
						0,
						0,
						0
					},
					scenegraph_id = texture_scenegraph_id
				}
				content[texture_id] = textures[i]
			end
		end

		content.num_textures = num_textures

		return {
			element = {
				passes = passes
			},
			content = content,
			style = style,
			scenegraph_id = scenegraph_id
		}
	end
}

return 