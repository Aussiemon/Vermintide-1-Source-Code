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
	dead_space_filler = {
		scale = "fit",
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
	background = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			-10,
			1
		}
	},
	contents_list = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			680,
			650
		},
		position = {
			240,
			-260,
			1
		}
	},
	contents_title = {
		vertical_alignment = "top",
		parent = "contents_list",
		horizontal_alignment = "center",
		size = {
			600,
			90
		},
		position = {
			0,
			120,
			1
		}
	},
	contents_title_divider = {
		vertical_alignment = "bottom",
		parent = "contents_title",
		horizontal_alignment = "center",
		size = {
			289,
			31
		},
		position = {
			0,
			-30,
			1
		}
	},
	page_content = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			640,
			700
		},
		position = {
			1080,
			-190,
			1
		}
	},
	page_title = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			640,
			90
		},
		position = {
			0,
			95,
			1
		}
	},
	front_page_title_image = {
		vertical_alignment = "center",
		parent = "contents_list",
		horizontal_alignment = "center",
		size = {
			724,
			316
		},
		position = {
			0,
			250,
			1
		}
	},
	front_page_new_icon = {
		vertical_alignment = "bottom",
		parent = "contents_list",
		horizontal_alignment = "left",
		size = {
			30,
			30
		},
		position = {
			-30,
			0,
			1
		}
	},
	front_page_lock_icon = {
		vertical_alignment = "bottom",
		parent = "contents_list",
		horizontal_alignment = "left",
		size = {
			30,
			30
		},
		position = {
			-30,
			-30,
			1
		}
	},
	front_page_new_icon_text = {
		vertical_alignment = "center",
		parent = "front_page_new_icon",
		horizontal_alignment = "left",
		size = {
			500,
			30
		},
		position = {
			35,
			0,
			1
		}
	},
	front_page_lock_icon_text = {
		vertical_alignment = "center",
		parent = "front_page_lock_icon",
		horizontal_alignment = "left",
		size = {
			500,
			30
		},
		position = {
			35,
			0,
			1
		}
	},
	front_page_description_text = {
		vertical_alignment = "bottom",
		parent = "front_page_title_image",
		horizontal_alignment = "center",
		size = {
			500,
			150
		},
		position = {
			0,
			-200,
			1
		}
	},
	paragraph_divider_large = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			430,
			20
		},
		position = {
			105,
			0,
			1
		}
	},
	paragraph_divider_medium = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			200,
			20
		},
		position = {
			220,
			0,
			1
		}
	},
	paragraph_divider_small = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			14,
			20
		},
		position = {
			313,
			0,
			1
		}
	},
	page_image_1 = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_image_2 = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	lorebook_front_page_collectible_title = {
		vertical_alignment = "top",
		parent = "lorebook_front_page_image",
		horizontal_alignment = "center",
		size = {
			600,
			50
		},
		position = {
			0,
			280,
			1
		}
	},
	lorebook_front_page_collectible_counter = {
		vertical_alignment = "center",
		parent = "lorebook_front_page_collectible_title",
		horizontal_alignment = "center",
		size = {
			600,
			50
		},
		position = {
			0,
			-125,
			1
		}
	},
	lorebook_front_page_collectible_divider = {
		vertical_alignment = "center",
		parent = "lorebook_front_page_collectible_title",
		horizontal_alignment = "center",
		size = {
			289,
			31
		},
		position = {
			0,
			-65,
			1
		}
	},
	lorebook_front_page_image = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			730,
			390
		},
		position = {
			15,
			-20,
			1
		}
	},
	tutorial_front_page_image = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			696,
			406
		},
		position = {
			15,
			-20,
			1
		}
	},
	next_page_button = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			33,
			24
		},
		position = {
			44,
			-48,
			1
		}
	},
	previous_page_button = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			33,
			24
		},
		position = {
			-44,
			-48,
			1
		}
	},
	page_count = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			60,
			34
		},
		position = {
			0,
			-54,
			1
		}
	},
	exit_button = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-50,
			40,
			2
		}
	},
	tab_button_1 = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			90,
			162
		},
		position = {
			53,
			-216,
			1
		}
	},
	tab_button_2 = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			87,
			156
		},
		position = {
			58,
			-458,
			1
		}
	},
	page_back_button = {
		vertical_alignment = "bottom",
		parent = "contents_list",
		horizontal_alignment = "left",
		size = {
			52,
			52
		},
		position = {
			-70,
			0,
			2
		}
	},
	page_index_path = {
		vertical_alignment = "center",
		parent = "page_back_button",
		horizontal_alignment = "left",
		size = {
			700,
			50
		},
		position = {
			60,
			0,
			1
		}
	},
	page_reveal_mask_cover = {
		vertical_alignment = "center",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			800,
			850
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_1 = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_2 = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_3 = {
		vertical_alignment = "top",
		parent = "page_content",
		horizontal_alignment = "right",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_4 = {
		vertical_alignment = "center",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_5 = {
		vertical_alignment = "center",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_6 = {
		vertical_alignment = "center",
		parent = "page_content",
		horizontal_alignment = "right",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_7 = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "left",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_8 = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_root_9 = {
		vertical_alignment = "bottom",
		parent = "page_content",
		horizontal_alignment = "right",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_1 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_1",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_2 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_2",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_3 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_3",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_4 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_4",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_5 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_5",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_6 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_6",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_7 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_7",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_8 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_8",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	},
	page_reveal_mask_9 = {
		vertical_alignment = "center",
		parent = "page_reveal_mask_root_9",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			0,
			1
		}
	}
}
local BUTTON_TYPES = {
	confirm = "(A)",
	back = "(B)"
}

local function create_gamepad_button_widget(button_type, scenegraph_id)
	return {
		element = UIElements.GamepadButton(button_type),
		content = {
			texture_click_id = "small_button_gold_selected",
			texture_id = "small_button_gold_normal",
			texture_hover_id = "small_button_gold_hover",
			text_field = "",
			button_hotspot = {},
			gamepad_button = {
				is_clicked = 10
			},
			button_type_text_field = BUTTON_TYPES[button_type]
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
					4
				}
			},
			button_type_text = {
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = 24,
				horizontal_alignment = "left",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					60,
					2,
					4
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
end

local masked = false
local page_masked = true
local page_reveal_mask_textures = {
	"journal_gradient_01",
	"journal_gradient_02",
	"journal_gradient_03",
	"journal_gradient_04",
	"journal_gradient_05",
	"journal_gradient_01",
	"journal_gradient_02",
	"journal_gradient_03",
	"journal_gradient_04"
}
local widget_definitions = {
	title_text = UIWidgets.create_title_text("contents_title", "title_text"),
	page_back_button = UIWidgets.create_journal_back_arrow_button("page_back_button", masked),
	page_index_path = UIWidgets.create_simple_text("", "page_index_path", 18, Colors.get_color_table_with_alpha("black", 160), nil, "hell_shark"),
	tab_button_1 = UIWidgets.create_journal_tab("tab_button_1", "journal_tab_02", masked),
	tab_button_2 = UIWidgets.create_journal_tab("tab_button_2", "journal_tab_01", masked),
	exit_button = UIWidgets.create_menu_button_medium("close", "exit_button"),
	contents_title_divider = UIWidgets.create_simple_texture("journal_divider", "contents_title_divider", masked),
	lorebook_front_page_image = UIWidgets.create_simple_texture("journal_image_large_01", "lorebook_front_page_image", masked),
	lorebook_front_page_collectible_title = UIWidgets.create_simple_text("dlc1_3_lorebook_collectibles_title", "lorebook_front_page_collectible_title", 52, Colors.get_color_table_with_alpha("black", 160), nil, "hell_shark_header"),
	lorebook_front_page_collectible_counter = UIWidgets.create_simple_text("", "lorebook_front_page_collectible_counter", 32, Colors.get_color_table_with_alpha("black", 160), nil, "hell_shark"),
	lorebook_front_page_collectible_divider = UIWidgets.create_simple_texture("journal_divider", "lorebook_front_page_collectible_divider", masked),
	tutorial_front_page_image = UIWidgets.create_simple_texture("journal_image_10", "tutorial_front_page_image", masked),
	front_page_new_icon = UIWidgets.create_simple_texture("journal_icon_02", "front_page_new_icon", masked),
	front_page_lock_icon = UIWidgets.create_simple_texture("journal_icon_01", "front_page_lock_icon", masked),
	front_page_title_image = UIWidgets.create_simple_texture("journal_vermintide_logo", "front_page_title_image", masked),
	front_page_new_icon_text = UIWidgets.create_simple_text("dlc1_3_journal_new_icon_description", "front_page_new_icon_text", 18, Colors.get_color_table_with_alpha("black", 160), nil, "hell_shark"),
	front_page_lock_icon_text = UIWidgets.create_simple_text("dlc1_3_journal_lock_icon_description", "front_page_lock_icon_text", 18, Colors.get_color_table_with_alpha("black", 160), nil, "hell_shark"),
	front_page_description_text = UIWidgets.create_simple_text("dlc1_3_journal_front_page_description", "front_page_description_text", 20, Colors.get_color_table_with_alpha("black", 160), nil, "hell_shark"),
	page_reveal_mask = UIWidgets.create_journal_reveal_mask(page_reveal_mask_textures, {
		"page_reveal_mask_1",
		"page_reveal_mask_2",
		"page_reveal_mask_3",
		"page_reveal_mask_4",
		"page_reveal_mask_5",
		"page_reveal_mask_6",
		"page_reveal_mask_7",
		"page_reveal_mask_8",
		"page_reveal_mask_9"
	}, "page_reveal_mask_cover"),
	contents_title = {
		scenegraph_id = "contents_title",
		element = UIElements.StaticText,
		content = {
			text_field = ""
		},
		style = {
			text = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				localize = true,
				font_size = 55,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("black", 160),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	page_title = {
		scenegraph_id = "page_title",
		element = UIElements.StaticText,
		content = {
			text_field = ""
		},
		style = {
			text = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				localize = false,
				font_size = 32,
				font_type = "hell_shark_header",
				text_color = Colors.get_color_table_with_alpha("black", 160),
				masked = page_masked,
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	page_content = {
		scenegraph_id = "page_content",
		element = UIElements.LorebookMultipleTexts,
		content = {
			max_texts = 18,
			text_start_index = 1,
			text_field = "page_content",
			text_exclusion_zones = {
				top = {
					active = false
				},
				bottom = {
					active = false
				}
			}
		},
		style = {
			text = {
				font_size = 20,
				word_wrap = true,
				localize = false,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("black", 160),
				masked = page_masked,
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	paragraph_divider_large = {
		scenegraph_id = "paragraph_divider_large",
		element = {
			passes = {
				{
					pass_type = "lorebook_paragraph_divider",
					style_id = "texture_id",
					texture_id = "texture_id"
				}
			}
		},
		content = {
			texture_id = "journal_content_divider_large",
			positions = {}
		},
		style = {
			texture_id = {
				color = {
					191,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				},
				masked = page_masked
			}
		}
	},
	paragraph_divider_medium = {
		scenegraph_id = "paragraph_divider_medium",
		element = {
			passes = {
				{
					pass_type = "lorebook_paragraph_divider",
					style_id = "texture_id",
					texture_id = "texture_id"
				}
			}
		},
		content = {
			texture_id = "journal_content_divider_medium",
			positions = {}
		},
		style = {
			texture_id = {
				color = {
					191,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				},
				masked = page_masked
			}
		}
	},
	paragraph_divider_small = {
		scenegraph_id = "paragraph_divider_small",
		element = {
			passes = {
				{
					pass_type = "lorebook_paragraph_divider",
					style_id = "texture_id",
					texture_id = "texture_id"
				}
			}
		},
		content = {
			texture_id = "journal_content_divider_small",
			positions = {}
		},
		style = {
			texture_id = {
				color = {
					191,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				},
				masked = page_masked
			}
		}
	},
	page_image_1 = {
		scenegraph_id = "page_image_1",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "texture_id",
					texture_id = "texture_id"
				}
			}
		},
		content = {
			vertical_alignment = "left",
			texture_id = "crosshair_01_horizontal",
			horizontal_alignment = "top",
			size = {
				0,
				0
			},
			element = UIElements.SimpleTexture
		},
		style = {
			texture_id = {
				masked = page_masked
			}
		}
	},
	page_image_2 = {
		scenegraph_id = "page_image_2",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "texture_id",
					texture_id = "texture_id"
				}
			}
		},
		content = {
			vertical_alignment = "left",
			texture_id = "crosshair_01_horizontal",
			horizontal_alignment = "top",
			size = {
				0,
				0
			},
			element = UIElements.SimpleTexture
		},
		style = {
			texture_id = {
				masked = page_masked
			}
		}
	},
	page_count = {
		scenegraph_id = "page_count",
		element = UIElements.StaticText,
		content = {
			text_field = "/"
		},
		style = {
			text = {
				vertical_alignment = "center",
				dynamic_font = true,
				horizontal_alignment = "center",
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("black", 160),
				offset = {
					0,
					0,
					2
				}
			}
		}
	},
	next_page_button = UIWidgets.create_journal_page_arrow_button("next_page_button", {
		{
			1,
			0
		},
		{
			0,
			1
		}
	}),
	previous_page_button = UIWidgets.create_journal_page_arrow_button("previous_page_button"),
	dead_space_filler = {
		scenegraph_id = "dead_space_filler",
		element = {
			passes = {
				{
					pass_type = "rect"
				}
			}
		},
		content = {},
		style = {
			color = {
				255,
				0,
				0,
				0
			}
		}
	}
}
local contents_list_definition = {
	scenegraph_id = "contents_list",
	element = {
		passes = {
			{
				style_id = "list_style",
				pass_type = "list_pass",
				content_id = "list_content",
				passes = {
					{
						style_id = "hotspot",
						pass_type = "hotspot",
						content_id = "button_hotspot",
						content_check_function = function (content, style)
							return not content.selected and content.visible and content.available
						end
					},
					{
						style_id = "name",
						pass_type = "text",
						text_id = "name",
						content_check_function = function (content, style)
							return content.visible
						end
					},
					{
						pass_type = "texture",
						style_id = "hover_texture_left",
						texture_id = "hover_texture_left",
						content_check_function = function (content)
							return not content.selected and (content.button_hotspot.is_hover or content.gamepad_hover)
						end
					},
					{
						pass_type = "texture",
						style_id = "hover_texture_right",
						texture_id = "hover_texture_right",
						content_check_function = function (content)
							return not content.selected and (content.button_hotspot.is_hover or content.gamepad_hover)
						end
					},
					{
						pass_type = "texture",
						style_id = "new_texture_left",
						texture_id = "new_texture",
						content_check_function = function (content)
							return content.new and content.visible
						end
					},
					{
						pass_type = "texture",
						style_id = "new_texture_right",
						texture_id = "new_texture",
						content_check_function = function (content)
							return content.new and content.visible
						end
					},
					{
						pass_type = "texture",
						style_id = "locked_texture_left",
						texture_id = "locked_texture",
						content_check_function = function (content)
							return not content.unlocked and content.visible
						end
					},
					{
						pass_type = "texture",
						style_id = "locked_texture_right",
						texture_id = "locked_texture",
						content_check_function = function (content)
							return not content.unlocked and content.visible
						end
					},
					{
						pass_type = "texture",
						style_id = "selected_texture_left",
						texture_id = "selected_texture_left",
						content_check_function = function (content)
							return content.selected
						end
					},
					{
						pass_type = "texture",
						style_id = "selected_texture_right",
						texture_id = "selected_texture_right",
						content_check_function = function (content)
							return content.selected
						end
					}
				}
			}
		}
	},
	content = {
		list_content = {}
	},
	style = {
		list_style = {
			columns = 1,
			scenegraph_id = "contents_list",
			start_index = 1,
			horizontal_alignment = "center",
			vertical_alignment = "top",
			num_draws = 0,
			column_offset = 0,
			offset = {
				0,
				-30,
				0
			},
			item_styles = {},
			list_member_offset = {
				0,
				-50,
				0
			}
		}
	}
}
local simple_texture_template = {
	scenegraph_id = "",
	element = UIElements.SimpleTexture,
	content = {
		texture_id = ""
	},
	style = {}
}

local function create_simple_texture_widget(texture_id, scenegraph_id)
	simple_texture_template.content.texture_id = texture_id
	simple_texture_template.scenegraph_id = scenegraph_id

	return UIWidget.init(simple_texture_template)
end

local temp_texture_values = {}
local animations = {
	on_element_select = {
		{
			name = "fade",
			scale_duration_by_speed = true,
			start_progress = 0,
			end_progress = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				local contents_list = widgets[1]
				local contents_list_style = contents_list.style.list_style
				local item_styles = contents_list_style.item_styles
				local select_index = params.select_index
				local selected_item_style = item_styles[select_index]
				local left_texture_color = selected_item_style.selected_texture_left.color
				local right_texture_color = selected_item_style.selected_texture_right.color
				left_texture_color[1] = 0
				right_texture_color[1] = 0

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local contents_list = widgets[1]
				local contents_list_style = contents_list.style.list_style
				local item_styles = contents_list_style.item_styles
				local select_alpha = local_progress*255
				local select_index = params.select_index
				local selected_item_style = item_styles[select_index]
				local left_texture_color = selected_item_style.selected_texture_left.color
				local right_texture_color = selected_item_style.selected_texture_right.color
				local alpha = select_alpha

				if left_texture_color[1] < alpha then
					left_texture_color[1] = alpha
					right_texture_color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	on_element_hover = {
		{
			name = "fade",
			scale_duration_by_speed = true,
			start_progress = 0,
			end_progress = 0.2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local contents_list = widgets[1]
				local contents_list_content = contents_list.content.list_content
				local contents_list_style = contents_list.style.list_style
				local item_styles = contents_list_style.item_styles
				local start_index = contents_list_style.start_index
				local num_draws = contents_list_style.num_draws - 1
				local stop_index = math.min(start_index + num_draws, #contents_list_content)
				local hover_alpha = local_progress*255
				local hover_index = params.hover_index

				for i = start_index, stop_index, 1 do
					local is_hover_element = i == hover_index
					local left_texture_color = item_styles[i].hover_texture_left.color
					local right_texture_color = item_styles[i].hover_texture_right.color

					if is_hover_element then
						local alpha = hover_alpha

						if left_texture_color[1] < alpha then
							left_texture_color[1] = alpha
							right_texture_color[1] = alpha
						end
					else
						local alpha = hover_alpha - 255

						if alpha < left_texture_color[1] then
							left_texture_color[1] = alpha
							right_texture_color[1] = alpha
						end
					end
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	},
	page_reveal = {
		{
			name = "start",
			start_progress = 0,
			end_progress = 1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				table.shuffle(page_reveal_mask_textures)

				local widget = widgets[1]
				local widget_style = widget.style
				local num_textures = widget.content.num_textures

				for i = 1, num_textures, 1 do
					local style_id = "texture_" .. i
					local texture_style = widget_style[style_id]
					local texture_scenegraph_id = texture_style.scenegraph_id
					local texture_size = ui_scenegraph[texture_scenegraph_id].size
					local size = Math.random_range(300, 1000)
					texture_size[1] = 0
					texture_size[2] = 0
					texture_style.color[1] = 0
					temp_texture_values[i] = {
						alpha_speed_multiplier = Math.random_range(1, 3),
						size_speed_multiplier = Math.random_range(1, 3),
						width_value = size,
						height_value = size
					}
				end

				widget_style.cover_rect.color[1] = 0

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local widget_style = widget.style
				local widget_content = widget.content
				local num_textures = widget.content.num_textures

				for i = 1, num_textures, 1 do
					local style_id = "texture_" .. i
					local texture_style = widget_style[style_id]
					local widget_texture_value = temp_texture_values[i]
					local texture_scenegraph_id = texture_style.scenegraph_id
					local ui_scenegraph_definition = ui_scenegraph[texture_scenegraph_id]
					local texture_size = ui_scenegraph_definition.size
					local local_position = ui_scenegraph_definition.local_position
					local random_texture = page_reveal_mask_textures[i]
					widget_content[style_id] = random_texture
					local size_speed_multiplier = widget_texture_value.size_speed_multiplier
					local size_progress = math.min(1, local_progress*size_speed_multiplier)
					texture_size[1] = local_progress*widget_texture_value.width_value
					texture_size[2] = local_progress*widget_texture_value.height_value
					local alpha_speed_multiplier = widget_texture_value.alpha_speed_multiplier
					local alpha_progress = math.min(1, local_progress*size_speed_multiplier)
					texture_style.color[1] = alpha_progress*255
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "full rect",
			start_progress = 1,
			end_progress = 2,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local widget = widgets[1]
				local widget_style = widget.style
				widget_style.cover_rect.color[1] = local_progress*255

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}
local generic_input_actions = {
	{
		input_action = "l2_r2",
		priority = 1,
		description_text = "dlc1_3_input_description_switch_tab",
		ignore_keybinding = true
	}
}
local input_actions = {
	default = {
		{
			input_action = "back",
			priority = 49,
			description_text = "input_description_close"
		}
	},
	selection = {
		{
			input_action = "d_vertical",
			priority = 2,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "confirm",
			priority = 3,
			description_text = "input_description_select"
		},
		{
			input_action = "back",
			priority = 49,
			description_text = "input_description_back"
		}
	},
	selection_includes_pages = {
		{
			input_action = "d_vertical",
			priority = 2,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "confirm",
			priority = 3,
			description_text = "input_description_select"
		},
		{
			input_action = "l1_r1",
			priority = 4,
			description_text = "dlc1_3_input_description_change_page",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 49,
			description_text = "input_description_back"
		}
	},
	selection_locked = {
		{
			input_action = "d_vertical",
			priority = 2,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 49,
			description_text = "input_description_back"
		}
	},
	selection_locked_includes_pages = {
		{
			input_action = "d_vertical",
			priority = 2,
			description_text = "input_description_navigate",
			ignore_keybinding = true
		},
		{
			input_action = "l1_r1",
			priority = 4,
			description_text = "dlc1_3_input_description_change_page",
			ignore_keybinding = true
		},
		{
			input_action = "back",
			priority = 49,
			description_text = "input_description_back"
		}
	}
}

return {
	generic_input_actions = generic_input_actions,
	input_actions = input_actions,
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	contents_list_definition = contents_list_definition,
	create_simple_texture_widget = create_simple_texture_widget,
	animations = animations
}
