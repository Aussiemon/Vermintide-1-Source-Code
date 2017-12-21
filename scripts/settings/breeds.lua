require("scripts/unit_extensions/human/ai_player_unit/ai_utils")
require("scripts/managers/bot_nav_transition/bot_nav_transition_manager")
require("scripts/settings/player_unit_status_settings")
require("scripts/unit_extensions/human/ai_player_unit/debug_breeds/debug_globadier")
require("scripts/unit_extensions/human/ai_player_unit/debug_breeds/debug_gutter_runner")
require("scripts/settings/smartobject_settings")
require("scripts/settings/nav_tag_volume_settings")
require("foundation/scripts/util/table")
require("scripts/unit_extensions/human/ai_player_unit/ai_breed_snippets")
require("scripts/settings/dlc_settings")

Breeds = Breeds or {}
BreedActions = BreedActions or {}
BreedHitZonesLookup = BreedHitZonesLookup or {}

setmetatable(UtilityConsiderations, {
	__index = function (t, k)
		error(string.format("Trying to access UtilityConsiderations %s that doesn't exist", k))

		return 
	end
})
dofile("scripts/settings/breeds/breed_skaven_clan_rat")
dofile("scripts/settings/breeds/breed_skaven_slave")
dofile("scripts/settings/breeds/breed_skaven_storm_vermin")
dofile("scripts/settings/breeds/breed_skaven_loot_rat")
dofile("scripts/settings/breeds/breed_skaven_gutter_runner")
dofile("scripts/settings/breeds/breed_skaven_pack_master")
dofile("scripts/settings/breeds/breed_skaven_poison_wind_globadier")
dofile("scripts/settings/breeds/breed_skaven_ratling_gunner")
dofile("scripts/settings/breeds/breed_skaven_rat_ogre")
dofile("scripts/settings/breeds/breed_critters")

for _, dlc in pairs(DLCSettings) do
	local breeds = dlc.breeds

	for _, breed in ipairs(breeds) do
		dofile(breed)
	end
end

setmetatable(UtilityConsiderations, nil)

for breed_name, breed_data in pairs(Breeds) do
	local lookup = BreedHitZonesLookup[breed_name]

	if lookup then
		breed_data.hit_zones_lookup = lookup

		assert(breed_data.debug_color, "breed needs a debug color")
	end
end

local current_difficulty = (Managers and Managers.state.difficulty and Managers.state.difficulty:get_difficulty()) or "normal"

for breed_name, breed_actions in pairs(BreedActions) do
	for action_name, action_data in pairs(breed_actions) do
		action_data.name = action_name

		if action_data.dimishing_damage then
			local difficulty_dimishing_damage = table.clone(BreedActionDimishingDamageDifficulty[current_difficulty])
			action_data.dimishing_damage = difficulty_dimishing_damage
		end

		if action_data.difficulty_damage then
			local difficulty_damage = action_data.difficulty_damage[current_difficulty]
			action_data.damage = difficulty_damage
		end
	end
end

LAYER_ID_MAPPING = {
	"ledges",
	"ledges_with_fence",
	"jumps",
	"doors",
	"planks",
	"bot_poison_wind",
	"teleporters"
}

for layer, cost in pairs(BotNavTransitionManager.TRANSITION_LAYERS) do
	LAYER_ID_MAPPING[#LAYER_ID_MAPPING + 1] = layer
end

assert(#LAYER_ID_MAPPING < NavTagVolumeStartLayer, "Nav tag volume layers are conflicting with layers used by other systems.")

for i = #LAYER_ID_MAPPING + 1, NavTagVolumeStartLayer - 1, 1 do
	LAYER_ID_MAPPING[i] = "dummy_layer" .. i
end

NAV_TAG_VOLUME_LAYER_COST_AI = NAV_TAG_VOLUME_LAYER_COST_AI or {}
NAV_TAG_VOLUME_LAYER_COST_BOTS = NAV_TAG_VOLUME_LAYER_COST_BOTS or {}

for _, layer_name in ipairs(NavTagVolumeLayers) do
	LAYER_ID_MAPPING[#LAYER_ID_MAPPING + 1] = layer_name
	NAV_TAG_VOLUME_LAYER_COST_AI[layer_name] = NAV_TAG_VOLUME_LAYER_COST_AI[layer_name] or 1
	NAV_TAG_VOLUME_LAYER_COST_BOTS[layer_name] = NAV_TAG_VOLUME_LAYER_COST_BOTS[layer_name] or 1
end

for k, v in ipairs(LAYER_ID_MAPPING) do
	LAYER_ID_MAPPING[v] = k
end

local PerceptionTypes = {
	perception_pack_master = true,
	perception_no_seeing = true,
	perception_regular = true,
	perception_rat_ogre = true,
	perception_all_seeing = true,
	perception_all_seeing_re_evaluate = true
}
local TargetSelectionTypes = {
	pick_rat_ogre_target_idle = true,
	pick_ninja_approach_target = true,
	pick_rat_ogre_target_with_weights = true,
	pick_flee_target = true,
	pick_pounce_down_target = true,
	pick_closest_target_with_spillover = true,
	pick_solitary_target = true,
	horde_pick_closest_target_with_spillover = true,
	pick_pack_master_target = true,
	pick_no_targets = true,
	pick_closest_target = true
}

for name, breed in pairs(Breeds) do
	breed.name = name

	if not breed.allowed_layers then
		breed.allowed_layers = {
			bot_poison_wind = 1.5,
			planks = 1.5,
			ledges = 1.5,
			jumps = 1.5,
			barrel_explosion = 10,
			bot_ratling_gun_fire = 3,
			ledges_with_fence = 1.5,
			doors = 1.5,
			teleporters = 5,
			smoke_grenade = 4,
			fire_grenade = 10
		}
	end

	if breed.perception and not PerceptionTypes[breed.perception] then
		error("Bad perception type '" .. breed.perception .. "' specified in breed .. '" .. breed.name .. "'.")
	end

	if breed.target_selection and not TargetSelectionTypes[breed.target_selection] then
		error("Bad 'target_selection' type '" .. breed.target_selection .. "' specified in breed .. '" .. breed.name .. "'.")
	end

	if breed.smart_object_template == nil then
		breed.smart_object_template = "fallback"
	end
end

return 
