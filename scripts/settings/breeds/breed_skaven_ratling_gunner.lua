local breed_data = {
	perception_continuous = "perception_continuous_keep_target",
	target_selection = "pick_closest_target",
	scale_death_push = 5,
	awards_positive_reinforcement_message = true,
	hit_effect_template = "HitEffectsRatlingGunner",
	run_speed = 4,
	walk_speed = 1.9,
	exchange_order = 2,
	animation_sync_rpc = "rpc_sync_anim_state_4",
	has_inventory = true,
	poison_resistance = 100,
	armor_category = 2,
	special = true,
	weapon_reach = 2,
	bone_lod_level = 1,
	hit_reaction = "ai_default",
	no_stagger_duration = true,
	wield_inventory_on_spawn = true,
	aim_template = "ratling_gunner",
	default_inventory_template = "ratlinggun",
	smart_targeting_outer_width = 0.7,
	bots_flank_while_targeted = true,
	flingable = true,
	smart_targeting_height_multiplier = 2.1,
	headshot_coop_stamina_fatigue_type = "headshot_special",
	radius = 1,
	unit_template = "ai_unit_ratling_gunner",
	perception_previous_attacker_stickyness_value = -20,
	smart_object_template = "special",
	proximity_system_check = true,
	death_reaction = "ai_default",
	perception = "perception_all_seeing",
	player_locomotion_constrain_radius = 0.7,
	death_sound_event = "Play_enemy_vo_ratling_gunner_die",
	spawning_rule = "always_ahead",
	smart_targeting_width = 0.3,
	is_bot_aid_threat = true,
	behavior = "skaven_ratling_gunner",
	base_unit = "units/beings/enemies/skaven_ratlinggunner/chr_skaven_ratlinggunner",
	bots_should_flank = true,
	size_variation_range = {
		1.1,
		1.1
	},
	disabled = Development.setting("disable_ratling_gunner") or false,
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
		},
		aux = {
			prio = 6,
			actors = {
				"c_backpack"
			}
		}
	},
	max_health = {
		5,
		6,
		7,
		8,
		10
	},
	detection_radius = math.huge,
	num_push_anims = {
		push_backward = 2
	},
	debug_color = {
		255,
		200,
		200,
		0
	},
	line_of_sight_cast_template = {
		"c_spine1",
		"c_head",
		current_index = 1,
		c_head = false,
		c_spine1 = false
	},
	run_on_death = AiBreedSnippets.spawn_event_item_special
}
Breeds.skaven_ratling_gunner = table.create_copy(Breeds.skaven_ratling_gunner, breed_data)
local action_data = {
	move_to_players = {
		find_target_function_name = "_find_target_ratling_gunner"
	},
	lurk = {
		move_anim = "move_fwd",
		check_distance = 35,
		move_speed = breed_data.walk_speed
	},
	engage = {
		show_tutorial_message = true,
		check_distance = 20,
		max_angle_step = 2,
		move_anim = "move_fwd_run",
		min_angle_step = 0,
		move_speed = breed_data.run_speed
	},
	move_to_shoot_position = {
		move_anim = "move_fwd_run",
		move_speed = breed_data.run_speed,
		keep_target_distance = {
			15,
			20
		}
	},
	wind_up_ratling_gun = {
		wind_up_time = {
			2,
			2
		}
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
	shoot_ratling_gun = {
		afro_hit_sound = "bullet_pass_by",
		attack_template = "shot_machinegun",
		nav_obstacle_layer_name = "bot_ratling_gun_fire",
		fire_rate_at_end = 25,
		projectile_speed = 80,
		fire_rate_at_start = 10,
		angle_speed = 15,
		hit_effect = "nodecals",
		max_penetrations = 1,
		attack_anim = "attack_shoot",
		max_fire_rate_at_percentage = 0.25,
		projectile_max_range = 50,
		impact_push_speed = 1.5,
		light_weight_projectile_particle_effect = "ratling_gun_bullet",
		attack_time = {
			7,
			10
		},
		start_angle = {
			15,
			20
		},
		attack_template_damage_type = {
			"ratlinggun_easy",
			"ratlinggun_normal",
			"ratlinggun_hard",
			"ratlinggun_very_hard",
			"ratlinggun_very_hard"
		},
		spread = math.degrees_to_radians(7),
		target_switch_distance = {
			15,
			15
		},
		realign_angle = math.pi/4,
		radial_speed_feet_shooting = math.pi*0.725,
		radial_speed_upper_body_shooting = math.pi*0.35,
		line_of_fire_nav_obstacle_half_extents = Vector3Box(1, 25, 1),
		arc_of_sight_nav_obstacle_half_extents = Vector3Box(5, 5, 1),
		ignore_staggers = {
			true,
			false,
			false,
			true,
			true,
			false
		}
	},
	reload_ratling_gun = {
		reload_time = {
			1,
			2
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
					"stun_ranged_fwd"
				},
				bwd = {
					"stun_ranged_bwd"
				},
				left = {
					"stun_ranged_left"
				},
				right = {
					"stun_ranged_right"
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
BreedActions.skaven_ratling_gunner = table.create_copy(BreedActions.skaven_ratling_gunner, action_data)

return 
