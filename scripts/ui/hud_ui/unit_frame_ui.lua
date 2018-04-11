local PLAYER_NAME_MAX_LENGTH = 16
UnitFrameUI = class(UnitFrameUI)
UnitFrameUI.init = function (self, ingame_ui_context, definitions, data, frame_index)
	self.definitions = definitions
	self.features_list = definitions.features_list
	self.inventory_consumable_icons = definitions.inventory_consumable_icons
	self.cleanui = ingame_ui_context.cleanui
	self.inventory_index_by_slot = definitions.inventory_index_by_slot
	self.weapon_slot_widget_settings = definitions.weapon_slot_widget_settings
	self.render_settings = {
		alpha_multiplier = 1,
		snap_pixel_positions = true
	}
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager
	self.ui_animations = {}
	self.data = data

	self._create_ui_elements(self, frame_index)
	rawset(_G, "team_unit_frames_ui", self)

	return 
end
UnitFrameUI._create_ui_elements = function (self, frame_index)
	local definitions = self.definitions
	local scenegraph_definition = self.definitions.scenegraph_definition
	self.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	local widgets = {}

	for name, definition in pairs(definitions.widget_definitions) do
		widgets[name] = UIWidget.init(definition)
	end

	self._widgets = widgets

	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.slot_equip_animations = {}
	self.bar_animations = {}

	self.reset(self)

	if frame_index then
		self._widget_by_name(self, "loadout_dynamic").content.hp_bar.normal_texture_id = "teammate_hp_bar_color_tint_" .. frame_index
	end

	self.set_visible(self, true)
	self.set_dirty(self)

	return 
end
UnitFrameUI._widget_by_name = function (self, name)
	return self._widgets[name]
end
UnitFrameUI.set_position = function (self, x, y)
	local position = self.ui_scenegraph.pivot.local_position
	position[1] = x
	position[2] = y

	for _, widget in pairs(self._widgets) do
		self._set_widget_dirty(self, widget)
	end

	self.set_dirty(self)

	return 
end
UnitFrameUI.destroy = function (self)
	self.set_visible(self, false)
	rawset(_G, "team_unit_frames_ui", nil)

	return 
end
UnitFrameUI.set_visible = function (self, visible)
	self._is_visible = visible
	local ui_renderer = self.ui_renderer

	for _, widget in pairs(self._widgets) do
		UIRenderer.set_element_visible(ui_renderer, widget.element, visible)
	end

	self.set_dirty(self)

	return 
end
UnitFrameUI.update = function (self, dt, t)
	local dirty = false
	local data = self.data
	local is_dead = data.is_dead
	local is_talking = data.is_talking
	local is_knocked_down = data.is_knocked_down
	local needs_help = data.needs_help
	local show_overlay = data.show_overlay
	self.overlay_time = (self.overlay_time or 0) + dt * 1.4

	Profiler.start("overlay")

	if show_overlay then
		self._update_overlay(self, is_dead, is_knocked_down, needs_help)

		dirty = true
	end

	Profiler.stop("overlay")
	Profiler.start("voice")

	if self._update_voice_animation(self, dt, t, is_talking) then
		dirty = true
	end

	Profiler.stop("voice")
	Profiler.start("bar")

	if self._update_bar_animations(self, dt, t) then
		dirty = true
	end

	Profiler.stop("bar")
	Profiler.start("grimoire")

	if self._update_grimoire_bar_animation(self, dt, t) then
		dirty = true
	end

	Profiler.stop("grimoire")
	Profiler.start("health")

	if self._update_health_bar_animation(self, dt, t) then
		dirty = true
	end

	Profiler.stop("health")
	Profiler.start("shield")

	if self._update_shield_bar_animation(self, dt, t) then
		dirty = true
	end

	Profiler.stop("shield")
	Profiler.start("overcharge")

	if self._update_overcharge_animation(self, dt, t) then
		dirty = true
	end

	Profiler.stop("overcharge")
	Profiler.start("loadout")

	if self._update_slot_equip_animations(self, dt, t) then
		dirty = true
	end

	Profiler.stop("loadout")
	Profiler.start("connection")

	if self._update_connection_animation(self, dt, t) then
		dirty = true
	end

	Profiler.stop("connection")

	local alpha = UICleanUI.get_alpha(self.cleanui, self)

	if alpha ~= self.last_alpha then
		dirty = true
		self.last_alpha = alpha

		for _, widget in pairs(self._widgets) do
			self._set_widget_dirty(self, widget)
		end
	end

	if dirty then
		self.set_dirty(self)
	end

	return 
end
UnitFrameUI.on_resolution_modified = function (self)
	for _, widget in pairs(self._widgets) do
		self._set_widget_dirty(self, widget)
	end

	self.set_dirty(self)

	return 
end
UnitFrameUI.draw = function (self, dt)
	if not self._is_visible then
		return 
	end

	if not self._dirty then
		return 
	end

	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")
	local render_settings = self.render_settings
	render_settings.alpha_multiplier = self.last_alpha

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, render_settings)

	for _, widget in pairs(self._widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	render_settings.alpha_multiplier = 1

	UIRenderer.end_pass(ui_renderer)

	self._dirty = false

	return 
end
UnitFrameUI.set_dirty = function (self)
	self._dirty = true

	return 
end
UnitFrameUI._set_widget_dirty = function (self, widget)
	widget.element.dirty = true

	return 
end
UnitFrameUI.reset = function (self)
	self.set_potrait(self, "unit_frame_portrait_matchmaking_03")
	self.set_player_level(self, "-")
	self.set_player_name(self, "")
	self.set_talking(self, false)
	self.set_overlay_visibility(self, false)
	self.set_icon_visibility(self, false)
	self.set_connecting_status(self, true)
	self.set_shielded(self, false, 0)

	local show_health_bar = true
	local is_knocked_down = false
	local is_wounded = false

	self.set_health_bar_status(self, show_health_bar, is_knocked_down, is_wounded)

	if self.features_list.equipment then
		for slot_name, _ in pairs(self.inventory_index_by_slot) do
			self.set_inventory_slot_data(self, slot_name, false)
		end
	end

	self.set_dirty(self)

	return 
end
UnitFrameUI.set_potrait_frame = function (self, frame_texture)
	local widget = self._widget_by_name(self, "portait_static")
	local widget_content = widget.content
	widget_content.portrait_frame = frame_texture

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_potrait = function (self, portrait_texture)
	local widget = self._widget_by_name(self, "portait_static")
	local widget_content = widget.content
	widget_content.character_portrait = portrait_texture

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_player_level = function (self, level_text)
	local widget = self._widget_by_name(self, "portait_static")
	local widget_content = widget.content
	widget_content.player_level = level_text

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_host_status = function (self, is_host)
	local widget = self._widget_by_name(self, "portait_static")
	local widget_content = widget.content
	widget_content.is_host = is_host

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_talking = function (self, is_talking)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content
	widget_content.is_talking = is_talking

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_potrait_overlay = function (self, overlay_texture)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content
	widget_content.portrait_overlay = overlay_texture

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_status_icon = function (self, icon_texture)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content
	widget_content.portrait_icon = icon_texture

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_connecting_status = function (self, is_connecting)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content
	widget_content.connecting = is_connecting

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_overlay_visibility = function (self, show_overlay)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content
	widget_content.display_portrait_overlay = show_overlay

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_icon_visibility = function (self, show_icon)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content
	widget_content.display_portrait_icon = show_icon

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_portrait_status = function (self, is_knocked_down, needs_help)
	local widget = self._widget_by_name(self, "portait_static")
	local portrait_texture = widget.content.character_portrait
	local gui = self.ui_renderer.gui_retained
	local gui_material = Gui.material(gui, portrait_texture)

	if is_knocked_down or needs_help then
		Material.set_vector2(gui_material, "saturate_params", Vector2(0.7, 1))
	else
		Material.set_vector2(gui_material, "saturate_params", Vector2(0, 1))
	end

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_player_name = function (self, name_text)
	local widget = self._widget_by_name(self, "loadout_static")
	local widget_content = widget.content
	local display_name = (widget.style.player_name and PLAYER_NAME_MAX_LENGTH < UTF8Utils.string_length(name_text) and UIRenderer.crop_text_width(self.ui_renderer, name_text, 180, widget.style.player_name)) or name_text
	widget_content.player_name = display_name

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_inventory_slot_data = function (self, slot_name, slot_visible, item_name)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style
	local slot_index = self.inventory_index_by_slot[slot_name]

	if slot_index then
		local widget_slot_name = "item_slot_" .. slot_index
		local icon_texture = (slot_visible and self.inventory_consumable_icons[item_name]) or self.inventory_consumable_icons[slot_index]
		widget_content[widget_slot_name] = icon_texture
		widget_style[widget_slot_name].color[1] = (slot_visible and 255) or 100

		if slot_visible then
			self._add_slot_equip_animation(self, slot_name .. "_equip_anim", widget, widget_style["item_slot_highlight_" .. slot_index])
		end
	end

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_selected_slot = function (self, slot_name, item_name, selected, slot_visible)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style
	local slot_index = self.inventory_index_by_slot[slot_name]

	if slot_index then
		local widget_slot_name = "item_slot_" .. slot_index .. "_lit"
		local icon_texture = (slot_visible and self.inventory_consumable_icons[item_name]) or self.inventory_consumable_icons[slot_index]
		widget_content[widget_slot_name] = (selected and icon_texture .. "_lit") or nil
	end

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_equipped_weapon_info = function (self, slot_name, wielded, item_name, hud_icon)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style

	if wielded then
		widget_content.equipped_weapon_lit = hud_icon .. "_lit"
		widget_content.equipped_weapon = hud_icon
		widget_content.equipped_weapon_slot = slot_name
	elseif widget_content.equipped_weapon_slot == slot_name then
		widget_content.equipped_weapon_lit = nil
	elseif not widget_content.equipped_weapon then
		widget_content.equipped_weapon = hud_icon
		widget_content.equipped_weapon_lit = nil
	end

	for name, field_name in pairs(self.weapon_slot_widget_settings.ammo_fields) do
		if slot_name == name then
			local alpha = (wielded and 255) or 100
			widget_style[field_name].text_color[1] = alpha
			widget_style[field_name .. "_2"].text_color[1] = alpha
			widget_style[field_name .. "_3"].text_color[1] = alpha
		end
	end

	self._set_widget_dirty(self, widget)

	return 
end
local ammo_prefix = " "
UnitFrameUI.set_ammo_for_slot = function (self, slot_name, ammo_count, remaining_ammo, using_single_clip)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style
	local text_field_name = self.weapon_slot_widget_settings.ammo_fields[slot_name]

	if not ammo_count or not remaining_ammo then
		widget_content[text_field_name] = " "
		widget_content[text_field_name .. "_2"] = " "
		widget_content[text_field_name .. "_3"] = " "
	else
		widget_content[text_field_name] = ammo_prefix .. tostring(ammo_count)
		widget_content[text_field_name .. "_2"] = (using_single_clip and ammo_prefix) or "|"
		widget_content[text_field_name .. "_3"] = (using_single_clip and ammo_prefix) or tostring(remaining_ammo)
	end

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_overcharge_percentage = function (self, has_overcharge, overcharge_percent)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style
	widget_content.has_overcharge = has_overcharge
	widget_content.overcharge_fill.has_overcharge = has_overcharge
	widget_content.overcharge_fill.overcharge_percent = overcharge_percent or 0

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_active_percentage = function (self, active_percentage)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_style = widget.style
	local widget_content = widget.content
	widget_content.actual_active_percentage = active_percentage

	self._on_num_grimoires_changed(self, "grimoires", widget, 1 - active_percentage)
	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_health_percentage = function (self, health_percentage, active_percentage, low_health)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_style = widget.style
	local widget_content = widget.content
	widget_content.hp_bar.low_health = low_health
	widget_content.actual_health_percent = health_percentage

	self._on_player_health_changed(self, "health", widget, health_percentage * active_percentage)
	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_health_bar_status = function (self, show_health_bar, is_knocked_down, is_wounded)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_style = widget.style
	local widget_content = widget.content
	local hp_bar_content = widget_content.hp_bar
	hp_bar_content.draw_health_bar = show_health_bar
	hp_bar_content.is_knocked_down = is_knocked_down
	hp_bar_content.is_wounded = is_wounded

	if is_wounded then
		hp_bar_content.texture_id = hp_bar_content.wounded_texture_id
	else
		hp_bar_content.texture_id = hp_bar_content.normal_texture_id
		local gui = self.ui_renderer.gui_retained
		local gui_material = Gui.material(gui, hp_bar_content.texture_id)

		if is_knocked_down then
			Material.set_vector2(gui_material, "color_tint_uv", Vector2(1, 0.5))
		else
			local inverted_bar_value = 1 - (hp_bar_content.bar_value or 1)

			Material.set_vector2(gui_material, "color_tint_uv", Vector2(inverted_bar_value, 0.5))
		end
	end

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_health_bar_divider_amount = function (self, health_bar_divider_count)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_style = widget.style
	widget_style.hp_bar_divider.texture_amount = health_bar_divider_count

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI.set_shielded = function (self, has_shield, shield_percent)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style
	widget_content.has_shield = has_shield
	widget_content.hp_bar_shield.has_shield = has_shield
	widget_content.hp_bar_shield.shield_percent = shield_percent
	widget_content.hp_bar_shield.internal_shield_percent = nil
	widget_content.hp_bar_shield.internal_health_percent = nil
	widget_content.hp_bar_shield.internal_grimoire_percent = nil

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI._update_overlay = function (self, is_dead, is_knocked_down, needs_help)
	local alpha = 255

	if is_dead then
		self.set_potrait_overlay(self, "unit_frame_portrait_dead")

		alpha = 255
	elseif is_knocked_down then
		self.set_potrait_overlay(self, "unit_frame_portrait_dead")

		local i = math.sirp(0, 0.7, self.overlay_time)
		alpha = 255 * i
	elseif needs_help then
		self.set_potrait_overlay(self, "unit_frame_red_overlay")

		local i = math.sirp(0.6, 1, self.overlay_time)
		alpha = 255 * i
	end

	local widget = self._widget_by_name(self, "portait_dynamic")
	widget.style.portrait_overlay.color[1] = alpha

	self._set_widget_dirty(self, widget)

	return 
end
UnitFrameUI._update_voice_animation = function (self, dt, t, is_talking)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local highlight_style = widget.style.talk_indicator_highlight
	local color = highlight_style.color
	local size = highlight_style.size
	local old_alpha = color[1]
	old_alpha = old_alpha + ((is_talking and 1) or -1) * 255 * dt

	if is_talking then
		old_alpha = old_alpha + math.sin(t * 3) * 20
		old_alpha = old_alpha + math.cos((t + 1) * 13) * 20
		size[2] = 70 + math.sin(t * 7) * 15 + math.cos((t + 1) * 17) * 10
	end

	old_alpha = math.clamp(old_alpha, 0, 255)

	if old_alpha ~= color[1] then
		color[1] = old_alpha

		self._set_widget_dirty(self, widget)

		return true
	end

	return 
end
UnitFrameUI._update_grimoire_bar_animation = function (self, dt, t)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local content = widget_content.grimoire_debuff
	local bar_value = content.bar_value

	if bar_value ~= content.internal_bar_value then
		local bar_start_side = widget_content.bar_start_side
		local widget_style = widget.style
		local style = widget_style.grimoire_debuff
		local uv_start_pixels = style.uv_start_pixels
		local uv_scale_pixels = style.uv_scale_pixels
		local uv_scale_axis = 1
		local offset_scale = 1
		local offset = style.offset
		local uvs = content.uvs
		local size = style.size
		local uv_pixels = uv_start_pixels + uv_scale_pixels * bar_value
		local uv_change = uv_pixels / (uv_start_pixels + uv_scale_pixels)
		size[uv_scale_axis] = uv_pixels

		if bar_start_side == "left" then
			uvs[1][uv_scale_axis] = 1 - uv_change
			offset[uv_scale_axis] = style.start_offset + ((uv_start_pixels + uv_scale_pixels) - uv_pixels) * offset_scale
		else
			uvs[2][uv_scale_axis] = uv_change
		end

		content.internal_bar_value = bar_value

		self._set_widget_dirty(self, widget)

		local show_bar_overlay = 0 < bar_value
		local max_health_divider_content = widget_content.hp_bar_max_health_divider
		local grimoire_icon_content = widget_content.hp_bar_grimoire_icon
		max_health_divider_content.active = show_bar_overlay
		grimoire_icon_content.active = show_bar_overlay and 0.1 < bar_value

		if show_bar_overlay then
			local max_health_divider_style = widget_style.hp_bar_max_health_divider
			local grimoire_icon_style = widget_style.hp_bar_grimoire_icon

			if bar_start_side == "left" then
				local bar_offset = bar_value * uv_scale_pixels
				max_health_divider_style.offset[1] = max_health_divider_style.start_offset + uv_scale_pixels - math.ceil(bar_offset)
				grimoire_icon_style.offset[1] = grimoire_icon_style.start_offset - math.ceil(bar_offset / 2)
			else
				local bar_offset = bar_value * uv_scale_pixels
				max_health_divider_style.offset[1] = max_health_divider_style.start_offset + math.ceil(bar_offset)
				grimoire_icon_style.offset[1] = grimoire_icon_style.start_offset + math.ceil(bar_offset / 2)
			end
		end

		return true
	end

	return 
end
UnitFrameUI._update_health_bar_animation = function (self, dt, t)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local content = widget_content.hp_bar
	local bar_value = content.bar_value

	if bar_value ~= content.internal_bar_value then
		local bar_start_side = widget_content.bar_start_side
		local widget_style = widget.style
		local style = widget_style.hp_bar
		local uv_start_pixels = style.uv_start_pixels
		local uv_scale_pixels = style.uv_scale_pixels
		local uv_scale_axis = style.scale_axis
		local offset_scale = style.offset_scale
		local offset = style.offset
		local default_offset = style.default_offset
		local size = style.size
		local uvs = content.uvs
		local is_wounded = content.is_wounded
		local inverted_bar_value = 1 - bar_value

		if is_wounded then
			content.texture_id = content.wounded_texture_id
		else
			content.texture_id = content.normal_texture_id
			local gui = self.ui_renderer.gui_retained
			local gui_material = Gui.material(gui, content.texture_id)

			if content.is_knocked_down then
				Material.set_vector2(gui_material, "color_tint_uv", Vector2(1, 0.5))
			else
				Material.set_vector2(gui_material, "color_tint_uv", Vector2(inverted_bar_value, 0.5))
			end
		end

		local uv_pixels = uv_start_pixels + uv_scale_pixels * bar_value
		size[uv_scale_axis] = uv_pixels

		if bar_start_side == "left" then
			uvs[2][uv_scale_axis] = uv_pixels / (uv_start_pixels + uv_scale_pixels)
		else
			uvs[2][uv_scale_axis] = uv_pixels / (uv_start_pixels + uv_scale_pixels)
			offset[uv_scale_axis] = default_offset[1] + ((uv_start_pixels + uv_scale_pixels) - uv_pixels) * offset_scale
		end

		content.internal_bar_value = bar_value

		return true
	end

	return 
end
UnitFrameUI._update_shield_bar_animation = function (self, dt, t)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content

	if not widget_content.has_shield then
		return 
	end

	local content = widget_content.hp_bar_shield
	local current_bar_health_style = widget.style.hp_bar
	local shield_percent = content.shield_percent
	local health_percent = widget_content.hp_bar.internal_bar_value
	local grimoire_percent = widget_content.grimoire_debuff.bar_value
	local shield_changed = content.internal_shield_percent ~= shield_percent
	local health_changed = content.internal_health_percent ~= health_percent
	local grimoire_changed = content.internal_grimoire_percent ~= grimoire_percent

	if shield_changed or health_changed or grimoire_changed then
		local bar_start_side = widget_content.bar_start_side
		local widget_style = widget.style
		local style = widget_style.hp_bar_shield
		local uv_start_pixels = style.uv_start_pixels
		local uv_scale_pixels = style.uv_scale_pixels
		local uv_scale_axis = style.scale_axis
		local offset_scale = style.offset_scale
		local offset = style.offset
		local size = style.size
		local uvs = content.uvs
		local actual_active_percentage = widget_content.actual_active_percentage or 1
		local grimoire_width = (1 - actual_active_percentage) * uv_scale_pixels
		local health_bar_length = health_percent * uv_scale_pixels
		local removed_health_length = uv_scale_pixels - health_bar_length
		local width_between_grimoire_and_health = math.max(uv_scale_pixels - health_bar_length - grimoire_width, 0)
		local shield_size = uv_start_pixels + shield_percent * uv_scale_pixels
		shield_size = math.min(shield_size, width_between_grimoire_and_health + health_bar_length)
		size[uv_scale_axis] = shield_size
		local position_x = style.start_offset

		if bar_start_side == "left" then
			position_x = position_x + health_bar_length - shield_size + math.min(width_between_grimoire_and_health, shield_size)
			offset[uv_scale_axis] = position_x
			uvs[2][uv_scale_axis] = shield_size / (uv_start_pixels + uv_scale_pixels)
		else
			position_x = (position_x + removed_health_length) - math.min(width_between_grimoire_and_health, shield_size)
			offset[uv_scale_axis] = position_x
			uvs[2][uv_scale_axis] = shield_size / (uv_start_pixels + uv_scale_pixels)
		end

		content.internal_bar_value_position = health_percent
		content.internal_health_percent = health_percent
		content.internal_grimoire_percent = grimoire_percent
		content.internal_shield_percent = shield_percent

		return true
	end

	return 
end
UnitFrameUI._update_overcharge_animation = function (self, dt, t)
	local widget = self._widget_by_name(self, "loadout_dynamic")
	local widget_content = widget.content
	local widget_style = widget.style

	if not widget_content.has_overcharge then
		return 
	end

	local style = widget_style.overcharge_fill
	local content = widget_content.overcharge_fill
	local overcharge_percent = content.overcharge_percent
	local overcharge_changed = content.internal_overcharge_percent ~= overcharge_percent

	if overcharge_changed then
		local bar_start_side = widget_content.bar_start_side
		local uv_start_pixels = style.uv_start_pixels
		local uv_scale_pixels = style.uv_scale_pixels
		local uv_scale_axis = style.scale_axis
		local offset_scale = style.offset_scale
		local offset = style.offset
		local size = style.size
		local uvs = content.uvs
		local overcharge_offset = uv_scale_pixels
		local uv_pixels = uv_start_pixels + uv_scale_pixels
		local bar_size = uv_start_pixels + uv_scale_pixels * overcharge_percent
		size[uv_scale_axis] = bar_size
		local position_x = style.start_offset

		if bar_start_side == "left" then
			uvs[2][uv_scale_axis] = uv_pixels / (uv_start_pixels + uv_scale_pixels)
			local start_offset = style.start_offset
			position_x = math.max(start_offset + overcharge_offset, (start_offset + uv_scale_pixels) - bar_size)
			offset[uv_scale_axis] = position_x
		else
			uvs[2][uv_scale_axis] = uv_pixels / (uv_start_pixels + uv_scale_pixels)
			local start_offset = style.start_offset
			position_x = (start_offset + overcharge_offset) - bar_size
			offset[uv_scale_axis] = position_x
		end

		content.internal_overcharge_percent = overcharge_percent

		return true
	end

	return 
end
UnitFrameUI._on_num_grimoires_changed = function (self, name, widget, health_debuff_percent)
	if not self.bar_animations then
		self.bar_animations = {}
	end

	local unit_frames_settings = UISettings.unit_frames
	local bar_animation = self.bar_animations[name] or {}

	if health_debuff_percent ~= bar_animation.current_health_debuff then
		local current_bar_health_debuff = widget.content.grimoire_debuff.bar_value
		local current_bar_health_debuff_style = widget.style.grimoire_debuff
		local current_bar_health_style = widget.style.hp_bar
		local lerp_time = UISettings.unit_frames.health_bar_lerp_time
		local anim_time = nil

		if current_bar_health_debuff < health_debuff_percent then
			anim_time = (health_debuff_percent - current_bar_health_debuff) * lerp_time
		else
			anim_time = (current_bar_health_debuff - health_debuff_percent) * lerp_time
		end

		local length_difference = current_bar_health_debuff_style.uv_scale_pixels - current_bar_health_style.uv_scale_pixels
		local hp_bar_percentage_length = current_bar_health_style.uv_scale_pixels * health_debuff_percent
		local actual_debuff_length = hp_bar_percentage_length + length_difference * 0.5
		local actual_debuff_percent = actual_debuff_length / current_bar_health_debuff_style.uv_scale_pixels
		health_debuff_percent = actual_debuff_percent
		bar_animation.animate = true
		bar_animation.new_value = actual_debuff_percent
		bar_animation.previous_value = current_bar_health_debuff
		bar_animation.time = 0
		bar_animation.total_time = anim_time
		bar_animation.widget = widget
		bar_animation.bar = widget.content.grimoire_debuff
	end

	bar_animation.current_health_debuff = health_debuff_percent
	self.bar_animations[name] = bar_animation

	return 
end
UnitFrameUI._on_overcharge_changed = function (self, name, widget, overcharge_percent)
	if not self.bar_animations then
		self.bar_animations = {}
	end

	local unit_frames_settings = UISettings.unit_frames
	local bar_animation = self.bar_animations[name] or {}

	if overcharge_percent ~= bar_animation.current_overcharge_percent then
		local current_overcharge_percent = widget.content.overcharge_fill.bar_value
		local lerp_time = UISettings.unit_frames.health_bar_lerp_time
		local anim_time = nil

		if current_overcharge_percent < overcharge_percent then
			anim_time = (overcharge_percent - current_overcharge_percent) * lerp_time
		else
			anim_time = (current_overcharge_percent - overcharge_percent) * lerp_time
		end

		bar_animation.animate = true
		bar_animation.new_value = overcharge_percent
		bar_animation.previous_value = current_overcharge_percent
		bar_animation.time = 0
		bar_animation.total_time = anim_time
		bar_animation.widget = widget
		bar_animation.bar = widget.content.overcharge_fill
	end

	bar_animation.current_overcharge_percent = overcharge_percent
	self.bar_animations[name] = bar_animation

	return 
end
UnitFrameUI._on_player_health_changed = function (self, name, widget, health_percent)
	local unit_frames_settings = UISettings.unit_frames

	if not self.bar_animations[name] then
		local bar_animation = {
			low_health_animation = UIAnimation.init(UIAnimation.pulse_animation, widget.style.hp_bar.color, 1, unit_frames_settings.low_health_animation_alpha_from, unit_frames_settings.low_health_animation_alpha_to, unit_frames_settings.low_health_animation_time)
		}
	end

	self.bar_animations[name] = bar_animation
	local health_percent_current = bar_animation.current_health
	bar_animation.current_health = health_percent

	if health_percent <= 1 and health_percent ~= health_percent_current then
		local is_knocked_down = widget.content.hp_bar.is_knocked_down
		local current_bar_health = widget.content.hp_bar.bar_value
		local lerp_time = UISettings.unit_frames.health_bar_lerp_time
		local anim_time = nil

		if current_bar_health < health_percent then
			anim_time = (health_percent - current_bar_health) * lerp_time
		else
			anim_time = (current_bar_health - health_percent) * lerp_time
		end

		local animate_highlight = (not is_knocked_down and health_percent < (health_percent_current or 1)) or false
		bar_animation.animate_highlight = (not animate_highlight or 0) and bar_animation.animate_highlight
		bar_animation.animate = true
		bar_animation.new_value = health_percent
		bar_animation.previous_value = current_bar_health
		bar_animation.time = 0
		bar_animation.total_time = anim_time
		bar_animation.widget = widget
		bar_animation.bar = widget.content.hp_bar

		return true
	end

	return 
end
UnitFrameUI._update_bar_animations = function (self, dt)
	local dirty = false

	Profiler.start("update_unit_frames_animations")

	local bar_animations = self.bar_animations

	if bar_animations then
		for name, animation_data in pairs(bar_animations) do
			local widget_dirty = false
			local widget = animation_data.widget
			local bar = animation_data.bar

			if bar.low_health then
				UIAnimation.update(animation_data.low_health_animation, dt)

				dirty = true
				widget_dirty = true
			end

			if animation_data.animate_highlight and not widget.content.has_shield then
				animation_data.animate_highlight = self._update_damage_highlight(self, widget, animation_data.animate_highlight, dt)
				dirty = true
				widget_dirty = true
			end

			if animation_data.animate then
				local time = animation_data.time
				local total_time = animation_data.total_time
				local new_value = animation_data.new_value
				local previous_value = animation_data.previous_value
				local time_left = self._update_player_bar_animation(self, widget, bar, time, total_time, previous_value, new_value, dt)
				widget_dirty = true

				if time_left then
					animation_data.time = time_left
				else
					animation_data.animate = nil
				end

				dirty = true
			end

			if widget_dirty then
				self._set_widget_dirty(self, widget)
			end
		end
	end

	Profiler.stop("update_unit_frames_animations")

	return dirty
end
UnitFrameUI._update_damage_highlight = function (self, widget, time, dt)
	local total_time = 0.2
	time = time + dt

	if 0 < total_time then
		local style = widget.style
		local progress = math.min(time / total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -8, 0, 0, -8)
		local highlight_alpha = 255 * catmullrom_value
		style.hp_bar_highlight.color[1] = highlight_alpha

		self._set_widget_dirty(self, widget)

		return (progress < 1 and time) or nil
	end

	return nil
end
UnitFrameUI._update_player_bar_animation = function (self, widget, bar, time, total_time, anim_start_value, anim_end_value, dt)
	time = time + dt

	if 0 < total_time then
		local style = widget.style
		local progress = math.min(time / total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -14, 0, 0, 0)
		local weight = 7
		local weighted_average = (progress * (weight - 1) + 1) / weight
		local bar_fraction = nil

		if anim_start_value < anim_end_value then
			bar_fraction = anim_start_value + (anim_end_value - anim_start_value) * weighted_average
		else
			bar_fraction = anim_start_value - (anim_start_value - anim_end_value) * weighted_average
		end

		bar.bar_value = bar_fraction

		return (progress < 1 and time) or nil
	end

	bar.bar_value = anim_end_value

	return nil
end
UnitFrameUI._add_slot_equip_animation = function (self, name, widget, style)
	local animations = self.slot_equip_animations
	local inventory_hud_settings = UISettings.inventory_hud
	local total_time = inventory_hud_settings.equip_animation_duration
	local animation = animations[name]

	if animation then
		animation.total_time = total_time
		animation.time = 0
	else
		animations[name] = {
			time = 0,
			total_time = total_time,
			style = style,
			widget = widget
		}
	end

	return 
end
UnitFrameUI._animate_slot_equip = function (self, animation_data, dt)
	local style = animation_data.style
	local total_time = animation_data.total_time
	local time = animation_data.time
	time = time + dt
	local progress = math.min(time / total_time, 1)
	local catmullrom_value = math.catmullrom(progress, -10, 0, 0, -4)
	style.color[1] = 255 * catmullrom_value
	animation_data.time = time

	return (progress < 1 and animation_data) or nil
end
UnitFrameUI._update_slot_equip_animations = function (self, dt)
	local animations = self.slot_equip_animations

	for name, animation_data in pairs(animations) do
		animations[name] = self._animate_slot_equip(self, animation_data, dt)
		local widget = animation_data.widget

		self._set_widget_dirty(self, widget)

		return true
	end

	return 
end
UnitFrameUI._update_connection_animation = function (self, dt)
	local widget = self._widget_by_name(self, "portait_dynamic")
	local widget_content = widget.content

	if widget_content.connecting then
		local connecting_icon_style = widget.style.connecting_icon
		local connecting_rotation_speed = 200
		local connecting_rotation_angle = (dt * connecting_rotation_speed) % 360
		local connecting_radians = math.degrees_to_radians(connecting_rotation_angle)
		connecting_icon_style.angle = connecting_icon_style.angle + connecting_radians

		self._set_widget_dirty(self, widget)

		return true
	end

	return 
end

return 
