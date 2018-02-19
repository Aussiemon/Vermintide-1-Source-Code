return {
	storm_vermin_champion_guardbreak = {
		distance_to_target = {
			max_value = 3,
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
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		}
	},
	storm_vermin_champion_special_attack = {
		distance_to_target = {
			max_value = 10,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.21666666666666667,
				1,
				0.3,
				1,
				0.4,
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
				0.2,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		}
	},
	storm_vermin_champion_running_attack = {
		distance_to_target = {
			max_value = 4.5,
			min_value = 2,
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
		target_move_speed = {
			max_value = 4,
			blackboard_input = "target_speed_away",
			spline = {
				0,
				0,
				0.15,
				0,
				0.3,
				0.5,
				1,
				0.9966666666666667
			}
		},
		distance_to_destination = {
			max_value = 8,
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
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		},
		defensive = {
			is_condition = true,
			invert = true,
			blackboard_input = "defensive_mode_duration"
		},
		time_since_last = {
			max_value = 8,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				0.5,
				0,
				0.66,
				0.2,
				1,
				1
			}
		}
	},
	storm_vermin_champion_spin = {
		surrounding_players = {
			max_value = 4,
			blackboard_input = "surrounding_players",
			spline = {
				0,
				0,
				0.25,
				0,
				0.5,
				0.15,
				0.75,
				1,
				1,
				1
			}
		},
		time_since_last = {
			max_value = 10,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				0.5,
				0,
				0.66,
				0.2,
				1,
				1
			}
		},
		phase = {
			max_value = 1,
			blackboard_input = "spawned_allies_wave",
			spline = {
				0,
				0,
				1,
				1
			}
		}
	},
	storm_vermin_champion_lunge_attack = {
		distance_to_target = {
			max_value = 9,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.4,
				0,
				0.6,
				1,
				0.8,
				1,
				0.85,
				0,
				1,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		},
		time_since_last = {
			max_value = 10,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				0.7,
				0,
				0.9,
				1,
				1,
				1
			}
		},
		phase = {
			max_value = 1,
			blackboard_input = "spawned_allies_wave",
			spline = {
				0,
				0,
				1,
				1
			}
		},
		defensive = {
			is_condition = true,
			invert = true,
			blackboard_input = "defensive_mode_duration"
		}
	},
	storm_vermin_champion_shatter_attack = {
		distance_to_target = {
			max_value = 15,
			blackboard_input = "target_dist",
			spline = {
				0,
				1,
				0.99,
				1,
				1,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		},
		phase = {
			max_value = 3,
			blackboard_input = "current_phase",
			spline = {
				0,
				0,
				0.7,
				0,
				1,
				1
			}
		},
		defensive = {
			is_condition = true,
			invert = true,
			blackboard_input = "defensive_mode_duration"
		}
	},
	storm_vermin_champion_defensive_shatter_attack = {
		distance_to_target = {
			max_value = 9,
			blackboard_input = "target_dist",
			spline = {
				0,
				0,
				0.4,
				0,
				0.6,
				1,
				0.8,
				1,
				0.85,
				0,
				1,
				0
			}
		},
		has_line_of_sight = {
			is_condition = true,
			blackboard_input = "has_line_of_sight"
		},
		phase = {
			max_value = 2,
			blackboard_input = "current_phase",
			spline = {
				0,
				0,
				0.5,
				1,
				1,
				1
			}
		},
		defensive = {
			is_condition = true,
			blackboard_input = "defensive_mode_duration"
		}
	},
	storm_vermin_champion_spawn = {
		phase = {
			max_value = 2,
			blackboard_input = "current_phase",
			spline = {
				0,
				0,
				0.5,
				0,
				1,
				1
			}
		},
		time_since_last = {
			max_value = 2200,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				0.025,
				0,
				1,
				1
			}
		}
	},
	storm_vermin_champion_follow = {
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
		},
		defensive = {
			is_condition = true,
			invert = true,
			blackboard_input = "defensive_mode_duration"
		}
	},
	storm_vermin_champion_turn_to_face_target = {
		target_changed = {
			is_condition = true,
			blackboard_input = "target_changed"
		}
	},
	storm_vermin_champion_defensive_spin = {
		defensive = {
			is_condition = true,
			blackboard_input = "defensive_mode_duration"
		},
		time_since_last = {
			max_value = 10,
			blackboard_input = "time_since_last",
			spline = {
				0,
				0,
				0.5,
				0,
				0.66,
				0.2,
				1,
				1
			}
		},
		surrounding_players = {
			max_value = 1,
			blackboard_input = "surrounding_players",
			spline = {
				0,
				0,
				1,
				1
			}
		}
	}
}
