local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.end_screen + 2
		},
		size = {
			1920,
			1080
		}
	},
	screen = {
		scale = "fit",
		position = {
			0,
			0,
			UILayer.end_screen
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
		}
	},
	scoreboard_window = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			1920,
			1080
		}
	},
	player_list_window = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			-200,
			2
		},
		size = {
			1500,
			700
		}
	},
	leaderboard_type = {
		vertical_alignment = "top",
		parent = "player_list_window",
		horizontal_alignment = "center",
		position = {
			0,
			90,
			2
		},
		size = {
			1500,
			50
		}
	},
	entry_base = {
		vertical_alignment = "top",
		parent = "player_list_window",
		horizontal_alignment = "center",
		position = {
			0,
			-55,
			1
		},
		size = {
			1472,
			0
		}
	},
	entry_root = {
		vertical_alignment = "top",
		parent = "entry_base",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			0
		},
		size = {
			1472,
			50
		}
	},
	mask_root = {
		vertical_alignment = "top",
		parent = "player_list_window",
		horizontal_alignment = "center",
		position = {
			0,
			-55,
			1
		},
		size = {
			1472,
			50
		}
	},
	character_selection_bar = {
		vertical_alignment = "top",
		parent = "player_list_window",
		horizontal_alignment = "center",
		size = {
			580,
			40
		},
		position = {
			3,
			40,
			1
		}
	},
	loading_icon_area = {
		vertical_alignment = "center",
		parent = "player_list_window",
		horizontal_alignment = "center",
		size = {
			1472,
			624
		},
		position = {
			0,
			0,
			1
		}
	},
	loading_icon = {
		vertical_alignment = "center",
		parent = "loading_icon_area",
		horizontal_alignment = "center",
		size = {
			50,
			50
		},
		position = {
			0,
			0,
			1
		}
	}
}

local function create_empty_entry()
	local definition = {
		scenegraph_id = "entry_root",
		element = {
			passes = {
				{
					style_id = "missing_data",
					pass_type = "text",
					text_id = "missing_data"
				}
			}
		},
		content = {
			missing_data = "dlc1_2_difficulty_unavailable"
		},
		style = {
			missing_data = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = true,
				font_size = 36,
				font_type = "hell_shark",
				text_color = {
					255,
					192,
					192,
					192
				},
				offset = {
					0,
					-6,
					1
				}
			}
		}
	}

	return UIWidget.init(definition)
end

local function create_selection_bar(textures, icons, tooltips, offset, scenegraph_base, size, icon_size)
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
		local button_disabled_style_name = string.format("button_disabled_style_%d", i)
		local button_click_style_name = string.format("button_click_style_%d", i)
		local icon_texture_id = string.format("icon_%d", i)
		local icon_click_texture_id = string.format("icon_click_%d", i)

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
			texture_id = button_disabled_style_name,
			style_id = button_disabled_style_name,
			content_check_function = function (content)
				return content[button_hotspot_name].disable_button
			end
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
		content_data[button_disabled_style_name] = "tab_small_disabled_overlay"
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
				255,
				255,
				255,
				255
			},
			size = size
		}
		style[button_disabled_style_name] = {
			scenegraph_id = scenegraph_id,
			offset = {
				0,
				0,
				8
			},
			color = {
				255,
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
end

local hero_icons_by_profile_name = {
	witch_hunter = {
		texture_hover_id = "tabs_class_icon_witch_hunter_hover",
		texture_click_id = "tabs_class_icon_witch_hunter_selected",
		texture_id = "tabs_class_icon_witch_hunter_normal"
	},
	bright_wizard = {
		texture_hover_id = "tabs_class_icon_bright_wizard_hover",
		texture_click_id = "tabs_class_icon_bright_wizard_selected",
		texture_id = "tabs_class_icon_bright_wizard_normal"
	},
	dwarf_ranger = {
		texture_hover_id = "tabs_class_icon_dwarf_ranger_hover",
		texture_click_id = "tabs_class_icon_dwarf_ranger_selected",
		texture_id = "tabs_class_icon_dwarf_ranger_normal"
	},
	wood_elf = {
		texture_hover_id = "tabs_class_icon_way_watcher_hover",
		texture_click_id = "tabs_class_icon_way_watcher_selected",
		texture_id = "tabs_class_icon_way_watcher_normal"
	},
	empire_soldier = {
		texture_hover_id = "tabs_class_icon_empire_soldier_hover",
		texture_click_id = "tabs_class_icon_empire_soldier_selected",
		texture_id = "tabs_class_icon_empire_soldier_normal"
	}
}

function generate_icons()
	local icons = {}

	for _, name in ipairs(LeaderboardSettings.characters) do
		icons[#icons + 1] = hero_icons_by_profile_name[name]
	end

	return icons
end

local tooltips_by_profile_name = {
	witch_hunter = "inventory_screen_witch_hunter_tooltip",
	empire_soldier = "inventory_screen_empire_soldier_tooltip",
	dwarf_ranger = "inventory_screen_dwarf_tooltip",
	wood_elf = "inventory_screen_way_watcher_tooltip",
	bright_wizard = "inventory_screen_bright_wizard_tooltip"
}

function generate_tooltips()
	local tooltips = {}

	for _, name in ipairs(LeaderboardSettings.characters) do
		tooltips[#tooltips + 1] = tooltips_by_profile_name[name]
	end

	return tooltips
end

local character_selection_bar = create_selection_bar({
	texture_hover_id = "tab_hover",
	texture_click_id = "tab_selected",
	texture_id = "tab_normal"
}, generate_icons(), generate_tooltips(), {
	114,
	0,
	0
}, "character_selection_bar", {
	116,
	40
}, {
	34,
	34
})
local ENTRY_AREA = {
	1472,
	624
}
local ENTRY_SIZE = {
	1472,
	40
}

local function create_entry(name, rank, score, data, scenegraph_id, base_offset, index, id, my_id)
	local uneven = index%2 == 1
	local definition = {
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "background",
					texture_id = "background"
				},
				{
					pass_type = "texture",
					style_id = "highlight",
					texture_id = "highlight",
					content_check_function = function (content)
						return content.highlight_enabled
					end
				},
				{
					pass_type = "texture",
					style_id = "divider",
					texture_id = "background"
				},
				{
					style_id = "rank",
					pass_type = "text",
					text_id = "rank"
				},
				{
					style_id = "name",
					pass_type = "text",
					text_id = "name",
					content_check_function = function (content)
						return content.id ~= content.my_id
					end
				},
				{
					style_id = "my_name",
					pass_type = "text",
					text_id = "my_name",
					content_check_function = function (content)
						return content.id == content.my_id
					end
				},
				{
					style_id = "skaven_slaves",
					pass_type = "text",
					text_id = "skaven_slaves"
				},
				{
					style_id = "skaven_clan_rat",
					pass_type = "text",
					text_id = "skaven_clan_rat"
				},
				{
					style_id = "skaven_storm_vermin",
					pass_type = "text",
					text_id = "skaven_storm_vermin"
				},
				{
					style_id = "skaven_specials",
					pass_type = "text",
					text_id = "skaven_specials"
				},
				{
					style_id = "skaven_rat_ogre",
					pass_type = "text",
					text_id = "skaven_rat_ogre"
				},
				{
					style_id = "waves",
					pass_type = "text",
					text_id = "waves"
				},
				{
					style_id = "time",
					pass_type = "text",
					text_id = "time"
				}
			}
		},
		content = {
			background = "rect_masked",
			highlight = "scoreboard_window_highlight",
			rank = rank or "missing",
			name = name or "missing",
			my_name = name or "missing",
			skaven_slaves = data[2] or "missing",
			skaven_clan_rat = data[3] or "missing",
			skaven_storm_vermin = data[4] or "missing",
			skaven_specials = data[5] or "missing",
			skaven_rat_ogre = data[6] or "missing",
			waves = data[1] or "missing",
			time = data[7] or "missing",
			id = id,
			my_id = my_id
		},
		style = {
			background = {
				color = {
					((uneven and 32) or 0) + 32,
					128,
					128,
					128
				},
				size = ENTRY_SIZE,
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3]
				}
			},
			highlight = {
				masked = true,
				size = {
					1472,
					40
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					base_offset[2],
					2
				}
			},
			divider = {
				color = {
					255,
					0,
					0,
					0
				},
				size = {
					ENTRY_SIZE[1],
					3
				},
				offset = {
					base_offset[1],
					base_offset[2],
					base_offset[3] + 1
				}
			},
			rank = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-700,
					base_offset[2] + -3,
					1
				}
			},
			name = {
				vertical_alignment = "bottom",
				horizontal_alignment = "left",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					135,
					base_offset[2] + -3,
					1
				}
			},
			my_name = {
				vertical_alignment = "bottom",
				horizontal_alignment = "left",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("gainsboro", 255),
				offset = {
					135,
					base_offset[2] + -3,
					1
				}
			},
			skaven_slaves = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-100,
					base_offset[2] + -3,
					1
				}
			},
			skaven_clan_rat = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					25,
					base_offset[2] + -3,
					1
				}
			},
			skaven_storm_vermin = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					145,
					base_offset[2] + -3,
					1
				}
			},
			skaven_specials = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					272,
					base_offset[2] + -3,
					1
				}
			},
			skaven_rat_ogre = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					400,
					base_offset[2] + -3,
					1
				}
			},
			waves = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("gainsboro", 255),
				offset = {
					525,
					base_offset[2] + -3,
					1
				}
			},
			time = {
				vertical_alignment = "bottom",
				horizontal_alignment = "center",
				localize = false,
				masked = true,
				font_size = 32,
				font_type = "hell_shark_masked",
				text_color = Colors.get_color_table_with_alpha("gainsboro", 255),
				offset = {
					650,
					base_offset[2] + -3,
					1
				}
			}
		},
		scenegraph_id = scenegraph_id
	}
	base_offset[2] = base_offset[2] - ENTRY_SIZE[2]

	return UIWidget.init(definition)
end

local widgets = {
	window = {
		scenegraph_id = "scoreboard_window",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "background_mask",
					texture_id = "background_mask",
					scenegraph_id = "player_list_window"
				},
				{
					texture_id = "player_list_window",
					style_id = "player_list_window",
					pass_type = "texture"
				},
				{
					style_id = "leaderboard_header",
					pass_type = "text",
					text_id = "leaderboard_header"
				},
				{
					style_id = "leaderboard_type",
					pass_type = "text",
					text_id = "leaderboard_type"
				},
				{
					style_id = "rank_header",
					pass_type = "text",
					text_id = "rank_header"
				},
				{
					style_id = "name_header",
					pass_type = "text",
					text_id = "name_header"
				},
				{
					style_id = "wave_header",
					pass_type = "text",
					text_id = "wave_header"
				},
				{
					style_id = "slave_header",
					pass_type = "text",
					text_id = "slave_header"
				},
				{
					style_id = "clan_rat_header",
					pass_type = "text",
					text_id = "clan_rat_header"
				},
				{
					style_id = "storm_header",
					pass_type = "text",
					text_id = "storm_header"
				},
				{
					style_id = "special_header",
					pass_type = "text",
					text_id = "special_header"
				},
				{
					style_id = "rat_ogre_header",
					pass_type = "text",
					text_id = "rat_ogre_header"
				},
				{
					style_id = "time_header",
					pass_type = "text",
					text_id = "time_header"
				}
			}
		},
		content = {
			time_header = "dlc1_2_end_screen_time",
			rank_header = "#",
			background_mask = "mask_rect",
			storm_header = "Storm",
			leaderboard_header = "",
			rat_ogre_header = "Ogre",
			wave_header = "dlc1_2_end_screen_waves",
			leaderboard_type = "leaderboard_global",
			slave_header = "Slave",
			player_list_window = "scoreboard_window",
			clan_rat_header = "Clan",
			special_header = "Special",
			name_header = "player_list_title_name"
		},
		style = {
			background_mask = {
				scenegraph_id = "mask_root",
				offset = {
					0,
					-583,
					50
				},
				size = {
					1472,
					624
				}
			},
			player_list_window = {
				scenegraph_id = "player_list_window",
				offset = {
					0,
					0,
					1
				}
			},
			leaderboard_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = true,
				font_size = 60,
				font_type = "hell_shark",
				horizontal_alignment = "center",
				text_color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					150,
					1
				}
			},
			leaderboard_type = {
				vertical_alignment = "center",
				scenegraph_id = "leaderboard_type",
				localize = true,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "center",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					0,
					10
				}
			},
			rank_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = false,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "left",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					40,
					-15,
					1
				}
			},
			name_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = true,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "left",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					150,
					-15,
					1
				}
			},
			slave_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = false,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-810,
					-15,
					1
				}
			},
			clan_rat_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = false,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-690,
					-15,
					1
				}
			},
			storm_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = false,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-560,
					-15,
					1
				}
			},
			special_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = false,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-425,
					-15,
					1
				}
			},
			rat_ogre_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = false,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					-315,
					-15,
					1
				}
			},
			wave_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = true,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("gainsboro", 255),
				offset = {
					-182,
					-15,
					1
				}
			},
			time_header = {
				vertical_alignment = "top",
				scenegraph_id = "player_list_window",
				localize = true,
				font_size = 32,
				font_type = "hell_shark",
				horizontal_alignment = "right",
				text_color = Colors.get_color_table_with_alpha("gainsboro", 255),
				offset = {
					-65,
					-15,
					1
				}
			}
		}
	}
}

return {
	scenegraph = scenegraph_definition,
	widgets = widgets,
	create_entry = create_entry,
	create_empty_entry = create_empty_entry,
	character_selection_bar_widget = character_selection_bar,
	entry_size = ENTRY_SIZE,
	entry_area = ENTRY_AREA
}
