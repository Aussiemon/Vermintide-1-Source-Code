require("scripts/unit_extensions/generic/generic_unit_interactable_extension")

InteractableSystem = class(InteractableSystem, ExtensionSystemBase)
local RPCS = {
	"rpc_generic_interaction_request"
}
local extensions = {
	"GenericUnitInteractableExtension"
}

InteractableSystem.init = function (self, entity_system_creation_context, system_name)
	InteractableSystem.super.init(self, entity_system_creation_context, system_name, extensions)

	local network_event_delegate = entity_system_creation_context.network_event_delegate
	self.network_event_delegate = network_event_delegate

	network_event_delegate:register(self, unpack(RPCS))

	self.unit_extensions = {}

	if script_data.debug_chests then
		self.debug_num_chests = 0
	end
end

InteractableSystem.destroy = function (self)
	self.network_event_delegate:unregister(self)
end

InteractableSystem.update = function (self, context, t)
	Profiler.start("InteractableSystem")

	local dt = context.dt

	if script_data.debug_interactions then
		for unit, extension in pairs(self.unit_extensions) do
			local pose, half_extents = Unit.box(unit)

			QuickDrawer:box(pose, half_extents)
		end
	end

	if script_data.debug_chests then
		Debug.text("Opened chests: %i/%i", Managers.player:statistics_db():get_stat("session", "chests_opened"), self.debug_num_chests)
	end

	Profiler.stop("InteractableSystem")
end

InteractableSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local extension = InteractableSystem.super.on_add_extension(self, world, unit, extension_name, extension_init_data)
	self.unit_extensions[unit] = extension

	if script_data.debug_chests and extension:interaction_type() == "chest" then
		self.debug_num_chests = self.debug_num_chests + 1
		local pos = Unit.world_position(unit, 0)

		print("CHEST", self.debug_num_chests, pos)
		QuickDrawerStay:sphere(pos, 5, Color(255, 0, 0))
	end

	return extension
end

InteractableSystem.on_remove_extension = function (self, unit, extension_name)
	self.unit_extensions[unit] = nil

	InteractableSystem.super.on_remove_extension(self, unit, extension_name)
end

InteractableSystem._can_interact = function (self, interactor_unit, interactable_unit, interaction_type)
	if Unit.alive(interactor_unit) and Unit.alive(interactable_unit) then
		local interactable_extension = ScriptUnit.extension(interactable_unit, "interactable_system")
		local can_interact = not interactable_extension:is_being_interacted_with() and InteractionDefinitions[interaction_type].server.can_interact(interactor_unit, interactable_unit)

		return can_interact
	end

	return false
end

InteractableSystem._handle_standard_interact_request = function (self, interaction_type, sender, interactor_id, interactable_id, is_level_unit)
	local interactor_unit = self.unit_storage:unit(interactor_id)
	local interactable_unit = nil

	if is_level_unit then
		local level = LevelHelper:current_level(self.world)
		interactable_unit = Level.unit_by_index(level, interactable_id)

		if not interactable_unit then
			InteractionHelper:deny_request(sender, interactor_id)

			return
		end
	else
		interactable_unit = self.unit_storage:unit(interactable_id)
	end

	if self:_can_interact(interactor_unit, interactable_unit, interaction_type) then
		local interactor_extension = ScriptUnit.extension(interactor_unit, "interactor_system")

		interactor_extension:interaction_approved(interaction_type, interactable_unit)
		InteractionHelper:approve_request(interaction_type, interactor_unit, interactable_unit)

		return
	end

	InteractionHelper:deny_request(sender, interactor_id)
end

InteractableSystem.rpc_generic_interaction_request = function (self, sender, interactor_go_id, interactable_go_id, is_level_unit, interaction_type_id)
	local interaction_type = NetworkLookup.interactions[interaction_type_id]

	InteractionHelper.printf("rpc_generic_interaction_request(%s, %s, %s, %s, %s)", sender, tostring(interactor_go_id), tostring(interactable_go_id), tostring(is_level_unit), interaction_type)
	self:_handle_standard_interact_request(interaction_type, sender, interactor_go_id, interactable_go_id, is_level_unit)
end

return
