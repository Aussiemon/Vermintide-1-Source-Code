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
			50,
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
			450,
			134
		}
	},
	bar_frame = {
		vertical_alignment = "bottom",
		parent = "info_box",
		horizontal_alignment = "center",
		position = {
			0,
			-22,
			1
		},
		size = {
			246,
			24
		}
	},
	input_icon_pivot_yes = {
		vertical_alignment = "top",
		parent = "bar_frame",
		horizontal_alignment = "center",
		position = {
			-45,
			-28,
			1
		},
		size = {
			0,
			0
		}
	},
	input_icon_pivot_no = {
		vertical_alignment = "top",
		parent = "bar_frame",
		horizontal_alignment = "center",
		position = {
			45,
			-28,
			1
		},
		size = {
			0,
			0
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
		horizontal_alignment = "center",
		position = {
			0,
			21,
			2
		},
		size = {
			31,
			25
		}
	},
	option_no = {
		vertical_alignment = "top",
		parent = "option_box",
		horizontal_alignment = "center",
		position = {
			0,
			21,
			0
		},
		size = {
			31,
			25
		}
	},
	input_bar_option_no = {
		vertical_alignment = "bottom",
		parent = "option_box",
		horizontal_alignment = "left",
		position = {
			6,
			5,
			1
		},
		size = {
			346,
			34
		}
	},
	input_bar_option_yes = {
		vertical_alignment = "bottom",
		parent = "option_box",
		horizontal_alignment = "left",
		position = {
			6,
			39,
			1
		},
		size = {
			346,
			34
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
			style_id = "option_texture",
			texture_id = "option_texture"
		},
		{
			style_id = "bar",
			pass_type = "texture_uv",
			content_id = "bar",
			content_check_function = function (content)
				local parent = content.parent

				return parent.can_vote and not parent.has_voted
			end
		},
		{
			pass_type = "texture",
			style_id = "bar_bg",
			texture_id = "bar_bg",
			content_check_function = function (content)
				return content.can_vote and not content.has_voted
			end
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
		},
		{
			style_id = "input_text",
			pass_type = "text",
			text_id = "input_text",
			content_check_function = function (content)
				return content.can_vote and not content.has_voted
			end
		},
		{
			pass_type = "texture",
			style_id = "input_icon",
			texture_id = "input_icon",
			content_check_function = function (content)
				return content.can_vote and not content.has_voted and content.input_icon
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
					style_id = "info_box",
					texture_id = "info_box"
				},
				{
					pass_type = "texture",
					style_id = "bar_frame",
					texture_id = "bar_frame",
					content_check_function = function (content)
						return content.can_vote and not content.has_voted
					end
				},
				{
					pass_type = "texture",
					style_id = "bar_bg",
					texture_id = "bar_bg",
					content_check_function = function (content)
						return content.can_vote and not content.has_voted
					end
				},
				{
					pass_type = "texture",
					style_id = "input_info_bg",
					texture_id = "input_info_bg",
					content_check_function = function (content)
						return not content.has_voted and not content.can_vote
					end
				},
				{
					style_id = "input_text",
					pass_type = "text",
					text_id = "input_text",
					content_check_function = function (content)
						return not content.has_voted and not content.can_vote
					end
				},
				{
					style_id = "title_text",
					pass_type = "text",
					text_id = "title_text"
				},
				{
					style_id = "info_text",
					pass_type = "text",
					text_id = "info_text"
				},
				{
					pass_type = "texture",
					style_id = "gamepad_input_icon",
					texture_id = "gamepad_input_icon",
					content_check_function = function (content)
						return content.gamepad_input_icon and content.is_gamepad_active and not content.has_voted
					end
				}
			}
		},
		content = {
			info_box = "voting_frame_01",
			title_text = "",
			can_vote = false,
			input_text = "voting_open_description",
			has_voted = false,
			input_info_bg = "voting_bottom_fade",
			info_text = "",
			bar_frame = "voting_frame_02",
			bar_bg = "voting_frame_02_bg"
		},
		style = {
			info_box = {
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
				}
			},
			input_info_bg = {
				scenegraph_id = "info_box",
				size = {
					434,
					60
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					8,
					-58,
					2
				}
			},
			bar_frame = {
				scenegraph_id = "bar_frame",
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					2
				}
			},
			bar_bg = {
				scenegraph_id = "bar_frame",
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					0,
					-5
				}
			},
			input_text = {
				vertical_alignment = "bottom",
				scenegraph_id = "info_box",
				localize = true,
				horizontal_alignment = "center",
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					-30,
					2
				}
			},
			info_text = {
				font_size = 20,
				scenegraph_id = "info_box",
				localize = false,
				word_wrap = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					2,
					0
				}
			},
			title_text = {
				vertical_alignment = "top",
				scenegraph_id = "info_box",
				localize = false,
				horizontal_alignment = "center",
				font_size = 24,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					-12,
					1
				}
			}
		}
	},
	option_yes = {
		scenegraph_id = "option_yes",
		element = option_element,
		content = {
			option_texture = "voting_icon_01",
			can_vote = false,
			input_text = "",
			has_voted = false,
			result_text = "0",
			gamepad_active = false,
			left_side = true,
			option_text = "",
			bar_bg = "voting_bar_01",
			bar = {
				texture_id = "voting_bar_01",
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
		},
		style = {
			bar = {
				default_width = 115,
				scenegraph_id = "bar_frame",
				size = {
					115,
					19
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					6,
					4,
					-3
				},
				default_offset = {
					6,
					4,
					-3
				}
			},
			bar_bg = {
				default_width = 115,
				scenegraph_id = "bar_frame",
				size = {
					115,
					19
				},
				color = {
					150,
					255,
					255,
					255
				},
				offset = {
					6,
					4,
					-3
				},
				default_offset = {
					6,
					4,
					-4
				}
			},
			option_texture = {
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					10,
					1
				}
			},
			input_icon = {
				scenegraph_id = "input_icon_pivot_yes",
				color = {
					255,
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
			option_text = {
				font_size = 24,
				localize = false,
				horizontal_alignment = "left",
				word_wrap = false,
				pixel_perfect = true,
				vertical_alignment = "bottom",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					35,
					3,
					1
				}
			},
			result_text = {
				font_size = 24,
				localize = false,
				horizontal_alignment = "left",
				word_wrap = false,
				pixel_perfect = true,
				vertical_alignment = "bottom",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					35,
					3,
					1
				}
			},
			input_text = {
				scenegraph_id = "info_box",
				localize = false,
				horizontal_alignment = "right",
				word_wrap = false,
				pixel_perfect = true,
				font_size = 24,
				vertical_alignment = "bottom",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					-235,
					-55,
					1
				}
			}
		}
	},
	option_no = {
		scenegraph_id = "option_no",
		element = option_element,
		content = {
			option_texture = "voting_icon_02",
			can_vote = false,
			input_text = "",
			has_voted = false,
			result_text = "0",
			gamepad_active = false,
			option_text = "",
			bar_bg = "voting_bar_02",
			bar = {
				texture_id = "voting_bar_02",
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
		},
		style = {
			bar = {
				default_width = 115,
				scenegraph_id = "bar_frame",
				size = {
					115,
					19
				},
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					125,
					4,
					-3
				},
				default_offset = {
					125,
					4,
					-3
				}
			},
			bar_bg = {
				default_width = 115,
				scenegraph_id = "bar_frame",
				size = {
					115,
					19
				},
				color = {
					150,
					255,
					255,
					255
				},
				offset = {
					125,
					4,
					-3
				},
				default_offset = {
					125,
					4,
					-4
				}
			},
			option_texture = {
				color = {
					255,
					255,
					255,
					255
				},
				offset = {
					0,
					10,
					1
				}
			},
			input_icon = {
				scenegraph_id = "input_icon_pivot_no",
				color = {
					255,
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
			option_text = {
				vertical_alignment = "bottom",
				localize = false,
				font_size = 24,
				horizontal_alignment = "left",
				font_type = "hell_shark",
				word_wrap = false,
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					35,
					3,
					1
				}
			},
			result_text = {
				vertical_alignment = "bottom",
				localize = false,
				font_size = 24,
				horizontal_alignment = "left",
				font_type = "hell_shark",
				word_wrap = false,
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					35,
					3,
					1
				}
			},
			input_text = {
				font_size = 24,
				scenegraph_id = "info_box",
				localize = false,
				word_wrap = false,
				horizontal_alignment = "left",
				vertical_alignment = "bottom",
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					235,
					-55,
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
