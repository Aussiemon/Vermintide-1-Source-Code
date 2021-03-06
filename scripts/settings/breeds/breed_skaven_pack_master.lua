local breed_data = {
	detection_radius = 12,
	target_selection = "pick_pack_master_target",
	perception = "perception_pack_master",
	run_speed = 5,
	awards_positive_reinforcement_message = true,
	flingable = false,
	has_inventory = true,
	walk_speed = 2.25,
	exchange_order = 2,
	animation_sync_rpc = "rpc_sync_anim_state_5",
	poison_resistance = 100,
	special = true,
	headshot_coop_stamina_fatigue_type = "headshot_special",
	hit_reaction = "ai_default",
	bone_lod_level = 1,
	wield_inventory_on_spawn = true,
	default_inventory_template = "pack_master",
	smart_targeting_outer_width = 0.6,
	hit_effect_template = "HitEffectsSkavenPackMaster",
	smart_targeting_height_multiplier = 3,
	radius = 1,
	unit_template = "ai_unit_pack_master",
	smart_object_template = "special",
	proximity_system_check = true,
	death_reaction = "ai_default",
	armor_category = 3,
	player_locomotion_constrain_radius = 0.7,
	weapon_reach = 5,
	smart_targeting_width = 0.2,
	is_bot_aid_threat = true,
	behavior = "pack_master",
	base_unit = "units/beings/enemies/skaven_pack_master/chr_skaven_pack_master",
	size_variation_range = {
		1,
		1
	},
	disabled = Development.setting("disable_pack_master") or false,
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
				"c_spine2",
				"c_spine",
				"c_hips",
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
				"c_backpack"
			}
		}
	},
	max_health = {
		16,
		20,
		24,
		28,
		36
	},
	allowed_layers = {
		planks = 1.5,
		ledges = 1.5,
		smoke_grenade = 10,
		jumps = 1.5,
		bot_ratling_gun_fire = 15,
		ledges_with_fence = 1.5,
		doors = 1.5,
		teleporters = 5,
		bot_poison_wind = 15,
		fire_grenade = 15
	},
	num_push_anims = {
		push_backward = 4
	},
	debug_color = {
		255,
		200,
		200,
		0
	},
	run_on_death = AiBreedSnippets.spawn_event_item_special
}
Breeds.skaven_pack_master = table.create_copy(Breeds.skaven_pack_master, breed_data)
local action_data = {
	skulk = {
		skulk_time = 1,
		skulk_time_force_attack = 10,
		melee_override_distance_sqr = 16,
		dogpile_aggro_needed = 2
	},
	follow = {
		distance_to_attack = 3,
		start_anims_name = {
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
				rad = math.pi / 2
			},
			move_start_right = {
				dir = -1,
				rad = math.pi / 2
			}
		}
	},
	grab_attack = {
		attack_anim_duration = 1,
		dodge_angle = 12.5,
		cooldown = 4,
		fatigue_type = "blocked_attack",
		dodge_distance = 4,
		damage_type = "pack_master_grab",
		unblockable = true,
		attack_anim = "attack_grab",
		damage = {
			0,
			0
		}
	},
	initial_pull = {
		pull_time = 1.733,
		cooldown = 4,
		anim = "drag_walk",
		pull_distance = 4,
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	drag = {
		time_to_damage = 1,
		cooldown = 4,
		damage_amount = 3,
		safe_hoist_dist_squared_from_humans = 100,
		hit_zone_name = "full",
		damage_type = "cutting",
		safe_hoist_max_height_differance = 1,
		anim = "drag_walk",
		force_hoist_time = 15,
		ignore_staggers = {
			true,
			true,
			true,
			true,
			true,
			false
		}
	},
	hoist = {
		cooldown = 4,
		hoist_anim_length = 3.5,
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
		attack_anim = "smash_door",
		damage = {
			5,
			5,
			5
		}
	},
	stagger = {
		scale_animation_speeds = true,
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
	}
}
BreedActions.skaven_pack_master = table.create_copy(BreedActions.skaven_pack_master, action_data)

return
