OutlineSettings = OutlineSettings or {}
OutlineSettings.colors = {
	ally = {
		variable = "outline_color_alpha",
		outline_multiplier = 2,
		pulse_multiplier = 50,
		pulsate = false,
		outline_multiplier_variable = "outline_multiplier_alpha",
		channel = {
			255,
			0,
			0,
			0
		},
		color = {
			255,
			118,
			186,
			0
		}
	},
	knocked_down = {
		variable = "outline_color_red",
		outline_multiplier = 3,
		pulse_multiplier = 50,
		pulsate = false,
		outline_multiplier_variable = "outline_multiplier_red",
		channel = {
			0,
			255,
			0,
			0
		},
		color = {
			255,
			227,
			4,
			4
		}
	},
	interactable = {
		variable = "outline_color_green",
		outline_multiplier = 2,
		pulse_multiplier = 50,
		pulsate = false,
		outline_multiplier_variable = "outline_multiplier_green",
		channel = {
			0,
			0,
			255,
			0
		},
		color = {
			255,
			225,
			235,
			123
		}
	},
	player_attention = {
		variable = "outline_color_blue",
		outline_multiplier = 3,
		pulse_multiplier = 15,
		pulsate = true,
		outline_multiplier_variable = "outline_multiplier_blue",
		channel = {
			0,
			0,
			0,
			255
		},
		color = {
			255,
			30,
			150,
			255
		}
	}
}
OutlineSettings.ranges = {
	pickup = 10,
	elevators = 10,
	doors = 10,
	objective = 100,
	player_husk = 60
}

return 
