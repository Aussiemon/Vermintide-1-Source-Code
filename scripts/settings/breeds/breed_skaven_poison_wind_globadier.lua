local breed_data = {
	walk_speed = 2.75,
	run_speed = 5,
	awards_positive_reinforcement_message = true,
	poison_resistance = 100,
	armor_category = 1,
	no_stagger_duration = true,
	target_selection = "pick_closest_target",
	animation_sync_rpc = "rpc_sync_anim_state_3",
	detection_radius = 9999999,
	smart_object_template = "special",
	headshot_coop_stamina_fatigue_type = "headshot_special",
	max_globe_throw_speed = 16383,
	hit_reaction = "ai_default",
	bone_lod_level = 1,
	special = true,
	hit_effect_template = "HitEffectsPoisonWind",
	debug_flag = "ai_globadier_behavior",
	radius = 1,
	unit_template = "ai_unit_poison_wind_globadier",
	proximity_system_check = true,
	death_reaction = "poison_globadier",
	perception = "perception_all_seeing",
	player_locomotion_constrain_radius = 0.7,
	death_sound_event = "Play_globadier_death_vce",
	perception_continuous = "perception_continuous_keep_target",
	behavior = "skaven_poison_wind_globadier",
	base_unit = "units/beings/enemies/skaven_wind_globadier/chr_skaven_wind_globadier",
	max_health = {
		12,
		16,
		20,
		25,
		30
	},
	num_push_anims = {
		push_backward = 1
	},
	disabled = Development.setting("disable_globadier") or false,
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
				"c_neck",
				"c_neck1"
			},
			push_actors = {
				"j_head",
				"j_spine1"
			}
		},
		torso = {
			prio = 3,
			actors = {
				"c_hips",
				"c_spine",
				"c_spine2",
				"c_leftshoulder",
				"c_rightshoulder"
			},
			push_actors = {
				"j_spine1"
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
				"c_leftleg",
				"c_leftupleg",
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
				"c_rightleg",
				"c_rightupleg",
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
	allowed_layers = {
		planks = 1.5,
		ledges = 5,
		smoke_grenade = 4,
		jumps = 5,
		bot_ratling_gun_fire = 10,
		ledges_with_fence = 5,
		doors = 1.5,
		teleporters = 5,
		bot_poison_wind = 2,
		fire_grenade = 10
	},
	debug_class = DebugGlobadier,
	debug_color = {
		255,
		200,
		200,
		0
	}
}
Breeds.skaven_poison_wind_globadier = table.create_copy(Breeds.skaven_poison_wind_globadier, breed_data)
local GLOBE_RADIUS = 4
local action_data = {
	skulk_approach = {
		decrease_radius_speed = 0.5,
		commit_distance = 40,
		skulk_init_distance = 50
	},
	move_to_players = {
		find_target_function_name = "_find_target_globadier",
		attack_distance = 25,
		attack_throw_offset = {
			0.1281,
			1.1719,
			1.3749
		}
	},
	advance_towards_players = {
		ignore_LOS_check_after_first_throw = false,
		range = 40,
		exit_to_skulk_distance = 45,
		slot_count_distance_modifier = 1,
		slot_count_time_modifier = -0.5,
		time_before_throw_distance_modifier = 2,
		time_until_first_throw = {
			0,
			1
		},
		keep_target_distance = {
			15,
			20
		},
		throw_at_distance = {
			10,
			25
		},
		throw_at_distance_first_time = {
			8,
			35
		},
		attack_throw_offset = {
			0.1281,
			1.1719,
			1.3749
		},
		radius = GLOBE_RADIUS
	},
	throw_poison_globe = {
		duration = 9,
		aoe_dot_damage_interval = 1,
		nav_tag_volume_layer = "bot_poison_wind",
		create_nav_tag_volume = true,
		damage_type = "poison",
		weapon_node_name = "j_rightweaponattach",
		attack_time = 1.44,
		attack_anim = "attack_throw",
		aoe_init_damage = {
			{
				0,
				1,
				0
			},
			{
				0,
				1,
				0
			},
			{
				5,
				1,
				0
			},
			{
				7,
				1,
				0
			},
			{
				10,
				1,
				0
			}
		},
		aoe_dot_damage = {
			{
				2,
				0,
				0
			},
			{
				4,
				0,
				0
			},
			{
				6,
				0,
				0
			},
			{
				8,
				0,
				0
			},
			{
				15,
				0,
				0
			}
		},
		radius = GLOBE_RADIUS,
		time_between_throws = {
			1,
			3
		}
	},
	observe_poison_wind = {
		action_weight = 1
	},
	smash_door = {
		unblockable = true,
		name = "smash_door",
		damage_type = "cutting",
		move_anim = "move_fwd",
		attack_anim = "smash_door",
		damage = {
			5,
			5,
			5
		}
	},
	suicide_run = {
		suicide_explosion_timer = 8,
		radius = 4,
		action_weight = 10,
		nav_tag_volume_layer = "bot_poison_wind",
		distance_to_explode = 1.5,
		create_nav_tag_volume = true,
		damage_type = "poison",
		duration = 3,
		aoe_dot_damage_interval = 1,
		aoe_init_damage = {
			{
				10,
				3,
				0
			},
			{
				15,
				3,
				0
			},
			{
				20,
				3,
				0
			},
			{
				25,
				3,
				0
			},
			{
				40,
				3,
				0
			}
		},
		aoe_dot_damage = {
			{
				2,
				0,
				0
			},
			{
				4,
				0,
				0
			},
			{
				6,
				0,
				0
			},
			{
				8,
				0,
				0
			},
			{
				10,
				0,
				0
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
			},
			{
				fwd = {
					"stun_fwd_ranged_light"
				},
				bwd = {
					"stun_bwd_ranged_light"
				},
				left = {
					"stun_left_ranged_light"
				},
				right = {
					"stun_right_ranged_light"
				}
			},
			{
				fwd = {
					"stun_fwd_sword"
				},
				bwd = {
					"stun_bwd_stab"
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
	}
}
BreedActions.skaven_poison_wind_globadier = table.create_copy(BreedActions.skaven_poison_wind_globadier, action_data)

return 
