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
end

GenericHitReactionExtension = class(GenericHitReactionExtension)

local function modify_push_distance_with_buff(attacker, value)
	if value and Unit.alive(attacker) and ScriptUnit.has_extension(attacker, "buff_system") then
		local buff_extension = ScriptUnit.extension(attacker, "buff_system")
		local new_value = buff_extension:apply_buffs_to_value(value, StatBuffIndex.PUSH)

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
			attacker_unit = first_person_extension:get_first_person_unit()
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
end

local function play_effect(hit_effect_name, unit, world, actors, hit_direction, damage_type, position)
	local hit_rotation = Quaternion.look(hit_direction)

	World.create_particles(world, hit_effect_name, position, hit_rotation)
end

local function play_sound(event_id, wwise_world, wwise_source_id, position, is_husk)
	assert(sound_event_table[event_id], "Could not find sound event %q in any template", event_id)

	local event_name = sound_event_table[event_id][tostring(is_husk)]

	WwiseWorld.trigger_event(wwise_world, event_name, wwise_source_id)
end

local function send_flow_event(event, unit)
	if event == "dismember_torso" and not Unit.has_animation_state_machine(unit) then
		return
	end

	Unit.flow_event(unit, event)
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
end

GenericHitReactionExtension.set_hit_effect_template_id = function (self, template_id)
	self.hit_effect_template = template_id
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
end

GenericHitReactionExtension.destroy = function (self)
	return
end

GenericHitReactionExtension.reset = function (self)
	return
end

local biggest_hit = {}
local conditions = {}
local temp_effect_results = {}

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
		local has_pushed = self:_do_push(unit, dt)

		if has_pushed then
			self._delayed_push = nil
		end

		return
	end

	local damage_extension = self.damage_extension
	local damages, num_damages = damage_extension:recent_damages()

	if num_damages == 0 then
		return
	end

	local best_damage_amount = -1000
	local best_damage_index = nil
	local stride = DamageDataIndex.STRIDE

	for i = 1, num_damages, stride do
		local damage_amount = damages[(i + DamageDataIndex.DAMAGE_AMOUNT) - 1]

		if best_damage_amount < damage_amount and damage_amount >= 0 then
			best_damage_amount = damage_amount
			best_damage_index = i
		end
	end

	if best_damage_amount < 0 then
		return
	end

	pack_index[DamageDataIndex.STRIDE](biggest_hit, 1, unpack_index[DamageDataIndex.STRIDE](damages, 1))

	local is_dead = not health_extension:is_alive()

	if not is_dead then
		Profiler.start(self.hit_reaction_template)

		local hit_reaction = HitReactions.get_reaction(self.hit_reaction_template, self.is_husk)

		hit_reaction(unit, dt, context, t, biggest_hit)
		Profiler.stop(self.hit_reaction_template)
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
	conditions.damage = damage_amount > 0

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

	local hit_effects, num_effects = self:_resolve_effects(conditions, temp_effect_results)
	local parameters = conditions

	Profiler.start("executing effects")

	for i = 1, num_effects, 1 do
		self:_execute_effect(unit, hit_effects[i], biggest_hit, parameters)
	end

	Profiler.stop("executing effects")
end

GenericHitReactionExtension._resolve_effects = function (self, conditions, results)
	local template_name = self.hit_effect_template
	local templates = hit_templates[template_name]

	assert(templates, "Hit effect template %q does not exist", template_name)

	local num_conditions = 0
	local num_results = 0

	for i = 1, #templates, 1 do
		local current_template = templates[i]

		if check_conditions(conditions, current_template) then
			num_results = num_results + 1
			results[num_results] = current_template

			break
		end
	end

	return results, num_results
end

GenericHitReactionExtension._can_wall_nail = function (self, effect_template)
	if effect_template.disable_wall_nail then
		return false
	end

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

local WWISE_PARAMETERS = {}

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
	local can_wall_nail = self:_can_wall_nail(effect_template)

	if effect_template.buff then
		local buff_system = Managers.state.entity:system("buff_system")

		buff_system:add_buff(self.unit, effect_template.buff, attacker_unit)
	end

	if effect_template.do_dismember and (not death_ext or not death_ext:is_wall_nailed()) then
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

			projectile_linker_system:clear_linked_projectiles(unit)
		end

		debug_printf("Dismember event %q triggered", dismember_event)
	end

	if flow_event then
		if parameters.death and death_ext then
			if death_ext:has_death_started() and flow_event == "dismember_torso" then
				flow_event = nil
			end

			self._delayed_flow = flow_event

			debug_printf("Delayed flow event %q", tostring(flow_event))
		elseif death_ext and death_ext:has_death_started() then
			flow_event = nil
		else
			map_function(flow_event, function (event, unit)
				Unit.flow_event(unit, event)
			end, unit)
			debug_printf("Started flow event %q", tostring(flow_event))
		end
	end

	local is_falling = self.locomotion_extension and self.locomotion_extension._is_falling

	if can_wall_nail and parameters.death and hit_ragdoll_actor_name ~= "n/a" then
		local hit_speed = 10

		death_ext:nailing_hit(hit_ragdoll_actor_name, hit_direction, hit_speed)

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
			local angle = (math.atan2(hit_direction_flat.y, hit_direction_flat.x) - math.atan2(flat_fwd.y, flat_fwd.x)) % (math.pi * 2)

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

		if self.death_extension:has_death_started() and self.death_extension:second_hit_ragdoll_allowed() then
			animation_event = "ragdoll"
		elseif self.death_extension:has_death_started() then
			animation_event = nil
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

	local should_spawn_blood = not breed_data.no_blood_splatter_on_damage and not effect_template.disable_blood
	local sound_event = effect_template.sound_event
	local impact_position = nil

	if hit_effect or should_spawn_blood or sound_event then
		local actor_name = actors[1]

		if not actor_name then
			impact_position = Unit.world_position(unit, 0)
		elseif not Unit.has_node(unit, actor_name) then
			impact_position = Actor.center_of_mass(Unit.actor(unit, actor_name))
		else
			local node = Unit.node(unit, actor_name)
			impact_position = Unit.world_position(unit, node)
		end
	end

	if should_spawn_blood then
		Managers.state.blood:spawn_blood_ball(impact_position, hit_direction, damage_type, unit)
	end

	if hit_effect then
		map_function(hit_effect, play_effect, unit, world, actors, hit_direction, damage_type, impact_position)
	end

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

	if sound_event then
		local wwise_world = Managers.world:wwise_world(world)
		local wwise_source_id = WwiseWorld.make_auto_source(wwise_world, impact_position)

		table.clear(WWISE_PARAMETERS)

		WWISE_PARAMETERS.damage_type = parameters.damage_type
		WWISE_PARAMETERS.enemy_type = breed_data.name
		WWISE_PARAMETERS.weapon_type = parameters.weapon_type
		WWISE_PARAMETERS.hit_zone = hit_zone
		WWISE_PARAMETERS.husk = NetworkUnit.is_husk_unit(unit)
		local dialogue_extension = self.dialogue_extension

		if dialogue_extension and dialogue_extension.wwise_voice_switch_group then
			WWISE_PARAMETERS[dialogue_extension.wwise_voice_switch_group] = dialogue_extension.wwise_voice_switch_value
		end

		Managers.state.entity:system("sound_environment_system"):set_source_environment(wwise_source_id, impact_position)

		for param_name, param_value in pairs(WWISE_PARAMETERS) do
			WwiseWorld.set_switch(wwise_world, wwise_source_id, param_name, param_value)
		end

		map_function(effect_template.sound_event, play_sound, wwise_world, wwise_source_id, impact_position, parameters.is_husk)
	end

	if parameters.death and self.death_extension and not self.death_extension:has_death_started() then
		Unit.flow_event(unit, "lua_on_death")
	end
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

		actor = Unit.actor(unit, push_actors[i]) or actor
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
	local distal_vector = distal_direction * distal_force
	local lateral_vector = lateral_direction * lateral_force
	local vertical_vector = Vector3(0, 0, vertical_force)
	local push_force = (distal_vector + lateral_vector + vertical_vector) / (0.75 * num_actors)
	local breed = Unit.get_data(unit, "breed")

	if breed.scale_death_push then
		push_force = push_force * breed.scale_death_push
	end

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
