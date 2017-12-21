local definitions = local_require("scripts/ui/hud_ui/observer_ui_definitions")
local RELOAD_UI = false
local MIN_HEALTH_DIVIDERS = 0
local MAX_HEALTH_DIVIDERS = 10
ObserverUI = class(ObserverUI)
ObserverUI.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.input_manager = ingame_ui_context.input_manager
	self.profile_synchronizer = ingame_ui_context.profile_synchronizer
	self.player_manager = ingame_ui_context.player_manager
	self.peer_id = ingame_ui_context.peer_id
	self.local_player = Managers.player:local_player()
	self.player_shielded = false
	self._is_visible = false
	self._is_own_player_dead = false

	self.create_ui_elements(self)

	return 
end
ObserverUI.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.divider_widget = UIWidget.init(definitions.widget_definitions.divider)
	self.player_name_widget = UIWidget.init(definitions.widget_definitions.player_name)
	self.hero_name_widget = UIWidget.init(definitions.widget_definitions.hero_name)
	self.hp_bar_widget = UIWidget.init(definitions.widget_definitions.hp_bar)
	self.player_name_widget.style.text.localize = false

	return 
end
ObserverUI.get_player_camera_extension = function (self)
	local peer_id = self.peer_id
	local my_player = self.player_manager:player_from_peer_id(peer_id)
	local camera_unit = my_player.camera_follow_unit

	if camera_unit and ScriptUnit.has_extension(camera_unit, "camera_system") then
		return ScriptUnit.extension(camera_unit, "camera_system")
	end

	return 
end
ObserverUI.handle_observer_player_changed = function (self)
	local camera_extension = self.get_player_camera_extension(self)

	if not camera_extension then
		return 
	end

	local observed_player_id = camera_extension.get_observed_player_id(camera_extension)

	if observed_player_id then
		local current_observing_player_id = self.observing_player_id

		if not current_observing_player_id or current_observing_player_id ~= observed_player_id then
			self.set_observer_player(self, observed_player_id)
		end
	else
		self.stop_draw_observer_ui(self)
	end

	return 
end
ObserverUI.set_observer_player = function (self, player_id)
	local profiles = SPProfiles
	local profile_synchronizer = self.profile_synchronizer
	local player_manager = Managers.player
	local players = player_manager.players(player_manager)
	local follow_player = players[player_id]
	local is_player_controlled = follow_player.is_player_controlled(follow_player)
	local local_player_id = follow_player.local_player_id(follow_player)
	local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, follow_player.peer_id, local_player_id)
	local hero_display_name = profiles[profile_index] and profiles[profile_index].display_name
	local player_name = follow_player.name(follow_player)
	self.player_name_widget.content.text = (is_player_controlled and player_name) or player_name .. " (BOT)"
	self.hero_name_widget.content.text = hero_display_name
	self.observing_player_id = player_id
	self._skip_bar_animation = true
	self.player_name_widget.element.dirty = true
	self.hero_name_widget.element.dirty = true
	self._dirty = true

	return 
end
ObserverUI.stop_draw_observer_ui = function (self)
	self.observing_player_id = nil
	self.divider_widget.element.dirty = true
	self.player_name_widget.element.dirty = true
	self.hero_name_widget.element.dirty = true
	self.hp_bar_widget.element.dirty = true
	self._dirty = true

	return 
end
ObserverUI.update = function (self, dt, t, is_own_player_dead, is_in_inn)
	if is_in_inn then
		return 
	end

	if self._is_own_player_dead ~= is_own_player_dead then
		self._is_own_player_dead = is_own_player_dead

		self.set_visible(self, not self._is_visible)
	end

	if not self._is_visible then
		return 
	end

	self.handle_observer_player_changed(self)

	if self.observing_player_id then
		self.update_health_animations(self, dt)
		self.update_follow_player_health_bar(self, self.observing_player_id)

		self._skip_bar_animation = nil
	end

	self.draw(self, dt)

	return 
end
ObserverUI.draw = function (self, dt)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("Player")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	if self._dirty then
		UIRenderer.draw_widget(ui_renderer, self.divider_widget)
		UIRenderer.draw_widget(ui_renderer, self.player_name_widget)
		UIRenderer.draw_widget(ui_renderer, self.hero_name_widget)

		self._dirty = false
	end

	UIRenderer.draw_widget(ui_renderer, self.hp_bar_widget)
	UIRenderer.end_pass(ui_renderer)

	return 
end
ObserverUI.destroy = function (self)
	return 
end
ObserverUI.set_visible = function (self, visible)
	if self._is_visible ~= visible then
		local divider_widget = self.divider_widget

		UIRenderer.set_element_visible(self.ui_renderer, divider_widget.element, visible)

		divider_widget.content.visible = visible
		divider_widget.element.dirty = true
		local player_name_widget = self.player_name_widget

		UIRenderer.set_element_visible(self.ui_renderer, player_name_widget.element, visible)

		divider_widget.content.visible = visible
		player_name_widget.element.dirty = true
		local hero_name_widget = self.hero_name_widget

		UIRenderer.set_element_visible(self.ui_renderer, hero_name_widget.element, visible)

		divider_widget.content.visible = visible
		hero_name_widget.element.dirty = true
		local hp_bar_widget = self.hp_bar_widget

		UIRenderer.set_element_visible(self.ui_renderer, hp_bar_widget.element, visible)

		divider_widget.content.visible = visible
		hp_bar_widget.element.dirty = true
		self._dirty = true
		self._is_visible = visible
	end

	return 
end
ObserverUI.update_follow_player_health_bar = function (self, peer_id)
	Profiler.start("update_follow_player_health_bar")

	local profile_synchronizer = self.profile_synchronizer
	local player_manager = Managers.player
	local players = player_manager.players(player_manager)
	local player = players[peer_id]
	local local_player_id = player.local_player_id(player)
	local player_unit = player.player_unit
	local health_percent, is_knocked_down, is_dead, is_wounded, is_ready_for_assisted_respawn = nil
	local shield_percent = 0
	local active_percentage = 1
	local modified_bar = false
	local hp_bar_widget = self.hp_bar_widget
	local bar_content = hp_bar_widget.content
	local bar_style = hp_bar_widget.style

	if player_unit then
		local health_extension = ScriptUnit.extension(player_unit, "health_system")
		local status_extension = ScriptUnit.extension(player_unit, "status_system")
		local damage_extension = ScriptUnit.extension(player_unit, "damage_system")
		health_percent = health_extension.current_health_percent(health_extension)
		local max_health = health_extension.unmodified_max_health
		local has_shield, shield_amount = damage_extension.has_assist_shield(damage_extension)

		if has_shield then
			shield_percent = shield_amount/max_health

			if not self.player_shielded then
				local hp_bar_highlight = bar_style.hp_bar_highlight
				hp_bar_highlight.color[1] = 255
				hp_bar_highlight.color[2] = 140
				hp_bar_highlight.color[3] = 180
				hp_bar_highlight.color[4] = 255
				hp_bar_widget.element.dirty = true
				self._dirty = true
				self.player_shielded = true
			end
		elseif self.player_shielded then
			local hp_bar_highlight = bar_style.hp_bar_highlight
			hp_bar_highlight.color[1] = 0
			hp_bar_highlight.color[2] = 0
			hp_bar_highlight.color[3] = 0
			hp_bar_highlight.color[4] = 0
			hp_bar_widget.element.dirty = true
			self._dirty = true
			self.player_shielded = false
		end

		is_wounded = status_extension.is_wounded(status_extension)
		is_knocked_down = status_extension.is_knocked_down(status_extension) and 0 < health_percent
		is_ready_for_assisted_respawn = status_extension.is_ready_for_assisted_respawn(status_extension)
		local buff_extension = ScriptUnit.extension(player_unit, "buff_system")
		local num_grimoires = buff_extension.num_buff_type(buff_extension, "grimoire_health_debuff")
		local multiplier = buff_extension.apply_buffs_to_value(buff_extension, PlayerUnitDamageSettings.GRIMOIRE_HEALTH_DEBUFF, StatBuffIndex.CURSE_PROTECTION)
		active_percentage = num_grimoires*multiplier - 1
	else
		health_percent = 0
		is_knocked_down = false
	end

	bar_content.hp_bar.draw_health_bar = not is_ready_for_assisted_respawn
	is_dead = health_percent <= 0
	local num_of_health_dividers = MIN_HEALTH_DIVIDERS
	local low_health = (not is_dead and not is_knocked_down and health_percent < UISettings.unit_frames.low_health_threshold) or nil
	local health_changed = self.on_player_health_changed(self, "my_player", hp_bar_widget, health_percent*active_percentage)
	local grims_changed = self.on_num_grimoires_changed(self, "my_player_grimoires", hp_bar_widget, active_percentage - 1)
	modified_bar = modified_bar or health_changed or grims_changed
	local hp_bar_value = hp_bar_widget.content.hp_bar.bar_value
	local grimoire_value = hp_bar_widget.content.hp_bar_grimoire_debuff.bar_value
	bar_content.hp_bar_shield.bar_value_position = hp_bar_value
	bar_content.hp_bar_shield.bar_value_offset = grimoire_value
	bar_content.hp_bar_shield.bar_value_size = shield_percent
	local max_health_divider_content = bar_content.hp_bar_max_health_divider
	max_health_divider_content.active = false
	local grimoire_icon_content = bar_content.hp_bar_grimoire_icon
	grimoire_icon_content.active = false

	if active_percentage < 1 then
		max_health_divider_content.active = true
		local max_health_divider_style = hp_bar_widget.style.hp_bar_max_health_divider
		local default_bar_length = definitions.scenegraph_definition.hp_bar_grimoire_debuff_fill.size[1]
		local bar_value = bar_content.hp_bar_grimoire_debuff.bar_value
		local bar_offset = -bar_value*default_bar_length
		max_health_divider_style.offset[1] = bar_offset
		grimoire_icon_content.active = true
		local grimoire_icon_style = hp_bar_widget.style.hp_bar_grimoire_icon
		grimoire_icon_style.offset[1] = bar_offset/2
	end

	local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, player.peer_id, local_player_id)

	if profile_index then
		if is_knocked_down or is_dead then
			num_of_health_dividers = MIN_HEALTH_DIVIDERS
		else
			num_of_health_dividers = MAX_HEALTH_DIVIDERS
		end

		bar_content.hp_bar.low_health = low_health
		bar_content.hp_bar.is_knocked_down = is_knocked_down
		bar_content.hp_bar.is_wounded = is_wounded
		bar_style.hp_bar_divider.texture_amount = num_of_health_dividers
	end

	local resolution_modified = RESOLUTION_LOOKUP.modified

	if modified_bar or resolution_modified then
		hp_bar_widget.element.dirty = true
		self._dirty = true
		self.divider_widget.element.dirty = true
		self.player_name_widget.element.dirty = true
		self.hero_name_widget.element.dirty = true
	end

	Profiler.stop()

	return 
end
ObserverUI.on_player_health_changed = function (self, name, widget, health_percent)
	if not self.bar_animations_data then
		self.bar_animations_data = {}
	end

	local unit_frames_settings = UISettings.unit_frames

	if not self.bar_animations_data[name] then
		local widget_animation_data = {
			low_health_animation = UIAnimation.init(UIAnimation.pulse_animation, widget.style.hp_bar.color, 1, unit_frames_settings.low_health_animation_alpha_from, unit_frames_settings.low_health_animation_alpha_to, unit_frames_settings.low_health_animation_time)
		}
	end

	self.bar_animations_data[name] = widget_animation_data
	local health_percent_current = widget_animation_data.current_health
	widget_animation_data.current_health = health_percent

	if health_percent <= 1 and health_percent ~= health_percent_current then
		local is_knocked_down = widget.content.hp_bar.is_knocked_down
		local current_bar_health = widget.content.hp_bar.bar_value
		local lerp_time = UISettings.unit_frames.health_bar_lerp_time
		local anim_time = nil

		if current_bar_health < health_percent then
			anim_time = (health_percent - current_bar_health)*lerp_time
		else
			anim_time = (current_bar_health - health_percent)*lerp_time
		end

		local animate_highlight = (not is_knocked_down and health_percent < (health_percent_current or 1)) or false
		widget_animation_data.animate_highlight = (not animate_highlight or 0) and widget_animation_data.animate_highlight
		widget_animation_data.animate = true
		widget_animation_data.new_health = health_percent
		widget_animation_data.previous_health = current_bar_health
		widget_animation_data.time = 0
		widget_animation_data.total_time = (not self._skip_bar_animation or 0) and anim_time
		widget_animation_data.widget = widget
		widget_animation_data.bar = widget.content.hp_bar

		return true
	end

	return 
end
ObserverUI.on_num_grimoires_changed = function (self, name, widget, health_debuff_percent)
	if not self.bar_animations_data then
		self.bar_animations_data = {}
	end

	local unit_frames_settings = UISettings.unit_frames
	local widget_animation_data = self.bar_animations_data[name] or {}

	if health_debuff_percent ~= widget_animation_data.current_health_debuff then
		local current_bar_health_debuff = widget.content.hp_bar_grimoire_debuff.bar_value
		local lerp_time = UISettings.unit_frames.health_bar_lerp_time
		local anim_time = nil

		if current_bar_health_debuff < health_debuff_percent then
			anim_time = (health_debuff_percent - current_bar_health_debuff)*lerp_time
		else
			anim_time = (current_bar_health_debuff - health_debuff_percent)*lerp_time
		end

		widget_animation_data.animate = true
		widget_animation_data.new_health = health_debuff_percent
		widget_animation_data.previous_health = current_bar_health_debuff
		widget_animation_data.time = 0
		widget_animation_data.total_time = (not self._skip_bar_animation or 0) and anim_time
		widget_animation_data.widget = widget
		widget_animation_data.bar = widget.content.hp_bar_grimoire_debuff
	end

	widget_animation_data.current_health_debuff = health_debuff_percent
	self.bar_animations_data[name] = widget_animation_data

	return 
end
ObserverUI.update_health_animations = function (self, dt)
	Profiler.start("update_health_animations")

	local bar_animations = self.bar_animations_data

	if bar_animations then
		for name, animation_data in pairs(bar_animations) do
			local widget = animation_data.widget
			local bar = animation_data.bar

			if bar.low_health then
				UIAnimation.update(animation_data.low_health_animation, dt)
			end

			if animation_data.animate_highlight and not self.player_shielded then
				animation_data.animate_highlight = self.update_damage_highlight(self, widget, animation_data.animate_highlight, dt)
			end

			if animation_data.animate then
				local time = animation_data.time
				local total_time = animation_data.total_time
				local new_health = animation_data.new_health
				local previous_health = animation_data.previous_health
				local time_left = self.update_player_bar_animation(self, widget, bar, time, total_time, previous_health, new_health, dt)

				if time_left then
					animation_data.time = time_left
				else
					animation_data.animate = nil
				end
			end
		end
	end

	Profiler.stop()

	return 
end
ObserverUI.update_player_bar_animation = function (self, widget, bar, time, total_time, anim_start_health, anim_end_health, dt)
	time = time + dt

	if 0 < total_time then
		local style = widget.style
		local progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -14, 0, 0, 0)
		local weight = 7
		local weighted_average = (progress*(weight - 1) + 1)/weight
		local bar_fraction = nil

		if anim_start_health < anim_end_health then
			bar_fraction = anim_start_health + (anim_end_health - anim_start_health)*weighted_average
		else
			bar_fraction = anim_start_health - (anim_start_health - anim_end_health)*weighted_average
		end

		bar.bar_value = bar_fraction
		widget.element.dirty = true
		self._dirty = true

		return (progress < 1 and time) or nil
	end

	bar.bar_value = anim_end_health

	return nil
end
ObserverUI.update_damage_highlight = function (self, widget, time, dt)
	local total_time = (not self._skip_bar_animation or 0) and 0.2
	time = time + dt

	if 0 < total_time then
		local style = widget.style
		local progress = math.min(time/total_time, 1)
		local catmullrom_value = math.catmullrom(progress, -8, 0, 0, -8)
		local highlight_alpha = catmullrom_value*255
		style.hp_bar_highlight.color[1] = highlight_alpha
		widget.element.dirty = true
		self._dirty = true

		return (progress < 1 and time) or nil
	end

	return nil
end

return 