local scenegraph = {
	root = {
		is_root = true,
		size = {
			1920,
			1080
		},
		position = {
			0,
			0,
			UILayer.gdc_intro
		}
	},
	information_text = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			600,
			62
		},
		position = {
			0,
			-200,
			2
		}
	}
}
local widget_definitions = {
	information_text = {
		scenegraph_id = "information_text",
		element = {
			passes = {
				{
					style_id = "information_text",
					pass_type = "text",
					text_id = "information_text",
					content_check_function = function (content)
						return content.information_text
					end
				}
			}
		},
		content = {
			information_text = "information_text"
		},
		style = {
			information_text = {
				scenegraph_id = "information_text",
				font_size = 36,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "center",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					3,
					1
				}
			}
		}
	}
}
InformationView = class(InformationView)
InformationView.init = function (self, world)
	self._world = world
	self.ui_renderer = UIRenderer.create(self._world, "material", "materials/fonts/hell_shark_font", "material", "materials/fonts/gw_fonts")

	UISetupFontHeights(self.ui_renderer.gui)
	self._create_ui_elements(self)

	return 
end
InformationView._create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph)
	self.information_text_widget = UIWidget.init(widget_definitions.information_text)

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)
	self.set_information_text(self)

	return 
end
InformationView.update = function (self, dt)
	self.draw(self, dt)

	return 
end
InformationView.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, nil, dt)
	UIRenderer.draw_widget(ui_renderer, self.information_text_widget)
	UIRenderer.end_pass(ui_renderer)

	return 
end
InformationView.destroy = function (self)
	GarbageLeakDetector.register_object(self, "InformationView")
	UIRenderer.destroy(self.ui_renderer, self._world)

	return 
end
InformationView.set_information_text = function (self, optinal_text)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local widget = self.information_text_widget
	local widget_content = widget.content
	local widget_style = widget.style
	local text = ""

	if not optinal_text then
		widget_content.information_text = Localize("state_info")
	else
		widget_content.information_text = optinal_text
	end

	ui_scenegraph.information_text.local_position[1] = 0

	return 
end

return 
