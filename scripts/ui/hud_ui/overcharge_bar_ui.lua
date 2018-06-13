local definitions = local_require("scripts/ui/hud_ui/overcharge_bar_ui_definitions")
OverchargeBarUI = class(OverchargeBarUI)
local charge_bar_end_position = {
	190,
	80
}
local accepted_slots = {
	slot_ranged = true,
	slot_melee = true
}

OverchargeBarUI.init = function (self, ingame_ui_context)
	self.platform = PLATFORM
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.slot_equip_animations = {}
	self.slot_animations = {}
	self.ui_animations = {}

	self:create_ui_elements()

	self.peer_id = ingame_ui_context.peer_id
	self.player_manager = ingame_ui_context.player_manager
	self.render_settings = {
		snap_pixel_positions = true
	}
end

local function get_overcharge_amount(left_hand_wielded_unit, right_hand_wielded_unit)
	local overcharge_extension = nil

	if right_hand_wielded_unit and ScriptUnit.has_extension(right_hand_wielded_unit, "overcharge_system") then
		overcharge_extension = ScriptUnit.extension(right_hand_wielded_unit, "overcharge_system")
	elseif left_hand_wielded_unit and ScriptUnit.has_extension(left_hand_wielded_unit, "overcharge_system") then
		overcharge_extension = ScriptUnit.extension(left_hand_wielded_unit, "overcharge_system")
	end

	if overcharge_extension then
		local overcharge_fraction = overcharge_extension:overcharge_fraction()
		local threshold_fraction = overcharge_extension:threshold_fraction()
		local anim_blend_overcharge = overcharge_extension:get_anim_blend_overcharge()

		return overcharge_fraction, threshold_fraction, anim_blend_overcharge
	end
end

OverchargeBarUI._set_player_extensions = function (self, player_unit)
	print("_set_player_extensions", player_unit)

	self.inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
	self.initialize_charge_bar = true
end

OverchargeBarUI._update_overcharge = function (self, player, dt)
	if not player then
		return
	end

	local player_unit = player.player_unit

	if not Unit.alive(player_unit) then
		return
	end

	local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
	local equipment = inventory_extension:equipment()

	if not equipment then
		return
	end

	local wielded = equipment.wielded
	local inventory_slots = InventorySettings.slots

	for _, slot in ipairs(inventory_slots) do
		local slot_name = slot.name

		if accepted_slots[slot_name] then
			local slot_data = equipment.slots[slot_name]

			if slot_data then
				local item_data = slot_data.item_data
				local item_name = item_data.name
				local is_wielded = wielded == item_data

				if is_wielded then
					local overcharge_fraction, threshold_fraction, anim_blend_overcharge = get_overcharge_amount(slot_data.left_unit_1p, slot_data.right_unit_1p)
					local has_overcharge = overcharge_fraction and overcharge_fraction > 0

					if has_overcharge then
						if not self.wielded_item_name or self.wielded_item_name ~= item_name then
							self.wielded_item_name = item_name

							self:setup_charge_bar(threshold_fraction or 1)
						end

						self:set_charge_bar_fraction(overcharge_fraction, threshold_fraction, anim_blend_overcharge)

						return true
					end
				end
			end
		end
	end
end

OverchargeBarUI.create_ui_elements = function (self)
	UIRenderer.clear_scenegraph_queue(self.ui_renderer)

	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	local widget_definitions = definitions.inventory_entry_definitions
	self.charge_bar = UIWidget.init(definitions.widget_definitions.charge_bar)
end

OverchargeBarUI.update = function (self, dt, t, player)
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("ingame_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")

	if self:_update_overcharge(player, dt) then
		local ui_renderer = self.ui_renderer

		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, self.render_settings)
		UIRenderer.draw_widget(ui_renderer, self.charge_bar)
		UIRenderer.end_pass(ui_renderer)
	end
end

OverchargeBarUI.setup_charge_bar = function (self, threshold_fraction)
	local widget = self.charge_bar
	local widget_style = widget.style
	local marker_fraction = threshold_fraction * 0.82
	local r = 265
	local x = r * math.sin(marker_fraction)
	local y = r * -math.cos(marker_fraction)
	widget_style.black_divider_left.offset[1] = -x
	widget_style.black_divider_left.offset[2] = y
	widget_style.black_divider_right.offset[1] = x
	widget_style.black_divider_right.offset[2] = y
	local one_side_max_angle = 45
	local current_angle = threshold_fraction * one_side_max_angle
	local radians = math.degrees_to_radians(current_angle)
	widget_style.black_divider_right.angle = -radians
	widget_style.black_divider_left.angle = radians
end

OverchargeBarUI.set_charge_bar_fraction = function (self, overcharge_fraction, threshold_fraction, anim_blend_overcharge)
	local widget = self.charge_bar
	local widget_style = widget.style
	overcharge_fraction = math.lerp(widget_style.fill.gradient_threshold, math.min(overcharge_fraction, 1), 0.3)
	widget_style.fill.gradient_threshold = overcharge_fraction
	widget_style.sidefade.gradient_threshold = 1
	local marker_fraction = overcharge_fraction * 0.82
	local r = 265
	local x = r * math.sin(marker_fraction)
	local y = r * -math.cos(marker_fraction)
	widget_style.white_divider_left.offset[1] = -x
	widget_style.white_divider_left.offset[2] = y
	widget_style.white_divider_right.offset[1] = x
	widget_style.white_divider_right.offset[2] = y
	local white_divider_alpha = 255 * math.min(overcharge_fraction / (threshold_fraction * 1.5), 1)
	widget_style.white_divider_left.color[1] = white_divider_alpha
	widget_style.white_divider_right.color[1] = white_divider_alpha
	widget_style.fill.color[3] = 255 - white_divider_alpha
	local sidefade_alpha = 255 * math.max(0, math.min((overcharge_fraction - threshold_fraction) / 0.1, 1))
	widget_style.sidefade.color[1] = sidefade_alpha
	local one_side_max_angle = 45
	local current_angle = overcharge_fraction * one_side_max_angle
	local radians = math.degrees_to_radians(current_angle)
	widget_style.white_divider_right.angle = -radians
	widget_style.white_divider_left.angle = radians
	self.ui_scenegraph.charge_bar_white_divider_start_left.local_position[1] = -2
	self.ui_scenegraph.charge_bar_white_divider_start_right.local_position[1] = 2
	widget_style.flames_texture.offset[2] = -130 + anim_blend_overcharge * 130
end

OverchargeBarUI.destroy = function (self)
	return
end

return
