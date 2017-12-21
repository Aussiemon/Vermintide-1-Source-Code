local breed_data = {
	detection_radius = 9999999,
	target_selection = "pick_rat_ogre_target_idle",
	target_selection_angry = "pick_rat_ogre_target_with_weights",
	chance_of_starting_angry = 1,
	blood_effect_name = "fx/impact_blood_ogre",
	combat_detect_player_stinger = "enemy_ratogre_stinger",
	override_mover_move_distance = 2,
	boss_staggers = true,
	run_speed = 7,
	exchange_order = 1,
	animation_sync_rpc = "rpc_sync_anim_state_5",
	jump_slam_gravity = 19,
	reach_distance = 3,
	has_inventory = true,
	use_avoidance = false,
	ignore_nav_propagation_box = true,
	poison_resistance = 100,
	armor_category = 3,
	hit_reaction = "ai_default",
	bot_opportunity_target_melee_range = 7,
	bone_lod_level = 0,
	use_aggro = true,
	default_inventory_template = "rat_ogre",
	perception_continuous = "perception_continuous_rat_ogre",
	smart_targeting_outer_width = 1.4,
	walk_speed = 5,
	hit_effect_template = "HitEffectsRatOgre",
	smart_targeting_height_multiplier = 1.5,
	radius = 2,
	unit_template = "ai_unit_rat_ogre",
	aoe_radius = 1,
	combat_spawn_stinger = "enemy_ratogre_stinger",
	smart_object_template = "rat_ogre",
	num_forced_slams_at_target_switch = 0,
	proximity_system_check = true,
	death_reaction = "ai_default",
	perception = "perception_rat_ogre",
	player_locomotion_constrain_radius = 1.5,
	bot_opportunity_target_melee_range_while_ranged = 5,
	no_stagger_duration = false,
	awards_positive_reinforcement_message = true,
	bot_optimal_melee_distance = 2,
	headshot_coop_stamina_fatigue_type = "headshot_special",
	far_off_despawn_immunity = true,
	trigger_dialogue_on_target_switch = true,
	smart_targeting_width = 0.6,
	is_bot_aid_threat = true,
	behavior = "ogre",
	base_unit = "units/beings/enemies/skaven_rat_ogre/chr_skaven_rat_ogre",
	aoe_height = 2.4,
	bots_should_flank = true,
	hit_zones = {
		full = {
			prio = 1,
			actors = {}
		},
		head = {
			prio = 1,
			actors = {
				"c_head"
			},
			push_actors = {
				"j_head",
				"j_spine1"
			}
		},
		neck = {
			prio = 1,
			actors = {
				"c_neck1",
				"c_spine1"
			},
			push_actors = {
				"j_head",
				"j_spine1"
			}
		},
		torso = {
			prio = 3,
			actors = {
				"c_spine2",
				"c_spine",
				"c_hips",
				"c_leftshoulder",
				"c_rightshoulder"
			},
			push_actors = {
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
				"j_spine1"
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
				"j_spine1"
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
				"j_hips"
			}
		},
		afro = {
			prio = 5,
			actors = {
				"c_afro"
			}
		}
	},
	blood_effect_nodes = {
		{
			triggered = false,
			node = "fx_wound_001"
		},
		{
			triggered = false,
			node = "fx_wound_002"
		},
		{
			triggered = false,
			node = "fx_wound_003"
		},
		{
			triggered = false,
			node = "fx_wound_004"
		},
		{
			triggered = false,
			node = "fx_wound_005"
		},
		{
			triggered = false,
			node = "fx_wound_006"
		},
		{
			triggered = false,
			node = "fx_wound_007"
		},
		{
			triggered = false,
			node = "fx_wound_008"
		},
		{
			triggered = false,
			node = "fx_wound_009"
		},
		{
			triggered = false,
			node = "fx_wound_010"
		},
		{
			triggered = false,
			node = "fx_wound_011"
		},
		{
			triggered = false,
			node = "fx_wound_012"
		},
		{
			triggered = false,
			node = "fx_wound_013"
		}
	},
	blood_intensity = {
		mtr_skin = "blood_intensity"
	},
	perception_weights = {
		target_catapulted_mul = 0.5,
		target_stickyness_bonus_b = 10,
		targeted_by_other_special = -10,
		target_stickyness_duration_a = 5,
		target_stickyness_duration_b = 20,
		aggro_decay_per_sec = 1,
		target_outside_navmesh_mul = 0.5,
		old_target_aggro_mul = 1,
		target_disabled_aggro_mul = 0,
		max_distance = 50,
		target_stickyness_bonus_a = 50,
		distance_weight = 100,
		target_disabled_mul = 0.15
	},
	max_health = {
		800,
		1000,
		1200,
		1400,
		2000
	},
	num_push_anims = {},
	run_on_spawn = AiBreedSnippets.on_rat_ogre_spawn,
	run_on_death = AiBreedSnippets.on_rat_ogre_death,
	debug_color = {
		255,
		20,
		20,
		20
	},
	blackboard_init_data = {
		ladder_distance = math.huge
	}
}
Breeds.skaven_rat_ogre = table.create_copy(Breeds.skaven_rat_ogre, breed_data)
local action_data = {
	follow = {
		move_anim = "move_start_fwd",
		cooldown = -1,
		action_weight = 1,
		considerations = UtilityConsiderations.follow,
		init_blackboard = {
			chasing_timer = -10
		}
	},
	smash_door = {
		unblockable = true,
		name = "smash_door",
		damage_type = "cutting",
		move_anim = "move_fwd",
		attack_anim = "attack_slam",
		door_attack_distance = 2,
		damage = {
			25,
			25,
			25
		},
		ignore_staggers = {
			false,
			true,
			true,
			true,
			false,
			true
		}
	},
	target_rage = {
		move_anim = "move_start_fwd",
		change_target_fwd_close_dist = 15,
		rage_time = 1.75,
		start_anims_name = {
			bwd = "change_target_bwd",
			fwd = "change_target_fwd",
			left = "change_target_left",
			right = "change_target_right"
		},
		start_anims_data = {
			change_target_fwd = {},
			change_target_bwd = {
				dir = -1,
				rad = math.pi
			},
			change_target_left = {
				dir = 1,
				rad = math.pi/2
			},
			change_target_right = {
				dir = -1,
				rad = math.pi/2
			}
		},
		change_target_fwd_close_anims = {
			"roar",
			"roar_2"
		}
	},
	melee_slam = {
		stagger_distance = 7,
		height = 2.5,
		forward_offset = 1.75,
		cooldown = -1,
		fatigue_type = "blocked_slam",
		radius = 1.2,
		damage_type = "cutting",
		player_push_speed = 8,
		action_weight = 1,
		player_push_speed_blocked = 4,
		unblockable = false,
		attack_time = 1.75,
		dodge_mitigation_radius_squared = 2.25,
		attack_anim = {
			"attack_slam",
			"attack_slam_2",
			"attack_slam_3",
			"attack_slam_4"
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
			8,
			5
		},
		difficulty_damage = {
			easy = {
				8,
				6,
				5
			},
			normal = {
				15,
				8,
				5
			},
			hard = {
				20,
				10,
				5
			},
			survival_hard = {
				20,
				10,
				5
			},
			harder = {
				25,
				15,
				10
			},
			survival_harder = {
				25,
				15,
				10
			},
			hardest = {
				40,
				20,
				15
			},
			survival_hardest = {
				60,
				30,
				22.5
			}
		},
		considerations = UtilityConsiderations.melee_slam,
		stagger_impact = {
			1,
			2,
			0,
			0
		}
	},
	melee_shove = {
		shove_blocked_speed_mul = 0.6,
		shove_z_speed = 4,
		attack_anim_right_running = "attack_shove_right_run",
		cooldown = -1,
		target_running_velocity_threshold = 2,
		fatigue_type = "ogre_shove",
		stagger_distance = 3,
		damage_type = "cutting",
		attack_anim_left = "attack_shove_left",
		attack_anim_left_running = "attack_shove_left_run",
		action_weight = 1,
		shove_speed = 16,
		attack_anim_right = "attack_shove_right",
		attack_time = 2.5,
		damage = {
			20,
			20,
			20
		},
		difficulty_damage = {
			easy = {
				15,
				20,
				20
			},
			normal = {
				20,
				20,
				20
			},
			hard = {
				30,
				25,
				25
			},
			survival_hard = {
				30,
				25,
				25
			},
			harder = {
				40,
				30,
				30
			},
			survival_harder = {
				40,
				30,
				30
			},
			hardest = {
				60,
				50,
				50
			},
			survival_hardest = {
				90,
				75,
				75
			}
		},
		considerations = UtilityConsiderations.melee_shove,
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4.5,
			1,
			0,
			0
		}
	},
	fling_skaven = {
		shove_blocked_speed_mul = 0.6,
		shove_z_speed = 4,
		target_running_velocity_threshold = 2,
		cooldown = -1,
		fatigue_type = "ogre_shove",
		attack_anim_right_running = "attack_shove_right_run",
		stagger_distance = 4,
		damage_type = "cutting",
		attack_anim_left = "attack_shove_left",
		attack_anim_left_running = "attack_shove_left_run",
		shove_speed = 16,
		attack_anim_right = "attack_shove_right",
		attack_time = 1.5,
		fling_damage = 100,
		damage = {
			20,
			20,
			20
		},
		difficulty_damage = {
			easy = {
				20,
				20,
				20
			},
			normal = {
				30,
				20,
				20
			},
			hard = {
				40,
				25,
				25
			},
			survival_hard = {
				40,
				25,
				25
			},
			harder = {
				50,
				30,
				30
			},
			survival_harder = {
				50,
				30,
				30
			},
			hardest = {
				75,
				50,
				50
			},
			survival_hardest = {
				112.5,
				75,
				75
			}
		},
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4.5,
			1,
			0,
			0
		}
	},
	target_unreachable = {
		cooldown = -1,
		move_anim = "move_start_fwd"
	},
	jump_slam = {
		action_weight = 1,
		considerations = UtilityConsiderations.jump_slam
	},
	climb = {
		catapult_players = {
			speed = 7,
			radius = 2,
			collision_filter = "filter_player_hit_box_check",
			angle = math.pi/6
		}
	},
	jump_slam_impact = {
		stagger_distance = 7,
		max_damage_radius = 2.5,
		stagger_radius = 7.5,
		catapult_players = true,
		damage_type = "blunt",
		fatigue_type = "blocked_jump_slam",
		catapult_within_radius = 7,
		catapulted_player_speed = 7,
		damage = {
			5,
			0,
			0
		},
		stagger_impact = {
			1,
			2,
			0,
			0
		}
	},
	stagger = {
		scale_animation_speeds = true,
		stagger_animation_scale = 1,
		stagger_anims = {
			{
				fwd = {},
				bwd = {},
				left = {},
				right = {}
			},
			{
				fwd = {},
				bwd = {},
				left = {},
				right = {}
			},
			{
				fwd = {},
				bwd = {},
				left = {},
				right = {}
			},
			{
				fwd = {},
				bwd = {},
				left = {},
				right = {}
			},
			{
				fwd = {},
				bwd = {},
				left = {},
				right = {}
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
				fwd = {},
				bwd = {},
				left = {},
				right = {}
			}
		}
	},
	anti_ladder_melee_slam = table.clone(action_data.melee_slam)
}
action_data.anti_ladder_melee_slam.considerations = UtilityConsiderations.anti_ladder_melee_slam
BreedActions.skaven_rat_ogre = table.create_copy(BreedActions.skaven_rat_ogre, action_data)

return 
