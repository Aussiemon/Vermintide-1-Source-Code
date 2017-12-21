local font_size = 26
local font = "gw_arial_16"
local font_mtrl = "materials/fonts/" .. font
PlayerHud = class(PlayerHud)
PlayerHud.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.gui = World.create_screen_gui(self.world, "material", "materials/fonts/gw_fonts", "immediate")
	self.raycast_state = "waiting_to_raycast"
	self.raycast_target = nil
	local physics_world = World.get_data(extension_init_context.world, "physics_world")
	self.physics_world = physics_world
	self.current_location = nil
	self.picked_up_ammo = false

	self.reset(self)

	return 
end
PlayerHud.extensions_ready = function (self, world, unit)
	return 
end
PlayerHud.destroy = function (self)
	return 
end
PlayerHud.reset = function (self)
	self.outline_timers = {}

	return 
end
local show_intensity = true
PlayerHud.update = function (self, unit, input, dt, context, t)
	return 
end
PlayerHud.draw_player_names = function (self, unit)
	local player_manager = Managers.player
	local players = player_manager.players(player_manager)
	local viewport_name = "player_1"
	local viewport = ScriptWorld.viewport(self.world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local res_x = RESOLUTION_LOOKUP.res_w
	local res_y = RESOLUTION_LOOKUP.res_h
	local viewport_center = Vector3(res_x/2, res_y/2, 0)
	local text_visibility_radius_sq = res_y/3
	text_visibility_radius_sq = text_visibility_radius_sq*text_visibility_radius_sq
	local gui = self.gui
	local offset_vector = Vector3(0, 0, 0.925)

	for k, player in pairs(players) do
		local name = player.name(player)

		if player.player_unit and player.player_unit ~= unit then
			local player_world_pos_center = Unit.local_position(player.player_unit, 0) + offset_vector
			local player_world_pos_head = player_world_pos_center + offset_vector

			if 0 < Camera.inside_frustum(camera, player_world_pos_center) then
				local min, max = Gui.text_extents(gui, name, font_mtrl, font_size)
				local text_length = max.x - min.x
				local player_screen_pos_center = Camera.world_to_screen(camera, player_world_pos_center)
				player_screen_pos_center = Vector3(player_screen_pos_center.x, player_screen_pos_center.z, 0)
				local player_screen_pos_head = Camera.world_to_screen(camera, player_world_pos_head)
				local text_pos = Vector3(player_screen_pos_head.x - text_length/2, player_screen_pos_head.z, 0)
				local distance_to_center_sq = Vector3.distance_squared(player_screen_pos_center, viewport_center)
				local delta = math.max(text_visibility_radius_sq - distance_to_center_sq, 0)
				local opacity = delta/text_visibility_radius_sq
				local color = Color(opacity*255, 0, 200, 200)

				Gui.text(gui, name, font_mtrl, font_size, font, text_pos, color)
			end
		end
	end

	return 
end
PlayerHud.draw_player_list = function (self, unit, dt, t)
	local res_x = RESOLUTION_LOOKUP.res_w
	local res_y = RESOLUTION_LOOKUP.res_h
	local gui = self.gui
	local pos = Vector3(res_x - 350, res_y - 200, 0)
	pos.y = res_y
	local player_manager = Managers.player
	local players = player_manager.human_and_bot_players(player_manager)
	local i = 1

	for k, player in pairs(players) do
		if player.player_unit == nil then
		else
			i = i + 1
			local player_unit = player.player_unit
			local health_extension = ScriptUnit.extension(player_unit, "health_system")
			local color = Color(255, 200, 200, 200)

			if ScriptUnit.has_extension(player_unit, "first_person_system") then
				color = Color(255, 255, 255, 100)
			end

			local name = player.name(player)
			local intensity_str = ""

			if show_intensity then
				local status_ext = ScriptUnit.extension(player_unit, "status_system")
				intensity_str = string.format("[%d i]", status_ext.intensity)
			end

			local health_str = tostring(health_extension.health - health_extension.damage)

			if health_extension.health == math.huge then
				health_str = "INF"
			end

			local player_str = string.format("%s  [%s hp] %s", name, health_str, intensity_str)

			Gui.text(gui, player_str, font_mtrl, font_size, font, pos + Vector3(20, -(i - 1)*font_size, 0), color)
		end
	end

	pos.y = res_y - i*font_size
	pos.z = -10

	Gui.rect(gui, pos, Vector2(350, font_size*i), Color(150, 50, 50, 50))

	return 
end
PlayerHud.set_current_location = function (self, location)
	self.current_location = location

	return 
end
PlayerHud.gdc_intro_active = function (self, state)
	self.show_gdc_intro = true

	return 
end
PlayerHud.set_picked_up_ammo = function (self, picked_up_ammo)
	self.picked_up_ammo = picked_up_ammo

	return 
end
PlayerHud.get_picked_up_ammo = function (self)
	return self.picked_up_ammo
end

return 
