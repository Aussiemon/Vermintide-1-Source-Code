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
	}
}

return 
