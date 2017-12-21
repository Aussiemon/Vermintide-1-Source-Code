GenericUnitInteractableExtension = class(GenericUnitInteractableExtension)
GenericUnitInteractableExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.unit = unit
	self.active = false
	self.interactable_type = Unit.get_data(unit, "interaction_data", "interaction_type")

	fassert(self.interactable_type, "Unit: %s missing interaction_type in its unit data, should it have an interaction extension?", unit)

	return 
end
GenericUnitInteractableExtension.destroy = function (self)
	return 
end
GenericUnitInteractableExtension.interaction_type = function (self)
	return self.interactable_type
end
GenericUnitInteractableExtension.set_is_being_interacted_with = function (self, active)
	assert(self.active ~= active, "Tried changing active state to what it already was.")

	self.active = active

	return 
end
GenericUnitInteractableExtension.is_being_interacted_with = function (self)
	return self.active
end

return 
