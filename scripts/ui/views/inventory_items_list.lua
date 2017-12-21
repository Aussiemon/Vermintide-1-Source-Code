-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
-- WARNING: Error occurred during decompilation.
--   Code may be incomplete or incorrect.
local animation_definitions = local_require("scripts/ui/views/inventory_view_animation_definitions")
local element_settings = {
	height_spacing = 4.5,
	height = 115,
	width = 535
}
local scrollbar_width = 22
local definitions = {
	scenegraph_definition = {
		root = {
			is_root = true,
			position = {
				0,
				0,
				UILayer.default + 1
			},
			size = {
				1920,
				1080
			}
		},
		menu_root = {
			vertical_alignment = "center",
			parent = "root",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				0
			},
			size = {
				1920,
				1080
			}
		},
		page_root = {
			vertical_alignment = "top",
			parent = "menu_root",
			position = {
				0,
				0,
				1
			},
			size = {
				1,
				1
			}
		},
		item_list = {
			vertical_alignment = "top",
			parent = "page_root",
			position = {
				0,
				0,
				1
			},
			size = {
				element_settings.width,
				element_settings.height
			}
		},
		inventory_selection_item = {
			vertical_alignment = "top",
			parent = "item_list",
			position = {
				0,
				0,
				1
			},
			size = {
				element_settings.width,
				element_settings.height
			}
		},
		inventory_selection_item_background = {
			vertical_alignment = "center",
			parent = "inventory_selection_item",
			horizontal_alignment = "center",
			position = {
				0,
				0,
				1
			},
			size = {
				element_settings.width,
				element_settings.height
			}
		},
		inventory_selection_item_background_hover = {
			vertical_alignment = "center",
			parent = "inventory_selection_item",
			horizontal_alignment = "center",
			position = {
				9,
				41,
				3
			},
			size = {
				518,
				94
			}
		},
		inventory_selection_item_icon = {
			vertical_alignment = "center",
			parent = "inventory_selection_item",
			horizontal_alignment = "center",
			position = {
				25,
				element_settings.height*0.5 - 32,
				5
			},
			size = {
				64,
				64
			}
		},
		inventory_selection_item_icon_border = {
			vertical_alignment = "center",
			parent = "inventory_selection_item",
			horizontal_alignment = "center",
			position = {
				19,
				63,
				3
			},
			size = {
				72,
				72
			}
		},
		item_list_scrollbar_root = {
			vertical_alignment = "top",
			parent = "item_list",
			horizontal_alignment = "right",
			position = {
				26,
				1,
				5
			},
			size = {
				22,
				839
			}
		}
	},
	widget_definitions = {
		inventory_list_widget = {
			scenegraph_id = "item_list",
			element = {
				passes = {
					{
						style_id = "list_style",
						pass_type = "list_pass",
						content_id = "list_content",
						passes = {
							{
								style_id = "background",
								pass_type = "hotspot",
								content_id = "button_hotspot"
							},
							{
								pass_type = "on_click",
								click_check_content_id = "button_hotspot",
								click_function = function (ui_scenegraph, ui_style, ui_content, input_service)
									if not ui_content.fake then
										ui_content.button_hotspot.is_selected = true
									end

									return 
								end
							},
							{
								texture_id = "item_texture_id",
								style_id = "background",
								pass_type = "drag",
								content_check_function = function (ui_content)
									return ui_content.active and (ui_content.allow_equipped_drag or not ui_content.equipped)
								end
							},
							{
								pass_type = "texture",
								style_id = "disabled_overlay",
								texture_id = "disabled_overlay",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return not ui_content.active
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_normal",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return ui_content.active and not button_hotspot.is_selected and not button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_normal_hover",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return ui_content.active and not button_hotspot.is_selected and button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_selected",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return ui_content.active and button_hotspot.is_selected and not button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_selected_hover",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return ui_content.active and button_hotspot.is_selected and button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_disabled",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return not ui_content.active and not button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_disabled_hover",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return not ui_content.active and button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_disabled_selected",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return not ui_content.active and button_hotspot.is_selected and not button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "background",
								texture_id = "background_disabled_selected_hover",
								content_check_function = function (ui_content)
									local button_hotspot = ui_content.button_hotspot

									return not ui_content.active and button_hotspot.is_selected and button_hotspot.is_hover
								end
							},
							{
								pass_type = "texture",
								style_id = "item_texture_id",
								texture_id = "item_texture_id",
								content_check_function = function (ui_content)
									return not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "item_frame_texture_id",
								texture_id = "item_frame_texture_id",
								content_check_function = function (ui_content)
									return not ui_content.fake
								end
							},
							{
								style_id = "text_title",
								pass_type = "text",
								text_id = "title",
								content_check_function = function (ui_content)
									return not ui_content.fake
								end
							},
							{
								style_id = "text_sub_title",
								pass_type = "text",
								text_id = "sub_title",
								content_check_function = function (ui_content)
									return not ui_content.fake
								end
							},
							{
								style_id = "text_equipped",
								pass_type = "text",
								text_id = "text_equipped",
								content_check_function = function (ui_content)
									return ui_content.equipped and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "new_texture",
								texture_id = "new_texture",
								content_check_function = function (ui_content)
									return ui_content.new and not ui_content.fake and not ui_content.equipped
								end
							},
							{
								pass_type = "texture",
								style_id = "locked_texture",
								texture_id = "locked_texture",
								content_check_function = function (ui_content)
									return ui_content.locked and not ui_content.fake
								end
							},
							{
								style_id = "locked_text",
								pass_type = "text",
								text_id = "locked_text",
								content_check_function = function (ui_content)
									return ui_content.locked and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_1",
								texture_id = "trait_slot_1",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_1 and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_2",
								texture_id = "trait_slot_2",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_2 and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_3",
								texture_id = "trait_slot_3",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_3 and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_4",
								texture_id = "trait_slot_4",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_4 and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_1",
								pass_type = "hotspot",
								content_id = "trait_slot_1_hotspot",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_1 and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_2",
								pass_type = "hotspot",
								content_id = "trait_slot_2_hotspot",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_2 and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_3",
								pass_type = "hotspot",
								content_id = "trait_slot_3_hotspot",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_3 and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_4",
								pass_type = "hotspot",
								content_id = "trait_slot_4_hotspot",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_4 and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_1_tooltip",
								pass_type = "tooltip_text",
								text_id = "trait_slot_1_tooltip",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_1 and ui_content.trait_slot_1_hotspot.is_hover and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_2_tooltip",
								pass_type = "tooltip_text",
								text_id = "trait_slot_2_tooltip",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_2 and ui_content.trait_slot_2_hotspot.is_hover and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_3_tooltip",
								pass_type = "tooltip_text",
								text_id = "trait_slot_3_tooltip",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_3 and ui_content.trait_slot_3_hotspot.is_hover and not ui_content.fake
								end
							},
							{
								style_id = "trait_slot_4_tooltip",
								pass_type = "tooltip_text",
								text_id = "trait_slot_4_tooltip",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_4 and ui_content.trait_slot_4_hotspot.is_hover and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_1_locked",
								texture_id = "trait_slot_locked",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_1 and ui_content.trait_slot_1_locked and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_2_locked",
								texture_id = "trait_slot_locked",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_2 and ui_content.trait_slot_2_locked and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_3_locked",
								texture_id = "trait_slot_locked",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_3 and ui_content.trait_slot_3_locked and not ui_content.fake
								end
							},
							{
								pass_type = "texture",
								style_id = "trait_slot_4_locked",
								texture_id = "trait_slot_locked",
								content_check_function = function (ui_content)
									return ui_content.trait_slot_4 and ui_content.trait_slot_4_locked and not ui_content.fake
								end
							}
						}
					},
					{
						style_id = "hover",
						pass_type = "hover",
						content_id = "hotspot"
					}
				}
			},
			content = {
				list_content = {}
			},
			style = {
				list_style = {},
				hover = {
					offset = {
						0,
						306
					},
					size = {
						1100,
						530
					}
				}
			}
		}
	}
}

local function setup_list_hover_area(width, height)
	local list_definition = definitions.widget_definitions.inventory_list_widget
	local hover_pass = list_definition.element.passes[2]
	local hover_style_definition = list_definition.style.hover
	local size = hover_style_definition.size
	local offset = hover_style_definition.offset
	size[1] = width
	size[2] = height
	offset[2] = 0

	return 
end

local function setup_mouse_scroll_widget_definition(scroll_field_width, scroll_field_height)
	local scenegraph_id = "mouse_scroll_field"
	local scroll_field_scenegraph_definition = {
		horizontal_alignment = "right",
		position = {
			0,
			-2,
			1
		},
		size = {
			scroll_field_width + 24,
			scroll_field_height
		},
		parent = "item_list_scrollbar_root"
	}
	definitions.scenegraph_definition[scenegraph_id] = scroll_field_scenegraph_definition
	definitions.widget_definitions.scroll_field = {
		element = {
			passes = {
				{
					pass_type = "scroll",
					scroll_function = function (ui_scenegraph, ui_style, ui_content, input_service, scroll_axis)
						local scroll_step = ui_content.scroll_step or 0.1
						local current_scroll_value = ui_content.internal_scroll_value
						current_scroll_value = current_scroll_value + scroll_step*-scroll_axis.y
						ui_content.internal_scroll_value = math.clamp(current_scroll_value, 0, 1)

						return 
					end
				}
			}
		},
		content = {
			scroll_step = 0.05,
			internal_scroll_value = 0
		},
		style = {},
		scenegraph_id = scenegraph_id
	}

	return 
end

local function create_inventory_item_template(is_room_item, item, item_color, equipped_item, is_new, is_active, is_locked, allow_equipped_drag, level_requirement, ui_top_renderer)
	local traits = item.traits
	local trait_textures = {}
	local traits_unlocked = {}
	local traits_tooltip = {}
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local slot_type = item.slot_type
	local is_trinket = slot_type == "trinket"
	local never_locked = is_trinket or slot_type == "hat"

	if traits then
		for i = #traits, 1, -1 do
			local trait_name = traits[i]
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local backend_id = item.backend_id
				local trait_unlocked = ((never_locked or BackendUtils.item_has_trait(backend_id, trait_name)) and true) or false
				local title_text = (trait_template.display_name and Localize(trait_template.display_name)) or "Unknown"
				local description_text = BackendUtils.get_item_trait_description(backend_id, i)
				local trait_icon = trait_template.icon or "icons_placeholder"
				trait_textures[#trait_textures + 1] = trait_icon
				traits_unlocked[#traits_unlocked + 1] = trait_unlocked
				local tooltip_text = title_text .. "\n" .. description_text

				if is_trinket then
					tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
				elseif not trait_unlocked then
					tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
				end

				traits_tooltip[#traits_tooltip + 1] = tooltip_text
			end
		end
	end

	local content = {
		trait_slot_fg = "trait_icon_selected_frame",
		trait_slot_locked = "trait_icon_selected_frame_locked",
		background_selected = "list_item_selected",
		background_normal_hover = "list_item_normal_hover",
		visible = true,
		background_selected_hover = "list_item_selected_hover",
		locked_texture = "locked_icon_01",
		background_normal = "list_item_normal",
		hover_disabled = false,
		background_disabled_hover = "list_item_disabled_hover",
		text_equipped = "item_compare_window_title",
		new_texture = "list_item_tag_new",
		background_disabled_selected_hover = "list_item_disabled_selected_hover",
		background_disabled_selected = "list_item_disabled_selected",
		background_disabled = "list_item_disabled",
		disabled_overlay = "list_item_disabled_overlay",
		item_frame_texture_id = "frame_01",
		ui_top_renderer = ui_top_renderer,
		drag_texture_size = {
			64,
			64
		},
		button_hotspot = {},
		item_texture_id = item.inventory_icon or "icons_placeholder",
		title = (item.name and item.localized_name) or "Unknown",
		sub_title = (item.item_type and Localize(item.item_type)) or "Unknown",
		description = (item.description and Localize(item.description)) or "Unknown",
		room_item = is_room_item,
		equipped = equipped_item,
		allow_equipped_drag = allow_equipped_drag or false,
		active = is_active,
		new = is_new,
		locked = is_locked,
		item = item,
		locked_text = level_requirement or "",
		trait_slot_1 = trait_textures[1],
		trait_slot_2 = trait_textures[2],
		trait_slot_3 = trait_textures[3],
		trait_slot_4 = trait_textures[4],
		trait_slot_1_hotspot = {},
		trait_slot_2_hotspot = {},
		trait_slot_3_hotspot = {},
		trait_slot_4_hotspot = {},
		trait_slot_1_tooltip = traits_tooltip[1] or "",
		trait_slot_2_tooltip = traits_tooltip[2] or "",
		trait_slot_3_tooltip = traits_tooltip[3] or "",
		trait_slot_4_tooltip = traits_tooltip[4] or "",
		trait_slot_1_locked = not traits_unlocked[1],
		trait_slot_2_locked = not traits_unlocked[2],
		trait_slot_3_locked = not traits_unlocked[3],
		trait_slot_4_locked = not traits_unlocked[4]
	}
	local style = {
		trait_slot_1 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 55,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_2 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 100,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_3 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 145,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_4 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 190,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_1_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 55,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_2_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 100,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_3_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 145,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_4_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 190,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_1_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 55,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_2_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 100,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_3_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 145,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_4_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 190,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		disabled_overlay = {
			size = {
				element_settings.width,
				element_settings.height
			},
			offset = {
				0,
				0,
				7
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		background = {
			size = {
				element_settings.width,
				element_settings.height
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
		item_texture_id = {
			size = {
				64,
				64
			},
			offset = {
				25,
				element_settings.height*0.5 - 32,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		item_frame_texture_id = {
			size = {
				64,
				64
			},
			offset = {
				25,
				element_settings.height*0.5 - 32,
				6
			},
			color = table.clone(item_color)
		},
		new_texture = {
			size = {
				126,
				51
			},
			offset = {
				element_settings.width - 126,
				element_settings.height - 55,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		locked_texture = {
			size = {
				30,
				38
			},
			offset = {
				element_settings.width - 50,
				17,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_1_tooltip = {
			font_size = 24,
			pixel_perfect = true,
			horizontal_alignment = "left",
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			size = {
				element_settings.width,
				element_settings.height
			},
			text_color = Colors.get_color_table_with_alpha("white", 255),
			line_colors = {
				Colors.get_color_table_with_alpha("cheeseburger", 255),
				Colors.get_color_table_with_alpha("white", 255)
			},
			last_line_color = ((is_trinket or not traits_unlocked[1]) and Colors.get_color_table_with_alpha("red", 255)) or nil,
			offset = {
				element_settings.width,
				0,
				25
			}
		},
		trait_slot_2_tooltip = {
			font_size = 24,
			pixel_perfect = true,
			horizontal_alignment = "left",
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			size = {
				element_settings.width,
				element_settings.height
			},
			text_color = Colors.get_color_table_with_alpha("white", 255),
			line_colors = {
				Colors.get_color_table_with_alpha("cheeseburger", 255),
				Colors.get_color_table_with_alpha("white", 255)
			},
			last_line_color = ((is_trinket or not traits_unlocked[2]) and Colors.get_color_table_with_alpha("red", 255)) or nil,
			offset = {
				element_settings.width,
				0,
				25
			}
		},
		trait_slot_3_tooltip = {
			font_size = 24,
			pixel_perfect = true,
			horizontal_alignment = "left",
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			size = {
				element_settings.width,
				element_settings.height
			},
			text_color = Colors.get_color_table_with_alpha("white", 255),
			line_colors = {
				Colors.get_color_table_with_alpha("cheeseburger", 255),
				Colors.get_color_table_with_alpha("white", 255)
			},
			last_line_color = ((is_trinket or not traits_unlocked[3]) and Colors.get_color_table_with_alpha("red", 255)) or nil,
			offset = {
				element_settings.width,
				0,
				25
			}
		},
		trait_slot_4_tooltip = {
			font_size = 24,
			pixel_perfect = true,
			horizontal_alignment = "left",
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			size = {
				element_settings.width,
				element_settings.height
			},
			text_color = Colors.get_color_table_with_alpha("white", 255),
			line_colors = {
				Colors.get_color_table_with_alpha("cheeseburger", 255),
				Colors.get_color_table_with_alpha("white", 255)
			},
			last_line_color = ((is_trinket or not traits_unlocked[4]) and Colors.get_color_table_with_alpha("red", 255)) or nil,
			offset = {
				element_settings.width,
				0,
				25
			}
		},
		locked_text = {
			font_size = 30,
			word_wrap = false,
			pixel_perfect = true,
			horizontal_alignment = "left",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("orange", 255),
			size = {
				30,
				38
			},
			offset = {
				element_settings.width - 40,
				7,
				6
			}
		},
		text_equipped = {
			word_wrap = true,
			localize = true,
			font_size = 16,
			pixel_perfect = true,
			horizontal_alignment = "right",
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("white", 200),
			offset = {
				-15,
				-15,
				6
			},
			size = {
				element_settings.width,
				element_settings.height
			}
		},
		text_title = {
			word_wrap = true,
			font_size = 28,
			pixel_perfect = true,
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark_header",
			text_color = item_color or table.clone(Colors.color_definitions.white),
			offset = {
				105,
				element_settings.height*0.5 - 5,
				6
			},
			size = {
				436,
				40
			}
		},
		text_sub_title = {
			word_wrap = true,
			font_size = 18,
			pixel_perfect = true,
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			offset = {
				105,
				element_settings.height*0.5 - 43,
				6
			},
			size = {
				436,
				40
			}
		}
	}

	return content, style
end

local function create_empty_inventory_item_template()
	local content = {
		trait_slot_fg = "trait_icon_selected_frame",
		active = false,
		new = false,
		new_texture = "list_item_tag_new",
		locked_texture = "locked_icon_01",
		locked_text = "99",
		fake = true,
		trait_slot_locked = "trait_icon_selected_frame_locked",
		background_selected = "list_item_empty",
		background_normal_hover = "list_item_empty",
		visible = true,
		trait_slot_3_tooltip = "",
		room_item = false,
		trait_slot_1_tooltip = "",
		background_selected_hover = "list_item_empty",
		title = "",
		allow_equipped_drag = false,
		background_disabled_hover = "list_item_empty",
		trait_slot_4_tooltip = "",
		background_disabled_selected = "list_item_empty",
		sub_title = "",
		background_normal = "list_item_empty",
		hover_disabled = true,
		item_texture_id = "icons_placeholder",
		locked = false,
		text_equipped = "",
		trait_slot_2_tooltip = "",
		background_disabled_selected_hover = "list_item_empty",
		background_disabled = "list_item_empty",
		description = "",
		disabled_overlay = "list_item_disabled_overlay",
		item_frame_texture_id = "frame_01",
		drag_texture_size = {
			64,
			64
		},
		button_hotspot = {},
		trait_slot_1_hotspot = {},
		trait_slot_2_hotspot = {},
		trait_slot_3_hotspot = {},
		trait_slot_4_hotspot = {}
	}
	local style = {
		trait_slot_1 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 55,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_2 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 100,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_3 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 145,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_4 = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 190,
				15,
				4
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_1_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 55,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_2_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 100,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_3_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 145,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_4_fg = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 190,
				15,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_1_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 55,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_2_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 100,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_3_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 145,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		trait_slot_4_locked = {
			size = {
				40,
				40
			},
			offset = {
				element_settings.width - 190,
				15,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		disabled_overlay = {
			size = {
				element_settings.width,
				element_settings.height
			},
			offset = {
				0,
				0,
				7
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		background = {
			size = {
				element_settings.width,
				element_settings.height
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
		item_texture_id = {
			size = {
				64,
				64
			},
			offset = {
				25,
				element_settings.height*0.5 - 32,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		item_frame_texture_id = {
			size = {
				64,
				64
			},
			offset = {
				25,
				element_settings.height*0.5 - 32,
				6
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		new_texture = {
			size = {
				126,
				51
			},
			offset = {
				element_settings.width - 126,
				element_settings.height - 55,
				7
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		locked_texture = {
			size = {
				30,
				38
			},
			offset = {
				element_settings.width - 50,
				17,
				5
			},
			color = {
				255,
				255,
				255,
				255
			}
		},
		locked_text = {
			font_size = 30,
			word_wrap = false,
			pixel_perfect = true,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("orange", 255),
			size = {
				30,
				38
			},
			offset = {
				element_settings.width - 40,
				7,
				6
			}
		},
		text_equipped = {
			word_wrap = true,
			localize = true,
			font_size = 28,
			pixel_perfect = true,
			horizontal_alignment = "right",
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = table.clone(Colors.color_definitions.white),
			offset = {
				-20,
				-10,
				6
			},
			size = {
				element_settings.width,
				element_settings.height
			}
		},
		text_title = {
			word_wrap = true,
			font_size = 28,
			pixel_perfect = true,
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = table.clone(Colors.color_definitions.white),
			offset = {
				105,
				element_settings.height*0.5,
				6
			},
			size = {
				436,
				40
			}
		},
		text_sub_title = {
			word_wrap = true,
			font_size = 22,
			pixel_perfect = true,
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = table.clone(Colors.color_definitions.cheeseburger),
			offset = {
				105,
				element_settings.height*0.5 - 40,
				6
			},
			size = {
				436,
				40
			}
		}
	}

	return content, style
end

local SLOT_TYPES = InventorySettings.inventory_slot_types_button_index
local index_by_stats_type = {
	damage = 1,
	armor_penetration = 2,
	elemental_effect = 5,
	status_effect = 3,
	head_shot = 4
}
local compare_state_textures = {
	equal = "stats_equal",
	up = {
		"stats_arrow_01",
		"stats_arrow_02",
		"stats_arrow_03"
	},
	down = {
		"stats_arrow_04",
		"stats_arrow_05",
		"stats_arrow_06"
	}
}
local compare_state_colors = {
	up = {
		255,
		0,
		255,
		0
	},
	down = {
		255,
		255,
		0,
		0
	},
	equal = {
		255,
		255,
		255,
		255
	}
}
local temp_stats = {
	damage = {
		3,
		1,
		1,
		0,
		0
	},
	armor_penetration = {
		2,
		0,
		0,
		0,
		0
	},
	status_effect = {
		1,
		2,
		3,
		0,
		0
	},
	head_shot = {
		1,
		0,
		0,
		0,
		0
	},
	elemental_effect = {
		1,
		2,
		0,
		0,
		0
	}
}
local possible_quick_compare_slots = {
	melee = "slot_melee",
	ranged = "slot_ranged"
}
local rarity_order = {
	common = 4,
	promo = 6,
	plentiful = 5,
	exotic = 2,
	rare = 3,
	unique = 1
}

local function rarity_sortation(a, b)
	return rarity_order[a.rarity] < rarity_order[b.rarity]
end

local function sort_by_loadout_rarity_name(a, b)
	local a_content = a.content
	local b_content = b.content

	if a_content.equipped and not b_content.equipped then
		return true
	elseif b_content.equipped and not a_content.equipped then
		return false
	else
		local a_item = a_content.item
		local b_item = b_content.item
		local a_rarity_order = rarity_order[a_item.rarity]
		local b_rarity_order = rarity_order[b_item.rarity]

		if a_rarity_order == b_rarity_order then
			local a_item_name = a_item.localized_name
			local b_item_name = b_item.localized_name

			if a_item_name == b_item_name then
				return a_item.backend_id < b_item.backend_id
			end

			return a_item_name < b_item_name
		else
			return a_rarity_order < b_rarity_order
		end
	end

	return 
end

local function sort_by_rarity_name(a, b)
	local a_content = a.content
	local b_content = b.content
	local a_item = a_content.item
	local b_item = b_content.item
	local a_rarity_order = rarity_order[a_item.rarity]
	local b_rarity_order = rarity_order[b_item.rarity]

	if a_rarity_order == b_rarity_order then
		local a_item_name = a_item.localized_name
		local b_item_name = b_item.localized_name

		if a_item_name == b_item_name then
			return a_item.backend_id < b_item.backend_id
		end

		return a_item_name < b_item_name
	else
		return a_rarity_order < b_rarity_order
	end

	return 
end

local fake_input_service = {
	get = function ()
		return 
	end,
	has = function ()
		return 
	end
}
InventoryItemsList = class(InventoryItemsList)
InventoryItemsList.init = function (self, position, ingame_ui_context, settings)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.input_manager = ingame_ui_context.input_manager
	local num_list_items = settings.num_list_items
	local columns = settings.columns
	local column_offset = settings.column_offset
	self.disabled_backend_ids = {}
	self.world_manager = ingame_ui_context.world_manager
	local world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(world)
	local scenegraph_definition = definitions.scenegraph_definition
	local item_list_definitions = scenegraph_definition.item_list
	local scroll_field_width = 0
	local scroll_field_height = 0

	if columns then
		item_list_definitions.size[1] = element_settings.width*columns + column_offset
		local list_items_per_column = num_list_items/columns
		item_list_definitions.size[2] = element_settings.height*list_items_per_column + element_settings.height_spacing*(list_items_per_column - 1)
		scroll_field_width = item_list_definitions.size[1] + scrollbar_width
		scroll_field_height = item_list_definitions.size[2]
	else
		item_list_definitions.size[1] = element_settings.width
		item_list_definitions.size[2] = element_settings.height*num_list_items + element_settings.height_spacing*(num_list_items - 1)
		scroll_field_width = item_list_definitions.size[1]
		scroll_field_height = item_list_definitions.size[2]
	end

	settings.list_size = {
		item_list_definitions.size[1],
		item_list_definitions.size[2]
	}

	setup_mouse_scroll_widget_definition(scroll_field_width, scroll_field_height)
	setup_list_hover_area(scroll_field_width, scroll_field_height)

	self.settings = settings
	self.widget_definitions = definitions.widget_definitions
	scenegraph_definition.page_root.position = position
	self.ui_animator = UIAnimator:new(scenegraph_definition, animation_definitions)
	self.bar_animations = {}
	self.inventory_list_animations = {}
	self.scenegraph_definition = scenegraph_definition
	self.input_service_name = settings.input_service_name

	self.set_list_item_select_sound(self, "Play_hud_select")
	self.create_ui_elements(self)

	local empty_widget_elements = {}

	for i = 1, 8, 1 do
		local content, style = create_empty_inventory_item_template()
		empty_widget_elements[i] = {
			content = content,
			style = style
		}
	end

	self.empty_widget_elements = empty_widget_elements

	return 
end
InventoryItemsList.destroy = function (self)
	self.ui_animator:destroy()

	self.ui_animator = nil

	return 
end
InventoryItemsList.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
	local scrollbar_scenegraph_id = "item_list_scrollbar_root"
	local scrollbar_scenegraph = self.scenegraph_definition[scrollbar_scenegraph_id]
	self.scrollbar_widget = UIWidget.init(UIWidgets.create_scrollbar(scrollbar_scenegraph.size[2], scrollbar_scenegraph_id))
	self.item_list_widget = UIWidget.init(self.widget_definitions.inventory_list_widget)
	self.scroll_field_widget = UIWidget.init(self.widget_definitions.scroll_field)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	return 
end
InventoryItemsList.handle_gamepad_input = function (self, dt, num_elements)
	local input_manager = self.input_manager
	local input_service = (self.input_disabled and fake_input_service) or input_manager.get_service(input_manager, self.input_service_name)
	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and 0 < controller_cooldown then
		self.controller_cooldown = controller_cooldown - dt
		local speed_multiplier = self.speed_multiplier or 1
		self.speed_multiplier = math.max(speed_multiplier - 0.05, 0.3)

		return 
	else
		local selected_list_index = self.selected_list_index

		if selected_list_index then
			local speed_multiplier = self.speed_multiplier or 1
			local new_list_index = nil
			local move_up = input_service.get(input_service, "move_up")
			local move_up_hold = input_service.get(input_service, "move_up_hold")

			if move_up or move_up_hold then
				new_list_index = math.max(selected_list_index - 1, 1)
				self.controller_cooldown = GamepadSettings.menu_cooldown*speed_multiplier
			else
				local move_down = input_service.get(input_service, "move_down")
				local move_down_hold = input_service.get(input_service, "move_down_hold")

				if move_down or move_down_hold then
					self.controller_cooldown = GamepadSettings.menu_cooldown*speed_multiplier
					new_list_index = math.min(selected_list_index + 1, num_elements)
				end
			end

			if new_list_index and new_list_index ~= selected_list_index then
				self.gamepad_changed_selected_list_index = new_list_index

				return 
			end
		end
	end

	self.speed_multiplier = 1

	return 
end
InventoryItemsList.update_gamepad_list_scroll = function (self)
	local selected_list_index = self.selected_list_index

	if not selected_list_index then
		return 
	end

	local is_outside, state = self.is_entry_outside(self, selected_list_index)

	while is_outside do
		local button_scroll_step = self.scrollbar_widget.content.button_scroll_step
		local scroll_value = self.scroll_value

		if state == "below" then
			scroll_value = math.min(scroll_value + button_scroll_step, 1)
		else
			scroll_value = math.max(scroll_value - button_scroll_step, 0)
		end

		if scroll_value ~= self.scroll_value then
			self.set_scroll_amount(self, scroll_value)
		end

		is_outside, state = self.is_entry_outside(self, self.selected_list_index)
	end

	return 
end
InventoryItemsList.update = function (self, dt, use_gamepad, disable_gamepad_pressed)
	local input_manager = self.input_manager
	local input_service = (self.input_disabled and fake_input_service) or input_manager.get_service(input_manager, self.input_service_name)

	self.ui_animator:update(dt)

	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local list_style = item_list_widget.style.list_style
	local selected_list_index = self.selected_list_index
	local hover_list_index = self.hover_list_index
	local number_of_items_in_list = self.number_of_items_in_list
	self.inventory_list_index_changed = nil
	self.inventory_list_index_pressed = nil
	local num_list_content = #list_content

	if use_gamepad then
		local number_of_real_items = self.number_of_real_items

		if number_of_real_items then
			self.handle_gamepad_input(self, dt, number_of_real_items)
			self.update_gamepad_list_scroll(self)
		end
	end

	local hover_index, hover_backend_id = self.on_item_hover_exit(self)

	if hover_index and hover_backend_id then
		local widget_content = list_content[hover_index]

		if widget_content and widget_content.new then
			widget_content.new = false

			ItemHelper.unmark_backend_id_as_new(hover_backend_id)
		end
	end

	for i = 1, num_list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if (button_hotspot.is_selected or self.gamepad_changed_selected_list_index == i) and i ~= selected_list_index then
			self.inventory_list_index_changed = i

			break
		end
	end

	for i = 1, num_list_content, 1 do
		local content = list_content[i]
		local button_hotspot = content.button_hotspot

		if button_hotspot.on_pressed and content.active then
			self.inventory_list_index_pressed = i

			break
		end
	end

	self.item_selected = nil
	self.item_selected_local = nil
	self.item_selected_is_equipped = nil

	for i = 1, #list_content, 1 do
		local button_widget_content = list_content[i]
		local button_hotspot = button_widget_content.button_hotspot
		local is_equipped = button_widget_content.equipped
		local is_active = button_widget_content.active
		local is_fake = button_widget_content.fake

		if not is_fake and ((button_hotspot.is_selected and button_hotspot.on_double_click) or button_hotspot.on_right_click or (use_gamepad and i == selected_list_index and not disable_gamepad_pressed and input_service.get(input_service, "confirm"))) then
			if is_active then
				self.item_selected = button_widget_content.item
				self.item_selected_is_equipped = is_equipped
			end

			self.item_selected_local = button_widget_content.item

			break
		end
	end

	if Debug.select_item then
		local i = Debug.select_item
		local button_widget_content = list_content[i]
		local is_equipped = button_widget_content.equipped
		local is_active = button_widget_content.active
		local is_fake = button_widget_content.fake

		if is_active then
			self.item_selected = button_widget_content.item
			self.item_selected_is_equipped = is_equipped
		end

		self.item_selected_local = button_widget_content.item
		Debug.select_item = nil
	end

	for i = 1, num_list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if button_hotspot.on_hover_enter then
			if not button_content.fake then
				self.play_sound(self, "Play_hud_hover")
			end

			if i ~= hover_list_index then
				self.hover_list_index = i
			end

			button_hotspot.on_hover_enter = nil
		elseif button_hotspot.on_hover_exit then
			if i == hover_list_index then
				self.hover_list_index = nil
			end

			button_hotspot.on_hover_exit = nil
		end
	end

	self.on_item_dragged(self)
	self.update_scroll(self)

	if self.inventory_list_animation_time then
	end

	self.gamepad_changed_selected_list_index = nil

	return 
end
InventoryItemsList.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = (self.input_disabled and fake_input_service) or input_manager.get_service(input_manager, self.input_service_name)
	local gamepad_active = input_manager.is_device_active(input_manager, "gamepad")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	local item_list_widget = self.item_list_widget

	if self.draw_inventory_list then
		UIRenderer.draw_widget(ui_renderer, self.scroll_field_widget)
		UIRenderer.draw_widget(ui_renderer, self.item_list_widget)
		UIRenderer.draw_widget(ui_renderer, self.scrollbar_widget)
	end

	UIRenderer.end_pass(ui_renderer)

	return 
end
InventoryItemsList.disable_input = function (self, disable)
	self.input_disabled = disable

	return 
end
InventoryItemsList.get_pressed_item = function (self)
	return self.item_selected_local
end
InventoryItemsList.set_list_item_select_sound = function (self, sound_event)
	self.item_select_sound_event = sound_event

	return 
end
InventoryItemsList.set_selected_profile_name = function (self, selected_profile_name)
	self.selected_profile_name = selected_profile_name
	self.inventory_list_animation_time = 0

	return 
end
InventoryItemsList.current_profile_name = function (self)
	return self.selected_profile_name
end
InventoryItemsList.set_selected_slot_type = function (self, selected_slot_type)
	self.selected_slot_type = selected_slot_type
	self.inventory_list_animation_time = 0

	return 
end
InventoryItemsList.refresh = function (self, ignore_scroll_reset, backend_id_ignore_list, optional_filter)
	self.populate_inventory_list(self, ignore_scroll_reset, backend_id_ignore_list, optional_filter)

	self.inventory_list_animation_time = 0

	return 
end
InventoryItemsList.remove_item = function (self, item_backend_id, ignore_scroll_reset)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content

	for i = 1, #list_content, 1 do
		local widget_content = list_content[i]

		if widget_content then
			local item = widget_content.item

			if item and item.backend_id == item_backend_id then
				local list_style = item_list_widget.style.list_style
				local item_styles = list_style.item_styles
				local column_count = list_style.columns

				table.remove(list_content, i)
				table.remove(item_styles, i)

				local number_of_items_in_list = math.max(self.number_of_items_in_list - 1, 0)
				self.number_of_items_in_list = number_of_items_in_list
				local total_elements = #list_content
				local start_index = list_style.start_index
				local num_draws = list_style.num_draws
				self.number_of_real_items = self.number_of_real_items - 1

				if number_of_items_in_list <= 0 then
					self.draw_inventory_list = false

					break
				end

				local selected_list_index = self.selected_list_index

				if total_elements - start_index - 1 < num_draws then
					list_style.start_index = math.max(start_index - 1, 1)

					if 1 < start_index then
						selected_list_index = selected_list_index - 1
					end

					local ignore_list_scroll = true

					self.set_scroll_amount(self, 1, ignore_list_scroll)
				else
					local button_scroll_step = self.scrollbar_widget.content.button_scroll_step
					local scroll_value = self.scroll_value
					scroll_value = math.min(scroll_value + button_scroll_step, 1)
					local ignore_list_scroll = true

					self.set_scroll_amount(self, scroll_value, ignore_list_scroll)
				end

				if total_elements < num_draws then
					local padding_n = num_draws - total_elements%num_draws

					if padding_n < num_draws then
						for i = 1, padding_n, 1 do
							local empty_element = self.empty_widget_elements[i]
							local index = #list_content + 1
							list_content[index] = empty_element.content
							item_styles[index] = empty_element.style
						end

						self.used_empty_elements = padding_n
					end
				end

				self.on_inventory_item_selected(self, selected_list_index)
				self.set_scrollbar_length(self, nil, ignore_scroll_reset, ignore_scroll_reset)

				break
			end
		end
	end

	return 
end
InventoryItemsList.clear_disabled_backend_ids = function (self)
	self.disabled_backend_ids = {}

	return 
end
InventoryItemsList.set_backend_id_disabled_state = function (self, backend_id, disabled)
	self.disabled_backend_ids[backend_id] = disabled

	self.set_item_active_by_backend_id(self, backend_id, not disabled)

	return 
end
InventoryItemsList.set_item_active_by_backend_id = function (self, backend_id, active)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type
	local selected_rarity = self.selected_rarity
	local disable_equipped_items = self.disable_equipped_items

	if selected_profile_name and selected_slot_type then
		local locked_item_types = self.get_locked_item_types(self)

		for i = 1, #list_content, 1 do
			local widget_content = list_content[i]

			if widget_content then
				local item = widget_content.item

				if item and item.backend_id == backend_id then
					widget_content.allow_equipped_drag = not disable_equipped_items
					local is_active = true
					local item_slot_type = item.slot_type
					local slot_names = InventorySettings.slot_names_by_type[item_slot_type]
					local item_equipped = false

					for k = 1, #slot_names, 1 do
						local slot_name = slot_names[k]
						local equipped_slot_item = BackendUtils.get_loadout_item(selected_profile_name, slot_name)

						if equipped_slot_item and equipped_slot_item.backend_id == item.backend_id then
							item_equipped = true

							break
						end
					end

					if (selected_rarity and item.rarity ~= selected_rarity) or (disable_equipped_items and item_equipped) then
						is_active = false
					end

					if is_active and self.disable_non_trait_items then
						local item_traits = item.traits

						if not item_traits or #item_traits < 1 then
							is_active = false
						end
					end

					local item_type = item.item_type
					local level_requirement = locked_item_types[item_type]

					if level_requirement then
						is_active = false
					end

					if active and not is_active then
						return 
					end

					widget_content.active = active

					break
				end
			end
		end
	end

	return 
end
InventoryItemsList.set_drag_enabled = function (self, enabled)
	local drag_disabled = not enabled
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type

	if selected_profile_name and selected_slot_type then
		for i = 1, #list_content, 1 do
			local widget_content = list_content[i]

			if widget_content then
				local item = widget_content.item

				if item then
					widget_content.drag_disabled = drag_disabled
				end
			end
		end
	end

	return 
end
InventoryItemsList.refresh_items_status = function (self)
	local selected_list_index = self.selected_list_index
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local list_style = item_list_widget.style.list_style
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type
	local selected_rarity = self.selected_rarity
	local disable_equipped_items = self.disable_equipped_items
	local new_backend_ids = ItemHelper.get_new_backend_ids()
	local accepted_rarity_list = self.accepted_rarity_list

	if selected_profile_name and selected_slot_type then
		local locked_trait_color = Colors.get_color_table_with_alpha("red", 255)
		local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
		local tooltip_trait_unique_text = Localize("unique_trait_description")
		local locked_item_types = self.get_locked_item_types(self)
		local disabled_backend_ids = self.disabled_backend_ids

		for i = 1, #list_content, 1 do
			local widget_content = list_content[i]
			local widget_style = list_style.item_styles[i]

			if widget_content then
				local item = widget_content.item

				if item then
					local item_backend_id = item.backend_id
					local item_rarity = item.rarity
					local item_slot_type = item.slot_type
					local slot_names = InventorySettings.slot_names_by_type[item_slot_type]
					local traits = item.traits

					if traits then
						local is_trinket = item_slot_type == "trinket"
						local traits_never_locked = is_trinket or item_slot_type == "hat"
						local trait_counter = 1

						for i = #traits, 1, -1 do
							local trait_name = traits[i]
							local trait_template = BuffTemplates[trait_name]

							if trait_template then
								local trait_unlocked = ((traits_never_locked or BackendUtils.item_has_trait(item_backend_id, trait_name)) and true) or false
								local trait_widget_locked_id = "trait_slot_" .. trait_counter .. "_locked"
								widget_content[trait_widget_locked_id] = not trait_unlocked
								local title_text = (trait_template.display_name and Localize(trait_template.display_name)) or "Unknown"
								local description_text = BackendUtils.get_item_trait_description(item_backend_id, i)
								local tooltip_text = title_text .. "\n" .. description_text

								if is_trinket then
									tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
								elseif not trait_unlocked then
									tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
								end

								local traits_tooltip_id = "trait_slot_" .. trait_counter .. "_tooltip"
								widget_content[traits_tooltip_id] = tooltip_text
								widget_style[traits_tooltip_id].last_line_color = ((is_trinket or not trait_unlocked) and locked_trait_color) or nil
							end

							trait_counter = trait_counter + 1
						end
					end

					local is_new = false

					if new_backend_ids and new_backend_ids[item_backend_id] then
						is_new = true
					end

					local is_active = true
					local is_locked = false
					local item_equipped = false

					if self.tag_equipped_items then
						if self._tag_all_equipped_items then
							local SPProfiles = SPProfiles

							for i = 1, #SPProfiles, 1 do
								local profile = SPProfiles[i]
								local profile_name = profile.display_name

								for k = 1, #slot_names, 1 do
									local slot_name = slot_names[k]
									local equipped_slot_item = BackendUtils.get_loadout_item(profile_name, slot_name)

									if equipped_slot_item and equipped_slot_item.backend_id == item_backend_id then
										item_equipped = true

										break
									end
								end
							end
						else
							for k = 1, #slot_names, 1 do
								local slot_name = slot_names[k]
								local equipped_slot_item = BackendUtils.get_loadout_item(selected_profile_name, slot_name)

								if equipped_slot_item and equipped_slot_item.backend_id == item_backend_id then
									item_equipped = true

									break
								end
							end
						end
					end

					widget_content.allow_equipped_drag = not disable_equipped_items

					if (selected_rarity and item_rarity ~= selected_rarity) or (disable_equipped_items and item_equipped) then
						is_active = false
					end

					if is_active and self.disable_non_trait_items then
						local item_traits = item.traits

						if not item_traits or #item_traits < 1 then
							is_active = false
						end
					end

					local item_type = item.item_type
					local level_requirement = locked_item_types[item_type]

					if level_requirement then
						is_locked = true
						is_active = false
						widget_content.locked_text = level_requirement
					end

					if accepted_rarity_list and not accepted_rarity_list[item_rarity] then
						is_active = false
					end

					if disabled_backend_ids[item_backend_id] then
						is_active = is_active and false
					end

					widget_content.equipped = item_equipped
					widget_content.active = is_active
					widget_content.locked = is_locked
					widget_content.new = is_new
					local button_hotspot = widget_content.button_hotspot
					button_hotspot.is_selected = i == selected_list_index
				end
			end
		end
	end

	return 
end
InventoryItemsList.get_player_level = function (self)
	local experience = ExperienceSettings.max_experience
	local prestige = 0
	local backend_manager = Managers.backend

	if backend_manager.available(backend_manager) and backend_manager.profiles_loaded(backend_manager) then
		experience = ScriptBackendProfileAttribute.get("experience")
	end

	local level = ExperienceSettings.get_level(experience)

	return level, prestige
end
InventoryItemsList.is_item_type_locked = function (self, item_type)
	return false
end
InventoryItemsList.get_locked_item_types = function (self)
	local item_types = InventorySettings.item_types
	local locked_item_types = {}

	for i = 1, #item_types, 1 do
		local item_type = item_types[i]

		if item_type then
			local is_locked, level_requirement = self.is_item_type_locked(self, item_type)

			if is_locked then
				locked_item_types[item_type] = level_requirement
			end
		end
	end

	return locked_item_types
end
InventoryItemsList.set_rarity = function (self, rarity)
	self.selected_rarity = rarity

	self.refresh_items_status(self)

	return 
end
InventoryItemsList.sort_items_by_rarity = function (self, enabled)
	self.sort_by_rarity = enabled

	return 
end
InventoryItemsList.on_item_list_hover = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		return item_list_widget.content.internal_is_hover
	end

	return 
end
InventoryItemsList.on_item_hover_enter = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content

	for i = 1, #list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if button_hotspot.on_hover_enter then
			local item = button_content.item

			return i, item and item.backend_id
		end
	end

	return 
end
InventoryItemsList.on_item_hover_exit = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content

	for i = 1, #list_content, 1 do
		local button_content = list_content[i]
		local button_hotspot = button_content.button_hotspot

		if button_hotspot.on_hover_exit then
			local item = button_content.item

			return i, item and item.backend_id
		end
	end

	return 
end
InventoryItemsList.is_dragging_item = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]

			if ui_content.is_dragging then
				return true
			end
		end
	end

	return 
end
InventoryItemsList.is_dragging_item_started = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]

			if ui_content.on_drag_started then
				return true
			end
		end
	end

	return 
end
InventoryItemsList.on_dragging_item_stopped = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]

			if ui_content.on_drag_stopped or ui_content.is_dragging then
				return ui_content.on_drag_stopped, ui_content.item
			end
		end
	end

	return 
end
InventoryItemsList.on_item_dragged = function (self)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content
		local item_styles = item_list_widget.style.list_style.item_styles

		for i = 1, #list_content, 1 do
			local ui_content = list_content[i]
			local ui_style = item_styles[i]
			local icon_color = ui_style.item_texture_id.color
			local icon_frame_color = ui_style.item_frame_texture_id.color

			if ui_content.is_dragging and icon_color[1] ~= 150 then
				icon_color[1] = 150
				icon_frame_color[1] = 150
			elseif ui_content.on_drag_stopped and icon_color[1] ~= 255 then
				icon_color[1] = 255
				icon_frame_color[1] = 255
			end
		end
	end

	return 
end
InventoryItemsList.deselect_all_list_items = function (self)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local num_list_content = #list_content

	for i = 1, num_list_content, 1 do
		local button_hotspot = list_content[i].button_hotspot
		button_hotspot.is_selected = false
		button_hotspot.on_hover_enter = false
		button_hotspot.on_hover_exit = false
		button_hotspot.is_hover = false
	end

	self.selected_list_index = nil

	return 
end
InventoryItemsList.set_accepted_rarities = function (self, rarity_list)
	self.accepted_rarity_list = rarity_list

	return 
end
InventoryItemsList.set_disable_non_trait_items = function (self, enabled)
	self.disable_non_trait_items = enabled

	return 
end
InventoryItemsList.mark_equipped_items = function (self)
	self.tag_equipped_items = true

	return 
end
InventoryItemsList.tag_all_equipped_items = function (self)
	self._tag_all_equipped_items = true

	return 
end
InventoryItemsList.sort_by_loadout_first = function (self)
	self.sort_by_equipment = true

	return 
end
InventoryItemsList.set_disable_loadout_items = function (self, disabled)
	self.disable_equipped_items = disabled

	return 
end
InventoryItemsList.populate_inventory_list = function (self, ignore_scroll_reset, backend_id_ignore_list, optional_item_filter)
	self.deselect_all_list_items(self)

	local settings = self.settings
	local selected_profile_name = self.selected_profile_name
	local selected_slot_type = self.selected_slot_type
	local selected_rarity = self.selected_rarity
	local backend_items, items = nil
	local tag_equipped_items = self.tag_equipped_items

	if optional_item_filter then
		backend_items = ScriptBackendItem.get_filtered_items(optional_item_filter)
	else

		-- decompilation error in this vicinity
		backend_items = {}

		for index, slot_type_name in ipairs(selected_slot_type) do
			local new_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, slot_type_name)) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, slot_type_name)

			table.append(backend_items, new_items)
		end

		local melee_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, "melee")) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, "melee")
		local ranged_items = (tag_equipped_items and BackendUtils.get_inventory_items(selected_profile_name, "ranged")) or BackendUtils.get_inventory_items_except_loadout(selected_profile_name, "ranged")
		backend_items = {}

		table.append(backend_items, melee_items)
		table.append(backend_items, ranged_items)
	end

	if backend_items then
		items = {}

		if backend_id_ignore_list then
			for index, item in ipairs(backend_items) do
				local add_item = true

				for i = 1, #backend_id_ignore_list, 1 do
					local backend_id_to_ignore = backend_id_ignore_list[i]

					if backend_id_to_ignore and backend_id_to_ignore == item.backend_id then
						add_item = false

						break
					end
				end

				if add_item then
					items[#items + 1] = item
				end
			end
		else
			items = backend_items
		end
	end

	local number_of_items_in_list = (items and #items) or 0
	self.number_of_items_in_list = number_of_items_in_list

	if 0 < number_of_items_in_list then
		self.draw_inventory_list = true
	else
		self.draw_inventory_list = nil
	end

	local item_list_widget = self.item_list_widget
	local list_content = {}
	local list_style = {
		vertical_alignment = "top",
		scenegraph_id = "item_list",
		size = settings.list_size,
		list_member_offset = {
			0,
			-(element_settings.height + element_settings.height_spacing),
			0
		},
		item_styles = {},
		columns = settings.columns,
		column_offset = settings.columns and element_settings.width + settings.column_offset
	}
	local loadout_items = nil

	if tag_equipped_items then
		loadout_items = {}
		local slots_by_name = InventorySettings.slots_by_name

		if self._tag_all_equipped_items then
			local SPProfiles = SPProfiles

			for i = 1, #SPProfiles, 1 do
				local profile = SPProfiles[i]
				local profile_name = profile.display_name

				for slot_name, _ in pairs(slots_by_name) do
					loadout_items[#loadout_items + 1] = BackendUtils.get_loadout_item(profile_name, slot_name)
				end
			end
		else
			local slots_by_name = InventorySettings.slots_by_name

			for slot_name, _ in pairs(slots_by_name) do
				loadout_items[#loadout_items + 1] = BackendUtils.get_loadout_item(selected_profile_name, slot_name)
			end
		end
	end

	local new_backend_ids = ItemHelper.get_new_backend_ids()
	local disable_equipped_items = self.disable_equipped_items
	local locked_item_types = self.get_locked_item_types(self)
	local accepted_rarity_list = self.accepted_rarity_list
	local disabled_backend_ids = self.disabled_backend_ids
	local sort_data = {}

	Profiler.start("InventoryItemsList: Create item templates")

	local use_top_renderer = self.settings.use_top_renderer

	for index, item in ipairs(items) do
		local item_backend_id = item.backend_id
		local item_rarity = item.rarity
		local item_color = self.get_rarity_color(self, item_rarity)
		local equipped_item = false
		local is_locked = false
		local is_active = true
		local is_new = false

		if new_backend_ids and new_backend_ids[item_backend_id] then
			is_new = true
		end

		if loadout_items then
			for _, loadout_item in ipairs(loadout_items) do
				if loadout_item.backend_id == item_backend_id then
					equipped_item = true

					break
				end
			end
		end

		if (selected_rarity and item_rarity ~= selected_rarity) or (disable_equipped_items and equipped_item) then
			is_active = false
		end

		if is_active and self.disable_non_trait_items then
			local item_traits = item.traits

			if not item_traits or #item_traits < 1 then
				is_active = false
			end
		end

		local item_type = item.item_type
		local level_requirement = locked_item_types[item_type]

		if level_requirement then
			is_locked = true
			is_active = false
		end

		if accepted_rarity_list and not accepted_rarity_list[item_rarity] then
			is_active = false
		end

		if disabled_backend_ids[item_backend_id] then
			is_active = is_active and false
		end

		local content, style = create_inventory_item_template(true, item, item_color, equipped_item, is_new, is_active, is_locked, not disable_equipped_items, level_requirement, use_top_renderer and self.ui_top_renderer)
		sort_data[index] = {
			content = content,
			style = style
		}
	end

	Profiler.stop()

	if self.sort_by_equipment then
		table.sort(sort_data, sort_by_loadout_rarity_name)
	else
		table.sort(sort_data, sort_by_rarity_name)
	end

	for i = 1, #sort_data, 1 do
		list_content[i] = sort_data[i].content
		list_style.item_styles[i] = sort_data[i].style
	end

	sort_data = nil
	item_list_widget.content.list_content = list_content
	item_list_widget.style.list_style = list_style
	item_list_widget.style.list_style.start_index = 1
	item_list_widget.style.list_style.num_draws = settings.num_list_items
	item_list_widget.element.pass_data[1].num_list_elements = nil
	local num_draws = item_list_widget.style.list_style.num_draws
	local list_content_n = #list_content
	self.number_of_real_items = list_content_n

	if list_content_n < num_draws then
		local padding_n = num_draws - #list_content%num_draws

		if padding_n < num_draws then
			for i = 1, padding_n, 1 do
				local empty_element = self.empty_widget_elements[i]
				local index = #list_content + 1
				list_content[index] = empty_element.content
				list_style.item_styles[index] = empty_element.style
			end

			self.used_empty_elements = padding_n
		end
	end

	self.set_scrollbar_length(self, nil, ignore_scroll_reset)

	return 
end
InventoryItemsList.set_list_compare_against_item = function (self, equipped_item_name)
	local equipped_item = rawget(ItemMasterList, equipped_item_name)

	if equipped_item then
		local equipped_item_template = BackendUtils.get_item_template(equipped_item)
		local equipped_item_compare_statistics = equipped_item_template.compare_statistics
		local equipped_item_statistics = (equipped_item_compare_statistics and equipped_item_compare_statistics.quick_compare and equipped_item_compare_statistics.quick_compare) or temp_stats
		local items = self.item_list
		local item_list_widget = self.item_list_widget
		local item_list_contents = item_list_widget.content.list_content
		local item_list_styles = item_list_widget.style.list_style.item_styles

		for index, item in ipairs(items) do
			if equipped_item.slot_type == item.slot_type then
				local item_template = BackendUtils.get_item_template(item)
				local item_compare_statistics = item_template.compare_statistics
				local item_statistics = (item_compare_statistics and item_compare_statistics.quick_compare and item_compare_statistics.quick_compare) or temp_stats
				local entry_content = item_list_contents[index]
				local entry_style = item_list_styles[index]

				for key, stat_data in pairs(equipped_item_statistics) do
					local i = index_by_stats_type[key]
					local compare_item_stat = item_statistics[key]
					local is_positive, result_score = self.stat_compare(self, key, stat_data, compare_item_stat)
					local widget_stat_id = "stat_" .. i

					if result_score ~= 0 then
						result_score = math.min(result_score, 2)
						local stats_textures = (is_positive and compare_state_textures.up) or compare_state_textures.down
						local stat_color = (is_positive and compare_state_colors.up) or compare_state_colors.down
						entry_content[widget_stat_id] = stats_textures[result_score]
						entry_style[widget_stat_id].color = stat_color
					else
						entry_content[widget_stat_id] = compare_state_textures.equal
						entry_style[widget_stat_id].color = compare_state_colors.equal
					end
				end
			end
		end
	end

	return 
end
InventoryItemsList.stat_compare = function (self, stat_name, equipped_item_stat, compare_item_stat)
	local equipped_total_score = 0
	local compare_total_score = 0
	local equipped_avrage_score = 0
	local compare_avrage_score = 0

	for i = 1, #equipped_item_stat, 1 do
		equipped_total_score = equipped_total_score + equipped_item_stat[i]
	end

	for i = 1, #compare_item_stat, 1 do
		compare_total_score = compare_total_score + compare_item_stat[i]
	end

	local equipped_first_score = equipped_item_stat[1]
	local compare_first_score = compare_item_stat[1]
	local diff = equipped_first_score - compare_first_score

	if equipped_first_score < compare_first_score then
		if equipped_first_score*2 <= compare_first_score then
			return true, 3
		elseif equipped_first_score*1.5 <= compare_first_score then
			return true, 2
		else
			return true, 1
		end
	elseif compare_first_score < equipped_first_score then
		if compare_first_score*2 <= equipped_first_score then
			return false, 3
		elseif compare_first_score*1.5 <= equipped_first_score then
			return false, 2
		else
			return false, 1
		end
	else
		return nil, 0
	end

	return 
end
InventoryItemsList.is_entry_outside = function (self, index)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content
		local list_style = item_list_widget.style.list_style
		local max_visible_elements = list_style.num_draws
		local total_elements = #list_content
		local current_start_index = list_style.start_index

		if index < current_start_index then
			return true, "above"
		elseif math.min((current_start_index + max_visible_elements) - 1, total_elements) < index then
			return true, "below"
		end
	end

	return false
end
InventoryItemsList.update_scroll = function (self)
	local scroll_bar_value = self.scrollbar_widget.content.scroll_bar_info.value
	local mouse_scroll_value = self.scroll_field_widget.content.internal_scroll_value
	local current_scroll_value = self.scroll_value

	if current_scroll_value ~= mouse_scroll_value then
		self.set_scroll_amount(self, mouse_scroll_value)
	elseif current_scroll_value ~= scroll_bar_value then
		self.set_scroll_amount(self, scroll_bar_value)
	end

	return 
end
InventoryItemsList.set_scroll_amount = function (self, value, ignore_list_scroll)
	local current_scroll_value = self.scroll_value

	if not current_scroll_value or value ~= current_scroll_value then
		local widget_scroll_bar_info = self.scrollbar_widget.content.scroll_bar_info
		widget_scroll_bar_info.value = value
		self.scroll_field_widget.content.internal_scroll_value = value
		self.scroll_value = value

		if not ignore_list_scroll then
			self.scroll_inventory_list(self, value)
		end
	end

	return 
end
InventoryItemsList.set_scrollbar_length = function (self, start_scroll_value, ignore_scroll_reset, ignore_scroll_set)
	local settings = self.settings
	local columns = settings.columns
	local total_inventory_slots = settings.num_list_items
	local number_of_items_in_list = self.number_of_items_in_list
	local item_diff_count = math.max(number_of_items_in_list - total_inventory_slots, 0)
	local scrollbar_content = self.scrollbar_widget.content
	local widget_scroll_bar_info = scrollbar_content.scroll_bar_info
	local bar_fraction = 0
	local step_fraction = 0

	if 0 < item_diff_count then
		local number_of_elements_per_step = (columns and columns) or 1
		local number_of_steps_possible = math.ceil(item_diff_count/number_of_elements_per_step)
		local number_of_steps_total = math.ceil(number_of_items_in_list/number_of_elements_per_step)
		local list_fraction = number_of_steps_total/1
		bar_fraction = list_fraction*number_of_steps_possible - 1
		step_fraction = number_of_steps_possible/1
	else
		bar_fraction = 1
		step_fraction = 1
	end

	widget_scroll_bar_info.bar_height_percentage = bar_fraction
	self.scroll_field_widget.content.scroll_step = step_fraction
	scrollbar_content.button_scroll_step = step_fraction

	if not ignore_scroll_set then
		if ignore_scroll_reset then
			local current_scroll_value = self.scroll_value
			self.scroll_value = nil

			self.set_scroll_amount(self, current_scroll_value or 0)
		else
			self.set_scroll_amount(self, start_scroll_value or 0)
		end
	end

	return 
end
InventoryItemsList.scroll_inventory_list = function (self, value)
	local item_list_widget = self.item_list_widget

	if item_list_widget then
		local list_content = item_list_widget.content.list_content
		local list_style = item_list_widget.style.list_style
		local max_visible_elements = list_style.num_draws
		local column_count = list_style.columns
		local total_elements = #list_content

		if max_visible_elements and max_visible_elements < total_elements then
			local elements_to_scroll = total_elements - max_visible_elements
			local new_start_index = math.max(0, math.round(value*elements_to_scroll)) + 1

			if column_count and new_start_index%column_count == 0 then
				new_start_index = (new_start_index + column_count) - 1
			end

			list_style.start_index = new_start_index
		end
	end

	return 
end
InventoryItemsList.on_inventory_item_selected = function (self, index, play_sound)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local number_of_items_in_list = self.number_of_items_in_list

	if not number_of_items_in_list or number_of_items_in_list < 1 then
		return 
	end

	if play_sound then
		self.play_sound(self, self.item_select_sound_event)
	end

	index = math.min(index, number_of_items_in_list)

	if index and list_content[index] then
		for i = 1, #list_content, 1 do
			list_content[i].button_hotspot.is_selected = i == index
		end

		self.inventory_list_select_animation_time = 0
		self.selected_list_index = index

		return list_content[index].item
	end

	return 
end
InventoryItemsList.index_by_backend_id = function (self, backend_id)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local number_of_items_in_list = self.number_of_items_in_list

	for i = 1, number_of_items_in_list, 1 do
		local content = list_content[i]
		local widget_item = content.item

		if widget_item and widget_item.backend_id == backend_id then
			return i
		end
	end

	return 
end
InventoryItemsList.item_by_index = function (self, index)
	local item_list_widget = self.item_list_widget
	local list_content = item_list_widget.content.list_content
	local widget_content = list_content[index]

	return widget_content and widget_content.item
end
InventoryItemsList.selected_item = function (self)
	local selected_list_index = self.selected_list_index

	if selected_list_index then
		local item_list_widget = self.item_list_widget
		local list_content = item_list_widget.content.list_content
		local list_widget_content = list_content[selected_list_index]
		local is_equipped = list_widget_content.equipped
		local active = list_widget_content.active

		return list_content[selected_list_index].item, is_equipped, active
	end

	return 
end
InventoryItemsList.get_available_equipment_slot_by_type = function (self, slot_type)
	for index, slot in ipairs(slot_button_index) do
		if slot == slot_type then
			return index
		end
	end

	return 
end
InventoryItemsList.animate_element_by_time = function (self, target, destination_index, from, to, time)
	local new_animation = UIAnimation.init(UIAnimation.function_by_time, target, destination_index, from, to, time, math.easeInCubic)

	return new_animation
end
InventoryItemsList.update_inventory_list_animations = function (self, dt)
	local item_list_widget = self.item_list_widget
	local content = item_list_widget.content.list_content
	local style = item_list_widget.style
	local list_style = style.list_style
	local inventory_list_animations = self.inventory_list_animations
	local border_settings = UISettings.inventory.item_list.border
	local hover_fade_in = border_settings.hover_fade_in_time
	local hover_fade_out = border_settings.hover_fade_out_time
	local alpha_normal = border_settings.alpha_normal
	local alpha_hover = border_settings.alpha_hover
	local non_room_item_alpha_value = UISettings.inventory.item_list.intro.non_room_item_alpha_value
	local start_index = list_style.start_index

	if not start_index then
		return 
	end

	local num_draws = list_style.num_draws
	local stop_index = math.min(start_index + num_draws, self.number_of_items_in_list)

	for i = 1, #content, 1 do
		local outside_view = i < start_index or stop_index < i
		local element_style = (list_style.item_styles and list_style.item_styles[i]) or list_style
		local element_content = content[i]
		local button_hotspot = element_content.button_hotspot
		local background_click_style = element_style.background_click_texture_id
		local background_hover_style = element_style.background_hover_texture_id
		local background_style = element_style.background_texture_id
		local border_style = element_style.border_texture_id
		local active_animations = inventory_list_animations[i] or {}
		local is_selected = button_hotspot.is_selected
		local select_anim_time = self.inventory_list_select_animation_time

		if select_anim_time and (is_selected or element_content.tweened_click) then
			local total_time = 0.2
			element_content.tweened_click = true
			select_anim_time = select_anim_time + dt
			local progress = math.min(select_anim_time/total_time, 1)
			local catmullrom_value = math.catmullrom(progress, 0.97, 1, 1, 0.57)
			local background_hover_default_style = definitions.scenegraph_definition.inventory_selection_item_background_hover
			local background_default_size = definitions.scenegraph_definition.inventory_selection_item_background.size
			local border_default_style = definitions.scenegraph_definition.inventory_selection_item_icon_border
			local background_default_style = definitions.scenegraph_definition.inventory_selection_item_background
			local item_default_style = definitions.scenegraph_definition.inventory_selection_item_icon

			animation_definitions.animate_style_on_select(background_click_style, background_default_size, progress, catmullrom_value)
			animation_definitions.animate_style_on_select(background_hover_style, background_hover_default_style.size, progress, catmullrom_value, background_hover_default_style, true)

			self.inventory_list_select_animation_time = (progress < 1 and select_anim_time) or nil
			background_style.color[1] = 0
		end

		if not is_selected and element_content.tweened_click then
			background_click_style.color[1] = alpha_normal
			background_style.color[1] = (element_content.room_item and 255) or non_room_item_alpha_value
			active_animations.background = self.animate_element_by_time(self, background_style.color, 1, background_style.color[1], 255, 0.1)
			element_content.tweened_click = nil
		end

		if button_hotspot.is_hover and not is_selected and not outside_view then
			if not element_content.tween_in then
				element_content.tween_in = true
				active_animations.hover = self.animate_element_by_time(self, background_hover_style.color, 1, background_hover_style.color[1], alpha_hover, hover_fade_in)

				self.play_sound(self, "Play_hud_hover")
			end
		elseif element_content.tween_in then
			element_content.tween_in = nil
			active_animations.hover = self.animate_element_by_time(self, background_hover_style.color, 1, background_hover_style.color[1], alpha_normal, hover_fade_out)
		end

		if active_animations then
			for name, animation in pairs(active_animations) do
				UIAnimation.update(animation, dt)

				if UIAnimation.completed(animation) then
					animation = nil
					self.inventory_list_animations[i] = nil
				end
			end
		end

		self.inventory_list_animations[i] = active_animations
	end

	return 
end
InventoryItemsList.update_inventory_list_intro_animation = function (self, dt)
	local time = self.inventory_list_animation_time
	local list_times = UISettings.inventory.item_list.intro
	local total_time = list_times.total_tween_time
	local alpha_fade_in_start_fraction = list_times.alpha_fade_in_start_fraction
	local size_fade_in_start_fraction = list_times.size_fade_in_start_fraction
	local item_fade_in_start_fraction = list_times.item_fade_in_start_fraction
	local item_fade_in_end_fraction = list_times.item_fade_in_end_fraction
	local background_fade_in_start_fraction = list_times.background_fade_in_start_fraction
	local background_fade_in_end_fraction = list_times.background_fade_in_end_fraction
	local text_fade_in_start_fraction = list_times.text_fade_in_start_fraction
	local text_fade_in_end_fraction = list_times.text_fade_in_end_fraction
	local non_room_item_alpha_value = list_times.non_room_item_alpha_value
	local item_list_widget = self.item_list_widget
	local content = item_list_widget.content
	local style = item_list_widget.style
	local list_style = style.list_style
	local scenegraph_definition = self.scenegraph_definition
	local background_default_style = scenegraph_definition.inventory_selection_item_background
	local item_default_style = scenegraph_definition.inventory_selection_item_icon
	time = time + dt
	local progress = math.min(time/total_time, 1)

	for i = 1, #content.list_content, 1 do
		local element_content = content.list_content[i]
		local element_style = (list_style.item_styles and list_style.item_styles[i]) or list_style
		local background_style = element_style.background_texture_id
		local item_style = element_style.item_texture_id
		local text_style = element_style.text_title
		local text_equipped_style = element_style.text_equipped
		local sub_text_style = element_style.text_sub_title

		if item_fade_in_start_fraction <= progress then
			local item_progress = progress - item_fade_in_start_fraction
			local item_tween_progress = (0 < item_progress and math.min(item_progress/(item_fade_in_end_fraction - item_fade_in_start_fraction), 1)) or 0
			local catmullrom_value = math.catmullrom(item_tween_progress, -0.5, 1, 1, -0.5)
			item_style.color[1] = math.max(122.5, item_tween_progress*255)
			local offset_fraction = (item_tween_progress < 1 and catmullrom_value - 1) or 0
			local x_offset = (offset_fraction*item_default_style.size[1])/2
			local y_offset = offset_fraction*item_default_style.size[2]/2
			item_style.size = {
				catmullrom_value*item_default_style.size[1],
				catmullrom_value*item_default_style.size[2]
			}
			item_style.offset = {
				item_default_style.position[1] + x_offset,
				item_default_style.position[2] + y_offset,
				item_style.offset[3]
			}
		else
			item_style.color[1] = 0
		end

		if background_fade_in_start_fraction <= progress then
			local background_progress = progress - background_fade_in_start_fraction
			local background_tween_progress = (0 < background_progress and math.min(background_progress/(background_fade_in_end_fraction - background_fade_in_start_fraction), 1)) or 0
			local catmullrom_value = math.catmullrom(background_tween_progress, 1.2, 1, 1, 1.2)
			background_style.color[1] = math.max(122.5, background_tween_progress*255)
			background_style.size[1] = catmullrom_value*background_default_style.size[1]
			background_style.size[2] = catmullrom_value*background_default_style.size[2]
			local offset_fraction = (background_tween_progress < 1 and catmullrom_value - 1) or 0
			local x_offset = (offset_fraction*background_default_style.size[1])/2
			local y_offset = offset_fraction*background_default_style.size[2]/2
			background_style.offset[1] = x_offset
			background_style.offset[2] = y_offset
			background_style.offset[3] = background_style.offset[3]
		else
			background_style.color[1] = 0
		end

		if text_fade_in_start_fraction <= progress then
			local text_progress = progress - text_fade_in_start_fraction
			local text_tween_progress = (0 < text_progress and math.min(text_progress/text_fade_in_end_fraction, 1)) or 0
			local text_color = progress*255
			text_style.text_color[1] = text_color
			sub_text_style.text_color[1] = text_color
			text_equipped_style.text_color[1] = text_color

			for k = 1, 5, 1 do
				local widget_stat_id = "stat_" .. k
				local widget_stat_title_id = "stat_title_icon_" .. k
				local compare_symbol_style = element_style[widget_stat_id]
				local compare_title_symbol_style = element_style[widget_stat_title_id]
				compare_symbol_style.color[1] = text_color
				compare_title_symbol_style.color[1] = text_color
			end

			if not element_content.room_item then
				background_style.color[1] = progress*(non_room_item_alpha_value - 255) - 255
			end
		else
			local text_color = 0
			text_style.text_color[1] = text_color
			sub_text_style.text_color[1] = text_color
			text_equipped_style.text_color[1] = text_color

			for k = 1, 5, 1 do
				local widget_stat_id = "stat_" .. k
				local widget_stat_title_id = "stat_title_icon_" .. k
				local compare_symbol_style = element_style[widget_stat_id]
				local compare_title_symbol_style = element_style[widget_stat_title_id]
				compare_symbol_style.color[1] = text_color
				compare_title_symbol_style.color[1] = text_color
			end
		end
	end

	if progress == 1 then
		self.inventory_list_animation_time = nil
	else
		self.inventory_list_animation_time = time
	end

	return 
end
InventoryItemsList.get_rarity_color = function (self, rarity)
	return Colors.get_table(rarity or "white")
end
InventoryItemsList.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)

	return 
end

return 
