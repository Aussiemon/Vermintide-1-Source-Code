local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.default
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
		size = {
			1920,
			1080
		}
	},
	page_root = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
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
	window_background = {
		vertical_alignment = "center",
		parent = "page_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			592,
			902
		}
	},
	window_title_text = {
		vertical_alignment = "top",
		parent = "window_background",
		horizontal_alignment = "center",
		position = {
			0,
			-15,
			1
		},
		size = {
			580,
			30
		}
	},
	scrollbar_root = {
		parent = "window_background",
		horizontal_alignment = "right",
		position = {
			-14,
			9,
			10
		},
		size = {
			22,
			839
		}
	},
	compare_window_bg = {
		vertical_alignment = "bottom",
		parent = "window_background",
		horizontal_alignment = "center",
		position = {
			-9,
			22,
			1
		},
		size = {
			534,
			819
		}
	},
	compare_window = {
		vertical_alignment = "bottom",
		parent = "window_background",
		horizontal_alignment = "center",
		position = {
			-9,
			22,
			1
		},
		size = {
			534,
			819
		}
	},
	compare_window_mask = {
		vertical_alignment = "bottom",
		parent = "window_background",
		horizontal_alignment = "center",
		position = {
			0,
			35,
			1
		},
		size = {
			548,
			795
		}
	},
	item_icon_background = {
		vertical_alignment = "top",
		parent = "compare_window",
		size = {
			78,
			79
		},
		position = {
			22,
			-22,
			1
		}
	},
	item_icon = {
		vertical_alignment = "center",
		parent = "item_icon_background",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			0,
			1
		}
	},
	item_title_text = {
		vertical_alignment = "center",
		parent = "item_icon_background",
		horizontal_alignment = "right",
		position = {
			390,
			20,
			1
		},
		size = {
			380,
			30
		}
	},
	item_sub_title_text = {
		parent = "item_title_text",
		position = {
			0,
			-35,
			1
		},
		size = {
			320,
			30
		}
	},
	detailed_item_info = {
		vertical_alignment = "bottom",
		parent = "item_icon_background",
		horizontal_alignment = "left",
		position = {
			0,
			-10,
			1
		},
		size = {
			1,
			1
		}
	},
	light_attack_frame = {
		vertical_alignment = "top",
		parent = "compare_window",
		horizontal_alignment = "center",
		position = {
			0,
			-155,
			1
		},
		size = {
			501,
			275
		}
	},
	heavy_attack_frame = {
		vertical_alignment = "top",
		parent = "compare_window",
		horizontal_alignment = "center",
		position = {
			0,
			-155,
			1
		},
		size = {
			501,
			275
		}
	},
	item_traits_root = {
		vertical_alignment = "top",
		parent = "compare_window",
		horizontal_alignment = "center",
		position = {
			0,
			-120,
			1
		},
		size = {
			1,
			1
		}
	},
	item_traits_background_top = {
		vertical_alignment = "top",
		parent = "item_traits_root",
		horizontal_alignment = "center",
		position = {
			0,
			-35,
			0
		},
		size = {
			503,
			94
		}
	},
	item_traits_background_center = {
		vertical_alignment = "top",
		parent = "item_traits_background_top",
		horizontal_alignment = "center",
		position = {
			0,
			-94,
			0
		},
		size = {
			503,
			28
		}
	},
	item_traits_background_bottom = {
		vertical_alignment = "bottom",
		parent = "item_traits_background_center",
		horizontal_alignment = "center",
		position = {
			0,
			-54,
			0
		},
		size = {
			503,
			54
		}
	},
	item_traits_start_root = {
		vertical_alignment = "top",
		parent = "item_traits_background_top",
		horizontal_alignment = "left",
		position = {
			20,
			-25,
			1
		},
		size = {
			1,
			1
		}
	},
	stamina_field = {
		vertical_alignment = "top",
		parent = "compare_window",
		horizontal_alignment = "left",
		position = {
			25,
			-121,
			1
		},
		size = {
			460,
			22
		}
	},
	ammo_field = {
		vertical_alignment = "top",
		parent = "compare_window",
		horizontal_alignment = "left",
		position = {
			25,
			-121,
			1
		},
		size = {
			460,
			22
		}
	},
	item_description_field = {
		vertical_alignment = "top",
		parent = "compare_window",
		horizontal_alignment = "center",
		position = {
			0,
			-122,
			1
		},
		size = {
			460,
			500
		}
	},
	trait_button_1 = {
		vertical_alignment = "top",
		parent = "item_traits_start_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_button_2 = {
		vertical_alignment = "top",
		parent = "item_traits_start_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_button_3 = {
		vertical_alignment = "top",
		parent = "item_traits_start_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_button_4 = {
		vertical_alignment = "top",
		parent = "item_traits_start_root",
		horizontal_alignment = "left",
		size = {
			40,
			40
		},
		position = {
			0,
			0,
			3
		}
	},
	trait_description_1 = {
		vertical_alignment = "top",
		parent = "trait_button_1",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	},
	trait_description_2 = {
		vertical_alignment = "top",
		parent = "trait_button_2",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	},
	trait_description_3 = {
		vertical_alignment = "top",
		parent = "trait_button_3",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	},
	trait_description_4 = {
		vertical_alignment = "top",
		parent = "trait_button_4",
		horizontal_alignment = "left",
		size = {
			460,
			40
		},
		position = {
			0,
			-55,
			1
		}
	}
}
local stats_icons_masked = {
	"stats_icon_range",
	"stats_icon_stagger",
	"stats_icon_targets",
	"stats_icon_attack_speed",
	"stats_icon_damage"
}
local default_tooltip_style = {
	font_size = 24,
	max_width = 500,
	localize = false,
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
		-10
	}
}
local trait_tooltip_style = table.clone(default_tooltip_style)
trait_tooltip_style.line_colors = {
	Colors.get_color_table_with_alpha("cheeseburger", 255),
	Colors.get_color_table_with_alpha("white", 255)
}
trait_tooltip_style.last_line_color = Colors.get_color_table_with_alpha("red", 255)
local widget_definitions = {
	trait_button_1 = UIWidgets.create_compare_menu_trait_widget("trait_button_1", "trait_description_1", true),
	trait_button_2 = UIWidgets.create_compare_menu_trait_widget("trait_button_2", "trait_description_2", true),
	trait_button_3 = UIWidgets.create_compare_menu_trait_widget("trait_button_3", "trait_description_3", true),
	trait_button_4 = UIWidgets.create_compare_menu_trait_widget("trait_button_4", "trait_description_4", true),
	trait_background = {
		scenegraph_id = "item_traits_root",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "top_texture",
					texture_id = "top_texture"
				},
				{
					pass_type = "texture",
					style_id = "bottom_texture",
					texture_id = "bottom_texture"
				},
				{
					texture_id = "center_texture",
					style_id = "center_texture",
					pass_type = "tiled_texture"
				}
			}
		},
		content = {
			center_texture = "traits_background_middle",
			top_texture = "traits_background_top",
			bottom_texture = "traits_background_bottom"
		},
		style = {
			top_texture = {
				scenegraph_id = "item_traits_background_top",
				masked = true
			},
			bottom_texture = {
				scenegraph_id = "item_traits_background_bottom",
				masked = true
			},
			center_texture = {
				scenegraph_id = "item_traits_background_center",
				masked = true,
				texture_tiling_size = {
					503,
					28
				}
			}
		}
	},
	traits_title = UIWidgets.create_simple_text(Localize("item_compare_traits_title"), "item_traits_root", nil, nil, {
		vertical_alignment = "top",
		horizontal_alignment = "center",
		localize = false,
		font_size = 24,
		font_type = "hell_shark_masked",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		offset = {
			0,
			0,
			3
		}
	}),
	scroll_field = {
		scenegraph_id = "window_background",
		element = {
			passes = {
				{
					pass_type = "scroll",
					scroll_function = function (ui_scenegraph, ui_style, ui_content, input_service, scroll_axis)
						local scroll_step = ui_content.scroll_step or 0.1
						local current_scroll_value = ui_content.internal_scroll_value
						current_scroll_value = current_scroll_value + scroll_step * -scroll_axis.y
						ui_content.internal_scroll_value = math.clamp(current_scroll_value, 0, 1)

						return 
					end
				}
			}
		},
		content = {
			internal_scroll_value = 0
		},
		style = {}
	},
	window_title_text = {
		scenegraph_id = "window_title_text",
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
			text = "item_compare_window_title"
		},
		style = {
			text = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				localize = true,
				font_size = 32,
				word_wrap = true,
				font_type = "hell_shark_header",
				text_color = Colors.color_definitions.cheeseburger
			}
		}
	},
	item_info = {
		scenegraph_id = "compare_window",
		element = {
			passes = {
				{
					texture_id = "icon_background_texture",
					style_id = "icon_background_texture",
					pass_type = "texture"
				},
				{
					texture_id = "icon_texture",
					style_id = "icon_texture",
					pass_type = "texture"
				},
				{
					texture_id = "icon_frame_texture",
					style_id = "icon_frame_texture",
					pass_type = "texture"
				},
				{
					style_id = "text_title",
					pass_type = "text",
					text_id = "text_title"
				},
				{
					style_id = "sub_text_title",
					pass_type = "text",
					text_id = "sub_text_title"
				}
			}
		},
		content = {
			icon_frame_texture = "frame_01",
			text_title = "text_title",
			icon_background_texture = "item_slot_01",
			icon_texture = "icons_placeholder",
			sub_text_title = "sub_text_title"
		},
		style = {
			text_title = {
				font_size = 28,
				scenegraph_id = "item_title_text",
				word_wrap = false,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark_header_masked",
				text_color = Colors.color_definitions.green
			},
			icon_texture = {
				scenegraph_id = "item_icon",
				masked = true,
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
			icon_frame_texture = {
				scenegraph_id = "item_icon",
				masked = true,
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
			icon_background_texture = {
				scenegraph_id = "item_icon_background",
				masked = true,
				color = {
					255,
					255,
					255,
					255
				}
			},
			sub_text_title = {
				font_size = 18,
				scenegraph_id = "item_sub_title_text",
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.color_definitions.cheeseburger
			}
		}
	},
	stamina_field = {
		scenegraph_id = "stamina_field",
		element = {
			passes = {
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					pass_type = "multi_texture",
					style_id = "icon_textures",
					texture_id = "icon_textures"
				}
			}
		},
		content = {
			title_text = "item_compare_stamina",
			rect = "rect_masked",
			icon_textures = {
				"fatigue_icon_empty",
				"fatigue_icon_empty",
				"fatigue_icon_empty",
				"fatigue_icon_empty",
				"fatigue_icon_empty",
				"fatigue_icon_empty"
			}
		},
		style = {
			title_text = {
				word_wrap = true,
				localize = true,
				font_size = 24,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					0,
					1
				}
			},
			icon_textures = {
				masked = true,
				texture_sizes = {
					{
						200,
						200
					},
					{
						200,
						200
					},
					{
						200,
						200
					},
					{
						200,
						200
					},
					{
						200,
						200
					},
					{
						200,
						200
					}
				},
				spacing = {
					-175,
					0,
					0
				},
				offset = {
					236,
					-89,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	ammo_field = {
		scenegraph_id = "ammo_field",
		element = {
			passes = {
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "ammo_text_1",
					pass_type = "text",
					text_id = "ammo_text_1"
				},
				{
					style_id = "ammo_text_2",
					pass_type = "text",
					text_id = "ammo_text_2"
				},
				{
					pass_type = "texture",
					style_id = "ammo_divider",
					texture_id = "ammo_divider",
					content_check_function = function (content)
						return content.ammo_text_1 ~= "" and content.ammo_text_2 ~= ""
					end
				}
			}
		},
		content = {
			ammo_divider = "weapon_generic_icons_ammodivider",
			ammo_text_1 = "ammo_text",
			title_text = "item_compare_ammo",
			rect = "rect_masked",
			ammo_text_2 = "ammo_text"
		},
		style = {
			title_text = {
				word_wrap = true,
				localize = true,
				font_size = 24,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					0,
					1
				}
			},
			ammo_text_1 = {
				vertical_alignment = "center",
				dynamic_font = true,
				horizontal_alignment = "right",
				font_size = 24,
				pixel_perfect = false,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					-20,
					0,
					1
				}
			},
			ammo_text_2 = {
				vertical_alignment = "center",
				dynamic_font = true,
				horizontal_alignment = "left",
				font_size = 24,
				pixel_perfect = false,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					450,
					0,
					1
				}
			},
			ammo_divider = {
				masked = true,
				size = {
					8,
					32
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					440,
					-4,
					1
				}
			}
		}
	},
	item_description_field = {
		scenegraph_id = "item_description_field",
		element = {
			passes = {
				{
					style_id = "description_text",
					pass_type = "text",
					text_id = "description_text"
				}
			}
		},
		content = {
			description_text = "placeholder_text"
		},
		style = {
			description_text = {
				font_size = 18,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.color_definitions.white,
				offset = {
					0,
					0,
					1
				}
			}
		}
	}
}
local STATS_BAR_LENGTH = 383

local function create_attack_detailed_info_widget(number_of_entries, scenegraph_id)
	local element_height = 29
	local element_height_spacing = 13
	local element_x_offset = 25
	local bar_tooltip_texts = {
		"inventory_screen_compare_range_tooltip",
		"inventory_screen_compare_knockback_tooltip",
		"inventory_screen_compare_targets_tooltip",
		"inventory_screen_compare_speed_tooltip",
		"inventory_screen_compare_damage_tooltip"
	}
	local widget_definition = {
		element = {
			passes = {
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "perk_text",
					pass_type = "text",
					text_id = "perk_text",
					content_check_function = function (content)
						return content.use_perks
					end
				},
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					style_id = "compare_window_hotspot",
					pass_type = "hotspot",
					content_id = "compare_window_hotspot"
				}
			}
		},
		content = {
			title_text = "placeholder_text",
			bar_edge_marker = "compare_divider",
			frame = "stats_window",
			bar_frame = "compare_bar_fg",
			use_perks = false,
			number_of_bars = 5,
			rect_masked = "rect_masked",
			background = "compare_window_bg_small",
			perk_text = "",
			compare_window_hotspot = {},
			bar_1 = {
				texture_id = "compare_bar_white",
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
			bar_2 = {
				texture_id = "compare_bar_white",
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
			}
		},
		style = {
			compare_window_hotspot = {
				scenegraph_id = "compare_window_mask"
			},
			background = {
				masked = true
			},
			frame = {
				masked = true,
				color = {
					255,
					255,
					255,
					255
				}
			},
			title_text = {
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.color_definitions.cheeseburger,
				offset = {
					0,
					35,
					1
				}
			},
			perk_text = {
				word_wrap = true,
				localize = false,
				font_size = 18,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "bottom",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.color_definitions.green,
				offset = {
					element_x_offset,
					20,
					1
				}
			},
			tooltip_text = default_tooltip_style
		},
		scenegraph_id = scenegraph_id
	}

	for i = 1, number_of_entries, 1 do
		local bar_y_position = (i ~= 1 and element_height_spacing + element_height) or 62
		local bar_x_position = (i == 1 or 0) and element_x_offset
		local bar_parent = (i ~= 1 and scenegraph_id .. "_stats_bar_icon_" .. i - 1) or scenegraph_id
		local stats_bar_icon_scenegraph_id = scenegraph_id .. "_stats_bar_icon_" .. i
		local bar_icon = "bar_icon_" .. i
		scenegraph_definition[stats_bar_icon_scenegraph_id] = {
			vertical_alignment = "bottom",
			horizontal_alignment = "left",
			parent = bar_parent,
			size = {
				20,
				20
			},
			position = {
				bar_x_position,
				bar_y_position,
				2
			}
		}
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "texture",
			style_id = bar_icon,
			texture_id = bar_icon,
			content_check_function = function (content)
				return number_of_entries - content.number_of_bars < i
			end
		}
		widget_definition.content[bar_icon] = stats_icons_masked[i]
		widget_definition.style[bar_icon] = {
			masked = true,
			scenegraph_id = stats_bar_icon_scenegraph_id,
			color = {
				255,
				255,
				255,
				255
			}
		}
		local stats_bar_frame_scenegraph_id = scenegraph_id .. "_stats_bar_frame_" .. i
		local bar_frame = "bar_frame_" .. i
		scenegraph_definition[stats_bar_frame_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = stats_bar_icon_scenegraph_id,
			size = {
				397,
				27
			},
			position = {
				40,
				0,
				4
			}
		}
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "texture",
			texture_id = "bar_frame",
			style_id = bar_frame
		}
		widget_definition.style[bar_frame] = {
			masked = true,
			scenegraph_id = stats_bar_frame_scenegraph_id,
			color = {
				255,
				255,
				255,
				255
			}
		}
		local stats_bar_title_scenegraph_id = scenegraph_id .. "_stats_bar_title_" .. i
		local bar_title = "bar_title_" .. i
		scenegraph_definition[stats_bar_title_scenegraph_id] = {
			vertical_alignment = "bottom",
			horizontal_alignment = "left",
			parent = stats_bar_frame_scenegraph_id,
			size = {
				397,
				27
			},
			position = {
				0,
				24,
				4
			}
		}
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "text",
			text_id = bar_title,
			style_id = bar_title,
			content_check_function = function (content)
				return number_of_entries - content.number_of_bars < i
			end
		}
		widget_definition.style[bar_title] = {
			font_size = 14,
			word_wrap = false,
			horizontal_alignment = "left",
			vertical_alignment = "bottom",
			masked = true,
			font_type = "hell_shark_masked",
			scenegraph_id = stats_bar_title_scenegraph_id,
			text_color = Colors.color_definitions.white,
			offset = {
				0,
				0,
				1
			}
		}
		local bar_background = "bar_background_" .. i
		local bar_background_active = "bar_background_active_" .. i
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "texture",
			texture_id = bar_background,
			style_id = bar_background
		}
		widget_definition.style[bar_background] = {
			masked = true,
			scenegraph_id = stats_bar_frame_scenegraph_id,
			size = {
				STATS_BAR_LENGTH,
				9
			},
			offset = {
				7,
				11,
				-3
			}
		}
		widget_definition.content[bar_background] = "compare_bar_disabled"
		widget_definition.content[bar_background_active] = false
		local stats_bar_scenegraph_id = scenegraph_id .. "_stats_bar_" .. i
		local bar = "bar_" .. i
		scenegraph_definition[stats_bar_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = stats_bar_frame_scenegraph_id,
			size = {
				STATS_BAR_LENGTH,
				9
			},
			position = {
				6,
				2,
				-1
			}
		}
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "texture_uv",
			content_id = "bar_1",
			style_id = bar
		}
		widget_definition.style[bar] = {
			masked = true,
			scenegraph_id = stats_bar_scenegraph_id,
			color = {
				255,
				255,
				255,
				255
			}
		}
		local stats_compare_bar_scenegraph_id = scenegraph_id .. "_stats_compare_bar_" .. i
		local compare_bar = "compare_bar_" .. i
		scenegraph_definition[stats_compare_bar_scenegraph_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = stats_bar_frame_scenegraph_id,
			size = {
				STATS_BAR_LENGTH,
				9
			},
			position = {
				6,
				2,
				-2
			}
		}
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "texture_uv",
			content_id = "bar_2",
			style_id = compare_bar
		}
		widget_definition.style[compare_bar] = {
			masked = true,
			scenegraph_id = stats_compare_bar_scenegraph_id,
			color = {
				255,
				255,
				255,
				255
			}
		}
		local stats_bar_edge_marker_scenegraph_id = scenegraph_id .. "_stats_bar_edge_marker_" .. i
		local bar_edge_marker = "bar_edge_marker_" .. i
		scenegraph_definition[stats_bar_edge_marker_scenegraph_id] = {
			vertical_alignment = "bottom",
			horizontal_alignment = "left",
			parent = stats_bar_scenegraph_id,
			size = {
				25,
				26
			},
			position = {
				0,
				-8.5,
				1
			}
		}
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "texture",
			texture_id = "bar_edge_marker",
			style_id = bar_edge_marker,
			content_check_function = function (content)
				return number_of_entries - content.number_of_bars < i
			end
		}
		widget_definition.style[bar_edge_marker] = {
			masked = true,
			scenegraph_id = stats_bar_edge_marker_scenegraph_id,
			offset = {
				-12,
				0,
				0
			}
		}
		local bar_tooltip_hotspot = "bar_tooltip_hotspot_" .. i
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			pass_type = "hotspot",
			content_id = bar_tooltip_hotspot,
			style_id = bar_tooltip_hotspot
		}
		widget_definition.style[bar_tooltip_hotspot] = {
			scenegraph_id = stats_bar_icon_scenegraph_id,
			size = {
				437,
				20
			}
		}
		widget_definition.content[bar_tooltip_hotspot] = {}
		local bar_tooltip_text = "bar_tooltip_text_" .. i
		widget_definition.element.passes[#widget_definition.element.passes + 1] = {
			style_id = "tooltip_text",
			pass_type = "tooltip_text",
			text_id = bar_tooltip_text,
			content_check_function = function (ui_content)
				return ui_content["bar_background_active_" .. i] and ui_content[bar_tooltip_hotspot].is_hover and ui_content.compare_window_hotspot.is_hover
			end
		}
		local display_text = Localize(bar_tooltip_texts[i])
		widget_definition.content[bar_title] = display_text
		widget_definition.content[bar_tooltip_text] = display_text
	end

	return UIWidget.init(widget_definition)
end

local simple_texture_template = {
	scenegraph_id = "",
	element = UIElements.SimpleTexture,
	content = {
		texture_id = ""
	},
	style = {}
}

local function create_simple_texture_widget(texture_id, scenegraph_id, style)
	local texture_template = table.clone(simple_texture_template)
	texture_template.content.texture_id = texture_id
	texture_template.scenegraph_id = scenegraph_id

	if style then
		texture_template.style = style
	end

	return UIWidget.init(texture_template)
end

return {
	scenegraph_definition = scenegraph_definition,
	create_simple_texture_widget = create_simple_texture_widget,
	widgets = widget_definitions,
	create_attack_detailed_info_widget = create_attack_detailed_info_widget,
	STATS_BAR_LENGTH = STATS_BAR_LENGTH
}
