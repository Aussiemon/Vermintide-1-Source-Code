require("scripts/unit_extensions/generic/hit_reactions")
require("scripts/settings/breeds")
require("scripts/utils/hit_reactions_template_compiler")
require("scripts/helpers/damage_utils")

local hit_templates = HitTemplates
local dismemberments = Dismemberments
local sound_event_table = SoundEvents
local script_data = script_data

local function print_debug()
	return script_data.debug_hit_effects_templates
end

local function debug_printf(pattern, ...)
	if script_data.debug_hit_effects_templates then
		printf("[hit-effects] " .. pattern, ...)
	end

	return 
end

GenericHitReactionExtension = class(GenericHitReactionExtension)

local function modify_push_distance_with_buff(attacker, value)
	if value and Unit.alive(attacker) and ScriptUnit.has_extension(attacker, "buff_system") then
		local buff_extension = ScriptUnit.extension(attacker, "buff_system")
		local new_value = buff_extension.apply_buffs_to_value(buff_extension, value, StatBuffIndex.PUSH)

		return new_value
	end

	return value
end

local function get_damage_direction(unit, direction_vector)
	local node = Unit.node(unit, "j_spine1")
	local unit_rotation = Unit.world_rotation(unit, node)
	local unit_direction = Quaternion.forward(unit_rotation)
	unit_direction.z = 0
	local flat_hit_direction = Vector3(direction_vector.x, direction_vector.y, 0)
	local dot = Vector3.dot(Vector3.normalize(flat_hit_direction), Vector3.normalize(unit_direction))

	if dot < 0 then
		return "front"
	end

	return "back"
end

local function get_attacker_direction(attacker_unit, hit_direction, explosion_push)
	local distal_direction, lateral_direction = nil

	if Unit.alive(attacker_unit) and not explosion_push then
		if ScriptUnit.has_extension(attacker_unit, "first_person_system") then
			local first_person_extension = ScriptUnit.extension(attacker_unit, "first_person_system")
			attacker_unit = first_person_extension.get_first_person_unit(first_person_extension)
		end

		local attacker_rotation = Unit.world_rotation(attacker_unit, 0)
		distal_direction = Quaternion.forward(attacker_rotation)
		distal_direction.z = 0
		distal_direction = Vector3.normalize(distal_direction)
		lateral_direction = Quaternion.right(attacker_rotation)
		lateral_direction.z = 0
		lateral_direction = Vector3.normalize(lateral_direction)
	else
		distal_direction = hit_direction
		lateral_direction = Vector3.cross(Vector3(0, 0, 1), distal_direction)
	end

	return distal_direction, lateral_direction
end

local function check_single_condition(control, test)
	if type(test) == "table" then
		for i = 1, #test, 1 do
			if test[i] == control then
				return true
			end
		end

		return false
	else
		return test == control
	end

	return 
end

local function check_conditions(control, test)
	local test_conditions = test.conditions

	for key, test_value in pairs(test_conditions) do
		if not check_single_condition(control[key], test_value) then
			return false
		elseif control.death == true and test_conditions.death ~= true then
			return false
		end
	end

	return true
end

local function map_function(event, func, ...)
	if type(event) == "table" then
		local num_events = #event

		for i = 1, num_events, 1 do
			func(event[i], ...)
		end
	else
		func(event, ...)
	end

	return 
end

local function play_effect(hit_effect_name, unit, world, actors, hit_direction_flat, damage_type)
	local node_name = actors[1]
	local node_id = node_name and Unit.node(unit, node_name)
	local node = (node_id and Unit.scene_graph_parent(unit, node_id)) or 0
	local hit_rotation = Quaternion.look(hit_direction_flat)

	if hit_effect_name then
		debug_printf("Playing effect %q", tostring(hit_effect_name))
		World.create_particles(world, hit_effect_name, Unit.world_position(unit, node), hit_rotation)
	end

	Managers.state.blood:spawn_blood_ball(Unit.world_position(unit, node), hit_direction_flat, damage_type, unit)

	return 
end

local function play_sound(event_id, wwise_world, unit, node, is_husk, wwise_parameters)
	assert(sound_event_table[event_id], "Could not find sound event %q in any template", event_id)

	local event_name = sound_event_table[event_id][tostring(is_husk)]

	debug_printf("Playing sound %q. damage_type = %q, enemy_type = %q, weapon_type = %q, hit_zone = %q, husk = %q", event_name, wwise_parameters.damage_type, wwise_parameters.enemy_type, wwise_parameters.weapon_type, wwise_parameters.hit_zone, tostring(wwise_parameters.husk))

	local wwise_source_id = WwiseWorld.make_auto_source(wwise_world, unit, node)

	Managers.state.entity:system("sound_environment_system"):set_source_environment(wwise_source_id, Unit.world_position(unit, node))

	for param_name, param_value in pairs(wwise_parameters) do
		WwiseWorld.set_switch(wwise_world, wwise_source_id, param_name, param_value)
	end

	WwiseWorld.trigger_event(wwise_world, event_name, wwise_source_id)

	return 
end

local function send_flow_event(event, unit)
	Unit.flow_event(unit, event)

	return 
end

local is_player = DamageUtils.is_player_unit
GenericHitReactionExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self.world = extension_init_context.world
	self.is_husk = extension_init_data.is_husk
	self.unit = unit
	self.is_server = Managers.player.is_server

	if extension_init_data.is_husk == nil then
		self.is_husk = not Managers.player.is_server
	end

	self.hit_reaction_template = extension_init_data.hit_reaction_template or Unit.get_data(unit, "hit_reaction")

	assert(self.hit_reaction_template)

	self.hit_effect_template = extension_init_data.hit_effect_template

	return 
end
GenericHitReactionExtension.set_hit_effect_template_id = function (self, template_id)
	self.hit_effect_template = template_id

	return 
end
GenericHitReactionExtension.extensions_ready = function (self, world, unit)
	self.damage_extension = ScriptUnit.extension(unit, "damage_system")

	assert(self.damage_extension)

	self.health_extension = ScriptUnit.extension(unit, "health_system")

	assert(self.health_extension)

	self.death_extension = ScriptUnit.extension(unit, "death_system")
	self.dialogue_extension = ScriptUnit.has_extension(unit, "ai_system") and ScriptUnit.extension(unit, "dialogue_system")
	self.locomotion_extension = ScriptUnit.has_extension(unit, "locomotion_system") and ScriptUnit.extension(unit, "locomotion_system")
	self.ai_extension = ScriptUnit.has_extension(unit, "ai_system") and ScriptUnit.extension(unit, "ai_system")

	return 
end
GenericHitReactionExtension.destroy = function (self)
	return 
end
GenericHitReactionExtension.reset = function (self)
	return 
end
local biggest_hit = {}
local conditions = {}
GenericHitReactionExtension.update = function (self, unit, input, dt, context, t)
	local health_extension = self.health_extension

	if self._delayed_flow then
		map_function(self._delayed_flow, send_flow_event, unit)

		self._delayed_flow = nil

		return 
	end

	if self._delayed_animation then
		if Unit.has_animation_state_machine(unit) then
			Unit.animation_event(unit, self._delayed_animation)
		end

		self._delayed_animation = nil

		return 
	end

	if self._delayed_push then
		local has_pushed = self._do_push(self, unit, dt)

		if has_pushed then
			self._delayed_push = nil
		end

		return 
	end

	local damage_extension = self.damage_extension
	local damages, num_damages = damage_extension.recent_damages(damage_extension)

	if num_damages == 0 then
		return 
	end

	local best_damage_amount = -100
	local best_damage_index = nil
	local stride = DamageDataIndex.STRIDE

	for i = 1, num_damages, stride do
		local damage_amount = damages[(i + DamageDataIndex.DAMAGE_AMOUNT) - 1]

		if best_damage_amount < damage_amount then
			best_damage_amount = damage_amount
			best_damage_index = i
		end
	end

	pack_index[DamageDataIndex.STRIDE](biggest_hit, 1, unpack_index[DamageDataIndex.STRIDE](damages, 1))

	local is_dead = not health_extension.is_alive(health_extension)

	if not is_dead then
		Profiler.start(self.hit_reaction_template)

		local hit_reaction = HitReactions.get_reaction(self.hit_reaction_template, self.is_husk)

		hit_reaction(unit, dt, context, t, biggest_hit)
		Profiler.stop()
	end

	if not self.hit_effect_template then
		return 
	end

	local damage_type = biggest_hit[DamageDataIndex.DAMAGE_TYPE]
	local damage_direction = Vector3Aux.unbox(biggest_hit[DamageDataIndex.DIRECTION])
	local hit_zone_name = biggest_hit[DamageDataIndex.HIT_ZONE]
	local damage_amount = biggest_hit[DamageDataIndex.DAMAGE_AMOUNT]
	local attacker_unit = biggest_hit[DamageDataIndex.ATTACKER]
	local attacker_is_player = is_player(attacker_unit)
	local offending_weapon = biggest_hit[DamageDataIndex.DAMAGE_SOURCE_NAME]
	local hit_direction = get_damage_direction(unit, damage_direction)
	local is_husk = false

	if attacker_is_player then
		is_husk = NetworkUnit.is_husk_unit(attacker_unit)
	end

	conditions.damage_type = damage_type
	conditions.hit_zone = hit_zone_name
	conditions.hit_direction = hit_direction
	conditions.death = is_dead
	conditions.weapon_type = offending_weapon
	conditions.is_husk = is_husk
	conditions.damage = 0 < damage_amount

	if self.ai_extension then
		conditions.action = self.ai_extension:current_action_name()
	end

	if script_data.debug_hit_effects_templates then
		debug_printf("Hit conditions:")

		for key, value in pairs(conditions) do
			debug_printf("    %s: %q", key, tostring(value))
		end

		debug_printf("    Hit direction: %q", tostring(damage_direction))
	end

	local hit_effects = self._resolve_effects(self, conditions)
	local parameters = conditions

	Profiler.start("executing effects")

	for i = 1, #hit_effects, 1 do
		self._execute_effect(self, unit, hit_effects[i], biggest_hit, parameters)
	end

	Profiler.stop()

	return 
end
GenericHitReactionExtension._resolve_effects = function (self, conditions)
	local template_name = self.hit_effect_template
	local templates = hit_templates[template_name]

	assert(templates, "Hit effect template %q does not exist", template_name)

	local results = {}
	local num_conditions = 0

	for i = 1, #templates, 1 do
		local current_template = templates[i]

		if check_conditions(conditions, current_template) then
			results[#results + 1] = current_template

			break
		end
	end

	return results
end
GenericHitReactionExtension._can_wall_nail = function (self, effect_template)
	local do_dismember = effect_template.do_dismember

	if do_dismember or self._delayed_flow then
		return false
	end

	local flow_event = effect_template.flow_event

	if flow_event and type(flow_event) == "string" then
		if DismemberFlowEvents[flow_event] then
			return false
		end
	elseif flow_event and type(flow_event) == "table" then
		local num_flow_events = #flow_event

		for i = 1, num_flow_events, 1 do
			local flow_event_string = flow_event[i]

			if DismemberFlowEvents[flow_event_string] then
				return false
			end
		end
	elseif flow_event then
		fassert(false, "unhandle flow_event type %s", type(flow_event))
	end

	return true
end
GenericHitReactionExtension._execute_effect = function (self, unit, effect_template, biggest_hit, parameters)
	debug_printf("executing effect %s", effect_template.template_name)

	local world = self.world
	local breed_data = Unit.get_data(unit, "breed")
	local attacker_unit = biggest_hit[DamageDataIndex.ATTACKER]
	local hit_direction = Vector3Aux.unbox(biggest_hit[DamageDataIndex.DIRECTION])
	local damage_type = biggest_hit[DamageDataIndex.DAMAGE_TYPE]
	local hit_zone = parameters.hit_zone

	assert(breed_data.hit_zones[hit_zone], "error no hitzone in breed that matches hitzone")

	local actors = breed_data.hit_zones and breed_data.hit_zones[hit_zone].actors
	local flow_event = (type(effect_template.flow_event) == "table" and table.clone(effect_template.flow_event)) or effect_template.flow_event
	local death_ext = self.death_extension
	local hit_ragdoll_actor_name = biggest_hit[DamageDataIndex.HIT_RAGDOLL_ACTOR_NAME]
	local can_wall_nail = self._can_wall_nail(self, effect_template)

	if effect_template.buff then
		local buff_system = Managers.state.entity:system("buff_system")

		buff_system.add_buff(buff_system, self.unit, effect_template.buff, attacker_unit)
	end

	if effect_template.do_dismember and (not death_ext or not death_ext.is_wall_nailed(death_ext)) then
		local event_table = dismemberments[breed_data.name]
		local dismember_event = event_table[hit_zone]

		if flow_event and type(flow_event) == "table" then
			flow_event[#flow_event + 1] = dismember_event
		elseif flow_event then
			flow_event = {
				dismember_event,
				flow_event
			}
		else
			flow_event = dismember_event
		end

		if ScriptUnit.has_extension(unit, "projectile_linker_system") then
			local projectile_linker_system = Managers.state.entity:system("projectile_linker_system")

			projectile_linker_system.clear_linked_projectiles(projectile_linker_system, unit)
		end

		debug_printf("Dismember event %q triggered", dismember_event)
	end

	if flow_event then
		if parameters.death and death_ext then
			if death_ext.has_death_started(death_ext) and flow_event == "dismember_torso" then
				flow_event = nil
			end

			self._delayed_flow = flow_event

			debug_printf("Delayed flow event %q", tostring(flow_event))
		elseif death_ext and death_ext.has_death_started(death_ext) then
			flow_event = nil
		else
			map_function(flow_event, function (event, unit)
				Unit.flow_event(unit, event)

				return 
			end, unit)
			debug_printf("Started flow event %q", tostring(flow_event))
		end
	end

	local is_falling = self.locomotion_extension and self.locomotion_extension._is_falling

	if can_wall_nail and parameters.death and hit_ragdoll_actor_name ~= "n/a" then
		local hit_speed = 10

		death_ext.nailing_hit(death_ext, hit_ragdoll_actor_name, hit_direction, hit_speed)

		self._delayed_animation = nil

		if Unit.has_animation_state_machine(unit) then
			Unit.animation_event(unit, "ragdoll")
		end
	elseif (self.force_ragdoll_on_death or is_falling) and not self.death_extension:has_death_started() and parameters.death then
		debug_printf("Forcing delayed ragdoll")

		self._delayed_animation = "ragdoll"
	elseif effect_template.animations and Unit.has_animation_state_machine(unit) then
		local hit_direction_flat = Vector3(hit_direction.x, hit_direction.y, 0)
		hit_direction_flat = Vector3.normalize(hit_direction_flat)
		local animations = effect_template.animations
		local angles = animations.angles

		if angles then
			local fwd = Quaternion.forward(Unit.local_rotation(unit, 0))
			local flat_fwd = Vector3.normalize(Vector3.flat(fwd))
			local found = false
			local angle = (math.atan2(hit_direction_flat.y, hit_direction_flat.x) - math.atan2(flat_fwd.y, flat_fwd.x))%(math.pi*2)

			for i = 1, #angles, 1 do
				local angle_data = angles[i]

				if angle < angle_data.to then
					animations = angle_data.animations
					found = true

					break
				end
			end

			if not found then
				animations = angles[1].animations
			end
		end

		local random_animation = math.random(#animations)
		local animation_event = animations[random_animation]

		if self.death_extension:has_death_started() then
			animation_event = "ragdoll"
		end

		if flow_event or parameters.death then
			self._delayed_animation = animation_event

			debug_printf("Delayed animation %q", animation_event)
		elseif self.death_extension and self.death_extension:has_death_started() then
		else
			if Unit.has_animation_state_machine(unit) then
				Unit.animation_event(unit, animation_event)
			end

			debug_printf("Playing animation %q", animation_event)
		end
	end

	local hit_effect_name = effect_template.hit_effect_name
	local husk_hit_effect_name = effect_template.husk_hit_effect_name
	local hit_effect = nil

	if husk_hit_effect_name and Unit.alive(attacker_unit) and (not NetworkUnit.is_network_unit(attacker_unit) or NetworkUnit.is_husk_unit(attacker_unit)) then
		hit_effect = husk_hit_effect_name
	elseif hit_effect_name then
		hit_effect = hit_effect_name
	end

	map_function(hit_effect, play_effect, unit, world, actors, hit_direction, damage_type)

	if effect_template.push then
		local push_actors = breed_data.hit_zones[hit_zone] and breed_data.hit_zones[hit_zone].push_actors

		if push_actors then
			self._delayed_push = {
				timeout = 0.1,
				push_parameters = effect_template.push,
				explosion_push = effect_template.explosion_push,
				attacker = attacker_unit,
				hit_direction_table = {
					hit_direction.x,
					hit_direction.y,
					hit_direction.z
				},
				push_actors = push_actors
			}
		end
	end

	if effect_template.sound_event then
		local wwise_world = Managers.world:wwise_world(world)
		local node_name = actors[1]
		local node_id = node_name and Unit.node(unit, node_name)
		local node = (node_id and Unit.scene_graph_parent(unit, node_id)) or 0
		local wwise_parameters = {
			damage_type = parameters.damage_type,
			enemy_type = breed_data.name,
			weapon_type = parameters.weapon_type,
			hit_zone = hit_zone,
			husk = NetworkUnit.is_husk_unit(unit)
		}
		local dialogue_extension = self.dialogue_extension

		if dialogue_extension and dialogue_extension.wwise_voice_switch_group then
			wwise_parameters[dialogue_extension.wwise_voice_switch_group] = dialogue_extension.wwise_voice_switch_value
		end

		map_function(effect_template.sound_event, play_sound, wwise_world, unit, node, parameters.is_husk, wwise_parameters)
	end

	if parameters.death and self.death_extension and not self.death_extension:has_death_started() then
		Unit.flow_event(unit, "lua_on_death")
	end

	return 
end
GenericHitReactionExtension._do_push = function (self, unit, dt)
	local delayed_push = self._delayed_push
	local push_parameters = delayed_push.push_parameters
	local hit_direction_table = delayed_push.hit_direction_table
	local attacker_unit = delayed_push.attacker
	local push_actors = delayed_push.push_actors
	local timeout = delayed_push.timeout - dt
	local explosion_push = delayed_push.explosion_push
	delayed_push.timeout = timeout
	local num_actors = #push_actors
	local actor = nil

	for i = 1, num_actors, 1 do
		local actor_name = push_actors[i]

		debug_printf("Checking actor %q", actor_name)

		if not Unit.actor(unit, push_actors[i]) then
		end
	end

	if not actor then
		debug_printf("No actor found. %f until timeout", timeout)

		return timeout <= 0
	end

	local hit_direction = Vector3(hit_direction_table[1], hit_direction_table[2], 0)
	hit_direction = Vector3.normalize(hit_direction)
	local distal_direction, lateral_direction = get_attacker_direction(attacker_unit, hit_direction, explosion_push)

	if Vector3.dot(lateral_direction, hit_direction) <= 0 then
		lateral_direction = -lateral_direction
	end

	local distal_force = modify_push_distance_with_buff(attacker_unit, push_parameters.distal_force) or 0
	local lateral_force = modify_push_distance_with_buff(attacker_unit, push_parameters.lateral_force) or 0
	local vertical_force = modify_push_distance_with_buff(attacker_unit, push_parameters.vertical_force) or 0
	local distal_vector = distal_direction*distal_force
	local lateral_vector = lateral_direction*lateral_force
	local vertical_vector = Vector3(0, 0, vertical_force)
	local push_force = (distal_vector + lateral_vector + vertical_vector)/(num_actors*0.75)

	for i = 1, num_actors, 1 do
		actor = Unit.actor(unit, push_actors[i])

		if actor then
			Actor.push(actor, push_force, 15)
		end

		debug_printf("Pushing actor %s, %f, timeout: %f", tostring(push_force), Vector3.length(push_force), timeout)
	end

	return true
end

return 
