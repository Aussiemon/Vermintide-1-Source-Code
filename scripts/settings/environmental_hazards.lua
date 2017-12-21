EnvironmentalHazards = {
	spike_trap = {
		enemy = {
			attack_template_name = "spike_trap"
		},
		player = {
			action_data = {
				player_push_speed = 1,
				damage_type = "cutting"
			},
			difficulty_damage = {
				easy = {
					7,
					6,
					5
				},
				normal = {
					12,
					10,
					5
				},
				hard = {
					15,
					11,
					7
				},
				harder = {
					18,
					15,
					11
				},
				hardest = {
					23,
					17,
					12
				}
			}
		}
	},
	thorn_trap = {
		enemy = {
			attack_template_name = "spike_trap"
		},
		player = {
			action_data = {
				player_push_speed = 1,
				damage_type = "cutting"
			},
			difficulty_damage = {
				easy = {
					3,
					2,
					1
				},
				normal = {
					4,
					3,
					2
				},
				hard = {
					5,
					4,
					3
				},
				harder = {
					6,
					5,
					4
				},
				hardest = {
					7,
					6,
					5
				}
			}
		}
	}
}

return 
