NetworkConstants = NetworkConstants or {}
NetworkConstants.damage = Network.type_info("damage")
NetworkConstants.damage_hotjoin_sync = Network.type_info("damage_hotjoin_sync")
NetworkConstants.health = Network.type_info("health")
NetworkConstants.velocity = Network.type_info("velocity")
NetworkConstants.enemy_velocity = Network.type_info("enemy_velocity")
NetworkConstants.VELOCITY_EPSILON = Vector3.length(Vector3(NetworkConstants.velocity.tolerance, NetworkConstants.velocity.tolerance, NetworkConstants.velocity.tolerance)) * 1.1
NetworkConstants.position = Network.type_info("position")
NetworkConstants.rotation = Network.type_info("rotation")
NetworkConstants.enemy_rotation = Network.type_info("enemy_rotation")
NetworkConstants.max_attachments = 4
NetworkConstants.clock_time = Network.type_info("clock_time")
NetworkConstants.time_multiplier = Network.type_info("time_multiplier")
NetworkConstants.ping = Network.type_info("ping")
NetworkConstants.animation_variable_float = Network.type_info("animation_variable_float")
NetworkConstants.number = Network.type_info("number")
NetworkConstants.game_object_id_max = Network.type_info("game_object_id").max
NetworkConstants.invalid_game_object_id = NetworkConstants.game_object_id_max
NetworkConstants.attack_template = Network.type_info("attack_template")

assert(#NetworkLookup.attack_templates <= NetworkConstants.attack_template.max, "Too many attack templates, global config max value needs to be upped")

NetworkConstants.attack_damage_value = Network.type_info("attack_damage_value")
local num_attack_damage_values = #NetworkLookup.attack_damage_values
local max_attack_damage_values = NetworkConstants.attack_damage_value.max

fassert(num_attack_damage_values <= max_attack_damage_values, "Too many attack damage values (%i), global config max value (%i) needs to be upped to %i", num_attack_damage_values, max_attack_damage_values, max_attack_damage_values * 2)

NetworkConstants.statistics_path_max_size = Network.type_info("statistics_path").max_size
NetworkConstants.anim_event = Network.type_info("anim_event")

assert(#NetworkLookup.anims <= NetworkConstants.anim_event.max, "Too many anim events in network lookup, time to up the network config max value")

NetworkConstants.bt_action_name = Network.type_info("bt_action_name")

assert(#NetworkLookup.bt_action_names <= NetworkConstants.bt_action_name.max, "Too many bt_action_name events in network lookup, time to up the network config max value")

NetworkConstants.surface_material_effect = Network.type_info("surface_material_effect")

assert(#NetworkLookup.surface_material_effects <= NetworkConstants.surface_material_effect.max, "Too many surface material effects in network lookup, time to up the network config max value")

NetworkConstants.particle_lookup = Network.type_info("particle_lookup")
local particles_max = NetworkConstants.particle_lookup.max
local particles_amount = #NetworkLookup.effects

fassert(particles_amount <= particles_max, "Too many effects in network lookup, amount: %i, max: %i, update global.network_config", particles_amount, particles_max)

NetworkConstants.light_weight_projectile_speed = Network.type_info("light_weight_projectile_speed")
NetworkConstants.light_weight_projectile_index = Network.type_info("light_weight_projectile_index")
NetworkConstants.weapon_id = Network.type_info("weapon_id")
local num_items = #ItemMasterList

assert(num_items <= NetworkConstants.weapon_id.max, "Too many weapons in ItemMasterList, global.network_config value weapon_id needs to be raised.")

local num_damage_sources = #NetworkLookup.damage_sources
NetworkConstants.damage_source_id = Network.type_info("damage_source_id")

assert(num_damage_sources <= NetworkConstants.damage_source_id.max, "Too many damage sources, global.network_config value damage_source_id needs to be raised.")
assert(num_items <= num_damage_sources, "weapon_id lookup is set higher than damage_source_id lookup despite all weapons being damage sources.")

local num_actions = #NetworkLookup.actions
NetworkConstants.action = Network.type_info("action")

fassert(num_actions <= NetworkConstants.action.max, "Too many actions, raise global.network_config value for action by a factor 2")

local num_sub_actions = #NetworkLookup.sub_actions
NetworkConstants.sub_action = Network.type_info("sub_action")

fassert(num_sub_actions <= NetworkConstants.sub_action.max, "Too many sub actions, raise global.network_config value for sub_action by a factor 2")

local num_item_template_names = #NetworkLookup.item_template_names
NetworkConstants.item_template_name = Network.type_info("item_template_name")

fassert(num_item_template_names <= NetworkConstants.item_template_name.max, "Too many item template names, raise global.network_config value for item_template_name by a factor 2")

local num_terror_flow_events = #NetworkLookup.terror_flow_events
NetworkConstants.terror_flow_event = Network.type_info("terror_flow_event")

fassert(num_terror_flow_events <= NetworkConstants.terror_flow_event.max, "Too many terror flow events, raise global.network_config value for terror_flow_event by a factor 2")

NetworkConstants.story_time = Network.type_info("story_time")
local fatigue_points_max = Network.type_info("fatigue_points").max
local num_fatigue_types = #NetworkLookup.fatigue_types

fassert(num_fatigue_types <= fatigue_points_max, "Too many fatigue_types, raise global.network_config value for fatigue_points by a factor of 2")

local damage_hotjoin_sync_max = NetworkConstants.damage_hotjoin_sync.max

for name, breed in pairs(Breeds) do
	local max_health = breed.max_health

	for _, health in ipairs(max_health) do
		fassert(health < damage_hotjoin_sync_max, "Assert, breed %s is unkillable since his health (%d) is bigger then max damage (%f) sent over the network. Raise global.network_config value for damage by a factor of 2", name, health, damage_hotjoin_sync_max)
	end
end

NetworkConstants.teleports = Network.type_info("teleports")
NetworkConstants.marker_lookup = Network.type_info("marker_lookup")
local num_markers = #NetworkLookup.markers

fassert(num_markers <= NetworkConstants.marker_lookup.max, "Too many dialogue system markers, raise global.network_config value for marker_lookup by a factor 2")

return 
