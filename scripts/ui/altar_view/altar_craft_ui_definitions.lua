local_require("scripts/ui/ui_widgets")

local scenegraph_definition = {
	root = {
		is_root = true,
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.default
		}
	},
	page_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1,
			1
		},
		position = {
			0,
			0,
			1
		}
	},
	frame = {
		vertical_alignment = "center",
		parent = "page_root",
		horizontal_alignment = "center",
		size = {
			592,
			902
		},
		position = {
			0,
			0,
			3
		}
	},
	frame_background = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			564,
			834
		},
		position = {
			0,
			12,
			-1
		}
	},
	fg_glow = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			564,
			654
		},
		position = {
			0,
			73,
			35
		}
	},
	craft_button = {
		vertical_alignment = "bottom",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			318,
			84
		},
		position = {
			0,
			86,
			3
		}
	},
	craft_button_text = {
		vertical_alignment = "center",
		parent = "craft_button",
		horizontal_alignment = "left",
		size = {
			60,
			20
		},
		position = {
			20,
			-4,
			1
		}
	},
	craft_button_token = {
		vertical_alignment = "center",
		parent = "craft_button",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			112,
			-4,
			1
		}
	},
	craft_button_fill = {
		vertical_alignment = "center",
		parent = "craft_button",
		horizontal_alignment = "left",
		size = {
			307,
			69
		},
		position = {
			16,
			-10,
			-1
		}
	},
	description_text_1 = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			322,
			1
		}
	},
	title_text = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			501,
			40
		},
		position = {
			0,
			380,
			1
		}
	},
	background_candle_left = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "left",
		size = {
			5,
			11
		},
		position = {
			64,
			-213,
			9
		}
	},
	background_candle_right = {
		vertical_alignment = "top",
		parent = "frame_background",
		horizontal_alignment = "right",
		size = {
			5,
			11
		},
		position = {
			-95,
			-170,
			9
		}
	},
	candle_glow_left = {
		vertical_alignment = "center",
		parent = "background_candle_left",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	candle_glow_right = {
		vertical_alignment = "center",
		parent = "background_candle_right",
		horizontal_alignment = "center",
		size = {
			74,
			75
		},
		position = {
			0,
			0,
			-1
		}
	},
	craft_wheel_frame = {
		vertical_alignment = "center",
		parent = "frame_background",
		horizontal_alignment = "center",
		size = {
			423,
			498
		},
		position = {
			0,
			20,
			13
		}
	},
	item_button = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			78,
			79
		},
		position = {
			0,
			-34,
			1
		}
	},
	item_button_icon = {
		vertical_alignment = "center",
		parent = "item_button",
		horizontal_alignment = "center",
		size = {
			64,
			64
		},
		position = {
			0,
			1,
			2
		}
	},
	item_button_class_icon = {
		vertical_alignment = "center",
		parent = "item_button",
		horizontal_alignment = "center",
		size = {
			46,
			46
		},
		position = {
			0,
			0,
			1
		}
	},
	wheel_root = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			0,
			0
		},
		position = {
			0,
			-37,
			-7
		}
	},
	wheel_mask = {
		vertical_alignment = "top",
		parent = "wheel_root",
		horizontal_alignment = "center",
		size = {
			400,
			225
		},
		position = {
			0,
			17,
			1
		}
	},
	wheel_token = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
		size = {
			411,
			411
		},
		position = {
			0,
			0,
			-3
		}
	},
	wheel_weapon_type = {
		vertical_alignment = "center",
		parent = "wheel_token",
		horizontal_alignment = "center",
		size = {
			276,
			278
		},
		position = {
			0,
			0,
			1
		}
	},
	wheel_glow_token = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			480,
			300
		},
		position = {
			0,
			-128,
			1
		}
	},
	wheel_glow_weapon_type = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			344,
			224
		},
		position = {
			0,
			-92,
			1
		}
	},
	token_icon_1 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
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
	token_icon_1_glow = {
		vertical_alignment = "center",
		parent = "token_icon_1",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	token_icon_1_bg = {
		vertical_alignment = "center",
		parent = "token_icon_1",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	token_icon_2 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
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
	token_icon_2_glow = {
		vertical_alignment = "center",
		parent = "token_icon_2",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	token_icon_2_bg = {
		vertical_alignment = "center",
		parent = "token_icon_2",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	token_icon_3 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
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
	token_icon_3_glow = {
		vertical_alignment = "center",
		parent = "token_icon_3",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	token_icon_3_bg = {
		vertical_alignment = "center",
		parent = "token_icon_3",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	token_icon_4 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
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
	token_icon_4_glow = {
		vertical_alignment = "center",
		parent = "token_icon_4",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	token_icon_4_bg = {
		vertical_alignment = "center",
		parent = "token_icon_4",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	weapon_type_icon_1 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
		size = {
			34,
			34
		},
		position = {
			0,
			0,
			3
		}
	},
	weapon_type_icon_1_glow = {
		vertical_alignment = "center",
		parent = "weapon_type_icon_1",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	weapon_type_icon_1_bg = {
		vertical_alignment = "center",
		parent = "weapon_type_icon_1",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	weapon_type_icon_2 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
		size = {
			34,
			34
		},
		position = {
			0,
			0,
			3
		}
	},
	weapon_type_icon_2_glow = {
		vertical_alignment = "center",
		parent = "weapon_type_icon_2",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	weapon_type_icon_2_bg = {
		vertical_alignment = "center",
		parent = "weapon_type_icon_2",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	weapon_type_icon_3 = {
		vertical_alignment = "center",
		parent = "wheel_root",
		horizontal_alignment = "center",
		size = {
			34,
			34
		},
		position = {
			0,
			0,
			3
		}
	},
	weapon_type_icon_3_glow = {
		vertical_alignment = "center",
		parent = "weapon_type_icon_3",
		horizontal_alignment = "center",
		size = {
			80,
			80
		},
		position = {
			0,
			0,
			-1
		}
	},
	weapon_type_icon_3_bg = {
		vertical_alignment = "center",
		parent = "weapon_type_icon_3",
		horizontal_alignment = "center",
		size = {
			54,
			54
		},
		position = {
			0,
			0,
			-2
		}
	},
	token_step_button_1 = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			58,
			21
		},
		position = {
			-169,
			-1,
			1
		}
	},
	token_step_button_2 = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			58,
			21
		},
		position = {
			169,
			-1,
			1
		}
	},
	weapon_type_step_button_1 = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			58,
			21
		},
		position = {
			-103,
			-1,
			1
		}
	},
	weapon_type_step_button_2 = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			58,
			21
		},
		position = {
			104,
			-1,
			1
		}
	},
	frame_glow_skull = {
		vertical_alignment = "center",
		parent = "craft_wheel_frame",
		horizontal_alignment = "center",
		size = {
			60,
			60
		},
		position = {
			-2.5,
			24,
			1
		}
	}
}

local function create_step_button(scenegraph_id)
	return {
		element = {
			passes = {
				{
					pass_type = "hotspot",
					content_id = "button_hotspot"
				},
				{
					pass_type = "texture",
					texture_id = "texture_normal",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.button_disabled and (not button_hotspot.is_clicked or 0 < button_hotspot.is_clicked)
					end
				},
				{
					pass_type = "texture",
					texture_id = "texture_pressed",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.button_disabled and button_hotspot.is_clicked and button_hotspot.is_clicked == 0
					end
				},
				{
					pass_type = "texture",
					style_id = "glow_texture_hover",
					texture_id = "texture_hover",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.button_disabled and content.show_glow and (not button_hotspot.is_clicked or 0 < button_hotspot.is_clicked)
					end
				},
				{
					pass_type = "texture",
					style_id = "glow_texture_pressed",
					texture_id = "texture_hover",
					content_check_function = function (content)
						local button_hotspot = content.button_hotspot

						return not button_hotspot.button_disabled and content.show_glow and button_hotspot.is_clicked and button_hotspot.is_clicked == 0
					end
				}
			}
		},
		content = {
			texture_hover = "craft_arrow_button_glow",
			texture_pressed = "altar_craft_wheel_button_clicked",
			show_glow = false,
			texture_normal = "altar_craft_wheel_button_normal",
			button_hotspot = {}
		},
		style = {
			glow_texture_hover = {
				size = {
					48,
					48
				},
				offset = {
					5,
					-14,
					1
				}
			},
			glow_texture_pressed = {
				size = {
					48,
					48
				},
				offset = {
					5,
					-15,
					1
				}
			}
		},
		style_global = {
			glow_color = {
				0,
				255,
				255,
				255
			}
		},
		scenegraph_id = scenegraph_id
	}
end

local use_mask = true
local widgets_definitions = {
	frame_widget = UIWidgets.create_simple_texture("character_selection_bg", "frame"),
	frame_background_widget = UIWidgets.create_simple_texture("craft_bg", "frame_background"),
	craft_wheel_frame_widget = UIWidgets.create_simple_texture("altar_craft_wheel_fg", "craft_wheel_frame"),
	frame_glow_skull_widget = UIWidgets.create_simple_texture("reroll_glow_skull", "frame_glow_skull"),
	wheel_token_widget = UIWidgets.create_simple_rotated_texture("altar_craft_wheel_01", 0, {
		205.5,
		205.5
	}, "wheel_token", use_mask),
	wheel_weapon_type_widget = UIWidgets.create_simple_rotated_texture("altar_craft_wheel_02", 0, {
		138,
		139
	}, "wheel_weapon_type", use_mask),
	wheel_glow_weapon_type_widget = UIWidgets.create_simple_texture("craft_wheel_glow_normal", "wheel_glow_weapon_type"),
	wheel_glow_token_widget = UIWidgets.create_simple_texture("craft_wheel_glow_large", "wheel_glow_token"),
	craft_wheel_mask_widget = UIWidgets.create_simple_texture("mask_rect", "wheel_mask"),
	craft_button_widget = UIWidgets.create_altar_button("altar_craft_button_text", "craft_button", "craft_button_text", "craft_button_token", "craft_button_fill"),
	description_text_1 = UIWidgets.create_simple_text("altar_craft_description_1", "description_text_1", 24, Colors.get_color_table_with_alpha("white", 255)),
	title_text = UIWidgets.create_simple_text("altar_title_craft", "title_text", 32, Colors.get_color_table_with_alpha("cheeseburger", 255), nil, "hell_shark_header"),
	background_candle_left_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_left"),
	background_candle_right_widget = UIWidgets.create_simple_texture("candle_glow_02", "background_candle_right"),
	candle_glow_left_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_left"),
	candle_glow_right_widget = UIWidgets.create_simple_texture("candle_glow_01", "candle_glow_right"),
	token_step_button_1 = create_step_button("token_step_button_1"),
	token_step_button_2 = create_step_button("token_step_button_2"),
	weapon_type_step_button_1 = create_step_button("weapon_type_step_button_1"),
	weapon_type_step_button_2 = create_step_button("weapon_type_step_button_2"),
	token_icon_1_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "token_icon_1_bg", use_mask),
	token_icon_2_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "token_icon_2_bg", use_mask),
	token_icon_3_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "token_icon_3_bg", use_mask),
	token_icon_4_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "token_icon_4_bg", use_mask),
	token_icon_1_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "token_icon_1_glow", use_mask),
	token_icon_2_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "token_icon_2_glow", use_mask),
	token_icon_3_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "token_icon_3_glow", use_mask),
	token_icon_4_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "token_icon_4_glow", use_mask),
	weapon_type_icon_1_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "weapon_type_icon_1_bg", use_mask),
	weapon_type_icon_2_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "weapon_type_icon_2_bg", use_mask),
	weapon_type_icon_3_bg_widget = UIWidgets.create_simple_texture("altar_craft_wheel_slot", "weapon_type_icon_3_bg", use_mask),
	weapon_type_icon_1_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "weapon_type_icon_1_glow", use_mask),
	weapon_type_icon_2_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "weapon_type_icon_2_glow", use_mask),
	weapon_type_icon_3_glow_widget = UIWidgets.create_simple_texture("craft_wheel_slot_glow", "weapon_type_icon_3_glow", use_mask)
}
local token_wheel_widgets_definition = {
	UIWidgets.create_altar_craft_reagent_button("token_icon_1", "token_icon_04", "wheel_mask", Localize("forge_screen_exotic_token_tooltip"), use_mask),
	UIWidgets.create_altar_craft_reagent_button("token_icon_2", "token_icon_03", "wheel_mask", Localize("forge_screen_rare_token_tooltip"), use_mask),
	UIWidgets.create_altar_craft_reagent_button("token_icon_3", "token_icon_02", "wheel_mask", Localize("forge_screen_common_token_tooltip"), use_mask),
	UIWidgets.create_altar_craft_reagent_button("token_icon_4", "token_icon_01", "wheel_mask", Localize("forge_screen_plentiful_token_tooltip"), use_mask)
}
local weapon_type_wheel_widgets_definition = {
	UIWidgets.create_altar_craft_reagent_button("weapon_type_icon_1", "tabs_inventory_icon_melee_selected", "wheel_mask", Localize("inventory_screen_melee_weapon_tooltip"), use_mask),
	UIWidgets.create_altar_craft_reagent_button("weapon_type_icon_2", "icon_any", "wheel_mask", Localize("inventory_screen_random_tooltip"), use_mask),
	UIWidgets.create_altar_craft_reagent_button("weapon_type_icon_3", "tabs_inventory_icon_ranged_selected", "wheel_mask", Localize("inventory_screen_ranged_weapon_tooltip"), use_mask)
}
local top_rendering_widgets = {
	fg_glow_widget = UIWidgets.create_simple_texture("gradient_enchantment_craft", "fg_glow"),
	item_button_widget = UIWidgets.create_attach_icon_button(nil, "item_button", "item_button_icon", scenegraph_definition.item_button_icon.size),
	item_button_class_icon = UIWidgets.create_simple_texture("altar_craft_icon_dwarf_ranger", "item_button_class_icon")
}
local animations = {
	glow_slots = {
		{
			name = "fade_in",
			start_progress = 0,
			end_progress = 0.5,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				for i = 1, #widgets, 1 do
					widgets[i].style.texture_id.color[1] = 0
				end

				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = math.easeOutCubic(local_progress) * 255

				for i = 1, #widgets, 1 do
					widgets[i].style.texture_id.color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "delay",
			start_progress = 0.5,
			end_progress = 0.8,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		},
		{
			name = "fade_out",
			start_progress = 0.8,
			end_progress = 1.1,
			init = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end,
			update = function (ui_scenegraph, scenegraph_definition, widgets, local_progress, params)
				local alpha = math.easeOutCubic(1 - local_progress) * 255

				for i = 1, #widgets, 1 do
					widgets[i].style.texture_id.color[1] = alpha
				end

				return 
			end,
			on_complete = function (ui_scenegraph, scenegraph_definition, widgets, params)
				return 
			end
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widgets_definitions = widgets_definitions,
	token_wheel_widgets_definition = token_wheel_widgets_definition,
	weapon_type_wheel_widgets_definition = weapon_type_wheel_widgets_definition,
	top_rendering_widgets = top_rendering_widgets,
	animations = animations
}
