require("scripts/settings/level_settings")
require("scripts/settings/level_unlock_settings")
require("scripts/settings/difficulty_settings")

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
			1280
		}
	},
	screen = {
		scale = "fit",
		position = {
			0,
			0,
			UILayer.default - 2
		},
		size = {
			1920,
			1080
		}
	},
	lobby_root = {
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
	background = {
		vertical_alignment = "center",
		parent = "screen",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			-1
		},
		size = {
			1920,
			1080
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			-10,
			1
		},
		size = {
			420,
			28
		}
	},
	back_button = {
		parent = "background",
		horizontal_alignment = "right",
		position = {
			-50,
			40,
			1
		},
		size = {
			220,
			62
		}
	},
	lobby_list_frame = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "right",
		position = {
			-50,
			-70,
			2
		},
		size = {
			1440,
			900
		}
	},
	lobby_list_title_line = {
		vertical_alignment = "top",
		parent = "lobby_list_frame",
		horizontal_alignment = "center",
		position = {
			0,
			-37,
			-1
		},
		size = {
			1440,
			8
		}
	},
	join_button = {
		parent = "lobby_list_frame",
		horizontal_alignment = "left",
		position = {
			0,
			-70,
			1
		},
		size = {
			220,
			62
		}
	},
	status_fade = {
		vertical_alignment = "center",
		parent = "background",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			100
		},
		size = {
			1920,
			1080
		}
	},
	status_background = {
		vertical_alignment = "center",
		parent = "status_fade",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			571,
			279
		}
	},
	status_title = {
		vertical_alignment = "top",
		parent = "status_background",
		horizontal_alignment = "center",
		position = {
			0,
			-14,
			1
		},
		size = {
			260,
			32
		}
	},
	status_text = {
		vertical_alignment = "center",
		parent = "status_background",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			571,
			50
		}
	},
	status_cancel_button = {
		vertical_alignment = "bottom",
		parent = "status_background",
		horizontal_alignment = "center",
		position = {
			0,
			-31,
			1
		},
		size = {
			220,
			62
		}
	},
	invalid_checkbox = {
		parent = "root",
		position = {
			40,
			1000,
			1
		},
		size = {
			200,
			34
		}
	},
	filter_frame = {
		vertical_alignment = "top",
		parent = "background",
		horizontal_alignment = "left",
		position = {
			50,
			-70,
			2
		},
		size = {
			375,
			900
		}
	},
	game_mode_stepper = {
		vertical_alignment = "top",
		parent = "filter_frame",
		horizontal_alignment = "left",
		position = {
			60,
			-73,
			1
		},
		size = {
			240,
			32
		}
	},
	game_mode_banner = {
		parent = "game_mode_stepper",
		position = {
			-45,
			30,
			1
		},
		size = {
			340,
			56
		}
	},
	game_mode_banner_text = {
		vertical_alignment = "center",
		parent = "game_mode_banner",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			340,
			40
		}
	},
	level_stepper = {
		vertical_alignment = "top",
		parent = "game_mode_stepper",
		horizontal_alignment = "left",
		position = {
			0,
			-128,
			1
		},
		size = {
			240,
			32
		}
	},
	level_banner = {
		parent = "level_stepper",
		position = {
			-45,
			30,
			1
		},
		size = {
			340,
			56
		}
	},
	level_banner_text = {
		vertical_alignment = "center",
		parent = "level_banner",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			340,
			40
		}
	},
	difficulty_stepper = {
		vertical_alignment = "top",
		parent = "level_stepper",
		horizontal_alignment = "center",
		position = {
			0,
			-128,
			0
		},
		size = {
			240,
			32
		}
	},
	difficulty_banner = {
		parent = "difficulty_stepper",
		position = {
			-45,
			30,
			1
		},
		size = {
			340,
			56
		}
	},
	difficulty_banner_text = {
		vertical_alignment = "center",
		parent = "difficulty_banner",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			340,
			40
		}
	},
	show_lobbies_stepper = {
		vertical_alignment = "top",
		parent = "difficulty_stepper",
		horizontal_alignment = "center",
		position = {
			0,
			-128,
			0
		},
		size = {
			240,
			32
		}
	},
	show_lobbies_banner = {
		parent = "show_lobbies_stepper",
		position = {
			-45,
			30,
			1
		},
		size = {
			340,
			56
		}
	},
	show_lobbies_banner_text = {
		vertical_alignment = "center",
		parent = "show_lobbies_banner",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			340,
			40
		}
	},
	distance_stepper = {
		vertical_alignment = "top",
		parent = "show_lobbies_stepper",
		horizontal_alignment = "center",
		position = {
			0,
			-128,
			0
		},
		size = {
			240,
			32
		}
	},
	distance_banner = {
		parent = "distance_stepper",
		position = {
			-45,
			30,
			1
		},
		size = {
			340,
			56
		}
	},
	distance_banner_text = {
		vertical_alignment = "center",
		parent = "distance_banner",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			340,
			40
		}
	},
	reset_button = {
		vertical_alignment = "top",
		parent = "search_button",
		horizontal_alignment = "center",
		position = {
			0,
			120,
			1
		},
		size = {
			318,
			84
		}
	},
	filter_divider = {
		vertical_alignment = "bottom",
		parent = "search_button",
		horizontal_alignment = "center",
		position = {
			0,
			93,
			2
		},
		size = {
			301,
			18
		}
	},
	search_button = {
		vertical_alignment = "bottom",
		parent = "filter_frame",
		horizontal_alignment = "center",
		position = {
			0,
			20,
			1
		},
		size = {
			318,
			84
		}
	}
}

local function sort_level_list(a, b)
	local level_settings = LevelSettings
	local a_map_settings = level_settings[a].map_settings
	local b_map_settings = level_settings[b].map_settings

	return a_map_settings.sorting < b_map_settings.sorting
end

local function setup_game_mode_data()
	local game_mode_data = {}
	local game_modes = {}
	local only_release = GameSettingsDevelopment.release_levels_only

	for name, data in pairs(LevelSettings) do
		if type(data) == "table" then
			local debug_level = string.match(data.package_name, "resource_packages/levels/debug/")

			if not only_release or not debug_level then
				local game_mode = data.game_mode

				if game_mode and table.find(UnlockableLevels, name) then
					local add_level = false

					if data.dlc_name then
						if Managers.unlock:is_dlc_unlocked(data.dlc_name) then
							add_level = true
						end
					else
						add_level = true
					end

					if add_level then
						if not game_modes[game_mode] then
							local index = #game_mode_data + 1
							local game_mode_settings = GameModeSettings[game_mode]
							local game_mode_difficulties = game_mode_settings.difficulties
							local game_mode_display_name = game_mode_settings.display_name
							local difficulties = table.clone(game_mode_difficulties)
							difficulties[#difficulties + 1] = "any"
							game_modes[game_mode] = index
							game_mode_data[index] = {
								levels = {},
								difficulties = difficulties,
								game_mode_key = game_mode,
								game_mode_display_name = game_mode_display_name
							}
						end

						local data = game_mode_data[game_modes[game_mode]]
						local levels = data.levels
						levels[#levels + 1] = name
					end
				end
			end
		end
	end

	for index, data in ipairs(game_mode_data) do
		local levels = data.levels

		table.sort(levels, sort_level_list)

		levels[#levels + 1] = "any"
	end

	return game_mode_data
end

local show_lobbies_array = {
	"lb_show_joinable",
	"lb_show_all"
}
local distance_array = {
	"map_zone_options_2",
	"map_zone_options_3",
	"map_zone_options_4",
	"map_zone_options_5"
}
LobbyBrowserGamepadWidgets = {
	stepper = {
		input_function = function (widget, input_service)
			local content = widget.content

			if input_service.get(input_service, "move_left") then
				content.left_button_hotspot.on_release = true

				return true
			elseif input_service.get(input_service, "move_right") then
				content.right_button_hotspot.on_release = true

				return true
			end

			return 
		end
	}
}

local function create_banner_text_config(scenegraph_id)
	return {
		vertical_alignment = "center",
		localize = true,
		font_size = 28,
		horizontal_alignment = "center",
		font_type = "hell_shark",
		text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
		scenegraph_id = scenegraph_id
	}
end

return {
	status_background = UIWidgets.create_simple_texture("unlock_key_bg", "status_background"),
	status_title = UIWidgets.create_simple_text("setting_privacy", "status_title", 32, Colors.get_table("cheeseburger")),
	status_text = UIWidgets.create_simple_text("status_text", "status_text", 32, Colors.get_table("white")),
	status_cancel_button = UIWidgets.create_menu_button_medium("button_cancel", "status_cancel_button"),
	status_fade = UIWidgets.create_simple_rect("status_fade", {
		200,
		0,
		0,
		0
	}),
	game_mode_stepper = UIWidgets.create_lobby_browser_stepper("game_mode_stepper"),
	level_stepper = UIWidgets.create_lobby_browser_stepper("level_stepper"),
	difficulty_stepper = UIWidgets.create_lobby_browser_stepper("difficulty_stepper"),
	show_lobbies_stepper = UIWidgets.create_lobby_browser_stepper("show_lobbies_stepper"),
	distance_stepper = UIWidgets.create_lobby_browser_stepper("distance_stepper"),
	search_button = UIWidgets.create_menu_button("lb_search", "search_button"),
	back_button = UIWidgets.create_menu_button_medium("close", "back_button"),
	join_button = UIWidgets.create_menu_button_medium("lb_join", "join_button"),
	reset_button = UIWidgets.create_menu_button("lb_reset_filters", "reset_button"),
	invalid_checkbox = UIWidgets.create_checkbox_widget("lb_show_invalid", "", "invalid_checkbox", 0, {
		30,
		0,
		4
	}),
	background_widget = UIWidgets.create_simple_texture("large_frame_01", "background"),
	title_widget = UIWidgets.create_title_text("menu_title_lobby_browser", "title_text"),
	lobby_list_frame_widget = UIWidgets.create_simple_frame("gold_frame_01_complete", {
		198,
		199
	}, {
		66,
		66
	}, {
		12,
		66
	}, {
		66,
		12
	}, "lobby_list_frame"),
	filter_frame_widget = UIWidgets.create_simple_frame("gold_frame_01_complete", {
		198,
		199
	}, {
		66,
		66
	}, {
		12,
		66
	}, {
		66,
		12
	}, "filter_frame"),
	filter_divider_widget = UIWidgets.create_simple_texture("summary_screen_line_breaker", "filter_divider"),
	lobby_list_title_line_widget = UIWidgets.create_tiled_texture("lobby_list_title_line", "gold_frame_01_horizontal_thin", {
		66,
		8
	}),
	scenegraph_definition = scenegraph_definition,
	show_lobbies_table = show_lobbies_array,
	distance_table = distance_array,
	setup_game_mode_data = setup_game_mode_data,
	dead_space_filler = UIWidgets.create_simple_rect("dead_space_filler", {
		255,
		0,
		0,
		0
	}),
	game_mode_banner_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_game_type_setting", "dlc1_2_map_game_mode_tooltip", "game_mode_banner", "game_mode_banner_text", create_banner_text_config("game_mode_banner_text")),
	level_banner_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_level_setting", "map_level_setting_tooltip", "level_banner", "level_banner_text", create_banner_text_config("level_banner_text")),
	difficulty_banner_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_difficulty_setting", "map_difficulty_setting_tooltip", "difficulty_banner", "difficulty_banner_text", create_banner_text_config("difficulty_banner_text")),
	show_lobbies_banner_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "lb_show_lobbies", "lb_show_lobbies_tooltip", "show_lobbies_banner", "show_lobbies_banner_text", create_banner_text_config("show_lobbies_banner_text")),
	distance_banner_widget = UIWidgets.create_texture_with_text_and_tooltip("title_bar", "map_search_zone_setting", "map_search_zone_setting_tooltip", "distance_banner", "distance_banner_text", create_banner_text_config("distance_banner_text"))
}
