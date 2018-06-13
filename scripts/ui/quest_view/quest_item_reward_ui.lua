local definitions = local_require("scripts/ui/quest_view/quest_item_reward_ui_definitions")
local scenegraph_definition = definitions.scenegraph_definition
QuestItemRewardUI = class(QuestItemRewardUI)
local ENABLE_DEBUG = false
local debug_item_key = "wh_2h_sword_0165"

QuestItemRewardUI.init = function (self, ingame_ui_context, input_service_name, world, viewport)
	self.world_manager = ingame_ui_context.world_manager
	local level_world = self.world_manager:world("level_world")
	self.wwise_world = Managers.world:wwise_world(level_world)
	self.loaded_packages = {}
	self.ui_animations = {}
	self.reward_world = world
	self.reward_viewport = viewport
	self.input_service_name = input_service_name
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ui_top_renderer = ingame_ui_context.ui_top_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager

	self:_create_ui_elements()
	rawset(_G, "quest_item_reward_ui", self)
end

QuestItemRewardUI._create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	local widget_definitions = definitions.widget_definitions
	self.reward_text_widgets = {
		title_text = UIWidget.init(widget_definitions.reward_title_text),
		name_text = UIWidget.init(widget_definitions.reward_name_text),
		type_text = UIWidget.init(widget_definitions.reward_type_text)
	}
	self.trait_icon_widgets = {
		UIWidget.init(widget_definitions.trait_button_1),
		UIWidget.init(widget_definitions.trait_button_2),
		UIWidget.init(widget_definitions.trait_button_3),
		UIWidget.init(widget_definitions.trait_button_4)
	}
	self.tooltip_widgets = {
		UIWidget.init(widget_definitions.trait_tooltip_1),
		UIWidget.init(widget_definitions.trait_tooltip_2),
		UIWidget.init(widget_definitions.trait_tooltip_3),
		UIWidget.init(widget_definitions.trait_tooltip_4)
	}
	self.hero_icon_widgets = {
		icon = UIWidget.init(widget_definitions.hero_icon),
		tooltip = UIWidget.init(widget_definitions.hero_icon_tooltip)
	}

	UIRenderer.clear_scenegraph_queue(self.ui_top_renderer)
end

QuestItemRewardUI.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

QuestItemRewardUI._destroy_units = function (self)
	local reward_world = self.reward_world

	if self.reward_units then
		for i = 1, #self.reward_units, 1 do
			local unit = self.reward_units[i]

			if unit then
				World.destroy_unit(reward_world, unit)
			end
		end

		table.clear(self.reward_units)
	end

	if self.link_unit then
		World.destroy_unit(reward_world, self.link_unit)

		self.link_unit = nil
	end

	self.units_spawned = nil
end

QuestItemRewardUI.start = function (self, reward)
	local item_key = nil

	if reward then
		local data_type = type(reward.data)

		if data_type == "string" then
			item_key = reward.data
		elseif data_type == "table" and #reward > 0 then
			item_key = reward.data[1]
		end
	end

	assert(item_key ~= nil, "reward data does not contain an item key!")
	self:set_item_key(item_key)
	self:spawn_link_unit()
	self:spawn_reward_units()
	self:set_reward_display_info(self.item_key)
	self:animate_reward_info()
	self:play_sound("Play_hud_quest_menu_finish_quest_turn_in_reward_weapon")
end

QuestItemRewardUI.stop = function (self)
	self.item_key = nil
	self.display_reward_texts = nil
	self.presentation_done = nil

	self:_destroy_units()
	self:unload_packages()
	table.clear(self.loaded_packages)
end

QuestItemRewardUI.done = function (self)
	return self.presentation_done
end

QuestItemRewardUI.active = function (self)
	return (self.item_key or self.units_spawned) ~= nil
end

QuestItemRewardUI.destroy = function (self)
	self.item_key = nil
	self.presentation_done = nil

	self:_destroy_units()
	rawset(_G, "quest_item_reward_ui", nil)
end

QuestItemRewardUI.update = function (self, dt, t)
	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil

			if name == "animate_reward_info" then
				self.presentation_done = true
			end
		end
	end

	self:_draw(dt)
end

QuestItemRewardUI._draw = function (self, dt)
	if self.display_reward_texts then
		local ui_renderer = self.ui_top_renderer
		local ui_scenegraph = self.ui_scenegraph
		local input_manager = self.input_manager
		local input_service = input_manager:get_service(self.input_service_name)

		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

		local reward_text_widgets = self.reward_text_widgets

		for key, text_widget in pairs(reward_text_widgets) do
			UIRenderer.draw_widget(ui_renderer, text_widget)
		end

		local trait_icon_widgets = self.trait_icon_widgets
		local number_of_traits_on_item = self.number_of_traits_on_item

		for i = 1, #trait_icon_widgets, 1 do
			local widget = trait_icon_widgets[i]

			UIRenderer.draw_widget(ui_renderer, widget)
		end

		local tooltip_widgets = self.tooltip_widgets

		for i = 1, #trait_icon_widgets, 1 do
			local widget = tooltip_widgets[i]

			UIRenderer.draw_widget(ui_renderer, widget)
		end

		local hero_icon_widgets = self.hero_icon_widgets

		for name, widget in pairs(hero_icon_widgets) do
			UIRenderer.draw_widget(ui_renderer, widget)
		end

		UIRenderer.end_pass(ui_renderer)
	end
end

QuestItemRewardUI.load_package = function (self, package_name)
	local package_manager = Managers.package
	local cb = callback(self, "on_load_complete", package_name)

	package_manager:load(package_name, "QuestItemRewardUI", cb, true)
end

QuestItemRewardUI.on_load_complete = function (self, package_name)
	self.loaded_packages[package_name] = true

	if self.spawn_reward_units_when_ready and self:ready_to_spawn() then
		self:spawn_reward_units()
	end
end

QuestItemRewardUI.unload_packages = function (self)
	local loaded_packages = self.loaded_packages

	if loaded_packages then
		local package_manager = Managers.package

		for package_name, _ in pairs(loaded_packages) do
			package_manager:unload(package_name, "QuestItemRewardUI")
		end
	end
end

QuestItemRewardUI.ready_to_spawn = function (self)
	local units_to_spawn_data = self.units_to_spawn_data
	local loaded_packages = self.loaded_packages

	for i = 1, #units_to_spawn_data, 1 do
		local unit_spawn_data = units_to_spawn_data[i]

		if not loaded_packages[unit_spawn_data.unit_name] then
			return false
		end
	end

	return true
end

QuestItemRewardUI.spawn_link_unit = function (self)
	if self.link_unit then
		return
	end

	local item_key = self.item_key
	local item_template = ItemHelper.get_template_by_item_name(item_key)
	local item_data = ItemMasterList[item_key]
	local unit_name = item_template.display_unit
	local camera_rotation = self:get_camera_rotation()
	local camera_forward_vector = Quaternion.forward(camera_rotation)
	local camera_look_rotation = Quaternion.look(camera_forward_vector, Vector3.up())
	local horizontal_rotation = Quaternion.axis_angle(Vector3.up(), math.pi * 1)
	local unit_spawn_rotation = Quaternion.multiply(camera_look_rotation, horizontal_rotation)
	local camera_position = self:get_camera_position()
	local unit_spawn_position = camera_position + camera_forward_vector
	unit_spawn_position.z = unit_spawn_position.z + 0.05
	local reward_world = self.reward_world
	local link_unit = World.spawn_unit(reward_world, unit_name, unit_spawn_position, unit_spawn_rotation)
	local unit_box, box_dimension = Unit.box(link_unit)
	local unit_center_position = Matrix4x4.translation(unit_box)
	local unit_root_position = Unit.world_position(link_unit, 0)
	local offset = unit_center_position - unit_root_position

	if box_dimension then
		local max_value = 0.1
		local largest_value = 0

		if largest_value < box_dimension.x then
			largest_value = box_dimension.x
		end

		if largest_value < box_dimension.z then
			largest_value = box_dimension.z
		end

		if largest_value < box_dimension.y then
			largest_value = box_dimension.y
		end

		if max_value < largest_value then
			local diff = largest_value - max_value
			local scale_fraction = 1 - diff / largest_value
			local scale = Vector3(scale_fraction, scale_fraction, scale_fraction)

			Unit.set_local_scale(link_unit, 0, scale)

			offset = offset * scale_fraction
		end

		local display_position = unit_spawn_position - offset

		Unit.set_local_position(link_unit, 0, display_position)

		self.link_unit = link_unit
	end
end

QuestItemRewardUI.spawn_reward_units = function (self)
	local link_unit = self.link_unit

	if self:ready_to_spawn() and link_unit then
		local scene_graph_links = {}
		local reward_world = self.reward_world
		local units_to_spawn_data = self.units_to_spawn_data
		local loaded_packages = self.loaded_packages
		local reward_units = {}
		local reward_units_default_position = {}
		local reward_units_position_offset = {}

		for i = 1, #units_to_spawn_data, 1 do
			local spawn_unit_data = units_to_spawn_data[i]
			local unit_name = spawn_unit_data.unit_name
			local unit_attachment_node_linking = spawn_unit_data.unit_attachment_node_linking
			local reward_unit = World.spawn_unit(reward_world, unit_name)
			reward_units[#reward_units + 1] = reward_unit

			GearUtils.link(reward_world, unit_attachment_node_linking, scene_graph_links, link_unit, reward_unit)
		end

		self.reward_units = reward_units
		self.reward_units_position_offset = reward_units_position_offset
		self.reward_units_default_position = reward_units_default_position
		self.spawn_reward_units_when_ready = nil

		Unit.flow_event(link_unit, self.spawn_effect_event_name or "lua_spin")

		self.units_spawned = true
	else
		self.spawn_reward_units_when_ready = true
	end
end

QuestItemRewardUI.get_camera_position = function (self)
	local reward_viewport = self.reward_viewport
	local camera = ScriptViewport.camera(reward_viewport)

	return ScriptCamera.position(camera)
end

QuestItemRewardUI.get_camera_rotation = function (self)
	local reward_viewport = self.reward_viewport
	local camera = ScriptViewport.camera(reward_viewport)

	return ScriptCamera.rotation(camera)
end

QuestItemRewardUI.set_item_key = function (self, item_key)
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = self.trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		trait_widget_style.texture_id.color[1] = 0
		trait_widget_style.texture_bg_id.color[1] = 0
		trait_widget_style.texture_lock_id.color[1] = 0
	end

	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_widget = hero_icon_widgets.icon
	hero_icon_widget.style.texture_id.color[1] = 0
	self.item_key = (ENABLE_DEBUG and debug_item_key) or item_key

	self:load_reward_units()
end

QuestItemRewardUI.load_reward_units = function (self)
	local item_key = self.item_key
	local item_data = ItemMasterList[item_key]
	local item_template = ItemHelper.get_template_by_item_name(item_key)
	local units_to_spawn_data = {}
	local slot_type = item_data.slot_type

	if slot_type == "melee" or slot_type == "ranged" then
		local left_hand_unit = item_data.left_hand_unit
		local right_hand_unit = item_data.right_hand_unit

		if left_hand_unit then
			local left_unit = left_hand_unit .. "_3p"

			self:load_package(left_unit)

			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = left_unit,
				unit_attachment_node_linking = item_template.left_hand_attachment_node_linking.third_person.display
			}
		end

		if right_hand_unit then
			local right_unit = right_hand_unit .. "_3p"

			if right_hand_unit ~= left_hand_unit then
				self:load_package(right_unit)
			end

			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = right_unit,
				unit_attachment_node_linking = item_template.right_hand_attachment_node_linking.third_person.display
			}
		end
	else
		local unit = item_data.unit

		if unit then
			self:load_package(unit)

			units_to_spawn_data[#units_to_spawn_data + 1] = {
				unit_name = unit,
				unit_attachment_node_linking = (slot_type == "trinket" and item_template.attachment_node_linking.slot_trinket_1) or item_template.attachment_node_linking.slot_hat
			}
		end
	end

	self.units_to_spawn_data = units_to_spawn_data
end

QuestItemRewardUI.animate_reward_info = function (self)
	local reward_text_widgets = self.reward_text_widgets
	local name_text_style = reward_text_widgets.name_text.style.text
	local type_text_style = reward_text_widgets.type_text.style.text
	local title_text_style = reward_text_widgets.title_text.style.text
	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_widget = hero_icon_widgets.icon
	local trait_icon_widgets = self.trait_icon_widgets
	local animation_name = "animate_reward_info"
	local animation_time = 0.3
	local wait_time = 0.2
	local from = 0
	local to = 255
	local ui_animations = self.ui_animations
	ui_animations[animation_name] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, name_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_2"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, type_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_3"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, title_text_style.text_color, 1, from, to, animation_time, math.easeInCubic)
	ui_animations[animation_name .. "_4"] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, hero_icon_widget.style.texture_id.color, 1, from, to, animation_time, math.easeInCubic)
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local trait_widget = trait_icon_widgets[i]
		local trait_widget_style = trait_widget.style
		ui_animations[animation_name .. "_trait_icon_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_id.color, 1, from, to, animation_time, math.easeInCubic)
		ui_animations[animation_name .. "_trait_bg_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_bg_id.color, 1, from, to, animation_time, math.easeInCubic)
		ui_animations[animation_name .. "_trait_lock_" .. i] = UIAnimation.init(UIAnimation.wait, wait_time, UIAnimation.function_by_time, trait_widget_style.texture_lock_id.color, 1, from, to, animation_time, math.easeInCubic)
	end

	self.display_reward_texts = true
end

QuestItemRewardUI.set_reward_display_info = function (self, item_key)
	local item = ItemMasterList[item_key]
	local ratity_color = Colors.get_color_table_with_alpha(item.rarity, 0)
	local reward_text_widgets = self.reward_text_widgets
	reward_text_widgets.name_text.content.text = item.display_name
	reward_text_widgets.name_text.style.text.text_color = ratity_color
	reward_text_widgets.type_text.content.text = item.item_type
	reward_text_widgets.type_text.style.text.text_color[1] = 0
	reward_text_widgets.title_text.style.text.text_color[1] = 0
	local hero_icon_widgets = self.hero_icon_widgets
	local hero_icon_widget = hero_icon_widgets.icon
	local hero_tooltip_widget = hero_icon_widgets.tooltip
	local draw_hero_icon = (#item.can_wield == 1 and true) or false

	if draw_hero_icon then
		local key = item.can_wield[1]
		local hero_icon_texture = UISettings.hero_icons.medium[key]
		local hero_icon_tooltip = UISettings.hero_tooltips[key]
		hero_icon_widget.content.texture_id = hero_icon_texture
		hero_tooltip_widget.content.tooltip_text = Localize(hero_icon_tooltip)
	end

	hero_icon_widget.content.visible = draw_hero_icon

	self:set_traits_info(item, item.traits)
end

QuestItemRewardUI.set_traits_info = function (self, item, traits)
	local trait_icon_widgets = self.trait_icon_widgets
	local tooltip_widgets = self.tooltip_widgets
	local num_total_traits = ForgeSettings.num_traits
	local number_of_traits_on_item = 0
	local tooltip_trait_locked_text = Localize("tooltip_trait_locked")
	local tooltip_trait_unique_text = Localize("unique_trait_description")
	local slot_type = item.slot_type
	local is_trinket = slot_type == "trinket"
	local trait_locked = not is_trinket and slot_type ~= "hat"

	for i = 1, num_total_traits, 1 do
		local trait_name = traits and traits[i]
		local trait_widget = trait_icon_widgets[i]
		local tooltip_trait_widget = tooltip_widgets[i]
		local trait_widget_content = trait_widget.content
		local trait_widget_hotspot = trait_widget_content.button_hotspot
		trait_widget_hotspot.disabled = trait_name == nil

		if trait_name then
			local trait_template = BuffTemplates[trait_name]

			if trait_template then
				local display_name = trait_template.display_name or "Unknown"
				local rarity = item.rarity
				local description_text = BackendUtils.get_trait_description(trait_name, rarity)
				local tooltip_text = Localize(display_name) .. "\n" .. description_text

				if is_trinket or trait_locked then
					if is_trinket then
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_unique_text
					else
						tooltip_text = tooltip_text .. "\n" .. tooltip_trait_locked_text
					end

					tooltip_trait_widget.style.tooltip_text.last_line_color = Colors.get_color_table_with_alpha("red", 255)
				else
					tooltip_trait_widget.style.tooltip_text.last_line_color = nil
				end

				tooltip_trait_widget.content.tooltip_text = tooltip_text
				local icon = trait_template.icon or "icons_placeholder"
				trait_widget_content.texture_id = icon
				trait_widget_hotspot.is_selected = false
				trait_widget_hotspot.on_pressed = false
				trait_widget_content.use_background = true
				trait_widget_content.use_glow = false
			end

			trait_widget_hotspot.locked = trait_locked
			number_of_traits_on_item = number_of_traits_on_item + 1
		end
	end

	self.number_of_traits_on_item = number_of_traits_on_item

	self:update_trait_alignment(number_of_traits_on_item)
end

QuestItemRewardUI.update_trait_alignment = function (self, number_of_traits)
	local ui_scenegraph = self.ui_scenegraph
	local width = 40
	local spacing = 80
	local half_trait_amount = (number_of_traits - 1) * 0.5
	local start_x_position = -((width + spacing) * half_trait_amount)

	for i = 1, number_of_traits, 1 do
		local trait_scenegraph_name = "trait_button_" .. i
		local trait_tooltip_scenegraph_name = "trait_tooltip_" .. i
		local position = ui_scenegraph[trait_scenegraph_name].local_position
		local tooltip_position = ui_scenegraph[trait_tooltip_scenegraph_name].local_position
		position[1] = start_x_position
		tooltip_position[1] = position[1]
		tooltip_position[2] = position[2]
		start_x_position = start_x_position + width + spacing
	end

	local trait_icon_widgets = self.trait_icon_widgets
	local num_total_traits = ForgeSettings.num_traits

	for i = 1, num_total_traits, 1 do
		local widget = trait_icon_widgets[i]
		widget.content.visible = (i <= number_of_traits and true) or false
	end
end

return
