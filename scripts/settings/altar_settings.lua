AltarSettings = {
	num_traits = 4,
	token_types = {
		iron_tokens = {
			max = 999
		},
		bronze_tokens = {
			max = 999
		},
		silver_tokens = {
			max = 999
		},
		gold_tokens = {
			max = 999
		}
	},
	reroll_traits = {
		common = {
			cost = 8,
			token_type = "bronze_tokens",
			token_texture = "token_icon_02"
		},
		rare = {
			cost = 6,
			token_type = "silver_tokens",
			token_texture = "token_icon_03"
		},
		exotic = {
			cost = 5,
			token_type = "gold_tokens",
			token_texture = "token_icon_04"
		}
	},
	proc_reroll_trait = {
		common = {
			cost = 10,
			token_type = "bronze_tokens",
			token_texture = "token_icon_02"
		},
		rare = {
			cost = 8,
			token_type = "silver_tokens",
			token_texture = "token_icon_03"
		},
		exotic = {
			cost = 6,
			token_type = "gold_tokens",
			token_texture = "token_icon_04"
		}
	},
	pray_for_loot_cost = {
		plentiful = {
			specific = 40,
			token_texture = "token_icon_01",
			token_type = "iron_tokens",
			random = 25
		},
		common = {
			specific = 50,
			token_texture = "token_icon_02",
			token_type = "bronze_tokens",
			random = 30
		},
		rare = {
			specific = 55,
			token_texture = "token_icon_03",
			token_type = "silver_tokens",
			random = 35
		},
		exotic = {
			specific = 60,
			token_texture = "token_icon_04",
			token_type = "gold_tokens",
			random = 40
		}
	}
}

return 
