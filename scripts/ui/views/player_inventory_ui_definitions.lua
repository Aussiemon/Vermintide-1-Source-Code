require("scripts/settings/inventory_settings")

local RETAINED_MODE_ENABLED = true
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.hud_inventory
		},
		size = {
			1920,
			1080
		}
	},
	inventory_entry_base = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "right",
		position = {
			-10,
			-140,
			1
		},
		size = {
			1,
			1
		}
	},
	charge_bar = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			512,
			128
		},
		position = {
			0,
			-220,
			1
		}
	},
	charge_bar_black_divider_start = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			8,
			8
		},
		position = {
			0,
			0,
			3
		}
	},
	charge_bar_white_divider_start_left = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			32,
			32
		},
		position = {
			2,
			0,
			4
		}
	},
	charge_bar_white_divider_start_right = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			32,
			32
		},
		position = {
			-2,
			0,
			4
		}
	},
	charge_bar_flames = {
		vertical_alignment = "bottom",
		parent = "charge_bar",
		horizontal_alignment = "center",
		size = {
			512,
			256
		},
		position = {
			0,
			0,
			-1
		}
	},
	attention_bar = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			212,
			24
		},
		position = {
			0,
			-170,
			1
		}
	},
	attention_bar_bg = {
		vertical_alignment = "center",
		parent = "attention_bar",
		horizontal_alignment = "center",
		size = {
			212,
			24
		},
		position = {
			0,
			0,
			1
		}
	},
	attention_bar_lit = {
		vertical_alignment = "center",
		parent = "attention_bar_bg",
		horizontal_alignment = "center",
		size = {
			260,
			76
		},
		position = {
			0,
			0,
			3
		}
	},
	attention_bar_fill = {
		vertical_alignment = "center",
		parent = "attention_bar_bg",
		horizontal_alignment = "left",
		size = {
			212,
			24
		},
		position = {
			0,
			0,
			1
		}
	}
}
local bar_textures = {
	stance_bar = {
		bar = "stance_bar_blue",
		glow = "stance_bar_glow_blue"
	},
	charge_bar = {
		bar = "stance_bar_orange",
		glow = "stance_bar_glow_orange"
	},
	attention_bar = {
		stance_bar = {
			bar = "hud_stance_bar_2",
			lit = "hud_stance_bar_2_lit"
		},
		charge_bar = {
			bar = "hud_charge_bar_2",
			lit = "hud_charge_bar_2_lit"
		}
	}
}
local widget_definitions = {
	charge_bar = {
		scenegraph_id = "charge_bar",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "bar_bg",
					texture_id = "bar_bg"
				},
				{
					pass_type = "texture",
					style_id = "flames_texture",
					texture_id = "flames_texture"
				},
				{
					pass_type = "texture",
					style_id = "flames_texture_mask",
					texture_id = "flames_texture_mask"
				},
				{
					pass_type = "gradient_mask_texture",
					style_id = "sidefade",
					texture_id = "sidefade"
				},
				{
					pass_type = "gradient_mask_texture",
					style_id = "fill",
					texture_id = "fill"
				},
				{
					pass_type = "rotated_texture",
					style_id = "black_divider_left",
					texture_id = "black_divider"
				},
				{
					pass_type = "rotated_texture",
					style_id = "black_divider_right",
					texture_id = "black_divider"
				},
				{
					pass_type = "rotated_texture",
					style_id = "white_divider_left",
					texture_id = "white_divider"
				},
				{
					pass_type = "rotated_texture",
					style_id = "white_divider_right",
					texture_id = "white_divider"
				}
			}
		},
		content = {
			sidefade = "overchargecircle_sidefade",
			fill = "overchargecircle_fill",
			white_divider = "overchargecircle_white_divider",
			black_divider = "overchargecircle_black_divider",
			bar_bg = "overchargecircle_bg",
			flames_texture_mask = "charge_bar_flames_mask",
			flames_texture = "charge_bar_flames"
		},
		style = {
			black_divider_left = {
				angle = 0,
				scenegraph_id = "charge_bar_black_divider_start",
				color = {
					255,
					255,
					255,
					255
				},
				pivot = {
					4,
					4
				},
				offset = {
					0,
					0,
					0
				}
			},
			black_divider_right = {
				angle = 0,
				scenegraph_id = "charge_bar_black_divider_start",
				color = {
					255,
					255,
					255,
					255
				},
				pivot = {
					4,
					4
				},
				offset = {
					0,
					0,
					0
				}
			},
			white_divider_left = {
				angle = 0,
				scenegraph_id = "charge_bar_white_divider_start_left",
				color = {
					255,
					255,
					255,
					255
				},
				pivot = {
					16,
					16
				},
				offset = {
					0,
					0,
					0
				}
			},
			white_divider_right = {
				angle = 0,
				scenegraph_id = "charge_bar_white_divider_start_right",
				color = {
					255,
					255,
					255,
					255
				},
				pivot = {
					16,
					16
				},
				offset = {
					0,
					0,
					0
				}
			},
			fill = {
				gradient_threshold = 0,
				color = {
					255,
					255,
					255,
					0
				}
			},
			sidefade = {
				gradient_threshold = 1,
				color = {
					255,
					255,
					255,
					255
				}
			},
			bar_bg = {
				color = {
					255,
					255,
					255,
					255
				}
			},
			flames_texture = {
				scenegraph_id = "charge_bar_flames",
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
			flames_texture_mask = {
				scenegraph_id = "charge_bar_flames",
				color = {
					255,
					255,
					255,
					255
				}
			}
		}
	},
	attention_bar = {
		scenegraph_id = "attention_bar",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "bar_bg",
					texture_id = "bar_bg"
				},
				{
					pass_type = "texture",
					style_id = "bar_fg",
					texture_id = "bar_fg"
				},
				{
					style_id = "bar",
					pass_type = "texture_uv_dynamic_color_uvs_size_offset",
					content_id = "bar",
					dynamic_function = function (content, style, size, dt)
						local bar_value = content.bar_value
						local uv_start_pixels = style.uv_start_pixels
						local uv_scale_pixels = style.uv_scale_pixels
						local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
						local uvs = style.uvs
						local uv_scale_axis = style.scale_axis
						local offset_scale = style.offset_scale
						local offset = {
							0,
							0,
							0
						}
						uvs[2][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels)
						size[uv_scale_axis] = uv_pixels

						return content.color, uvs, size, offset
					end
				},
				{
					pass_type = "texture",
					style_id = "bar_lit",
					texture_id = "bar_lit"
				}
			}
		},
		content = {
			bar_bg = "interaction_bar_bg",
			bar_fg = "interaction_bar_fg_skulls",
			bar_lit = "stance_bar_glow_blue",
			bar = {
				texture_id = "stance_bar_blue",
				bar_value = 1
			}
		},
		style = {
			bar_fg = {
				scenegraph_id = "attention_bar_bg",
				size = {
					245,
					24
				},
				offset = {
					-16,
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
			bar_bg = {
				scenegraph_id = "attention_bar_bg",
				color = {
					255,
					255,
					255,
					255
				}
			},
			bar_lit = {
				scenegraph_id = "attention_bar_lit",
				color = {
					0,
					255,
					255,
					255
				}
			},
			bar = {
				uv_start_pixels = 5,
				scenegraph_id = "attention_bar_fill",
				uv_scale_pixels = 207,
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
			}
		}
	}
}
local SLOTS_LIST = InventorySettings.weapon_slots
local consumable_slots = {
	slot_healthkit = 1,
	slot_grenade = 3,
	slot_potion = 2
}

local function create_inventory_entry_widgets(num_of_entries)
	local entries = {}

	for i = 1, num_of_entries, 1 do
		local slot = SLOTS_LIST[i]
		local slot_name = slot.name
		local is_consumable_slot = (consumable_slots[slot_name] and true) or false
		local scenegraph_id = "inventory_entry_" .. i
		local scenegraph_root_id = "inventory_entry_root_" .. i
		local scenegraph_background_id = "inventory_entry_background_" .. i
		local scenegraph_default_icon_id = "inventory_entry_default_icon_" .. i
		local scenegraph_icon_id = "inventory_entry_icon_" .. i
		local scenegraph_stance_bar_id = "inventory_entry_stance_bar_" .. i
		local scenegraph_stance_bar_fill_id = "inventory_entry_stance_bar_fill_" .. i
		local scenegraph_stance_bar_glow_id = "inventory_entry_stance_bar_glow_" .. i
		local scenegraph_ammo_text_root_id = "inventory_entry_ammo_text_root_" .. i
		local scenegraph_ammo_text_1_id = "inventory_entry_ammo_text_1_" .. i
		local scenegraph_ammo_text_2_id = "inventory_entry_ammo_text_2_" .. i
		scenegraph_definition[scenegraph_root_id] = {
			vertical_alignment = "center",
			parent = "inventory_entry_base",
			horizontal_alignment = "right",
			position = {
				-5,
				0,
				1
			},
			size = {
				512,
				128
			}
		}
		scenegraph_definition[scenegraph_id] = {
			horizontal_alignment = "right",
			parent = scenegraph_root_id,
			position = {
				0,
				0,
				1
			},
			size = {
				512,
				128
			}
		}

		if not is_consumable_slot then
			scenegraph_definition[scenegraph_background_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				parent = scenegraph_id,
				position = {
					0,
					0,
					1
				},
				size = {
					256,
					128
				}
			}
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				parent = scenegraph_background_id,
				position = {
					-20,
					0,
					1
				},
				size = {
					256,
					64
				}
			}
		elseif slot_name == "slot_healthkit" then
			scenegraph_definition[scenegraph_background_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				parent = scenegraph_id,
				position = {
					1,
					0,
					1
				},
				size = {
					96,
					96
				}
			}
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				parent = scenegraph_background_id,
				position = {
					0,
					0,
					1
				},
				size = {
					96,
					96
				}
			}
		else
			scenegraph_definition[scenegraph_background_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				parent = scenegraph_id,
				position = {
					1,
					0,
					1
				},
				size = {
					64,
					64
				}
			}
			scenegraph_definition[scenegraph_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				parent = scenegraph_background_id,
				position = {
					0,
					0,
					1
				},
				size = {
					64,
					64
				}
			}
		end

		if slot_name == "slot_healthkit" then
			scenegraph_definition[scenegraph_default_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				parent = scenegraph_id,
				position = {
					1,
					0,
					1
				},
				size = {
					76.8,
					76.8
				}
			}
		else
			scenegraph_definition[scenegraph_default_icon_id] = {
				vertical_alignment = "center",
				horizontal_alignment = "right",
				parent = scenegraph_id,
				position = {
					1,
					0,
					1
				},
				size = {
					51.2,
					51.2
				}
			}
		end

		scenegraph_definition[scenegraph_stance_bar_id] = {
			horizontal_alignment = "right",
			parent = scenegraph_background_id,
			position = {
				18,
				0,
				1
			},
			size = {
				32,
				128
			}
		}
		scenegraph_definition[scenegraph_stance_bar_fill_id] = {
			parent = scenegraph_stance_bar_id,
			position = {
				18,
				31,
				1
			},
			size = {
				9,
				67
			}
		}
		scenegraph_definition[scenegraph_stance_bar_glow_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			parent = scenegraph_stance_bar_fill_id,
			position = {
				0,
				0,
				5
			},
			size = {
				32,
				128
			}
		}
		scenegraph_definition[scenegraph_ammo_text_root_id] = {
			vertical_alignment = "bottom",
			horizontal_alignment = "left",
			parent = scenegraph_icon_id,
			position = {
				55,
				-6,
				1
			},
			size = {
				8,
				32
			}
		}
		scenegraph_definition[scenegraph_ammo_text_1_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "left",
			parent = scenegraph_ammo_text_root_id,
			position = {
				-61,
				0,
				1
			},
			size = {
				60,
				60
			}
		}
		scenegraph_definition[scenegraph_ammo_text_2_id] = {
			vertical_alignment = "center",
			horizontal_alignment = "right",
			parent = scenegraph_ammo_text_root_id,
			position = {
				61,
				0,
				1
			},
			size = {
				60,
				60
			}
		}
		local inventory_entry_widget = {
			element = {
				passes = {
					{
						pass_type = "texture",
						style_id = "background",
						texture_id = "background",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.has_data
						end
					},
					{
						pass_type = "texture",
						style_id = "background_lit",
						texture_id = "background_lit",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.has_data
						end
					},
					{
						pass_type = "texture",
						style_id = "default_icon",
						texture_id = "default_icon",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return not content.has_data
						end
					},
					{
						pass_type = "texture",
						style_id = "icon",
						texture_id = "icon",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.has_data
						end
					},
					{
						pass_type = "texture",
						style_id = "icon_lit",
						texture_id = "icon_lit",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.has_data
						end
					},
					{
						pass_type = "texture",
						style_id = "stance_bar_fg",
						texture_id = "stance_bar_fg",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.stance_bar.active
						end
					},
					{
						pass_type = "texture",
						style_id = "stance_bar_lit",
						texture_id = "stance_bar_lit",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.stance_bar.active
						end
					},
					{
						pass_type = "texture",
						style_id = "stance_bar_glow",
						texture_id = "stance_bar_glow",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return content.stance_bar.active
						end
					},
					{
						style_id = "stance_bar",
						pass_type = "texture_uv_dynamic_color_uvs_size_offset",
						content_id = "stance_bar",
						content_check_function = function (content)
							return content.active
						end,
						dynamic_function = function (content, style, size, dt)
							local bar_value = content.bar_value
							local uv_start_pixels = style.uv_start_pixels
							local uv_scale_pixels = style.uv_scale_pixels
							local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
							local uvs = style.uvs
							local uv_scale_axis = style.scale_axis
							local offset_scale = style.offset_scale
							local offset = style.offset
							uvs[1][uv_scale_axis] = uv_pixels/(uv_start_pixels + uv_scale_pixels) - 1
							size[uv_scale_axis] = uv_pixels

							return content.color, uvs, size, offset
						end
					},
					{
						style_id = "ammo_text_1",
						pass_type = "text",
						text_id = "ammo_text_1",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return not content.stance_bar.active and content.has_data
						end
					},
					{
						style_id = "ammo_text_2",
						pass_type = "text",
						text_id = "ammo_text_2",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return not content.stance_bar.active and content.has_data
						end
					},
					{
						pass_type = "texture",
						style_id = "ammo_divider",
						texture_id = "ammo_divider",
						retained_mode = RETAINED_MODE_ENABLED,
						content_check_function = function (content)
							return not content.stance_bar.active and content.has_data and content.ammo_text_1 ~= ""
						end
					}
				}
			},
			content = {
				ammo_divider = "weapon_generic_icons_ammodivider",
				stance_bar_fg = "stance_bar_frame",
				selected = false,
				ammo_text_1 = "ammo_text",
				icon_lit = "weapon_icon_empty",
				stance_bar_glow = "stance_bar_glow_orange",
				default_icon = "consumables_frame_bg_lit",
				stance_bar_lit = "stance_bar_frame_lit",
				icon = "weapon_icon_empty",
				ammo_text_2 = "ammo_text",
				background = (is_consumable_slot and "consumables_frame_bg_lit") or "weapon_generic_icons_bg",
				background_lit = (is_consumable_slot and "consumables_frame_lit") or "weapon_generic_icons_bg_lit",
				stance_bar = {
					bar_value = 0,
					active = false,
					texture_id = "stance_bar_orange"
				}
			},
			style = {
				ammo_divider = {
					color = {
						255,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_ammo_text_root_id
				},
				background = {
					color = {
						255,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_background_id
				},
				background_lit = {
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_background_id
				},
				icon = {
					color = {
						255,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_icon_id
				},
				icon_lit = {
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_icon_id
				},
				default_icon = {
					color = {
						150,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_default_icon_id
				},
				stance_bar_fg = {
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
					},
					scenegraph_id = scenegraph_stance_bar_id
				},
				stance_bar_lit = {
					offset = {
						0,
						0,
						4
					},
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_stance_bar_id
				},
				stance_bar_glow = {
					offset = {
						0,
						0,
						0
					},
					color = {
						0,
						255,
						255,
						255
					},
					scenegraph_id = scenegraph_stance_bar_glow_id
				},
				stance_bar = {
					uv_start_pixels = 0,
					uv_scale_pixels = 67,
					offset_scale = 1,
					scale_axis = 2,
					scenegraph_id = scenegraph_stance_bar_fill_id,
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
				ammo_text_1 = {
					vertical_alignment = "center",
					dynamic_font = true,
					horizontal_alignment = "right",
					font_size = 26,
					pixel_perfect = false,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 255),
					scenegraph_id = scenegraph_ammo_text_1_id
				},
				ammo_text_2 = {
					vertical_alignment = "center",
					dynamic_font = true,
					horizontal_alignment = "left",
					font_size = 26,
					pixel_perfect = false,
					font_type = "hell_shark",
					text_color = Colors.get_color_table_with_alpha("white", 150),
					scenegraph_id = scenegraph_ammo_text_2_id
				}
			},
			scenegraph_id = scenegraph_id
		}
		entries[i] = inventory_entry_widget
	end

	return entries
end

return {
	scenegraph_definition = scenegraph_definition,
	inventory_entry_definitions = create_inventory_entry_widgets(#SLOTS_LIST),
	widget_definitions = widget_definitions,
	bar_textures = bar_textures
}
