TrueFlightTemplates = TrueFlightTemplates or {}
TrueFlightTemplates.machinegun = {
	speed_multiplier = 0.001,
	lerp_constant = 50,
	time_between_raycasts = 0.1,
	broadphase_radius = 5,
	dot_threshold = 0.9999,
	lerp_squared_distance_threshold = 2000
}
TrueFlightTemplates.carbine = {
	speed_multiplier = 0.01,
	lerp_constant = 50,
	time_between_raycasts = 0.05,
	broadphase_radius = 5,
	dot_threshold = 0.9999,
	lerp_squared_distance_threshold = 2000
}
TrueFlightTemplates.sniper = {
	speed_multiplier = 0.01,
	lerp_constant = 50,
	time_between_raycasts = 0.05,
	broadphase_radius = 10,
	dot_threshold = 0.9999,
	lerp_squared_distance_threshold = 2000
}
TrueFlightTemplates.sniper = table.create_copy(TrueFlightTemplates.sniper, TrueFlightTemplates.sniper)
TrueFlightTemplates.carbine = table.create_copy(TrueFlightTemplates.overcharge_values, TrueFlightTemplates.carbine)
TrueFlightTemplates.machinegun = table.create_copy(TrueFlightTemplates.overcharge_values, TrueFlightTemplates.machinegun)
local template_index = 0
TrueFlightTemplatesLookup = TrueFlightTemplatesLookup or {}

for name, template in pairs(TrueFlightTemplates) do
	template_index = template_index + 1
	template.lookup_id = template_index
	TrueFlightTemplatesLookup[template_index] = name
end

return
