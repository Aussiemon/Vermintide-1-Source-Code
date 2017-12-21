local MAX_SIZE = 228
local GAP = 2
local HIT_GAP = 3
local scenegraph_definition = {
	root = {
		is_root = true,
		position = {
			0,
			0,
			UILayer.hud
		},
		size = {
			1920,
			1080
		}
	},
	crosshair_root = {
		parent = "root",
		position = {
			0,
			0,
			50
		},
		size = {
			MAX_SIZE,
			MAX_SIZE
		}
	},
	crosshair_dot = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			4,
			4
		}
	},
	crosshair_up = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			0,
			GAP + 5,
			1
		},
		size = {
			4,
			10
		}
	},
	crosshair_down = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			0,
			GAP - -5,
			1
		},
		size = {
			4,
			10
		}
	},
	crosshair_left = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			GAP - -5,
			0,
			1
		},
		size = {
			10,
			4
		}
	},
	crosshair_right = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			GAP + 5,
			0,
			1
		},
		size = {
			10,
			4
		}
	},
	crosshair_circle = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			0,
			0,
			1
		},
		size = {
			126,
			126
		}
	},
	crosshair_hit_1 = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			HIT_GAP + 4,
			HIT_GAP + 4,
			1
		},
		size = {
			8,
			8
		}
	},
	crosshair_hit_2 = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			HIT_GAP - 4,
			HIT_GAP + 4,
			1
		},
		size = {
			8,
			8
		}
	},
	crosshair_hit_3 = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			HIT_GAP - 4,
			HIT_GAP - 4,
			1
		},
		size = {
			8,
			8
		}
	},
	crosshair_hit_4 = {
		vertical_alignment = "center",
		parent = "crosshair_root",
		horizontal_alignment = "center",
		position = {
			HIT_GAP + 4,
			HIT_GAP - 4,
			1
		},
		size = {
			8,
			8
		}
	}
}
local widget_definitions = {
	crosshair_dot = {
		scenegraph_id = "crosshair_dot",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "crosshair_01_center"
		},
		style = {
			offset = {
				0,
				0,
				0
			}
		}
	},
	crosshair_up = {
		scenegraph_id = "crosshair_up",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "crosshair_01_vertical"
		},
		style = {
			offset = {
				0,
				0,
				0
			}
		}
	},
	crosshair_down = {
		scenegraph_id = "crosshair_down",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "crosshair_01_vertical"
		},
		style = {
			offset = {
				0,
				0,
				0
			}
		}
	},
	crosshair_left = {
		scenegraph_id = "crosshair_left",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "crosshair_01_horizontal"
		},
		style = {
			offset = {
				0,
				0,
				0
			}
		}
	},
	crosshair_right = {
		scenegraph_id = "crosshair_right",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "crosshair_01_horizontal"
		},
		style = {
			offset = {
				0,
				0,
				0
			}
		}
	},
	crosshair_hit_1 = {
		scenegraph_id = "crosshair_hit_1",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*2,
				pivot = {
					0,
					0
				},
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
				}
			}
		}
	},
	crosshair_hit_2 = {
		scenegraph_id = "crosshair_hit_2",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*1.5,
				pivot = {
					0,
					0
				},
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
				}
			}
		}
	},
	crosshair_hit_3 = {
		scenegraph_id = "crosshair_hit_3",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*1,
				pivot = {
					0,
					0
				},
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
				}
			}
		}
	},
	crosshair_hit_4 = {
		scenegraph_id = "crosshair_hit_4",
		element = UIElements.RotatedTexture,
		content = {
			texture_id = "crosshair_01_hit"
		},
		style = {
			rotating_texture = {
				angle = math.pi*0.5,
				pivot = {
					0,
					0
				},
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
				}
			}
		}
	},
	crosshair_circle = {
		scenegraph_id = "crosshair_circle",
		element = UIElements.SimpleTexture,
		content = {
			texture_id = "crosshair_02"
		},
		style = {
			offset = {
				0,
				0,
				0
			}
		}
	}
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	max_spread_pitch = MAX_SIZE,
	max_spread_yaw = MAX_SIZE
}
