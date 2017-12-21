local breed_data = {
	target_selection = "pick_closest_target",
	using_first_attack = true,
	run_speed = 4.8,
	awards_positive_reinforcement_message = true,
	flingable = false,
	walk_speed = 2,
	exchange_order = 3,
	animation_sync_rpc = "rpc_sync_anim_state_5",
	aoe_radius = 0.4,
	poison_resistance = 100,
	armor_category = 1,
	hit_reaction = "ai_default",
	wwise_voice_switch_group = "stormvermin_vce",
	bone_lod_level = 0,
	default_inventory_template = "rat_ogre",
	is_bot_threat = true,
	smart_targeting_outer_width = 1,
	has_running_attack = true,
	hit_effect_template = "HitEffectsSkavenGreySeer",
	smart_targeting_height_multiplier = 2.5,
	radius = 1,
	unit_template = "ai_unit_grey_seer",
	no_stagger_duration = true,
	disable_crowd_dispersion = true,
	has_inventory = true,
	perception_previous_attacker_stickyness_value = -4.5,
	smart_object_template = "special",
	bots_should_flank = true,
	headshot_coop_stamina_fatigue_type = "headshot_special",
	death_reaction = "ai_default",
	perception = "perception_all_seeing",
	player_locomotion_constrain_radius = 0.7,
	no_blood_splatter_on_damage = true,
	death_sound_event = "Play_stormvermin_die_vce",
	weapon_reach = 2,
	smart_targeting_width = 0.2,
	is_bot_aid_threat = true,
	behavior = "grey_seer",
	base_unit = "units/beings/enemies/skaven_grey_seer/chr_skaven_grey_seer",
	aoe_height = 1.7,
	size_variation_range = {
		1,
		1
	},
	ranged_shield = {
		distance = 4,
		hit_flow_event = "lua_on_shielded_hit"
	},
	animation_merge_options = {
		idle_animation_merge_options = {},
		walk_animation_merge_options = {},
		move_animation_merge_options = {}
	},
	weakspots = {
		head = true
	},
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
				"j_neck",
				"j_neck_1",
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
				"j_neck",
				"j_neck_1",
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
				"j_neck_1",
				"j_spine1",
				"j_hips"
			}
		},
		left_arm = {
			prio = 4,
			actors = {
				"c_leftshoulder",
				"c_leftarm",
				"c_leftforearm",
				"c_lefthand"
			},
			push_actors = {
				"j_spine1",
				"j_leftshoulder",
				"j_leftarm",
				"j_leftforearm"
			}
		},
		right_arm = {
			prio = 4,
			actors = {
				"c_rightshoulder",
				"c_rightarm",
				"c_rightforearm",
				"c_righthand"
			},
			push_actors = {
				"j_spine1",
				"j_rightshoulder",
				"j_rightarm",
				"j_right_forearm"
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
		c_neck1 = "j_neck_1",
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
		j_neck1 = 0.3,
		j_leftupleg = 0.2,
		j_rightshoulder = 0.3,
		j_rightarm = 0.2,
		j_righttoebase = 0.2,
		j_tail4 = 0.05,
		j_hips = 0.3,
		j_spine1 = 0.3,
		j_rightleg = 0.2,
		j_leftfoot = 0.2,
		j_leftshoulder = 0.3,
		j_tail5 = 0.05,
		j_rightupleg = 0.2,
		j_righthand = 0.2,
		j_lefttoebase = 0.2,
		j_head = 0.3,
		j_tail6 = 0.05,
		j_neck = 0.3,
		j_spine = 0.3,
		j_lefthand = 0.2,
		j_rightforearm = 0.2,
		j_tail2 = 0.05
	},
	perception_exceptions = {
		poison_well = true,
		wizard_destructible = true
	},
	max_health = {
		2000,
		2000,
		2000,
		2000,
		2000
	},
	detection_radius = math.huge,
	patrol_detection_radius = math.huge,
	death_squad_detection_radius = math.huge,
	panic_close_detection_radius_sq = math.huge,
	num_push_anims = {
		push_backward = 2
	},
	wwise_voices = {
		"low",
		"medium",
		"high"
	},
	debug_color = {
		255,
		200,
		0,
		170
	},
	run_on_spawn = AiBreedSnippets.on_grey_seer_spawn
}
Breeds.skaven_grey_seer = table.create_copy(Breeds.skaven_grey_seer, breed_data)
local action_data = {
	teleport_1 = {
		reset_damage = true,
		player_distance = 5,
		level_portal_id = 1,
		level_flow_event = "teleport_1_done",
		time_until_auto_teleport = 110
	},
	teleport_2 = {
		reset_damage = true,
		level_portal_id = 2,
		damage_threshold = 20,
		level_flow_event = "teleport_2_done",
		time_until_auto_teleport = 125
	},
	teleport_3 = {
		reset_damage = true,
		level_portal_id = 3,
		damage_threshold = 40,
		level_flow_event = "teleport_3_done",
		time_until_auto_teleport = 125
	},
	idle = {
		rotate_towards_target = false
	},
	stagger = {
		stagger_anims = {
			{
				fwd = {
					"stagger_block_light"
				},
				bwd = {
					"stagger_block_light"
				},
				left = {
					"stagger_block_light"
				},
				right = {
					"stagger_block_light"
				}
			},
			{
				fwd = {
					"stagger_block_medium"
				},
				bwd = {
					"stagger_block_medium"
				},
				left = {
					"stagger_block_medium"
				},
				right = {
					"stagger_block_medium"
				}
			},
			{
				fwd = {
					"stagger_block_heavy"
				},
				bwd = {
					"stagger_block_heavy"
				},
				left = {
					"stagger_block_heavy"
				},
				right = {
					"stagger_block_heavy"
				}
			},
			{
				fwd = {
					"stagger_block_light"
				},
				bwd = {
					"stagger_block_light"
				},
				left = {
					"stagger_block_light"
				},
				right = {
					"stagger_block_light"
				}
			},
			{
				fwd = {
					"stagger_block_light"
				},
				bwd = {
					"stagger_block_light"
				},
				left = {
					"stagger_block_light"
				},
				right = {
					"stagger_block_light"
				}
			},
			{
				fwd = {
					"stagger_block_heavy"
				},
				bwd = {
					"stagger_block_heavy"
				},
				left = {
					"stagger_block_heavy"
				},
				right = {
					"stagger_block_heavy"
				}
			},
			{
				fwd = {
					"stagger_block_light"
				},
				bwd = {
					"stagger_block_light"
				},
				left = {
					"stagger_block_light"
				},
				right = {
					"stagger_block_light"
				}
			}
		}
	}
}
BreedActions.skaven_grey_seer = table.create_copy(BreedActions.skaven_grey_seer, action_data)

return 
