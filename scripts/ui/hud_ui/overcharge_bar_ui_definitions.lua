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
		vertical_alignment = "bottom",
		parent = "root",
		horizontal_alignment = "right",
		position = {
			-10,
			420,
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
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
