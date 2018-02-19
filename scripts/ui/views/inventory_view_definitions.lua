local PAGE_SPACING = 25
local simple_texture_template = {
	scenegraph_id = "",
	element = UIElements.SimpleTexture,
	content = {
		texture_id = ""
	},
	style = {}
}

local function create_simple_texture_widget(texture_id, scenegraph_id)
	simple_texture_template.content.texture_id = texture_id
	simple_texture_template.scenegraph_id = scenegraph_id

	return UIWidget.init(simple_texture_template)
end

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
	root_filler = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
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
			1080
		}
	},
	menu_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			1920,
			1080
		}
	},
	title_text = {
		vertical_alignment = "top",
		parent = "menu_root",
		horizontal_alignment = "center",
		size = {
			420,
			28
		},
		position = {
			0,
			-10,
			1
		}
	},
	cancel_button = {
		vertical_alignment = "bottom",
		parent = "menu_root",
		horizontal_alignment = "right",
		size = {
			220,
			62
		},
		position = {
			-50,
			40,
			1
		}
	},
	equip_button = {
		vertical_alignment = "bottom",
		parent = "cancel_button",
		horizontal_alignment = "left",
		size = {
			220,
			62
		},
		position = {
			-240,
			0,
			1
		}
	},
	page_root_left = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			-(PAGE_SPACING + 592),
			20,
			1
		},
		size = {
			1,
			1
		}
	},
	page_root_center = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			0,
			20,
			1
		},
		size = {
			1,
			1
		}
	},
	page_root_right = {
		vertical_alignment = "center",
		parent = "menu_root",
		horizontal_alignment = "center",
		position = {
			PAGE_SPACING + 592,
			20,
			1
		},
		size = {
			1,
			1
		}
	}
}
local widget_definitions = {
	cancel_button = UIWidgets.create_menu_button_medium("map_screen_cancel_button", "cancel_button"),
	equip_button = UIWidgets.create_menu_button_medium("inventory_screen_equip_button", "equip_button"),
	dead_space_filler = {
		scenegraph_id = "dead_space_filler",
		element = {
			passes = {
				{
					pass_type = "rect"
				}
			}
		},
		content = {},
		style = {
			color = {
				255,
				0,
				0,
				0
			}
		}
	},
	title_widget = UIWidgets.create_title_text("menu_title_inventory", "title_text")
}

return {
	PAGE_SPACING = PAGE_SPACING,
	widget_definitions = widget_definitions,
	scenegraph_definition = scenegraph_definition,
	create_simple_texture_widget = create_simple_texture_widget
}
