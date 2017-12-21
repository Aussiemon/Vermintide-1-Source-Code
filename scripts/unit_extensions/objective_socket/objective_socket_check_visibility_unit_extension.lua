ObjectiveSocketCheckVisibilityUnitExtension = class(ObjectiveSocketCheckVisibilityUnitExtension, ObjectiveSocketUnitExtension)
ObjectiveSocketCheckVisibilityUnitExtension.init = function (self, extension_init_context, unit, extension_init_data, is_server)
	ObjectiveSocketCheckVisibilityUnitExtension.super.init(self, extension_init_context, unit, extension_init_data, is_server)

	self._visible = true

	return 
end
ObjectiveSocketCheckVisibilityUnitExtension.update = function (self, unit, input, dt, context, t)
	ObjectiveSocketCheckVisibilityUnitExtension.super.update(self, unit, input, dt, context, t)

	local sockets = self.sockets
	local full = true

	for i = 1, #sockets, 1 do
		local socket = sockets[i]

		if socket.open then
			full = false

			break
		end
	end

	local local_player = Managers.player:local_player()
	local player_unit = local_player.player_unit

	if Unit.alive(player_unit) then
		local inventory_extension = ScriptUnit.extension(player_unit, "inventory_system")
		local item_name = inventory_extension.get_item_name(inventory_extension, "slot_level_event")

		if item_name == "explosive_barrel" and not self._visible and not full then
			Unit.set_visibility(unit, "ghost", true)

			self._visible = true
		elseif item_name ~= "explosive_barrel" and self._visible then
			Unit.set_visibility(unit, "ghost", false)

			self._visible = false
		end
	end

	return 
end

return 
