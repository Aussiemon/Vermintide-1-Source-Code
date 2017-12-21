if not BT_COMPILER then
	local champion_utility_considerations = dofile("scripts/entity_system/systems/behaviour/utility/storm_vermin_champion_utility_considerations")

	for consideration_name, consideration_data in pairs(champion_utility_considerations) do
		fassert(not rawget(UtilityConsiderations, consideration_name), "Consideration %s already exists in UtilityConsiderations", consideration_name)

		UtilityConsiderations[consideration_name] = consideration_data
	end
end

AiBreedSnippets.on_storm_vermin_champion_spawn = function (unit, blackboard)
	blackboard.aggro_list = {}
	blackboard.next_move_check = 0
	blackboard.spawned_allies_wave = 0
	blackboard.surrounding_players = 0
	blackboard.current_phase = 1
	blackboard.spawn_type = nil
	blackboard.surrounding_players_last = -math.huge
	blackboard.run_speed = blackboard.breed.run_speed

	if 3 <= Managers.state.difficulty:get_difficulty_rank() then
		blackboard.trickle_timer = Managers.time:time("game") + 20
	else
		print("no trickle, difficulty:", Managers.state.difficulty:get_difficulty_rank())
	end

	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)
	local conflict_director = Managers.state.conflict

	conflict_director.freeze_intensity_decay(conflict_director, 10)
	conflict_director.add_unit_to_bosses(conflict_director, unit)

	local actor = Unit.actor(unit, "c_trophy_rack_ward")

	Actor.set_collision_enabled(actor, false)
	Actor.set_scene_query_enabled(actor, false)

	return 
end
AiBreedSnippets.on_storm_vermin_champion_husk_spawn = function (unit)
	local actor = Unit.actor(unit, "c_trophy_rack_ward")

	Actor.set_collision_enabled(actor, false)
	Actor.set_scene_query_enabled(actor, false)

	return 
end
AiBreedSnippets.on_storm_vermin_hot_join_sync = function (sender, unit)
	local bb = Unit.get_data(unit, "blackboard")

	if bb.ward_active then
		local network_manager = Managers.state.network
		local unit_id = network_manager.unit_game_object_id(network_manager, unit)

		RPC.rpc_set_ward_state(sender, unit_id, true)
	end

	return 
end
AiBreedSnippets.on_storm_vermin_champion_update = function (unit, blackboard, t, dt)
	local self_pos = POSITION_LOOKUP[unit]
	local range = BreedActions.skaven_storm_vermin_champion.special_attack_spin.radius
	local num = 0

	for i, position in ipairs(PLAYER_AND_BOT_POSITIONS) do
		if Vector3.distance(self_pos, position) < range and not ScriptUnit.extension(PLAYER_AND_BOT_UNITS[i], "status_system"):is_disabled() then
			num = num + 1
		end
	end

	blackboard.surrounding_players = num

	if 0 < blackboard.surrounding_players then
		blackboard.surrounding_players_last = t
	end

	if blackboard.trickle_timer and blackboard.trickle_timer < t and not blackboard.defensive_mode_duration then
		local conflict_director = Managers.state.conflict

		if conflict_director.count_units_by_breed(conflict_director, "skaven_clan_rat") < 3 then
			local strictly_not_close_to_players = true
			local silent = true
			local composition_type = "mini_patrol"
			local limit_spawners, terror_event_id = nil

			conflict_director.horde_spawner:execute_event_horde(t, terror_event_id, composition_type, limit_spawners, silent, nil, strictly_not_close_to_players)

			blackboard.trickle_timer = t + 15
		else
			blackboard.trickle_timer = t + 10
		end
	end

	local hp = ScriptUnit.extension(blackboard.unit, "health_system"):current_health_percent()

	if blackboard.current_phase == 2 and hp < 0.15 then
		blackboard.current_phase = 3
		local new_run_speed = blackboard.breed.angry_run_speed
		blackboard.run_speed = new_run_speed

		if not blackboard.run_speed_overridden then
			blackboard.navigation_extension:set_max_speed(new_run_speed)
		end
	elseif blackboard.current_phase == 1 and hp < 0.8 then
		blackboard.current_phase = 2
	end

	if blackboard.defensive_mode_duration then
		local remaining = blackboard.defensive_mode_duration - dt

		if remaining <= 0 or (remaining <= 10 and Managers.state.conflict:spawned_during_event() <= 2) then
			blackboard.defensive_mode_duration = nil
		else
			blackboard.defensive_mode_duration = remaining
		end
	end

	if blackboard.ward_active and script_data.ai_champion_spawn_debug then
		QuickDrawer:sphere(POSITION_LOOKUP[unit] + Vector3(0, 0, 1.5), 1.5, Color(255, 0, 0))
	end

	return 
end
AiBreedSnippets.on_storm_vermin_champion_death = function (unit, blackboard)
	local conflict_director = Managers.state.conflict

	conflict_director.freeze_intensity_decay(conflict_director, 1)
	conflict_director.add_unit_to_bosses(conflict_director, unit)

	return 
end
local breed_data = {
	initial_is_passive = false,
	walk_speed = 2,
	unit_template = "ai_unit_storm_vermin_champion",
	run_speed = 6.109090909090908,
	awards_positive_reinforcement_message = true,
	horde_behavior = "storm_vermin_champion",
	behavior = "storm_vermin_champion",
	aoe_radius = 0.6,
	smart_object_template = "special",
	exchange_order = 1,
	animation_sync_rpc = "rpc_sync_anim_state_5",
	disable_crowd_dispersion = true,
	smart_targeting_width = 0.2,
	smart_targeting_height_multiplier = 2.5,
	smart_targeting_outer_width = 1,
	has_inventory = true,
	poison_resistance = 100,
	armor_category = 2,
	hit_reaction = "ai_default",
	stagger_immune = true,
	wield_inventory_on_spawn = true,
	default_inventory_template = "halberd",
	is_bot_aid_threat = true,
	dialogue_source_name = "skaven_storm_vermin_champion",
	hit_effect_template = "HitEffectsStormVerminChampion",
	radius = 1,
	bot_opportunity_target_melee_range = 7,
	boss = true,
	death_sound_event = "Play_stormvermin_die_vce",
	headshot_coop_stamina_fatigue_type = "headshot_special",
	target_selection = "pick_rat_ogre_target_with_weights",
	bot_optimal_melee_distance = 2,
	has_running_attack = true,
	disable_second_hit_ragdoll = true,
	proximity_system_check = true,
	death_reaction = "storm_vermin_champion",
	perception = "perception_rat_ogre",
	player_locomotion_constrain_radius = 1,
	bot_opportunity_target_melee_range_while_ranged = 5,
	angry_run_speed = 6,
	weapon_reach = 2,
	bone_lod_level = 1,
	no_stagger_duration = true,
	override_mover_move_distance = 1.5,
	perception_continuous = "perception_continuous_rat_ogre",
	base_unit = "units/beings/enemies/skaven_stormvermin_champion/chr_skaven_stormvermin_champion",
	aoe_height = 1.7,
	bots_should_flank = true,
	run_on_spawn = AiBreedSnippets.on_storm_vermin_champion_spawn,
	run_on_death = AiBreedSnippets.on_storm_vermin_champion_death,
	run_on_update = AiBreedSnippets.on_storm_vermin_champion_update,
	run_on_husk_spawn = AiBreedSnippets.on_storm_vermin_champion_husk_spawn,
	hot_join_sync = AiBreedSnippets.on_storm_vermin_hot_join_sync,
	detection_radius = math.huge,
	perception_weights = {
		target_catapulted_mul = 0.5,
		target_stickyness_bonus_b = 10,
		targeted_by_other_special = -10,
		distance_weight = 10,
		target_stickyness_duration_b = 20,
		aggro_decay_per_sec = 10,
		target_outside_navmesh_mul = 0.5,
		target_stickyness_bonus_a = 50,
		old_target_aggro_mul = 1,
		target_disabled_aggro_mul = 0,
		max_distance = 50,
		target_stickyness_duration_a = 5,
		target_disabled_mul = 0.15,
		aggro_multipliers = {
			melee = 1,
			ranged = 3,
			grenade = 2
		}
	},
	size_variation_range = {
		1.4,
		1.4
	},
	max_health = {
		300,
		350,
		400,
		500,
		800
	},
	debug_color = {
		255,
		200,
		0,
		170
	},
	animation_merge_options = {
		idle_animation_merge_options = {},
		walk_animation_merge_options = {},
		move_animation_merge_options = {}
	},
	hit_zones = {
		full = {
			prio = 2,
			actors = {}
		},
		ward = {
			prio = 1,
			actors = {
				"c_trophy_rack_ward"
			},
			push_actors = {
				"j_hips"
			}
		},
		head = {
			prio = 2,
			actors = {
				"c_head"
			},
			push_actors = {
				"j_head",
				"j_neck",
				"j_spine1"
			}
		},
		neck = {
			prio = 2,
			actors = {
				"c_neck"
			},
			push_actors = {
				"j_head",
				"j_neck",
				"j_spine1"
			}
		},
		torso = {
			prio = 3,
			actors = {
				"c_spine2",
				"c_spine",
				"c_hips"
			},
			push_actors = {
				"j_neck",
				"j_spine1",
				"j_hips"
			}
		},
		left_arm = {
			prio = 4,
			actors = {
				"c_leftarm",
				"c_leftforearm",
				"c_lefthand"
			},
			push_actors = {
				"j_spine1",
				"j_leftshoulder",
				"j_leftarm"
			}
		},
		right_arm = {
			prio = 4,
			actors = {
				"c_rightarm",
				"c_rightforearm",
				"c_righthand"
			},
			push_actors = {
				"j_spine1",
				"j_rightshoulder",
				"j_rightarm"
			}
		},
		left_leg = {
			prio = 4,
			actors = {
				"c_leftupleg",
				"c_leftleg",
				"c_leftfoot",
				"c_lefttoebase"
			},
			push_actors = {
				"j_leftfoot",
				"j_rightfoot",
				"j_hips"
			}
		},
		right_leg = {
			prio = 4,
			actors = {
				"c_rightupleg",
				"c_rightleg",
				"c_rightfoot",
				"c_righttoebase"
			},
			push_actors = {
				"j_leftfoot",
				"j_rightfoot",
				"j_hips"
			}
		},
		tail = {
			prio = 4,
			actors = {
				"c_tail1",
				"c_tail2",
				"c_tail3",
				"c_tail4",
				"c_tail5",
				"c_tail6"
			},
			push_actors = {
				"j_hips",
				"j_taill"
			}
		},
		afro = {
			prio = 5,
			actors = {
				"c_afro"
			}
		}
	},
	hitbox_ragdoll_translation = {
		c_leftupleg = "j_leftupleg",
		c_rightarm = "j_rightarm",
		c_righthand = "j_righthand",
		c_rightfoot = "j_rightfoot",
		c_tail2 = "j_tail2",
		c_rightleg = "j_rightleg",
		c_lefthand = "j_lefthand",
		c_tail5 = "j_tail5",
		c_leftleg = "j_leftleg",
		c_spine2 = "j_spine1",
		c_tail6 = "j_tail6",
		c_rightupleg = "j_rightupleg",
		c_tail1 = "j_taill",
		c_tail4 = "j_tail4",
		c_spine = "j_spine",
		c_head = "j_head",
		c_leftforearm = "j_leftforearm",
		c_righttoebase = "j_righttoebase",
		c_leftfoot = "j_leftfoot",
		c_neck = "j_neck",
		c_tail3 = "j_tail3",
		c_rightforearm = "j_rightforearm",
		c_leftarm = "j_leftarm",
		c_hips = "j_hips",
		c_lefttoebase = "j_lefttoebase"
	},
	ragdoll_actor_thickness = {
		j_rightfoot = 0.2,
		j_taill = 0.05,
		j_leftarm = 0.2,
		j_leftforearm = 0.2,
		j_leftleg = 0.2,
		j_tail3 = 0.05,
		j_rightarm = 0.2,
		j_leftupleg = 0.2,
		j_rightshoulder = 0.3,
		j_righthand = 0.2,
		j_righttoebase = 0.2,
		j_tail4 = 0.05,
		j_hips = 0.3,
		j_leftshoulder = 0.3,
		j_rightleg = 0.2,
		j_leftfoot = 0.2,
		j_spine1 = 0.3,
		j_tail5 = 0.05,
		j_rightupleg = 0.2,
		j_tail6 = 0.05,
		j_lefttoebase = 0.2,
		j_head = 0.3,
		j_neck = 0.3,
		j_spine = 0.3,
		j_lefthand = 0.2,
		j_rightforearm = 0.2,
		j_tail2 = 0.05
	}
}
Breeds.skaven_storm_vermin_champion = table.create_copy(Breeds.skaven_storm_vermin_champion, breed_data)
local action_data = {
	follow = {
		move_anim = "move_fwd",
		cooldown = -1,
		action_weight = 1,
		start_anims = {
			bwd = "move_start_bwd",
			fwd = "move_start_fwd",
			left = "move_start_left",
			right = "move_start_right"
		},
		start_anims_data = {
			move_start_fwd = {},
			move_start_bwd = {
				dir = -1,
				rad = math.pi
			},
			move_start_left = {
				dir = 1,
				rad = math.pi/2
			},
			move_start_right = {
				dir = -1,
				rad = math.pi/2
			}
		},
		considerations = UtilityConsiderations.storm_vermin_champion_follow
	},
	special_attack_champion = {
		action_weight = 1,
		considerations = UtilityConsiderations.storm_vermin_champion_special_attack
	},
	running_attack = {
		action_weight = 2,
		considerations = UtilityConsiderations.storm_vermin_champion_running_attack
	},
	special_attack_cleave = {
		offset_forward = 0,
		height = 3,
		cooldown = 1.5,
		rotation_time = 1,
		fatigue_type = "blocked_sv_cleave",
		bot_threat_duration = 0.75,
		increment_stat_on_attack_dodged = "dodged_storm_vermin_champion",
		damage_type = "cutting",
		offset_up = 0,
		attack_anim = "attack_special",
		range = 4,
		player_push_speed = 10,
		player_push_speed_blocked = 8,
		move_anim = "move_fwd",
		width = 0.4,
		throw_dialogue_system_event_on_dodged_attack = true,
		blocked_damage = {
			0,
			0,
			0
		},
		blocked_difficulty_damage = {
			easy = {
				0,
				0,
				0
			},
			normal = {
				0,
				0,
				0
			},
			hard = {
				2,
				2,
				2
			},
			survival_hard = {
				2,
				2,
				2
			},
			harder = {
				5,
				5,
				5
			},
			survival_harder = {
				5,
				5,
				5
			},
			hardest = {
				10,
				10,
				10
			},
			survival_hardest = {
				10,
				10,
				10
			}
		},
		damage = {
			30,
			25,
			20
		},
		difficulty_damage = {
			easy = {
				20,
				20,
				15
			},
			normal = {
				30,
				25,
				20
			},
			hard = {
				40,
				35,
				30
			},
			survival_hard = {
				40,
				35,
				30
			},
			harder = {
				50,
				40,
				30
			},
			survival_harder = {
				50,
				40,
				30
			},
			hardest = {
				100,
				50,
				30
			},
			survival_hardest = {
				150,
				75,
				45
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	special_attack_spin = {
		height = 4,
		offset_forward = -6,
		radius = 4.5,
		cooldown = 0.25,
		rotation_time = 0,
		fatigue_type = "blocked_slam",
		collision_type = "cylinder",
		player_push_speed = 20,
		shove_speed = 9,
		damage_type = "cutting",
		shove_z_speed = 6,
		offset_up = 0,
		attack_anim = "attack_spin_charge",
		offset_right = 0,
		bot_threat_duration = 2,
		action_weight = 4,
		player_push_speed_blocked = 15,
		move_anim = "move_fwd",
		attack_sequence = {
			{
				attack_anim = "attack_spin_charge"
			},
			{
				attack_anim = "attack_spin",
				at = 2
			}
		},
		blocked_damage = {
			0,
			0,
			0
		},
		blocked_difficulty_damage = {
			easy = {
				0,
				0,
				0
			},
			normal = {
				0,
				0,
				0
			},
			hard = {
				2,
				2,
				2
			},
			survival_hard = {
				2,
				2,
				2
			},
			harder = {
				5,
				5,
				5
			},
			survival_harder = {
				5,
				5,
				5
			},
			hardest = {
				10,
				10,
				10
			},
			survival_hardest = {
				10,
				10,
				10
			}
		},
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		},
		considerations = UtilityConsiderations.storm_vermin_champion_spin
	},
	defensive_mode_spin = {
		height = 4,
		offset_forward = -6,
		radius = 6,
		cooldown = 0.25,
		rotation_time = 0,
		fatigue_type = "blocked_slam",
		collision_type = "cylinder",
		player_push_speed = 20,
		shove_speed = 9,
		damage_type = "cutting",
		shove_z_speed = 6,
		offset_up = 0,
		attack_anim = "attack_spin_charge",
		offset_right = 0,
		bot_threat_duration = 2,
		action_weight = 4,
		player_push_speed_blocked = 15,
		move_anim = "move_fwd",
		exit_flow_event = "lua_disable_weapon_fx",
		attack_sequence = {
			{
				attack_anim = "attack_spin_charge"
			},
			{
				attack_anim = "attack_spin",
				ready_function = function (unit, blackboard, t)
					local charge_t = t - blackboard.attack_sequence_start_time

					return (1.5 < charge_t and 0 < blackboard.surrounding_players) or 2.5 < charge_t
				end
			}
		},
		blocked_damage = {
			0,
			0,
			0
		},
		blocked_difficulty_damage = {
			easy = {
				0,
				0,
				0
			},
			normal = {
				0,
				0,
				0
			},
			hard = {
				2,
				2,
				2
			},
			survival_hard = {
				2,
				2,
				2
			},
			harder = {
				5,
				5,
				5
			},
			survival_harder = {
				5,
				5,
				5
			},
			hardest = {
				10,
				10,
				10
			},
			survival_hardest = {
				10,
				10,
				10
			}
		},
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		},
		considerations = UtilityConsiderations.storm_vermin_champion_defensive_spin
	},
	special_attack_sweep_left = {
		radius = 2.25,
		overlap_end_time = 0.7575757575757576,
		cooldown = 0.25,
		rotation_time = 0,
		fatigue_type = "blocked_sv_sweep",
		collision_filter = "filter_player_and_husk_trigger",
		offset_right = 0,
		mode = "radial_cylinder",
		direction = "counter_clockwise",
		damage_type = "cutting",
		offset_forward = -1.5,
		offset_up = 0,
		attack_anim = "attack_sweep_left",
		collision_type = "cylinder",
		height = 2,
		player_push_speed = 8,
		overlap_start_time = 0.5151515151515151,
		bot_threat_duration = 1,
		player_push_speed_blocked = 6,
		move_anim = "move_fwd",
		throw_dialogue_system_event_on_dodged_attack = true,
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		overlap_start_angle_offset = -math.pi,
		overlap_end_angle_offset = math.pi*0.5,
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	special_attack_sweep_right = {
		radius = 2.25,
		overlap_end_time = 0.7333333333333333,
		cooldown = 0.25,
		rotation_time = 0,
		fatigue_type = "blocked_sv_sweep",
		collision_filter = "filter_player_and_husk_trigger",
		offset_right = 0,
		mode = "radial_cylinder",
		direction = "clockwise",
		damage_type = "cutting",
		offset_forward = -1.1,
		offset_up = 0,
		attack_anim = "attack_sweep_right",
		collision_type = "cylinder",
		height = 2,
		player_push_speed = 8,
		overlap_start_time = 0.36666666666666664,
		bot_threat_duration = 1,
		player_push_speed_blocked = 6,
		move_anim = "move_fwd",
		throw_dialogue_system_event_on_dodged_attack = true,
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		overlap_start_angle_offset = math.pi*-0.5,
		overlap_end_angle_offset = math.pi,
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	special_lunge_attack = {
		animation_driven = true,
		offset_forward = 0.25,
		wall_collision_stun_time = 1.1666666666666667,
		overlap_start_time = 1.1,
		cooldown = 0.25,
		rotation_time = 1,
		fatigue_type = "blocked_slam",
		overlap_end_time = 2.3666666666666667,
		mode = "continuous_overlap",
		player_push_speed = 12,
		damage_type = "cutting",
		overlap_check_walls_range = 2,
		offset_up = 0,
		overlap_check_walls_time = 1.75,
		range = 2,
		height = 2,
		wall_collision_anim = "charge_attack_lunge_miss",
		action_weight = 5,
		player_push_speed_blocked = 8,
		move_anim = "move_fwd",
		width = 1,
		throw_dialogue_system_event_on_missed_attack = true,
		considerations = UtilityConsiderations.storm_vermin_champion_lunge_attack,
		attack_sequence = {
			{
				attack_anim = "charge_attack_step"
			},
			{
				at = 1.0666666666666667,
				animation_drive_scale = 0.4,
				attack_anim = "charge_attack_lunge"
			}
		},
		blocked_damage = {
			5,
			4,
			2.5
		},
		blocked_difficulty_damage = {
			easy = {
				4,
				4,
				2.5
			},
			normal = {
				5,
				4,
				2.5
			},
			hard = {
				7,
				5,
				2.5
			},
			survival_hard = {
				7,
				5,
				2.5
			},
			harder = {
				9,
				7.5,
				5
			},
			survival_harder = {
				9,
				7.5,
				5
			},
			hardest = {
				12,
				10,
				7.5
			},
			survival_hardest = {
				18,
				15,
				11.25
			}
		},
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	special_running_attack = {
		animation_driven = true,
		offset_forward = 0.15,
		overlap_start_time = 0.2,
		cooldown = 0.5,
		rotation_time = 1.1,
		fatigue_type = "blocked_attack",
		overlap_end_time = 1.1,
		overlap_start_damage = 0,
		mode = "continuous_overlap",
		height = 2,
		damage_type = "cutting",
		player_push_speed = 12,
		offset_up = 0,
		movement_controlled_rotation = false,
		action_weight = 5,
		player_push_speed_blocked = 12,
		width = 0.3,
		considerations = UtilityConsiderations.storm_vermin_champion_running_attack,
		attack_sequence = {
			{
				attack_anim = "charge_attack_step"
			},
			{
				attack_anim = "attack_run_2",
				at = 0.16666666666666666
			}
		},
		blocked_damage = {
			0,
			0,
			0
		},
		blocked_difficulty_damage = {
			easy = {
				0,
				0,
				0
			},
			normal = {
				0,
				0,
				0
			},
			hard = {
				2,
				2,
				2
			},
			survival_hard = {
				2,
				2,
				2
			},
			harder = {
				5,
				5,
				5
			},
			survival_harder = {
				5,
				5,
				5
			},
			hardest = {
				10,
				10,
				10
			},
			survival_hardest = {
				10,
				10,
				10
			}
		},
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		},
		range = function (t_value)
			if t_value < 0.65 then
				return 0.4
			else
				local scaled_t = math.min((t_value - 0.65)*4, 1)

				return math.lerp(0.4, 2.95, scaled_t)
			end

			return 
		end
	},
	special_attack_shatter = {
		wave_fx = "fx/chr_stormvermin_champion_beam_impact_dot",
		anticipation_fx = "fx/chr_stormvermin_champion_beam_anticipation_dot",
		cooldown = 1,
		rotation_time = 0,
		fatigue_type = "blocked_slam",
		wave_point_distance = 1,
		height = 2,
		mode = "nav_mesh_wave",
		offset_forward = 0.5,
		damage_type = "cutting",
		num_wave_points = 15,
		shove_speed = 4,
		shove_z_speed = 10,
		wave_sfx = "Play_enemy_stormvermin_champion_electric_floor",
		wave_speed = 20,
		overlap_start_time = 2.1666666666666665,
		action_weight = 5,
		move_anim = "move_fwd",
		width = 2,
		considerations = UtilityConsiderations.storm_vermin_champion_shatter_attack,
		attack_sequence = {
			{
				attack_anim = "attack_charge_special"
			},
			{
				attack_anim = "attack_charge_shatter",
				at = 1.5
			}
		},
		blocked_damage = {
			5,
			4,
			2.5
		},
		blocked_difficulty_damage = {
			easy = {
				4,
				4,
				2.5
			},
			normal = {
				5,
				4,
				2.5
			},
			hard = {
				7,
				5,
				2.5
			},
			survival_hard = {
				7,
				5,
				2.5
			},
			harder = {
				9,
				7.5,
				5
			},
			survival_harder = {
				9,
				7.5,
				5
			},
			hardest = {
				12,
				10,
				7.5
			},
			survival_hardest = {
				18,
				15,
				11.25
			}
		},
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	defensive_attack_shatter = {
		wave_fx = "fx/chr_stormvermin_champion_beam_impact_dot",
		anticipation_fx = "fx/chr_stormvermin_champion_beam_anticipation_dot",
		cooldown = 1,
		rotation_time = 0,
		fatigue_type = "blocked_slam",
		wave_point_distance = 1,
		height = 2,
		mode = "nav_mesh_wave",
		offset_forward = 0.5,
		damage_type = "cutting",
		num_wave_points = 9,
		shove_speed = 4,
		shove_z_speed = 10,
		wave_sfx = "Play_enemy_stormvermin_champion_electric_floor",
		wave_speed = 20,
		overlap_start_time = 2.1666666666666665,
		action_weight = 5,
		move_anim = "move_fwd",
		width = 2,
		considerations = UtilityConsiderations.storm_vermin_champion_defensive_shatter_attack,
		attack_sequence = {
			{
				attack_anim = "attack_charge_special"
			},
			{
				attack_anim = "attack_charge_shatter",
				at = 1.5
			}
		},
		blocked_damage = {
			5,
			4,
			2.5
		},
		blocked_difficulty_damage = {
			easy = {
				4,
				4,
				2.5
			},
			normal = {
				5,
				4,
				2.5
			},
			hard = {
				7,
				5,
				2.5
			},
			survival_hard = {
				7,
				5,
				2.5
			},
			harder = {
				9,
				7.5,
				5
			},
			survival_harder = {
				9,
				7.5,
				5
			},
			hardest = {
				12,
				10,
				7.5
			},
			survival_hardest = {
				18,
				15,
				11.25
			}
		},
		damage = {
			20,
			10,
			5
		},
		difficulty_damage = {
			easy = {
				15,
				10,
				5
			},
			normal = {
				20,
				10,
				5
			},
			hard = {
				25,
				15,
				10
			},
			survival_hard = {
				25,
				15,
				10
			},
			harder = {
				30,
				20,
				10
			},
			survival_harder = {
				30,
				20,
				10
			},
			hardest = {
				50,
				30,
				20
			},
			survival_hardest = {
				75,
				45,
				30
			}
		},
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	guard_break = {
		damage_type = "cutting",
		fatigue_type = "sv_push",
		impact_push_speed = 10,
		max_impact_push_speed = 12,
		attack_anim = "attack_push",
		action_weight = 1,
		considerations = UtilityConsiderations.storm_vermin_champion_guardbreak,
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	smash_door = {
		unblockable = true,
		name = "smash_door",
		damage_type = "cutting",
		move_anim = "move_fwd",
		attack_anim = "attack_pounce",
		damage = {
			3,
			3,
			3
		}
	},
	blocked = {
		blocked_anims = {
			"blocked",
			"blocked_2"
		}
	},
	stagger = {
		stagger_anims = {
			{
				fwd = {
					"stun_fwd_sword"
				},
				bwd = {
					"stun_bwd_sword"
				},
				left = {
					"stun_left_sword"
				},
				right = {
					"stun_right_sword"
				},
				dwn = {
					"stun_bwd_sword"
				}
			},
			{
				fwd = {
					"stagger_fwd"
				},
				bwd = {
					"stagger_bwd"
				},
				left = {
					"stagger_left"
				},
				right = {
					"stagger_right"
				},
				dwn = {
					"stagger_bwd"
				}
			},
			{
				fwd = {
					"stagger_fwd"
				},
				bwd = {
					"stagger_bwd"
				},
				left = {
					"stagger_left_heavy"
				},
				right = {
					"stagger_right_heavy"
				}
			},
			{
				fwd = {
					"stun_fwd_sword"
				},
				bwd = {
					"stun_bwd_sword"
				},
				left = {
					"stun_left_sword"
				},
				right = {
					"stun_right_sword"
				}
			},
			{
				fwd = {
					"stagger_fwd"
				},
				bwd = {
					"stagger_bwd_stab"
				},
				left = {
					"stagger_left"
				},
				right = {
					"stagger_right"
				}
			},
			{
				fwd = {
					"stagger_fwd_exp"
				},
				bwd = {
					"stagger_bwd_exp"
				},
				left = {
					"stagger_left_exp"
				},
				right = {
					"stagger_right_exp"
				}
			},
			{
				fwd = {
					"stagger_fwd"
				},
				bwd = {
					"stagger_bwd"
				},
				left = {
					"stagger_left"
				},
				right = {
					"stagger_right"
				}
			}
		}
	},
	spawn_sequence = {
		action_weight = 20,
		considerations = UtilityConsiderations.storm_vermin_champion_spawn
	},
	turn_to_face_target = {
		action_weight = 20,
		move_anim = "move_start_fwd",
		rage_time = 0.6,
		considerations = UtilityConsiderations.storm_vermin_champion_turn_to_face_target,
		start_anims_name = {
			bwd = "turn_bwd",
			left = "turn_left",
			right = "turn_right"
		},
		start_anims_data = {
			turn_bwd = {
				dir = -1,
				rad = math.pi
			},
			turn_left = {
				dir = 1,
				rad = math.pi/2
			},
			turn_right = {
				dir = -1,
				rad = math.pi/2
			}
		}
	},
	spawn_allies = {
		run_to_spawn_speed = 7,
		spawn_group = "chieftain_spawners",
		animation = "call_allies",
		move_anim = "move_fwd",
		duration = 5,
		spawn = "stormdorf_boss_event_defensive_hard",
		spawn_list = {
			"skaven_storm_vermin",
			"skaven_storm_vermin"
		},
		difficulty_spawn_list = {
			easy = {
				"skaven_storm_vermin"
			},
			normal = {
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			},
			hard = {
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			},
			survival_hard = {
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			},
			harder = {
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			},
			survival_harder = {
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			},
			hardest = {
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			},
			survival_hardest = {
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin",
				"skaven_storm_vermin"
			}
		},
		difficulty_spawn = {
			harder = "stormdorf_boss_event_defensive_harder",
			normal = "stormdorf_boss_event_defensive_normal",
			hard = "stormdorf_boss_event_defensive_hard",
			survival_hard = "stormdorf_boss_event_defensive_hard",
			survival_harder = "stormdorf_boss_event_defensive_hard",
			hardest = "stormdorf_boss_event_defensive_hardest",
			survival_hardest = "stormdorf_boss_event_defensive_hard",
			easy = "stormdorf_boss_event_defensive_easy"
		},
		start_anims = {
			bwd = "move_start_bwd",
			fwd = "move_start_fwd",
			left = "move_start_left",
			right = "move_start_right"
		},
		start_anims_data = {
			move_start_fwd = {},
			move_start_bwd = {
				dir = -1,
				rad = math.pi
			},
			move_start_left = {
				dir = 1,
				rad = math.pi/2
			},
			move_start_right = {
				dir = -1,
				rad = math.pi/2
			}
		}
	},
	defensive_idle = {
		force_idle_animation = true,
		idle_animation = "defensive_idle"
	}
}
BreedActions.skaven_storm_vermin_champion = table.create_copy(BreedActions.skaven_storm_vermin_champion, action_data)

return 
