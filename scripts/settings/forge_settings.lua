ForgeSettings = {
	num_traits = 4,
	trait_steps = 20,
	token_type_tooltips = {
		iron_tokens = "forge_screen_plentiful_token_tooltip",
		silver_tokens = "forge_screen_rare_token_tooltip",
		bronze_tokens = "forge_screen_common_token_tooltip",
		gold_tokens = "forge_screen_exotic_token_tooltip"
	},
	rarity_colors = {
		common = "green",
		plentiful = "dark_slate_gray",
		exotic = "yellow",
		rare = "purple",
		unique = "red"
	},
	rarity_to_token_type = {
		common = "bronze_tokens",
		plentiful = "iron_tokens",
		rare = "silver_tokens",
		exotic = "gold_tokens"
	},
	token_type_to_upgrade = {
		common = "iron_tokens",
		exotic = "silver_tokens",
		rare = "bronze_tokens",
		unique = "gold_tokens"
	},
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
	token_textures_by_type = {
		iron_tokens = "token_icon_01",
		silver_tokens = "token_icon_03",
		bronze_tokens = "token_icon_02",
		gold_tokens = "token_icon_04"
	},
	token_large_textures_by_type = {
		iron_tokens = "token_icon_01_large",
		silver_tokens = "token_icon_03_large",
		bronze_tokens = "token_icon_02_large",
		gold_tokens = "token_icon_04_large"
	},
	trait_unlock_cost = {
		common = {
			token_type = "iron_tokens",
			token_texture = "token_icon_01",
			cost = {
				8,
				16,
				24
			}
		},
		rare = {
			token_type = "bronze_tokens",
			token_texture = "token_icon_02",
			cost = {
				9,
				18,
				27
			}
		},
		exotic = {
			token_type = "silver_tokens",
			token_texture = "token_icon_03",
			cost = {
				10,
				20,
				30
			}
		},
		unique = {
			token_type = "gold_tokens",
			token_texture = "token_icon_04",
			cost = {
				13,
				26,
				39
			}
		}
	},
	merge_cost = {
		plentiful = {
			token_type = "iron_tokens",
			token_texture = "token_icon_01",
			cost = {
				20,
				60,
				120,
				200
			}
		},
		common = {
			token_type = "bronze_tokens",
			token_texture = "token_icon_02",
			cost = {
				25,
				75,
				150,
				250
			}
		},
		rare = {
			token_type = "silver_tokens",
			token_texture = "token_icon_03",
			cost = {
				30,
				90,
				180,
				300
			}
		}
	},
	melt_reward = {
		plentiful = {
			token_texture = "token_icon_01",
			min = 15,
			token_type = "iron_tokens",
			max = 25
		},
		common = {
			token_texture = "token_icon_02",
			min = 15,
			token_type = "bronze_tokens",
			max = 25
		},
		rare = {
			token_texture = "token_icon_03",
			min = 15,
			token_type = "silver_tokens",
			max = 25
		},
		exotic = {
			token_texture = "token_icon_04",
			min = 15,
			token_type = "gold_tokens",
			max = 25
		},
		unique = {
			token_texture = "token_icon_04",
			min = 30,
			token_type = "gold_tokens",
			max = 50
		}
	}
}

return 
