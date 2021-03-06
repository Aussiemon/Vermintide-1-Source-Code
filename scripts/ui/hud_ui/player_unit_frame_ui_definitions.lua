local SIZE_X = 1920
local SIZE_Y = 1080
local RETAINED_MODE_ENABLED = true
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.hud
		},
		size = {
			SIZE_X,
			SIZE_Y
		}
	},
	pivot = {
		vertical_alignment = "bottom",
		parent = "root",
		horizontal_alignment = "right",
		position = {
			-70,
			100,
			1
		},
		size = {
			0,
			0
		}
	}
}
local inventory_consumable_icons = {
	wpn_grimoire_01 = "teammate_consumable_icon_grimoire",
	potion_speed_boost_01 = "teammate_consumable_icon_speed",
	potion_healing_draught_01 = "teammate_consumable_icon_potion_01",
	grenade_frag_02 = "teammate_consumable_icon_frag",
	[3.0] = "teammate_consumable_icon_potion_empty",
	grenade_frag_01 = "teammate_consumable_icon_frag",
	grenade_smoke_02 = "teammate_consumable_icon_smoke",
	grenade_fire_01 = "teammate_consumable_icon_fire",
	grenade_fire_02 = "teammate_consumable_icon_fire",
	[1.0] = "teammate_consumable_icon_medpack_empty",
	[2.0] = "teammate_consumable_icon_grenade_empty",
	grenade_smoke_01 = "teammate_consumable_icon_smoke",
	wpn_side_objective_tome_01 = "teammate_consumable_icon_book",
	potion_damage_boost_01 = "teammate_consumable_icon_strength",
	healthkit_first_aid_kit_01 = "teammate_consumable_icon_medpack"
}
local inventory_index_by_slot = {
	slot_potion = 3,
	slot_grenade = 2,
	slot_healthkit = 1
}
local weapon_slot_widget_settings = {
	ammo_fields = {
		slot_ranged = "ammo_text_weapon_slot_2",
		slot_melee = "ammo_text_weapon_slot_1"
	}
}

local function create_static_potrait_widget()
	return {
		scenegraph_id = "pivot",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "portrait_frame",
					texture_id = "portrait_frame",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "texture",
					style_id = "character_portrait",
					texture_id = "character_portrait",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "texture",
					style_id = "player_level_bg",
					texture_id = "player_level_bg",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					style_id = "player_level",
					pass_type = "text",
					text_id = "player_level",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "texture",
					style_id = "host_icon",
					texture_id = "host_icon",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content)
						return content.is_host
					end
				}
			}
		},
		content = {
			player_level_bg = "unit_frame_lvl_bg",
			character_portrait = "unit_frame_portrait_empire_soldier",
			host_icon = "host_icon",
			portrait_frame = "unit_frame_01",
			is_host = false,
			player_level = "-"
		},
		style = {
			portrait_frame = {
				size = {
					141,
					198
				},
				offset = {
					-71,
					-99,
					5
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			character_portrait = {
				size = {
					66,
					101
				},
				offset = {
					-33,
					-50.5,
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
					-30,
					-48,
					4
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			player_level_bg = {
				size = {
					57,
					28
				},
				offset = {
					-29,
					-80,
					3
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			player_level = {
				vertical_alignment = "center",
				font_type = "hell_shark",
				font_size = 18,
				horizontal_alignment = "center",
				text_color = Colors.get_table("cheeseburger"),
				offset = {
					0,
					-65,
					3
				}
			}
		},
		offset = {
			0,
			0,
			0
		}
	}
end

local function create_dynamic_potrait_widget()
	return {
		scenegraph_id = "pivot",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "portrait_overlay",
					texture_id = "portrait_overlay",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content)
						return content.display_portrait_overlay
					end
				},
				{
					pass_type = "texture",
					style_id = "portrait_icon",
					texture_id = "portrait_icon",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content)
						return content.display_portrait_icon
					end
				},
				{
					pass_type = "texture",
					style_id = "talk_indicator_highlight",
					texture_id = "talk_indicator_highlight",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "rotated_texture",
					style_id = "connecting_icon",
					texture_id = "connecting_icon",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content)
						return content.connecting
					end
				}
			}
		},
		content = {
			display_portrait_overlay = false,
			connecting = false,
			display_portrait_icon = false,
			portrait_overlay = "unit_frame_red_overlay",
			connecting_icon = "matchmaking_connecting_icon",
			portrait_icon = "unit_frame_icon_01",
			talk_indicator_highlight = "talk_indicator_frame"
		},
		style = {
			talk_indicator_highlight = {
				size = {
					70,
					105
				},
				offset = {
					-35,
					-50,
					3
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
					-25,
					-25,
					4
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
			portrait_overlay = {
				size = {
					66,
					101
				},
				offset = {
					-33,
					-50.5,
					1
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			portrait_icon = {
				size = {
					33,
					39
				},
				offset = {
					-5,
					-48,
					4
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		},
		offset = {
			0,
			0,
			0
		}
	}
end

local function create_static_loadout_widget()
	return {
		scenegraph_id = "pivot",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "hp_bar_bg",
					texture_id = "hp_bar_bg",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					pass_type = "texture",
					style_id = "hp_bar_fg",
					texture_id = "hp_bar_fg",
					retained_mode = RETAINED_MODE_ENABLED
				}
			}
		},
		content = {
			hp_bar_fg = "player_hp_bar_fg",
			hp_bar_bg = "player_hp_bar_bg"
		},
		style = {
			hp_bar_bg = {
				size = {
					198,
					24
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
			hp_bar_fg = {
				size = {
					198,
					24
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
		offset = {
			-245,
			-52,
			0
		}
	}
end

local function create_dynamic_loadout_widget()
	return {
		scenegraph_id = "pivot",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "hp_bar_highlight",
					texture_id = "hp_bar_highlight",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content, style)
						return not content.has_shield
					end
				},
				{
					pass_type = "texture",
					style_id = "shield_bar_highlight",
					texture_id = "hp_bar_highlight",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content, style)
						return content.has_shield
					end
				},
				{
					pass_type = "texture",
					style_id = "hp_bar_max_health_divider",
					texture_id = "hp_bar_max_health_divider",
					content_id = "hp_bar_max_health_divider",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content, style)
						return content.active
					end
				},
				{
					pass_type = "texture",
					style_id = "hp_bar_grimoire_icon",
					texture_id = "hp_bar_grimoire_icon",
					content_id = "hp_bar_grimoire_icon",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content, style)
						return content.active
					end
				},
				{
					style_id = "grimoire_debuff",
					pass_type = "texture_uv",
					content_id = "grimoire_debuff",
					retained_mode = RETAINED_MODE_ENABLED
				},
				{
					style_id = "hp_bar",
					pass_type = "texture_uv",
					content_id = "hp_bar",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content)
						return content.draw_health_bar
					end
				},
				{
					pass_type = "centered_texture_amount",
					style_id = "hp_bar_divider",
					texture_id = "hp_bar_divider",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content, style)
						return style.texture_amount > 0
					end
				},
				{
					style_id = "hp_bar_shield",
					pass_type = "texture_uv",
					content_id = "hp_bar_shield",
					retained_mode = RETAINED_MODE_ENABLED,
					content_check_function = function (content, style)
						return content.has_shield
					end
				}
			}
		},
		content = {
			hp_bar_divider = "player_hp_bar_divider",
			hp_bar_highlight = "player_hp_bar_highlight",
			bar_start_side = "right",
			hp_bar = {
				internal_bar_value = 0,
				wounded_texture_id = "player_hp_bar",
				texture_id = "player_hp_bar",
				draw_health_bar = true,
				bar_value = 1,
				normal_texture_id = "player_hp_bar_color_tint",
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
			grimoire_debuff = {
				bar_value = 0,
				texture_id = "player_hp_bar_overlay",
				internal_bar_value = 0,
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
			hp_bar_shield = {
				bar_value_position = 0,
				bar_value_size = 0,
				texture_id = "player_hp_bar",
				internal_bar_value_position = 0,
				bar_value = 0,
				bar_value_offset = 0,
				internal_bar_value = 0,
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
			hp_bar_grimoire_icon = {
				hp_bar_grimoire_icon = "grimoire_icon",
				active = false
			},
			hp_bar_max_health_divider = {
				hp_bar_max_health_divider = "max_health_divider",
				active = false
			}
		},
		style = {
			hp_bar_max_health_divider = {
				start_offset = 5,
				size = {
					2,
					24
				},
				offset = {
					5,
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
			hp_bar_grimoire_icon = {
				start_offset = -6,
				size = {
					24,
					16
				},
				offset = {
					12,
					4,
					8
				},
				color = {
					255,
					255,
					255,
					255
				}
			},
			hp_bar = {
				uv_start_pixels = 0,
				uv_scale_pixels = 178,
				offset_scale = 1,
				scale_axis = 1,
				size = {
					178,
					24
				},
				color = {
					255,
					255,
					255,
					255
				},
				default_offset = {
					10,
					0,
					3
				},
				offset = {
					10,
					0,
					3
				}
			},
			hp_bar_shield = {
				uv_scale_pixels = 178,
				start_offset = 10,
				uv_start_pixels = 0,
				offset_scale = 1,
				scale_axis = 1,
				size = {
					0,
					24
				},
				color = {
					255,
					0,
					166,
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
				},
				offset = {
					10,
					0,
					4
				}
			},
			grimoire_debuff = {
				start_offset = 0,
				uv_start_pixels = 0,
				uv_scale_pixels = 188,
				offset_scale = 1,
				scale_axis = 1,
				size = {
					0,
					24
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					6,
					0,
					7
				}
			},
			hp_bar_highlight = {
				size = {
					198,
					24
				},
				offset = {
					0,
					0,
					5
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			shield_bar_highlight = {
				size = {
					198,
					24
				},
				offset = {
					0,
					0,
					5
				},
				color = {
					255,
					140,
					180,
					255
				}
			},
			hp_bar_divider = {
				texture_axis = 1,
				texture_amount = 0,
				texture_size = {
					4,
					14
				},
				size = {
					178,
					14
				},
				offset = {
					10,
					5,
					6
				},
				color = {
					255,
					255,
					255,
					255
				}
			}
		},
		offset = {
			-245,
			-52,
			0
		}
	}
end

local features_list = {}
local widget_definitions = {
	portait_static = create_static_potrait_widget(),
	portait_dynamic = create_dynamic_potrait_widget(),
	loadout_static = create_static_loadout_widget(),
	loadout_dynamic = create_dynamic_loadout_widget()
}

return {
	weapon_slot_widget_settings = weapon_slot_widget_settings,
	inventory_index_by_slot = inventory_index_by_slot,
	inventory_consumable_icons = inventory_consumable_icons,
	features_list = features_list,
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
