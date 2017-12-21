local element_settings = {
	height_spacing = 4.5,
	height = 115,
	width = 535
}
local scrollbar_width = 22
local scenegraph_definition = {
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
	},
	gamepad_slot_selection = {
		vertical_alignment = "bottom",
		parent = "item_list",
		horizontal_alignment = "center",
		position = {
			0,
			-34,
			10
		},
		size = {
			element_settings.width + 67,
			element_settings.height + 59
		}
	}
}
local widget_definitions = {
	gamepad_slot_selection = UIWidgets.create_gamepad_selection("gamepad_slot_selection", nil, nil, {
		90,
		90
	}),
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

local function create_inventory_item_template()
	local content = {
		trait_slot_fg = "trait_icon_selected_frame",
		trait_slot_4_locked = true,
		trait_slot_3_locked = true,
		trait_slot_1_tooltip = "",
		title = "Unknown",
		locked_text = "",
		trait_slot_locked = "trait_icon_selected_frame_locked",
		background_selected = "list_item_selected",
		background_normal_hover = "list_item_normal_hover",
		visible = true,
		trait_slot_3_tooltip = "",
		new = false,
		trait_slot_2_locked = true,
		background_selected_hover = "list_item_selected_hover",
		trait_slot_1_locked = true,
		locked_texture = "locked_icon_01",
		background_disabled_hover = "list_item_disabled_hover",
		trait_slot_4_tooltip = "",
		background_disabled_selected = "list_item_disabled_selected",
		new_texture = "list_item_tag_new",
		sub_title = "Unknown",
		background_normal = "list_item_normal",
		hover_disabled = false,
		item_texture_id = "icons_placeholder",
		locked = true,
		text_equipped = "item_compare_window_title",
		trait_slot_2_tooltip = "",
		background_disabled_selected_hover = "list_item_disabled_selected_hover",
		background_disabled = "list_item_disabled",
		description = "Unknown",
		disabled_overlay = "list_item_disabled_overlay",
		item_frame_texture_id = "frame_01",
		active = false,
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
			text_color = {
				255,
				255,
				255,
				255
			},
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

local temp_trait_textures = {}
local temp_traits_unlocked = {}
local temp_traits_tooltip = {}

local function set_item_element_info(item_element, is_room_item, item, item_color, equipped_item, is_new, is_active, is_locked, allow_equipped_drag, ui_renderer)
	local content = item_element.content
	local style = item_element.style
	local traits = item.traits

	table.clear(temp_trait_textures)
	table.clear(temp_traits_tooltip)
	table.clear(temp_traits_unlocked)

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
				temp_trait_textures[#temp_trait_textures + 1] = trait_icon
				temp_traits_unlocked[#temp_traits_unlocked + 1] = trait_unlocked
				local tooltip_text = title_text .. "\n" .. description_text

				if is_trinket then
					tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
				elseif not trait_unlocked then
					tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
				end

				temp_traits_tooltip[#temp_traits_tooltip + 1] = tooltip_text
			end
		end
	end

	table.clear(content.button_hotspot)
	table.clear(content.trait_slot_1_hotspot)
	table.clear(content.trait_slot_2_hotspot)
	table.clear(content.trait_slot_3_hotspot)
	table.clear(content.trait_slot_4_hotspot)

	content.item = item
	content.new = is_new
	content.visible = true
	content.active = is_active
	content.locked = is_locked
	content.hover_disabled = false
	content.equipped = equipped_item
	content.room_item = is_room_item
	content.trait_slot_1 = temp_trait_textures[1]
	content.trait_slot_2 = temp_trait_textures[2]
	content.trait_slot_3 = temp_trait_textures[3]
	content.trait_slot_4 = temp_trait_textures[4]
	content.locked_text = ""
	content.trait_slot_1_locked = not temp_traits_unlocked[1]
	content.trait_slot_2_locked = not temp_traits_unlocked[2]
	content.trait_slot_3_locked = not temp_traits_unlocked[3]
	content.trait_slot_4_locked = not temp_traits_unlocked[4]
	content.trait_slot_1_tooltip = temp_traits_tooltip[1] or ""
	content.trait_slot_2_tooltip = temp_traits_tooltip[2] or ""
	content.trait_slot_3_tooltip = temp_traits_tooltip[3] or ""
	content.trait_slot_4_tooltip = temp_traits_tooltip[4] or ""
	content.allow_equipped_drag = allow_equipped_drag or false
	local item_name = (item.name and item.localized_name) or "Unknown"

	if style.text_title and 25 < UTF8Utils.string_length(item_name) and not UIRenderer.crop_text_width(ui_renderer, item_name, 400, style.text_title) then
	end

	content.title = item_name
	content.item_texture_id = item.inventory_icon or "icons_placeholder"
	content.sub_title = (item.item_type and Localize(item.item_type)) or "Unknown"
	content.description = (item.description and Localize(item.description)) or "Unknown"
	style.item_frame_texture_id.color = table.clone(item_color)
	style.text_title.text_color = table.clone(item_color)
	local red_color = Colors.get_table("red")
	style.trait_slot_1_tooltip.last_line_color = ((is_trinket or not temp_traits_unlocked[1]) and table.clone(red_color)) or nil
	style.trait_slot_2_tooltip.last_line_color = ((is_trinket or not temp_traits_unlocked[2]) and table.clone(red_color)) or nil
	style.trait_slot_3_tooltip.last_line_color = ((is_trinket or not temp_traits_unlocked[3]) and table.clone(red_color)) or nil
	style.trait_slot_4_tooltip.last_line_color = ((is_trinket or not temp_traits_unlocked[4]) and table.clone(red_color)) or nil

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
	scenegraph_definition[scenegraph_id] = scroll_field_scenegraph_definition
	widget_definitions.scroll_field = {
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

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	create_empty_inventory_item_template = create_empty_inventory_item_template,
	create_inventory_item_template = create_inventory_item_template,
	set_item_element_info = set_item_element_info,
	setup_mouse_scroll_widget_definition = setup_mouse_scroll_widget_definition,
	element_settings = element_settings,
	scrollbar_width = scrollbar_width
}
