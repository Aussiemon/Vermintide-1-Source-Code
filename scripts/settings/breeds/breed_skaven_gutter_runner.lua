local breed_data = {
	detection_radius = 9999999,
	target_selection = "pick_ninja_approach_target",
	walk_speed = 3,
	pounce_bonus_dmg_per_meter = 1,
	run_speed = 9,
	awards_positive_reinforcement_message = true,
	stagger_in_air_mover_check_radius = 0.2,
	flingable = true,
	has_inventory = true,
	exchange_order = 2,
	animation_sync_rpc = "rpc_sync_anim_state_3",
	default_inventory_template = "gutter_runner",
	poison_resistance = 100,
	armor_category = 1,
	allow_fence_jumping = true,
	no_stagger_duration = true,
	approaching_switch_radius = 10,
	headshot_coop_stamina_fatigue_type = "headshot_special",
	hit_reaction = "ai_default",
	jump_speed = 25,
	time_to_unspawn_after_death = 1,
	behavior = "gutter_runner",
	special = true,
	debug_flag = "ai_gutter_runner_behavior",
	smart_targeting_outer_width = 0.6,
	hit_effect_template = "HitEffectsGutterRunner",
	smart_targeting_height_multiplier = 1.6,
	radius = 1,
	bone_lod_level = 1,
	unit_template = "ai_unit_gutter_runner",
	smart_object_template = "special",
	combat_spawn_stinger = "enemy_gutterrunner_stinger",
	force_despawn = true,
	proximity_system_check = true,
	death_reaction = "gutter_runner",
	perception = "perception_all_seeing_re_evaluate",
	player_locomotion_constrain_radius = 0.7,
	jump_gravity = 9.82,
	jump_range = 20,
	smart_targeting_width = 0.3,
	is_bot_aid_threat = true,
	initial_is_passive = false,
	base_unit = "units/beings/enemies/skaven_gutter_runner/chr_skaven_gutter_runner",
	pounce_impact_damage = {
		5,
		7
	},
	perception_weights = {
		sticky_bonus = 5,
		dog_pile_penalty = -5,
		distance_weight = 10,
		max_distance = 40
	},
	size_variation_range = {
		1,
		1
	},
	max_health = {
		10,
		12,
		14,
		16,
		20
	},
	debug_class = DebugGutterRunner,
	debug_color = {
		255,
		200,
		200,
		0
	},
	disabled = Development.setting("disable_gutter_runner") or false,
	run_on_death = AiBreedSnippets.spawn_event_item_special,
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
	heroic_archetypes = {
		{
			name = "decoy",
			breed_name = "skaven_gutter_runner_decoy",
			behaviour = "gutter_runner_heroic",
			health_multiplier = 5,
			blackboard = {
				ninja_vanish_at_health_percent = 0.6666666666666666,
				ninja_vanish_at_health_percent_treshold = 0.3333333333333333
			}
		}
	}
}
local archetype_lookup = {}

for i, data in ipairs(breed_data.heroic_archetypes) do
	archetype_lookup[data.name] = i
end

breed_data.heroic_archetype_lookup = archetype_lookup
Breeds.skaven_gutter_runner = table.create_copy(Breeds.skaven_gutter_runner, breed_data)
Breeds.skaven_gutter_runner_decoy = table.create_copy(Breeds.skaven_gutter_runner_decoy, breed_data)
Breeds.skaven_gutter_runner_decoy.max_health = {
	1,
	1,
	1,
	1,
	1
}
Breeds.skaven_gutter_runner_decoy.behavior = "gutter_runner_decoy"
Breeds.skaven_gutter_runner_decoy.death_reaction = "gutter_runner_decoy"
local action_data = {
	target_pounced = {
		stab_until_target_is_killed = true,
		foff_after_pounce_complete_probability = 1,
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
	target_pounced_heroic = {
		stab_until_target_is_killed = false,
		foff_after_pounce_complete_probability = 0.5,
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
		maximum_pounce_time = 2,
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
	approaching = {
		can_throw = false,
		crosshair_dodge_delay = 1.5,
		throw_stars_probability = 0
	},
	approaching_heroic = {
		can_throw = true,
		crosshair_dodge_delay = 0.75,
		throw_stars_probability = 0.3
	},
	ninja_vanish_uninterruptable = {
		stalk_lonliest_player = true,
		foff_anim_length = 0.32,
		effect_name = "fx/chr_gutter_foff",
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			true,
			allow_push = false
		}
	},
	throw_throwing_stars = {
		light_weight_projectile_particle_effect = "throwing_star",
		collision_filter = "filter_enemy_player_ray_projectile",
		attacks = {
			{
				projectile_speed = 10,
				num_projectiles = 5,
				pattern_name = "ninja_star_arc",
				projectile_max_range = 50,
				attack_anim = "attack_shuriken"
			},
			{
				projectile_speed = 10,
				num_projectiles = 7,
				pattern_name = "ninja_star_cluster",
				projectile_max_range = 50,
				attack_anim = "attack_shuriken_roll"
			}
		},
		impact_data = {
			max_penetrations = 1,
			can_be_blocked_by_parry = true,
			afro_hit_sound = "bullet_pass_by",
			hit_effect = "nodecals",
			attack_template = "shot_machinegun"
		},
		attack_template_damage_type = {
			"ratlinggun_easy",
			"ratlinggun_normal",
			"ratlinggun_hard",
			"ratlinggun_very_hard",
			"ratlinggun_very_hard"
		}
	},
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
		damage = {
			5,
			5,
			5
		}
	},
	circle_prey = {},
	circle_prey_decoy = {
		despawn_on_outside_navmesh = true
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
