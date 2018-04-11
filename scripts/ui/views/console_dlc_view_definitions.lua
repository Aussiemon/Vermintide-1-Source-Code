local IMAGE_SIZE = {
	960,
	540
}
local VIDEO_DELAY = 3
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.default + 10
		},
		size = {
			1920,
			1080
		}
	},
	root_filler = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
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
	tab = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "right",
		size = {
			300,
			60
		},
		position = {
			-28,
			-75,
			10
		}
	},
	dlc_data_root = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			600,
			800
		}
	},
	dlc_logo_text = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "left",
		size = {
			700,
			500
		}
	},
	dlc_image_root = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "right",
		size = IMAGE_SIZE,
		position = {
			-100,
			-200,
			1
		}
	},
	dlc_image_entry = {
		vertical_alignment = "top",
		parent = "dlc_image_root",
		horizontal_alignment = "right",
		size = IMAGE_SIZE,
		position = {
			0,
			0,
			1
		}
	},
	dlc_skin_image_entry = {
		vertical_alignment = "top",
		parent = "dlc_image_entry",
		horizontal_alignment = "right",
		size = IMAGE_SIZE,
		position = {
			IMAGE_SIZE[1] * 1.25,
			0,
			1
		}
	},
	frame_divider = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		position = {
			420,
			-90,
			2
		},
		size = {
			36,
			746
		}
	},
	left_frame = {
		vertical_alignment = "bottom",
		parent = "background",
		horizontal_alignment = "left",
		position = {
			40,
			88,
			2
		},
		size = {
			364,
			902
		}
	},
	right_frame = {
		vertical_alignment = "bottom",
		parent = "left_frame",
		horizontal_alignment = "right",
		position = {
			1455,
			37,
			2
		},
		size = {
			1420,
			902
		}
	},
	left_frame_glow = {
		vertical_alignment = "center",
		parent = "frame_divider",
		horizontal_alignment = "center",
		position = {
			-72,
			0,
			-1
		},
		size = {
			144,
			758
		}
	},
	right_frame_glow = {
		vertical_alignment = "center",
		parent = "frame_divider",
		horizontal_alignment = "center",
		position = {
			72,
			0,
			-1
		},
		size = {
			144,
			758
		}
	},
	gamepad_tooltip_text = {
		vertical_alignment = "top",
		parent = "right_frame",
		horizontal_alignment = "left",
		position = {
			18,
			-30,
			3
		},
		size = {
			820,
			762
		}
	},
	gamepad_reset_text = {
		vertical_alignment = "bottom",
		parent = "right_frame",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			600,
			60
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-10,
			2
		},
		size = {
			480,
			28
		}
	},
	list_mask = {
		vertical_alignment = "top",
		parent = "dlc_image_root",
		horizontal_alignment = "right",
		position = {
			0,
			0,
			2
		},
		size = {
			IMAGE_SIZE[1],
			IMAGE_SIZE[2] - 100
		}
	},
	list_edge_fade_top = {
		vertical_alignment = "top",
		parent = "list_mask",
		horizontal_alignment = "right",
		position = {
			0,
			25,
			2
		},
		size = {
			IMAGE_SIZE[1],
			25
		}
	},
	list_edge_fade_bottom = {
		vertical_alignment = "bottom",
		parent = "list_mask",
		horizontal_alignment = "right",
		position = {
			0,
			-250,
			2
		},
		size = {
			IMAGE_SIZE[1],
			250
		}
	},
	scrollbar_root = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "right",
		position = {
			-50,
			20,
			100
		},
		size = {
			26,
			750
		}
	}
}
local gamepad_frame_widget_definitions = {
	gamepad_button_selection = UIWidgets.create_gamepad_selection("settings_button_gamepad_selection", nil, nil, {
		70,
		70
	}),
	left_frame_glow = UIWidgets.create_simple_texture("options_menu_divider_glow_01", "left_frame_glow"),
	right_frame_glow = UIWidgets.create_simple_texture("options_menu_divider_glow_02", "right_frame_glow")
}
local background_widget_definitions = {
	background = {
		scenegraph_id = "background",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "large_frame_01"
		},
		style = {}
	},
	right_frame = {
		scenegraph_id = "right_frame",
		element = {
			passes = {
				{
					style_id = "edge_fade_top_id",
					pass_type = "texture_uv",
					content_id = "edge_fade_top_id"
				},
				{
					style_id = "edge_fade_bottom_id",
					pass_type = "texture_uv",
					content_id = "edge_fade_bottom_id"
				},
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
			internal_scroll_value = 0,
			edge_fade_top_id = {
				texture_id = "mask_rect_edge_fade",
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
			edge_fade_bottom_id = {
				texture_id = "mask_rect_edge_fade",
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
			}
		},
		style = {
			edge_fade_bottom_id = {
				scenegraph_id = "list_edge_fade_bottom",
				color = {
					255,
					255,
					255,
					255
				}
			},
			edge_fade_top_id = {
				scenegraph_id = "list_edge_fade_top",
				color = {
					255,
					255,
					255,
					255
				}
			},
			test_bottom = {
				scenegraph_id = "list_edge_fade_bottom",
				color = {
					30,
					255,
					0,
					255
				}
			},
			test_top = {
				scenegraph_id = "list_edge_fade_top",
				color = {
					30,
					255,
					255,
					255
				}
			}
		}
	},
	list_mask = {
		scenegraph_id = "list_mask",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "mask_rect"
		},
		style = {
			color = {
				255,
				255,
				255,
				255
			}
		}
	},
	title_text = UIWidgets.create_title_text("console_dlc_view_title", "title_text"),
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

local function find_skin_settings(dlc_name)
	for name, skin_settings in pairs(SkinSettings) do
		if skin_settings.dlc_name == dlc_name then
			return skin_settings
		end
	end

	return nil
end

local function create_dlc_entry(scenegraph_id, offset_y, texture_id, dlc_name, video_material_name, bg_overlay_id, id, is_dlc_unlocked)
	local widget = {}
	local widget_color = {
		60,
		255,
		255,
		255
	}
	local frame_color = {
		255,
		255,
		255,
		255
	}
	local element = {
		passes = {
			{
				pass_type = "texture",
				style = "image",
				texture_id = "texture_id",
				content_check_function = function (content, style)
					if not content.id and not Managers.unlock:is_dlc_unlocked(content.dlc_name) then
						style.color[2] = 60
						style.color[3] = 60
						style.color[4] = 60
					else
						style.color[2] = 255
						style.color[3] = 255
						style.color[4] = 255
					end

					return true
				end
			},
			{
				pass_type = "texture",
				style_id = "bg_overlay",
				texture_id = "bg_overlay_id"
			},
			{
				style_id = "video_style",
				pass_type = "video",
				content_id = "video_content",
				content_check_function = function (content)
					return content.video_player_created and content.video_name
				end
			},
			{
				style_id = "corner_top_left",
				pass_type = "texture_uv",
				content_id = "corner_top_left",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "corner_top_right",
				pass_type = "texture_uv",
				content_id = "corner_top_right",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "corner_bottom_left",
				pass_type = "texture_uv",
				content_id = "corner_bottom_left",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "corner_bottom_right",
				pass_type = "texture_uv",
				content_id = "corner_bottom_right",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "edge_top",
				pass_type = "texture_uv",
				content_id = "edge_top",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "edge_bottom",
				pass_type = "texture_uv",
				content_id = "edge_bottom",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "edge_left",
				pass_type = "texture_uv",
				content_id = "edge_left",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				style_id = "edge_right",
				pass_type = "texture_uv",
				content_id = "edge_right",
				content_check_function = function (content, style)
					style.color[2] = style.parent.color[1]
					style.color[3] = style.parent.color[1]
					style.color[4] = style.parent.color[1]

					return true
				end
			},
			{
				pass_type = "texture",
				style_id = "owned",
				texture_id = "owned_id",
				content_check_function = function (content)
					return Managers.unlock:is_dlc_unlocked(content.dlc_name)
				end
			},
			{
				pass_type = "texture",
				style_id = "owned_shade",
				texture_id = "owned_id",
				content_check_function = function (content)
					return Managers.unlock:is_dlc_unlocked(content.dlc_name)
				end
			},
			{
				style_id = "text",
				pass_type = "text",
				text_id = "text_id",
				content_check_function = function (content)
					return Managers.unlock:is_dlc_unlocked(content.dlc_name)
				end
			},
			{
				style_id = "text_shade",
				pass_type = "text",
				text_id = "text_id",
				content_check_function = function (content)
					return Managers.unlock:is_dlc_unlocked(content.dlc_name)
				end
			},
			{
				style_id = "equipped_text",
				pass_type = "text",
				text_id = "equipped_text_id",
				content_check_function = function (content)
					return content.skin_settings and Managers.unlock:is_dlc_unlocked(content.dlc_name) and PlayerData.skins_activated_data[content.skin_settings.profile_name] == content.skin_settings.name
				end
			},
			{
				style_id = "equipped_text_shade",
				pass_type = "text",
				text_id = "equipped_text_id",
				content_check_function = function (content)
					return content.skin_settings and Managers.unlock:is_dlc_unlocked(content.dlc_name) and PlayerData.skins_activated_data[content.skin_settings.profile_name] == content.skin_settings.name
				end
			},
			{
				style_id = "coming_soon_text",
				pass_type = "text",
				text_id = "coming_soon_id",
				content_check_function = function (content)
					return not content.id and not content.video_active and not Managers.unlock:is_dlc_unlocked(content.dlc_name)
				end
			}
		}
	}
	local content = {
		video_active = false,
		owned_id = "dlc_checkmark",
		text_id = "owned",
		equipped_text_id = "item_compare_window_title",
		coming_soon_id = "igs_coming_soon",
		dlc_name = dlc_name,
		skin_settings = find_skin_settings(dlc_name),
		texture_id = texture_id,
		bg_overlay_id = bg_overlay_id or "karak_bg",
		id = id,
		video_content = {
			video_completed = false,
			video_player_created = false,
			material_name = video_material_name,
			video_name = (video_material_name and "video/" .. video_material_name) or nil,
			offset = {
				0,
				0,
				1
			}
		},
		corner_top_left = {
			texture_id = "dlc_frame_corner",
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
		corner_top_right = {
			texture_id = "dlc_frame_corner",
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
		},
		corner_bottom_left = {
			texture_id = "dlc_frame_corner",
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
		corner_bottom_right = {
			texture_id = "dlc_frame_corner",
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
		edge_left = {
			texture_id = "dlc_frame_side",
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
		edge_right = {
			texture_id = "dlc_frame_side",
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
		edge_top = {
			texture_id = "dlc_frame_edge",
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
		edge_bottom = {
			texture_id = "dlc_frame_edge",
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
	}
	local style = {
		color = widget_color,
		video_style = {
			offset = {
				0,
				0,
				1
			}
		},
		image = {
			color = {
				255,
				255,
				255,
				255
			}
		},
		bg_overlay = {
			scenegraph_id = "background",
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
		coming_soon_text = {
			word_wrap = true,
			localize = true,
			font_size = 72,
			pixel_perfect = false,
			horizontal_alignment = "center",
			vertical_alignment = "center",
			dynamic_font = true,
			font_type = "hell_shark_header_masked",
			text_color = {
				255,
				140,
				140,
				140
			},
			offset = {
				0,
				0,
				10
			}
		},
		text = {
			word_wrap = true,
			localize = true,
			font_size = 36,
			pixel_perfect = false,
			horizontal_alignment = "right",
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark_masked",
			text_color = {
				255,
				189,
				170,
				143
			},
			offset = {
				-86,
				33,
				4
			}
		},
		text_shade = {
			font_size = 36,
			localize = true,
			word_wrap = true,
			pixel_perfect = false,
			horizontal_alignment = "right",
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark_masked",
			text_color = {
				255,
				0,
				0,
				0
			},
			offset = {
				-84,
				31,
				3
			}
		},
		equipped_text = {
			word_wrap = true,
			localize = true,
			font_size = 36,
			pixel_perfect = false,
			horizontal_alignment = "right",
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark_masked",
			text_color = {
				255,
				0,
				140,
				0
			},
			offset = {
				-86,
				0,
				4
			}
		},
		equipped_text_shade = {
			font_size = 36,
			localize = true,
			word_wrap = true,
			pixel_perfect = false,
			horizontal_alignment = "right",
			vertical_alignment = "bottom",
			dynamic_font = true,
			font_type = "hell_shark_masked",
			text_color = {
				255,
				0,
				0,
				0
			},
			offset = {
				-84,
				-2,
				3
			}
		},
		owned = {
			vertical_alignment = "bottom",
			horizontal_alignment = "right",
			texture_size = {
				96,
				128
			},
			color = {
				255,
				255,
				255,
				255
			},
			offset = {
				0,
				-30,
				10
			}
		},
		owned_shade = {
			vertical_alignment = "bottom",
			horizontal_alignment = "right",
			texture_size = {
				96,
				128
			},
			color = {
				128,
				0,
				0,
				0
			},
			offset = {
				4,
				-34,
				9
			}
		},
		corner_top_left = {
			vertical_alignment = "top",
			texture_size = {
				64,
				64
			},
			offset = {
				0,
				0,
				2
			},
			color = frame_color
		},
		corner_top_right = {
			vertical_alignment = "top",
			horizontal_alignment = "right",
			texture_size = {
				64,
				64
			},
			offset = {
				0,
				0,
				2
			},
			color = frame_color
		},
		corner_bottom_left = {
			texture_size = {
				64,
				64
			},
			offset = {
				0,
				0,
				2
			},
			color = frame_color
		},
		corner_bottom_right = {
			horizontal_alignment = "right",
			texture_size = {
				64,
				64
			},
			offset = {
				0,
				0,
				2
			},
			color = frame_color
		},
		edge_top = {
			vertical_alignment = "top",
			texture_size = {
				IMAGE_SIZE[1] - 128,
				64
			},
			offset = {
				64,
				0,
				2
			},
			color = frame_color
		},
		edge_bottom = {
			vertical_alignment = "bottom",
			texture_size = {
				IMAGE_SIZE[1] - 128,
				64
			},
			offset = {
				64,
				0,
				2
			},
			color = frame_color
		},
		edge_left = {
			horizontal_alignment = "left",
			size = {
				64,
				IMAGE_SIZE[2] - 128
			},
			offset = {
				0,
				64,
				2
			},
			color = frame_color
		},
		edge_right = {
			horizontal_alignment = "right",
			texture_size = {
				64,
				IMAGE_SIZE[2] - 128
			},
			offset = {
				0,
				64,
				2
			},
			color = frame_color
		}
	}
	local scenegraph_id = scenegraph_id
	local offset = {
		0,
		offset_y,
		0
	}
	widget.element = element
	widget.content = content
	widget.style = style
	widget.scenegraph_id = scenegraph_id
	widget.offset = offset

	return widget
end

local function create_dlc_data_entry(texture_id, text_id)
	local widget = {}
	local element = {
		passes = {
			{
				pass_type = "texture",
				style_id = "logo",
				texture_id = "texture_id"
			},
			{
				style_id = "text",
				pass_type = "text",
				text_id = "text_id"
			}
		}
	}
	local content = {
		texture_id = texture_id,
		text_id = text_id
	}
	local style = {
		logo = {
			vertical_alignment = "top",
			horizontal_alignment = "left",
			texture_size = {
				600,
				432
			},
			color = {
				0,
				255,
				255,
				255
			},
			offset = {
				150,
				-100
			}
		},
		text = {
			scenegraph_id = "dlc_logo_text",
			localize = true,
			font_size = 18,
			pixel_perfect = false,
			horizontal_alignment = "center",
			word_wrap = true,
			vertical_alignment = "top",
			dynamic_font = true,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("cheeseburger", 0),
			offset = {
				100,
				40,
				3
			}
		}
	}
	local scenegraph_id = "dlc_data_root"
	local offset = {
		0,
		0,
		100
	}
	widget.element = element
	widget.content = content
	widget.style = style
	widget.scenegraph_id = scenegraph_id
	widget.offset = offset

	return widget
end

local generic_input_actions = {
	{
		priority = 1,
		input_action = "left_stick",
		description_text = "input_description_select",
		ignore_keybinding = true
	},
	{
		priority = 2,
		description_text = "input_description_information",
		ignore_keybinding = true,
		input_action = (PLATFORM == "ps4" and "triangle") or "y"
	},
	{
		input_action = "l1_r1",
		priority = 3,
		description_text = "igs_toggle_skins_maps",
		ignore_keybinding = true
	},
	{
		priority = 20,
		input_action = "back",
		description_text = "input_description_close"
	}
}
local menu_descriptions_input_actions = {
	not_owned = {
		name = "not_owned",
		gamepad_support = true,
		actions = {
			{
				input_action = "confirm",
				priority = 4,
				description_text = "dlc1_4_input_description_storepage_xb1"
			}
		}
	},
	not_owned_video_play = {
		name = "not_owned_video_play",
		gamepad_support = true,
		actions = {
			{
				input_action = "confirm",
				priority = 4,
				description_text = "dlc1_4_input_description_storepage_xb1"
			},
			{
				input_action = "special_1",
				priority = 5,
				ignore_localization = true,
				description_text = Localize("input_description_play") .. " video"
			}
		}
	},
	not_owned_video_stop = {
		name = "not_owned_video_stop",
		gamepad_support = true,
		actions = {
			{
				input_action = "confirm",
				priority = 4,
				description_text = "dlc1_4_input_description_storepage_xb1"
			},
			{
				input_action = "special_1",
				priority = 5,
				ignore_localization = true,
				description_text = "Stop video"
			}
		}
	},
	owned = {
		name = "owned",
		gamepad_support = true,
		actions = {}
	},
	owned_video_play = {
		name = "owned_video_play",
		gamepad_support = true,
		actions = {
			{
				input_action = "special_1",
				priority = 4,
				ignore_localization = true,
				description_text = Localize("input_description_play") .. " video"
			}
		}
	},
	owned_video_stop = {
		name = "owned_video_stop",
		gamepad_support = true,
		actions = {
			{
				input_action = "special_1",
				priority = 4,
				ignore_localization = true,
				description_text = "Stop video"
			}
		}
	},
	owned_equip_skin = {
		name = "owned_equip",
		gamepad_support = true,
		actions = {
			{
				input_action = "special_1",
				priority = 4,
				ignore_localization = true,
				description_text = Localize("input_description_equip")
			}
		}
	},
	owned_unequip_skin = {
		name = "owned_unequip",
		gamepad_support = true,
		actions = {
			{
				input_action = "special_1",
				priority = 4,
				ignore_localization = true,
				description_text = Localize("input_description_unequip")
			}
		}
	}
}
local scrollbar_size_y = scenegraph_definition.scrollbar_root.size[2]
local scrollbar_definition = UIWidgets.create_scrollbar(scrollbar_size_y, "scrollbar_root")
local tab_widget = {
	scenegraph_id = "dlc_image_root",
	element = {
		passes = {
			{
				texture_id = "texture_id",
				style_id = "bg_left",
				pass_type = "texture",
				content_id = "bg_fade"
			},
			{
				style_id = "bg_right",
				pass_type = "texture_uv",
				content_id = "bg_fade"
			},
			{
				pass_type = "rect",
				style_id = "rect"
			},
			{
				pass_type = "rect",
				style_id = "selection"
			},
			{
				style_id = "dlc_left_text",
				pass_type = "text",
				text_id = "dlc_left_id",
				content_check_function = function (content, style)
					if content.selected == "dlc" then
						style.text_color = style.selected_color
						style.font_size = style.font_size_large
					else
						style.text_color = style.unselected_color
						style.font_size = style.font_size_small
					end

					return true
				end
			},
			{
				style_id = "dlc_right_text",
				pass_type = "text",
				text_id = "dlc_right_id",
				content_check_function = function (content, style)
					if content.selected == "skin" then
						style.text_color = style.selected_color
						style.font_size = style.font_size_large
					else
						style.text_color = style.unselected_color
						style.font_size = style.font_size_small
					end

					return true
				end
			}
		}
	},
	content = {
		right_shoulder = "",
		spacing = 50,
		selected = "dlc",
		dlc_right_id = "igs_skins",
		dlc_left_id = "igs_map",
		left_shoulder = "",
		bg_fade = {
			texture_id = "ingame_contract_bg_01",
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
		left_shoulder = {
			vertical_alignment = "top",
			horizontal_alignment = "left",
			offset = {
				0,
				90,
				10
			},
			texture_size = {
				0,
				0
			}
		},
		right_shoulder = {
			vertical_alignment = "top",
			horizontal_alignment = "right",
			offset = {
				0,
				90,
				10
			},
			texture_size = {
				0,
				0
			}
		},
		bg_left = {
			vertical_alignment = "top",
			horizontal_alignment = "left",
			texture_size = {
				200,
				60
			},
			offset = {
				0,
				100,
				1
			}
		},
		bg_right = {
			vertical_alignment = "top",
			horizontal_alignment = "right",
			texture_size = {
				200,
				60
			},
			offset = {
				0,
				100,
				1
			}
		},
		test = {
			offset = {
				-200,
				-200,
				0
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				700,
				500
			}
		},
		rect = {
			vertical_alignment = "top",
			horizontal_alignment = "center",
			offset = {
				0,
				100,
				1
			},
			color = {
				255,
				0,
				0,
				0
			},
			rect_size = {
				560,
				60
			}
		},
		divider = {
			vertical_alignment = "top",
			horizontal_alignment = "center",
			color = {
				255,
				60,
				60,
				60
			},
			rect_size = {
				2,
				60
			},
			offset = {
				0,
				100,
				10
			}
		},
		selection = {
			vertical_alignment = "top",
			horizontal_alignment = "left",
			color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			rect_size = {
				100,
				2
			},
			offset = {
				0,
				48,
				12
			}
		},
		dlc_left_text = {
			word_wrap = false,
			localize = true,
			pixel_perfect = false,
			font_size = 56,
			horizontal_alignment = "right",
			font_type = "hell_shark",
			vertical_alignment = "center",
			dynamic_font = true,
			font_size_large = 56,
			font_size_small = 46,
			selected_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			unselected_color = {
				255,
				140,
				140,
				140
			},
			text_color = {
				255,
				140,
				140,
				140
			},
			offset = {
				0,
				335,
				4
			}
		},
		dlc_right_text = {
			word_wrap = false,
			localize = true,
			pixel_perfect = false,
			font_size = 56,
			horizontal_alignment = "left",
			font_type = "hell_shark",
			vertical_alignment = "center",
			dynamic_font = true,
			font_size_large = 56,
			font_size_small = 46,
			selected_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
			unselected_color = {
				255,
				140,
				140,
				140
			},
			text_color = {
				255,
				140,
				140,
				140
			},
			offset = {
				-0,
				335,
				4
			}
		}
	}
}
local widget_definitions = {
	tab_widget = tab_widget
}

return {
	spacing = 50,
	scenegraph_definition = scenegraph_definition,
	background_widget_definitions = background_widget_definitions,
	widget_definitions = widget_definitions,
	gamepad_frame_widget_definitions = gamepad_frame_widget_definitions,
	create_dlc_entry = create_dlc_entry,
	create_dlc_data_entry = create_dlc_data_entry,
	entry_size = IMAGE_SIZE,
	generic_input_actions = generic_input_actions,
	menu_descriptions_input_actions = menu_descriptions_input_actions,
	scrollbar_definition = scrollbar_definition,
	video_delay = VIDEO_DELAY
}
