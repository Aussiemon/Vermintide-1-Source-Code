local breed_data = {
	detection_radius = 9999999,
	target_selection = "pick_ninja_approach_target",
	flingable = true,
	no_stagger_duration = true,
	awards_positive_reinforcement_message = true,
	death_reaction = "gutter_runner",
	has_inventory = true,
	run_speed = 9,
	exchange_order = 2,
	animation_sync_rpc = "rpc_sync_anim_state_3",
	walk_speed = 3,
	initial_is_passive = false,
	allow_fence_jumping = true,
	approaching_switch_radius = 10,
	hit_reaction = "ai_default",
	jump_speed = 25,
	time_to_unspawn_after_death = 1,
	bone_lod_level = 1,
	special = true,
	default_inventory_template = "gutter_runner",
	smart_targeting_outer_width = 0.6,
	hit_effect_template = "HitEffectsGutterRunner",
	smart_targeting_height_multiplier = 1.6,
	radius = 1,
	pounce_bonus_dmg_per_meter = 1,
	unit_template = "ai_unit_gutter_runner",
	debug_flag = "ai_gutter_runner_behavior",
	perception = "perception_all_seeing_re_evaluate",
	headshot_coop_stamina_fatigue_type = "headshot_special",
	combat_spawn_stinger = "enemy_gutterrunner_stinger",
	smart_object_template = "special",
	force_despawn = true,
	proximity_system_check = true,
	poison_resistance = 100,
	armor_category = 1,
	player_locomotion_constrain_radius = 0.7,
	jump_gravity = 9.82,
	jump_range = 20,
	smart_targeting_width = 0.3,
	is_bot_aid_threat = true,
	behavior = "gutter_runner",
	base_unit = "units/beings/enemies/skaven_gutter_runner/chr_skaven_gutter_runner",
	size_variation_range = {
		1,
		1
	},
	disabled = Development.setting("disable_gutter_runner") or false,
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
				"c_neck"
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
	perception_weights = {
		sticky_bonus = 5,
		dog_pile_penalty = -5,
		distance_weight = 10,
		max_distance = 40
	},
	max_health = {
		10,
		12,
		14,
		16,
		20
	},
	pounce_impact_damage = {
		5,
		7
	},
	difficulty_pounce_impact_damage = {
		easy = {
			4,
			6
		},
		normal = {
			5,
			7
		},
		hard = {
			6,
			8
		},
		survival_hard = {
			6,
			8
		},
		harder = {
			7,
			10
		},
		survival_harder = {
			7,
			10
		},
		hardest = {
			8,
			11
		},
		survival_hardest = {
			12,
			16.5
		}
	},
	difficulty_pounce_bonus_dmg_per_meter = {
		harder = 1.5,
		normal = 1,
		hard = 1.25,
		survival_hard = 1.25,
		survival_harder = 1.5,
		hardest = 2,
		survival_hardest = 2,
		easy = 0.75
	},
	num_push_anims = {
		push_backward = 1
	},
	debug_color = {
		255,
		200,
		200,
		0
	},
	debug_class = DebugGutterRunner,
	run_on_death = AiBreedSnippets.spawn_event_item_special
}
Breeds.skaven_gutter_runner = table.create_copy(Breeds.skaven_gutter_runner, breed_data)
local action_data = {
	target_pounced = {
		stab_until_target_is_killed = true,
		foff_after_pounce_kill = true,
		time_before_ramping_damage = 5,
		cooldown = 1.5,
		fatigue_type = "blocked_attack",
		far_impact_radius = 6,
		close_impact_radius = 2,
		impact_speed_given = 10,
		damage_type = "cutting",
		attack_anim = "attack_loop",
		final_damage_multiplier = 5,
		range = 1.5,
		time_to_reach_final_damage_multiplier = 10,
		move_anim = "move_fwd",
		attack_time = 1.5,
		damage = {
			1.5,
			1.5,
			1.5,
			1.5
		},
		difficulty_damage = {
			easy = {
				1,
				0.5,
				0.25
			},
			normal = {
				1.5,
				1,
				0.5
			},
			hard = {
				2,
				1,
				0.5
			},
			survival_hard = {
				2,
				1,
				0.5
			},
			harder = {
				2.5,
				1.5,
				0.5
			},
			survival_harder = {
				2.5,
				1.5,
				0.5
			},
			hardest = {
				5,
				2,
				0.5
			},
			survival_hardest = {
				7.5,
				3,
				0.75
			}
		},
		ignore_staggers = {
			true,
			false,
			false,
			true,
			false,
			false,
			allow_push = true
		}
	},
	skulking = {},
	skulk_idle = {},
	approaching = {},
	ninja_vanish = {
		stalk_lonliest_player = true,
		foff_anim_length = 0.32,
		effect_name = "fx/chr_gutter_foff"
	},
	smash_door = {
		unblockable = true,
		name = "smash_door",
		damage_type = "cutting",
		move_anim = "move_fwd",
		attack_anim = "smash_door",
		door_attack_distance = 1,
		damage = {
			5,
			5,
			5
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
BreedActions.skaven_gutter_runner = table.create_copy(BreedActions.skaven_gutter_runner, action_data)

return 
