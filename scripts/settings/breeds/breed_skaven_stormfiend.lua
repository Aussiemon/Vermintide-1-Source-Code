local breed_data = {
	detection_radius = 9999999,
	has_inventory = true,
	no_stagger_duration = true,
	awards_positive_reinforcement_message = true,
	perception = "perception_rat_ogre",
	death_reaction = "ai_default",
	smart_object_template = "rat_ogre",
	target_selection = "pick_rat_ogre_target_with_weights",
	exchange_order = 1,
	animation_sync_rpc = "rpc_sync_anim_state_7",
	jump_slam_gravity = 19,
	reach_distance = 3,
	run_speed = 8,
	walk_speed = 5,
	aoe_radius = 1,
	hit_reaction = "ai_default",
	use_aggro = true,
	bone_lod_level = 0,
	default_inventory_template = "rat_ogre",
	smart_targeting_outer_width = 1.4,
	hit_effect_template = "HitEffectsRatOgre",
	smart_targeting_height_multiplier = 2,
	radius = 2,
	unit_template = "ai_unit_rat_ogre",
	combat_spawn_stinger = "enemy_ratogre_stinger",
	use_avoidance = false,
	proximity_system_check = true,
	poison_resistance = 100,
	armor_category = 3,
	player_locomotion_constrain_radius = 1.5,
	far_off_despawn_immunity = true,
	trigger_dialogue_on_target_switch = true,
	smart_targeting_width = 0.6,
	perception_continuous = "perception_continuous_rat_ogre",
	behavior = "ogre",
	base_unit = "units/beings/enemies/skaven_stormfiend/chr_skaven_stormfiend",
	aoe_height = 2.4,
	hit_zones = {
		full = {
			prio = 1,
			actors = {}
		},
		head = {
			prio = 1,
			actors = {
				"c_head",
				"c_packmaster_sling_02"
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
				"c_leftforearm"
			},
			push_actors = {
				"j_spine1"
			}
		},
		right_arm = {
			prio = 4,
			actors = {
				"c_rightarm",
				"c_rightforearm"
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
		},
		aux = {
			prio = 6,
			actors = {
				"c_packmaster_sling"
			}
		}
	},
	perception_weights = {
		target_catapulted_mul = 0.1,
		target_stickyness_bonus_b = 10,
		targeted_by_other_special = -10,
		target_stickyness_duration_a = 5,
		target_stickyness_duration_b = 20,
		aggro_decay_per_sec = 1,
		target_outside_navmesh_mul = 0.7,
		max_distance = 50,
		target_stickyness_bonus_a = 50,
		distance_weight = 20,
		target_disabled_mul = 0.15
	},
	max_health = {
		500,
		600,
		600,
		600,
		800
	},
	num_push_anims = {},
	run_on_spawn = function (unit, blackboard)
		blackboard.cycle_rage_anim_index = 1

		return 
	end,
	debug_color = {
		255,
		20,
		20,
		20
	}
}
Breeds.skaven_stormfiend = table.create_copy(Breeds.skaven_stormfiend, breed_data)
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
		}
	},
	target_rage = {
		move_anim = "move_start_fwd",
		change_target_fwd_close_dist = 15,
		rage_time = 2.5,
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
		forward_offset = 1.5,
		radius = 1.5,
		cooldown = -1,
		player_push_speed = 8,
		fatigue_type = "blocked_slam",
		action_weight = 1,
		player_push_speed_blocked = 4,
		damage_type = "cutting",
		unblockable = true,
		attack_time = 1.5,
		attack_anim = "attack_slam",
		damage = {
			10,
			10,
			10,
			10
		},
		considerations = UtilityConsiderations.melee_slam
	},
	melee_shove = {
		attack_anim_right_running = "attack_shove_right_run",
		attack_anim_left_running = "attack_shove_left_run",
		shove_blocked_speed = 6,
		cooldown = -1,
		target_running_velocity_threshold = 1,
		fatigue_type = "blocked_shove",
		action_weight = 1,
		shove_speed = 8,
		damage_type = "cutting",
		attack_anim_right = "attack_shove_right",
		attack_anim_left = "attack_shove_left",
		attack_time = 1.5,
		shove_z_speed = 4,
		damage = {
			20,
			20,
			20
		},
		considerations = UtilityConsiderations.melee_shove
	},
	target_unreachable = {
		cooldown = -1,
		move_anim = "move_start_fwd"
	},
	jump_slam = {
		action_weight = 1,
		considerations = UtilityConsiderations.jump_slam
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
	}
}
BreedActions.skaven_stormfiend = table.create_copy(BreedActions.skaven_stormfiend, action_data)

return 
