local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.ingame_voting
		},
		size = {
			1920,
			1080
		}
	},
	voting_box_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "left",
		position = {
			10,
			0,
			0
		},
		size = {
			1,
			1
		}
	},
	info_box = {
		vertical_alignment = "bottom",
		parent = "voting_box_root",
		horizontal_alignment = "left",
		position = {
			0,
			0,
			1
		},
		size = {
			358,
			53
		}
	},
	info_box_top = {
		vertical_alignment = "top",
		parent = "info_box",
		horizontal_alignment = "left",
		position = {
			0,
			29,
			0
		},
		size = {
			358,
			29
		}
	},
	info_text = {
		vertical_alignment = "top",
		parent = "info_box",
		horizontal_alignment = "left",
		position = {
			15,
			14,
			1
		},
		size = {
			328,
			53
		}
	},
	option_box = {
		vertical_alignment = "bottom",
		parent = "info_box",
		horizontal_alignment = "left",
		position = {
			0,
			-84,
			0
		},
		size = {
			358,
			84
		}
	},
	option_yes = {
		vertical_alignment = "top",
		parent = "option_box",
		horizontal_alignment = "left",
		position = {
			15,
			-17,
			1
		},
		size = {
			328,
			26
		}
	},
	option_no = {
		vertical_alignment = "top",
		parent = "option_yes",
		horizontal_alignment = "left",
		position = {
			0,
			-30,
			0
		},
		size = {
			328,
			26
		}
	}
}
local text_box_element = {
	passes = {
		{
			pass_type = "rect",
			style_id = "rect"
		},
		{
			pass_type = "border",
			style_id = "border"
		},
		{
			style_id = "text",
			pass_type = "text",
			text_id = "text"
		}
	}
}
local option_element = {
	passes = {
		{
			pass_type = "texture",
			style_id = "checkbox_texture",
			texture_id = "checkbox_texture"
		},
		{
			pass_type = "texture",
			style_id = "option_texture",
			texture_id = "option_texture"
		},
		{
			pass_type = "texture",
			style_id = "glow_effect_texture",
			texture_id = "glow_effect_texture"
		},
		{
			style_id = "option_text",
			pass_type = "text",
			text_id = "option_text",
			content_check_function = function (content)
				return not content.has_voted
			end
		},
		{
			style_id = "result_text",
			pass_type = "text",
			text_id = "result_text",
			content_check_function = function (content)
				return content.has_voted
			end
		}
	}
}
local widget_definitions = {
	background = {
		scenegraph_id = "voting_box_root",
		element = {
			passes = {
				{
					pass_type = "texture",
					style_id = "info_box_top",
					texture_id = "info_box_top"
				},
				{
					pass_type = "tiled_texture",
					style_id = "info_box_middle",
					texture_id = "info_box_middle"
				},
				{
					pass_type = "texture",
					style_id = "option_box",
					texture_id = "option_box"
				},
				{
					style_id = "info_text",
					pass_type = "text",
					text_id = "info_text"
				}
			}
		},
		content = {
			option_box = "vote_kick_window_bottom",
			info_box_top = "vote_kick_window_top",
			info_box_middle = "vote_kick_window_middle",
			info_text = ""
		},
		style = {
			info_box_top = {
				scenegraph_id = "info_box_top",
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				}
			},
			info_box_middle = {
				scenegraph_id = "info_box",
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				},
				texture_tiling_size = {
					358,
					53
				}
			},
			option_box = {
				scenegraph_id = "option_box",
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				}
			},
			info_text = {
				word_wrap = true,
				scenegraph_id = "info_text",
				localize = false,
				font_size = 28,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					0
				}
			}
		}
	},
	option_yes = {
		scenegraph_id = "option_yes",
		element = option_element,
		content = {
			checkbox_texture = "vote_kick_window_checkbox",
			option_text = "",
			glow_effect_texture = "vote_kick_window_glow_effect_green",
			option_texture = "vote_kick_window_icon_01",
			result_text = "0",
			has_voted = false
		},
		style = {
			checkbox_texture = {
				size = {
					26,
					26
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				}
			},
			option_texture = {
				size = {
					15,
					15
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					5.5,
					5.5,
					1
				}
			},
			glow_effect_texture = {
				size = {
					74,
					74
				},
				color = {
					0,
					255,
					255,
					255
				},
				offset = {
					-24,
					-24,
					2
				}
			},
			option_text = {
				font_size = 24,
				localize = false,
				horizontal_alignment = "left",
				word_wrap = false,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					35,
					-2,
					1
				}
			},
			result_text = {
				font_size = 24,
				localize = false,
				horizontal_alignment = "left",
				word_wrap = false,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					35,
					-2,
					1
				}
			}
		}
	},
	option_no = {
		scenegraph_id = "option_no",
		element = option_element,
		content = {
			checkbox_texture = "vote_kick_window_checkbox",
			option_text = "",
			glow_effect_texture = "vote_kick_window_glow_effect_red",
			option_texture = "vote_kick_window_icon_02",
			result_text = "0",
			has_voted = false
		},
		style = {
			checkbox_texture = {
				size = {
					26,
					26
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					0
				}
			},
			option_texture = {
				size = {
					15,
					15
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					5.5,
					5.5,
					1
				}
			},
			glow_effect_texture = {
				size = {
					74,
					74
				},
				color = {
					0,
					255,
					255,
					255
				},
				offset = {
					-24,
					-24,
					2
				}
			},
			option_text = {
				font_size = 24,
				localize = false,
				horizontal_alignment = "left",
				word_wrap = false,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					35,
					-2,
					1
				}
			},
			result_text = {
				font_size = 24,
				localize = false,
				horizontal_alignment = "left",
				word_wrap = false,
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					35,
					-2,
					1
				}
			}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions
}
