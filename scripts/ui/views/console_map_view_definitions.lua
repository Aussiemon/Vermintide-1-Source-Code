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
	frame = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			1
		}
	},
	time_line = {
		vertical_alignment = "top",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			200,
			40
		},
		position = {
			0,
			-60,
			55
		}
	},
	time_line_slot_1 = {
		vertical_alignment = "top",
		parent = "time_line",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-81,
			0,
			1
		}
	},
	time_line_slot_2 = {
		vertical_alignment = "top",
		parent = "time_line",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			-27,
			0,
			1
		}
	},
	time_line_slot_3 = {
		vertical_alignment = "top",
		parent = "time_line",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			27,
			0,
			1
		}
	},
	time_line_slot_4 = {
		vertical_alignment = "top",
		parent = "time_line",
		horizontal_alignment = "center",
		size = {
			40,
			40
		},
		position = {
			81,
			0,
			1
		}
	},
	mask_layer = {
		vertical_alignment = "center",
		parent = "frame",
		horizontal_alignment = "center",
		size = {
			1920,
			810
		},
		position = {
			0,
			-5,
			300
		}
	},
	mask_layer_top = {
		vertical_alignment = "top",
		parent = "mask_layer",
		horizontal_alignment = "center",
		size = {
			1920,
			40
		},
		position = {
			0,
			40,
			1
		}
	},
	mask_layer_bottom = {
		vertical_alignment = "bottom",
		parent = "mask_layer",
		horizontal_alignment = "center",
		size = {
			1920,
			40
		},
		position = {
			0,
			-40,
			1
		}
	}
}
local widgets = {
	time_line_bg = UIWidgets.create_simple_texture("timeline_bg", "time_line"),
	time_line_slot_1 = UIWidgets.create_simple_texture("timeline_fg_02", "time_line_slot_1"),
	time_line_slot_2 = UIWidgets.create_simple_texture("timeline_fg_02", "time_line_slot_2"),
	time_line_slot_3 = UIWidgets.create_simple_texture("timeline_fg_02", "time_line_slot_3"),
	time_line_slot_4 = UIWidgets.create_simple_texture("timeline_fg_02", "time_line_slot_4"),
	time_line_marker = UIWidgets.create_simple_texture("timeline_fg_01", "time_line_slot_1"),
	mask_layer = UIWidgets.create_simple_texture("mask_rect", "mask_layer"),
	mask_layer_top = UIWidgets.create_simple_uv_texture("mask_rect_edge_fade", {
		{
			0,
			0
		},
		{
			1,
			1
		}
	}, "mask_layer_top"),
	mask_layer_bottom = UIWidgets.create_simple_uv_texture("mask_rect_edge_fade", {
		{
			0,
			1
		},
		{
			1,
			0
		}
	}, "mask_layer_bottom")
}

return {
	widgets = widgets,
	scenegraph_definition = scenegraph_definition
}
