InteractionUI = class(InteractionUI)
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
			UILayer.interaction
		}
	},
	interaction_bar = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		size = {
			212,
			24
		},
		position = {
			0,
			-140,
			1
		}
	},
	interaction_bar_bg = {
		vertical_alignment = "center",
		parent = "interaction_bar",
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
	interaction_bar_fg = {
		vertical_alignment = "center",
		parent = "interaction_bar_bg",
		horizontal_alignment = "center",
		size = {
			246,
			24
		},
		position = {
			0,
			0,
			2
		}
	},
	interaction_bar_fill = {
		vertical_alignment = "center",
		parent = "interaction_bar_bg",
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
	},
	tooltip_root = {
		vertical_alignment = "center",
		parent = "root",
		horizontal_alignment = "center",
		position = {
			0,
			-40,
			0
		},
		size = {
			1,
			1
		}
	},
	tooltip = {
		vertical_alignment = "bottom",
		parent = "tooltip_root",
		position = {
			0,
			-120,
			1
		},
		size = {
			200,
			40
		}
	},
	tooltip_text = {
		vertical_alignment = "center",
		parent = "tooltip",
		size = {
			600,
			70
		},
		position = {
			0,
			0,
			2
		}
	},
	tooltip_icon = {
		vertical_alignment = "center",
		parent = "tooltip",
		horizontal_alignment = "left",
		size = {
			62,
			62
		},
		position = {
			0,
			0,
			1
		}
	}
}
local widget_definitions = {
	tooltip = {
		scenegraph_id = "tooltip",
		element = {
			passes = {
				{
					texture_id = "icon_textures",
					style_id = "icon_styles",
					pass_type = "multi_texture"
				},
				{
					style_id = "button_text",
					pass_type = "text",
					text_id = "button_text",
					content_check_function = function (content)
						return content.text ~= ""
					end
				},
				{
					style_id = "text",
					pass_type = "text",
					text_id = "text",
					content_check_function = function (content)
						return content.text
					end
				}
			}
		},
		content = {
			text = "tooltip_text",
			button_text = "",
			icon_textures = {
				"pc_button_icon_left"
			}
		},
		style = {
			text = {
				scenegraph_id = "tooltip_text",
				font_size = 24,
				word_wrap = true,
				pixel_perfect = true,
				horizontal_alignment = "left",
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("white", 255),
				offset = {
					0,
					0,
					1
				}
			},
			button_text = {
				font_size = 24,
				scenegraph_id = "tooltip_icon",
				horizontal_alignment = "center",
				pixel_perfect = true,
				vertical_alignment = "center",
				dynamic_font = true,
				font_type = "hell_shark",
				text_color = Colors.get_color_table_with_alpha("cheeseburger", 255),
				offset = {
					0,
					-2,
					2
				}
			},
			icon_styles = {
				scenegraph_id = "tooltip_icon",
				texture_sizes = {
					{
						20,
						36
					}
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
			}
		}
	},
	interaction_bar = {
		scenegraph_id = "interaction_bar",
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
						local uv_pixels = uv_start_pixels + uv_scale_pixels * bar_value
						local uvs = style.uvs
						local uv_scale_axis = style.scale_axis
						local offset_scale = style.offset_scale
						local offset = {
							0,
							0,
							0
						}
						uvs[2][uv_scale_axis] = uv_pixels / (uv_start_pixels + uv_scale_pixels)
						size[uv_scale_axis] = uv_pixels

						return content.color, uvs, size, offset
					end
				}
			}
		},
		content = {
			bar_bg = "interaction_bar_bg",
			bar_fg = "interaction_bar_fg_skulls",
			bar = {
				texture_id = "interaction_bar",
				bar_value = 1
			}
		},
		style = {
			bar_fg = {
				scenegraph_id = "interaction_bar_fg",
				offset = {
					0,
					0,
					3
				},
				color = {
					0,
					255,
					255,
					255
				}
			},
			bar_bg = {
				scenegraph_id = "interaction_bar_bg",
				color = {
					0,
					255,
					255,
					255
				}
			},
			bar = {
				uv_start_pixels = 5,
				scenegraph_id = "interaction_bar_fill",
				uv_scale_pixels = 207,
				offset_scale = 1,
				scale_axis = 1,
				color = {
					0,
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

InteractionUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.player_manager = ingame_ui_context.player_manager
	self.peer_id = ingame_ui_context.peer_id
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.world = ingame_ui_context.world
	self.platform = PLATFORM
	self.interaction_animations = {}

	self:create_ui_elements()

	self.localized_texts = {
		hold = Localize("interaction_prefix_hold"),
		press = Localize("interaction_prefix_press"),
		to = Localize("interaction_to")
	}
end

InteractionUI.create_ui_elements = function (self)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	self.interaction_widget = UIWidget.init(widget_definitions.tooltip)
	self.interaction_bar_widget = UIWidget.init(widget_definitions.interaction_bar)
end

InteractionUI.destroy = function (self)
	GarbageLeakDetector.register_object(self, "interaction_gui")
end

InteractionUI.button_texture_data_by_input_action = function (self, input_action)
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("Player")
	local gamepad_active = input_manager:is_device_active("gamepad")

	return UISettings.get_gamepad_input_texture_data(input_service, input_action, gamepad_active)
end

InteractionUI.update = function (self, dt, t, my_player)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("Player")
	local console_disabled = false
	local player_unit = my_player.player_unit

	if not player_unit then
		return
	end

	for name, ui_animation in pairs(self.interaction_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.interaction_animations[name] = nil
		end
	end

	local interactor_extension = ScriptUnit.extension(player_unit, "interactor_system")
	local interaction_bar_active = false

	if interactor_extension:is_interacting() and not interactor_extension:is_waiting_for_interaction_approval() then
		local t = Managers.time:time("game")
		local progress = interactor_extension:get_progress(t)

		if progress and progress ~= 0 then
			local widget_content = self.interaction_bar_widget.content
			local widget_style = self.interaction_bar_widget.style

			if not self.draw_interaction_bar then
				self.draw_interaction_bar = true
				local fade_in_time = UISettings.interaction.bar.fade_in
				self.interaction_animations.interaction_bar_bg_fade = UIAnimation.init(UIAnimation.function_by_time, widget_style.bar_bg.color, 1, 0, 255, fade_in_time, math.easeInCubic)
				self.interaction_animations.interaction_bar_fg_fade = UIAnimation.init(UIAnimation.function_by_time, widget_style.bar_fg.color, 1, 0, 255, fade_in_time, math.easeInCubic)
				self.interaction_animations.interaction_bar_fill_fade = UIAnimation.init(UIAnimation.function_by_time, widget_style.bar.color, 1, 0, 255, fade_in_time, math.easeInCubic)
			end

			interaction_bar_active = true
			widget_content.bar.bar_value = progress
		end
	elseif not interactor_extension:is_interacting() and not interactor_extension:is_waiting_for_interaction_approval() then
		local hud_description_text, extra_param, interact_action = nil
		local can_interact, failed_reason, interaction_type = interactor_extension:can_interact()

		if (can_interact or failed_reason) and interaction_type ~= "heal" and interaction_type ~= "give_item" then
			interact_action = "interact"

			if can_interact then
				hud_description_text, extra_param = interactor_extension:interaction_description()
			elseif failed_reason then
				hud_description_text, extra_param = interactor_extension:interaction_description(failed_reason)
			end

			if CONSOLE_DISABLED_INTERACTIONS[interaction_type] then
				hud_description_text = "Currently Disabled"
				console_disabled = true
			end
		else
			local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
			local highest_prio = 0
			local best_action_name, best_sub_action_name = nil
			local equipment = inventory_extension:equipment()
			local item_data = equipment.wielded
			local item_template = BackendUtils.get_item_template(item_data)

			if item_data ~= nil then
				for action_name, sub_actions in pairs(item_template.actions) do
					for sub_action_name, action_settings in pairs(sub_actions) do
						local interaction_priority = action_settings.interaction_priority or -1000

						if action_settings.interaction_type ~= nil and highest_prio < interaction_priority and action_settings.condition_func(player_unit) then
							local input_device_supports_action = self:button_texture_data_by_input_action(action_settings.hold_input or action_name)

							if input_device_supports_action then
								highest_prio = action_settings.interaction_priority
								best_action_name = action_name
								best_sub_action_name = sub_action_name
							end
						end
					end
				end
			end

			if best_action_name then
				local action_settings = item_template.actions[best_action_name][best_sub_action_name]
				local interaction_type = action_settings.interaction_type
				local interaction_template = InteractionDefinitions[interaction_type]
				local interactable_unit = interactor_extension:interactable_unit()

				if Unit.alive(interactable_unit) then
					local can_interact_func = interaction_template.client.can_interact
					local can_interact = can_interact_func(player_unit, interactable_unit, interactor_extension.interaction_context.data, interaction_template.config, self.world)

					if can_interact then
						hud_description_text, extra_param = interaction_template.client.hud_description(interactable_unit, interaction_template.config, nil, player_unit)
					else
						hud_description_text, extra_param = interaction_template.client.hud_description(nil, interaction_template.config, nil, player_unit)
					end
				else
					hud_description_text, extra_param = interaction_template.client.hud_description(nil, interaction_template.config, nil, player_unit)
				end

				interact_action = action_settings.hold_input or best_action_name
			end
		end

		if not hud_description_text then
			hud_description_text, interact_action = self:external_interact_ui_description(player_unit)
		end

		if hud_description_text and hud_description_text ~= self.current_hud_description_text then
			local button_texture_data, button_text = self:button_texture_data_by_input_action(interact_action)

			assert(button_texture_data, "Could not find button texture(s) for action: %s", interact_action)

			local text = (console_disabled and hud_description_text) or Localize(hud_description_text)

			if extra_param then
				text = string.format(text, Localize(extra_param))
			end

			if hud_description_text == "interact_heal_ally" or hud_description_text == "interact_give_ally" then
				local interactable_unit = interactor_extension:interactable_unit()

				if Unit.alive(interactable_unit) then
					local player = Managers.player:owner(interactable_unit)
					local profile_index = self.profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
					local hero_data = SPProfiles[profile_index]
					local hero_name = hero_data.display_name
					text = text .. ": " .. Localize(hero_name)
				end
			end

			local widget_style = self.interaction_widget.style
			local widget_content = self.interaction_widget.content
			local texture_size_x = 0
			local texture_size_y = 0

			if button_texture_data and not failed_reason then
				if button_texture_data.texture then
					widget_content.button_text = ""
					widget_content.icon_textures = {
						button_texture_data.texture
					}
					widget_style.icon_styles.texture_sizes = {
						button_texture_data.size
					}
					texture_size_x = button_texture_data.size[1]
					texture_size_y = button_texture_data.size[2]
				else
					local textures = {}
					local sizes = {}
					local tile_sizes = {}
					local button_text_style = widget_style.button_text
					local font, scaled_font_size = UIFontByResolution(button_text_style)
					local text_width, text_height, min = UIRenderer.text_size(ui_renderer, button_text, font[1], scaled_font_size)

					for i = 1, #button_texture_data, 1 do
						textures[i] = button_texture_data[i].texture
						sizes[i] = button_texture_data[i].size

						if button_texture_data[i].tileable then
							tile_sizes[i] = {
								text_width,
								sizes[i][2]
							}
							texture_size_x = texture_size_x + text_width

							if texture_size_y < sizes[i][2] then
								texture_size_y = sizes[i][2] or texture_size_y
							end
						else
							texture_size_x = texture_size_x + sizes[i][1]

							if texture_size_y < sizes[i][2] then
								texture_size_y = sizes[i][2] or texture_size_y
							end
						end
					end

					widget_content.icon_textures = textures
					widget_content.button_text = button_text
					widget_style.icon_styles.texture_sizes = sizes
					widget_style.icon_styles.tile_sizes = tile_sizes
				end

				ui_scenegraph.tooltip_text.local_position[1] = texture_size_x
				ui_scenegraph.tooltip_icon.size[1] = texture_size_x
				ui_scenegraph.tooltip_icon.size[2] = texture_size_y
			else
				widget_content.icon_textures = {}
				widget_content.button_text = ""
				ui_scenegraph.tooltip_text.local_position[1] = 0
			end

			local text_style = widget_style.text
			local font, scaled_font_size = UIFontByResolution(text_style)
			local width, height, min = UIRenderer.text_size(ui_renderer, text, font[1], scaled_font_size)
			local text_width = width * 0.5
			widget_content.text = text
			ui_scenegraph.tooltip.position[1] = -((width + texture_size_x) * 0.5)

			if not self.draw_interaction_tooltip then
				local icon_style = widget_style.icon_styles
				local button_text_style = widget_style.button_text
				local text_style = widget_style.text
				local fade_in_time = 0.1
				local target_alpha = (console_disabled and 128) or 255
				self.interaction_animations.tooltip_icon_fade = UIAnimation.init(UIAnimation.function_by_time, icon_style.color, 1, 0, target_alpha, fade_in_time, math.easeInCubic)
				self.interaction_animations.tooltip_button_text_fade = UIAnimation.init(UIAnimation.function_by_time, button_text_style.text_color, 1, 0, target_alpha, fade_in_time, math.easeInCubic)
				self.interaction_animations.tooltip_text_fade = UIAnimation.init(UIAnimation.function_by_time, text_style.text_color, 1, 0, target_alpha, fade_in_time, math.easeInCubic)
			end
		end

		if hud_description_text then
			self.draw_interaction_tooltip = true
		else
			self.draw_interaction_tooltip = nil
		end

		self.current_hud_description_text = hud_description_text
	end

	if not interaction_bar_active and self.draw_interaction_bar then
		self.draw_interaction_bar = nil
		local fade_out_time = UISettings.interaction.bar.fade_out
		local widget_style = self.interaction_bar_widget.style
		self.interaction_animations.interaction_bar_bg_fade = UIAnimation.init(UIAnimation.function_by_time, widget_style.bar_bg.color, 1, widget_style.bar_bg.color[1], 0, fade_out_time, math.easeInCubic)
		self.interaction_animations.interaction_bar_fg_fade = UIAnimation.init(UIAnimation.function_by_time, widget_style.bar_fg.color, 1, widget_style.bar_fg.color[1], 0, fade_out_time, math.easeInCubic)
		self.interaction_animations.interaction_bar_fill_fade = UIAnimation.init(UIAnimation.function_by_time, widget_style.bar.color, 1, widget_style.bar.color[1], 0, fade_out_time, math.easeInCubic)
	end

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if self.draw_interaction_bar or self.interaction_animations.interaction_bar_bg_fade then
		UIRenderer.draw_widget(ui_renderer, self.interaction_bar_widget)
	elseif self.draw_interaction_tooltip then
		local HAS_TOBII = rawget(_G, "Tobii") and Application.user_setting("tobii_eyetracking") and Application.user_setting("tobii_interact_at_gaze")
		local interact_at_gaze_enabled = HAS_TOBII and Tobii.user_presence() == Tobii.USER_PRESENT and Tobii.device_status() == Tobii.DEVICE_TRACKING

		if interact_at_gaze_enabled then
			local interactable_unit = interactor_extension:interactable_unit()

			if Unit.alive(interactable_unit) then
				local mesh = Unit.mesh(interactable_unit, 0)
				local orientation_mat, _ = Mesh.box(mesh)
				local interactable_world_pos = Matrix4x4.translation(orientation_mat)
				local eyetracking_extension = ScriptUnit.extension(player_unit, "eyetracking_system")
				local pos_in_screen = eyetracking_extension:world_position_in_screen(interactable_world_pos)
				local x_scale = 1920 / RESOLUTION_LOOKUP.res_w
				local y_scale = 1080 / RESOLUTION_LOOKUP.res_h
				local new_position = Vector3(pos_in_screen[1] * x_scale - 960, pos_in_screen[2] * y_scale - 540, 0)

				UISceneGraph.set_local_position(ui_scenegraph, "tooltip_root", new_position)
			end
		else
			UISceneGraph.set_local_position(ui_scenegraph, "tooltip_root", Vector3(0, -40, 0))
		end

		UIRenderer.draw_widget(ui_renderer, self.interaction_widget)
	end

	UIRenderer.end_pass(ui_renderer)
end

InteractionUI.external_interact_ui_description = function (self, player_unit)
	local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
	local wielded_slot = inventory_extension:get_wielded_slot_name()
	local slot_data = inventory_extension:get_slot_data(wielded_slot)
	local hud_description_text, interact_action = nil

	if slot_data then
		local wielded_unit = slot_data.right_unit_1p or slot_data.left_unit_1p

		if ScriptUnit.has_extension(wielded_unit, "overcharge_system") then
			local overcharge_extension = ScriptUnit.extension(wielded_unit, "overcharge_system")

			if overcharge_extension:is_above_critical_limit() and not overcharge_extension:are_you_exploding() then
				hud_description_text = "vent_overcharge"
				interact_action = "weapon_reload"
			end
		end
	end

	return hud_description_text, interact_action
end

return
