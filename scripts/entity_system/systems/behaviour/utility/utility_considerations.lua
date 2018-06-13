UtilityConsiderations = {
	clan_rat_first_attack = {
		distance_to_target = {
			max_value = 8,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.3466666666666667,
				0,
				0.36666666666666664,
				1,
				0.48,
				1,
				0.53,
				0,
				1,
				0
			}
		},
		first_attack_cooldown = {
			max_value = 10,
			blackboard_input = "time_since_last_first_attack",
			spline = {
				0,
				0,
				0.4,
				0,
				0.8,
				1,
				1,
				1
			}
		},
		move_speed = {
			max_value = 10,
			blackboard_input = "move_speed",
			spline = {
				0,
				0,
				0.4066666666666667,
				0,
				0.58,
				1,
				1,
				0.9966666666666667
			}
		},
		have_slot = {
			max_value = 1,
			blackboard_input = "have_slot",
			spline = {
				0,
				0,
				0.5033333333333333,
				0,
				1,
				1
			}
		},
		attacks_done = {
			max_value = 1,
			blackboard_input = "attacks_done",
			spline = {
				0,
				1,
				0.5033333333333333,
				0,
				1,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		},
		attack_cooldown = {
			is_condition = true,
			invert = true,
			blackboard_input = "is_in_attack_cooldown"
		}
	},
	clan_rat_follow = {
		distance_to_destination = {
			max_value = 5,
			blackboard_input = "destination_dist",
			spline = {
				0,
				0,
				0.11333333333333333,
				0,
				0.15,
				1,
				1,
				1
			}
		},
		distance_to_target = {
			max_value = 10,
			blackboard_input = "target_dist",
			spline = {
				0,
				1e-05,
				0.2,
				1e-05,
				0.21,
				1,
				1,
				1
			}
		},
		no_path_found = {
			is_condition = true,
			invert = true,
			blackboard_input = "no_path_found"
		}
	},
	advance_towards_players = {
		distance_to_target = {
			max_value = 30,
			blackboard_input = "target_dist",
			spline = {
				0,
				0.9966666666666667,
				0.26,
				1,
				0.32666666666666666,
				0.25333333333333335,
				0.45,
				0.11333333333333333,
				0.5733333333333334,
				0.24666666666666667,
				0.6366666666666667,
				1,
				1,
				1
			}
		}
	},
	storm_vermin_special_attack = {
		distance_to_target = {
			max_value = 4,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.21666666666666667,
				0,
				0.47333333333333333,
				1,
				0.6333333333333333,
				1,
				0.7866666666666666,
				0,
				1,
				0
			}
		},
		special_attack = {
			max_value = 15,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				1,
				1
			}
		},
		target_move_speed = {
			max_value = 10,
			blackboard_input = "target_speed_away",
			spline = {
				0,
				1,
				0.14,
				1,
				0.15,
				0,
				1,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		}
	},
	player_bot_default_shoot = {
		distance_to_target = {
			max_value = 20,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.04,
				0,
				0.2,
				1,
				1,
				1
			}
		}
	},
	clan_rat_running_attack = {
		distance_to_target = {
			max_value = 4,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.15,
				0,
				0.35,
				0.5,
				0.55,
				0.75,
				1,
				0
			}
		},
		have_slot = {
			max_value = 1,
			blackboard_input = "have_slot",
			spline = {
				0,
				0,
				0.5033333333333333,
				0,
				1,
				1
			}
		},
		target_move_speed = {
			max_value = 10,
			blackboard_input = "target_speed_away",
			spline = {
				0,
				0,
				0.19,
				0.25,
				0.4,
				0.5,
				1,
				0.9966666666666667
			}
		},
		distance_to_destination = {
			max_value = 5,
			blackboard_input = "destination_dist",
			spline = {
				0,
				0,
				0.2,
				0,
				0.21,
				1,
				1,
				1
			}
		},
		attack_cooldown = {
			is_condition = true,
			invert = true,
			blackboard_input = "is_in_attack_cooldown"
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		}
	},
	storm_vermin_running_attack = {
		distance_to_target = {
			max_value = 8,
			blackboard_input = "target_dist",
			spline = {
				0,
				1,
				0.2,
				0.9966666666666667,
				0.30666666666666664,
				0,
				1,
				0
			}
		},
		have_slot = {
			max_value = 1,
			blackboard_input = "have_slot",
			spline = {
				0,
				0,
				0.5033333333333333,
				0,
				1,
				1
			}
		},
		target_move_speed = {
			max_value = 10,
			blackboard_input = "target_speed_away",
			spline = {
				0,
				0,
				0.14333333333333334,
				0.0033333333333333335,
				0.26666666666666666,
				1,
				1,
				0.9966666666666667
			}
		}
	},
	jump_slam = {
		distance_to_target = {
			max_value = 25,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.12,
				0,
				0.12333333333333334,
				0.15333333333333332,
				0.37,
				0.2,
				0.5466666666666666,
				1,
				0.6233333333333333,
				1,
				0.6266666666666667,
				0.0033333333333333335,
				1,
				0
			}
		},
		chasing_timer = {
			max_value = 25,
			blackboard_input = "chasing_timer",
			spline = {
				0,
				0,
				0.12,
				0,
				0.36333333333333334,
				1,
				1,
				1
			}
		}
	},
	melee_shove = {
		distance_to_target = {
			max_value = 5,
			blackboard_input = "target_dist",
			spline = {
				0,
				1,
				0.5233333333333333,
				1,
				0.6,
				0,
				1,
				0
			}
		},
		shove_opportunity = {
			is_condition = true,
			blackboard_input = "shove_opportunity"
		},
		target_is_not_downed = {
			is_condition = true,
			blackboard_input = "target_is_not_downed"
		}
	},
	clan_rat_shout = {
		distance_to_target = {
			max_value = 15,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.11,
				0.03,
				0.30333333333333334,
				0.04,
				0.7466666666666667,
				0.09333333333333334,
				0.9166666666666666,
				0.1,
				0.9466666666666667,
				0.10333333333333333,
				1,
				0.11333333333333333
			}
		},
		distance_to_destination = {
			max_value = 3,
			blackboard_input = "destination_dist",
			spline = {
				0,
				0.9133333333333333,
				0.03333333333333333,
				0.9133333333333333,
				0.08666666666666667,
				0.6,
				0.15,
				0.34,
				0.22666666666666666,
				0.17666666666666667,
				0.38,
				0.05333333333333334,
				1,
				0
			}
		},
		wait_slot_distance = {
			max_value = 10,
			blackboard_input = "wait_slot_distance",
			spline = {
				0,
				0.9933333333333333,
				0.39666666666666667,
				0,
				1,
				0
			}
		}
	},
	clan_rat_attack = {
		distance_to_slot_position = {
			max_value = 1.5,
			min_value = -1.5,
			blackboard_input = "slot_dist_z",
			spline = {
				0,
				0,
				0.05,
				1,
				0.95,
				1,
				1,
				0
			}
		},
		distance_to_target_flat_sq = {
			max_value = 13,
			blackboard_input = "target_dist_xy_sq",
			spline = {
				0,
				0,
				0.0255212,
				0,
				0.2018769,
				1,
				0.3392308,
				1,
				0.606528,
				0,
				0.8437957,
				0,
				1,
				0
			}
		},
		distance_to_target_height = {
			max_value = 3.75,
			min_value = -2.9,
			blackboard_input = "target_dist_z",
			spline = {
				0,
				0,
				0.01,
				1,
				0.99,
				1,
				1,
				0
			}
		},
		target_move_speed = {
			max_value = 10,
			blackboard_input = "target_speed_away",
			spline = {
				0,
				1,
				0.14,
				1,
				0.15,
				0,
				1,
				0
			}
		},
		attack_cooldown = {
			is_condition = true,
			invert = true,
			blackboard_input = "is_in_attack_cooldown"
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		}
	},
	improve_slot_position = {
		distance_to_prefered_slot = {
			max_value = 10,
			blackboard_input = "distance_to_prefered_slot",
			spline = {
				0,
				0.006666666666666667,
				0.07666666666666666,
				0.08,
				0.36,
				0.83,
				0.5633333333333334,
				0.95,
				0.7033333333333334,
				0.96,
				0.7866666666666666,
				0.9633333333333334,
				1,
				1
			}
		}
	},
	dummy_action = {
		dummy_consideration = {
			max_value = 1,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				1,
				0
			}
		}
	},
	player_bot_default_combat = {
		distance_to_target = {
			max_value = 20,
			blackboard_input = "target_dist",
			spline = {
				0,
				1,
				0.25,
				0.25,
				0.75,
				0,
				1,
				0
			}
		}
	},
	player_bot_default_follow = {
		distance_to_target = {
			max_value = 40,
			blackboard_input = "ally_distance",
			spline = {
				0,
				0.1,
				0.25,
				0.2,
				0.75,
				1,
				1,
				1
			}
		}
	},
	follow = {
		distance_to_target = {
			max_value = 20,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.04,
				0,
				0.2,
				1,
				1,
				1
			}
		}
	},
	storm_vermin_push_attack = {
		distance_to_target = {
			max_value = 4,
			blackboard_input = "target_dist",
			spline = {
				0,
				1,
				0.2966666666666667,
				1,
				0.45,
				0,
				1,
				0
			}
		},
		push_attack = {
			max_value = 15,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				1,
				1
			}
		},
		target_move_speed = {
			max_value = 10,
			blackboard_input = "target_speed_away",
			spline = {
				0,
				1,
				0.14,
				1,
				0.15,
				0,
				1,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		}
	},
	melee_slam = {
		distance_to_target = {
			max_value = 5,
			blackboard_input = "target_dist",
			spline = {
				0,
				1,
				0.5233333333333333,
				1,
				0.6,
				0,
				1,
				0
			}
		}
	},
	anti_ladder_melee_slam = {
		distance_to_ladder = {
			max_value = 5,
			blackboard_input = "ladder_distance",
			spline = {
				0,
				1,
				0.5233333333333333,
				1,
				0.6,
				0,
				1,
				0
			}
		}
	}
}

return
