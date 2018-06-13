SmartObjectSettings = {
	jump_up_max_height = 4.7,
	templates = {}
}
SmartObjectSettings.templates.fallback = {
	jump_up_anim_thresholds = {
		{
			horizontal_length = 1,
			animation_fence = "jump_up_1m",
			height_threshold = 1.5,
			vertical_length = 1,
			animation_edge = "jump_up_1m"
		},
		{
			horizontal_length = 1,
			animation_fence = "jump_up_3m",
			vertical_length = 3,
			animation_edge = "jump_up_3m",
			height_threshold = math.huge
		}
	},
	jump_down_anim_thresholds = {
		{
			animation_edge = "jump_down",
			animation_fence = "jump_down",
			height_threshold = 1.5,
			vertical_length = 1,
			fence_horizontal_length = 1.5,
			fence_land_length = 0
		},
		{
			animation_edge = "jump_down",
			animation_fence = "jump_down",
			vertical_length = 3,
			fence_horizontal_length = 1.1,
			fence_land_length = 0.4,
			height_threshold = math.huge
		}
	}
}
SmartObjectSettings.templates.default_clan_rat = {
	jump_up_anim_thresholds = {
		{
			horizontal_length = 1,
			height_threshold = 1.5,
			vertical_length = 1,
			animation_edge = {
				"jump_up_1m",
				"jump_up_1m_2"
			},
			animation_fence = {
				"jump_up_fence_1m",
				"jump_up_fence_1m_2"
			}
		},
		{
			horizontal_length = 1,
			height_threshold = 4,
			vertical_length = 3,
			animation_edge = {
				"jump_up_3m",
				"jump_up_3m_2"
			},
			animation_fence = {
				"jump_up_fence_3m",
				"jump_up_fence_3m_2"
			}
		},
		{
			horizontal_length = 1,
			animation_fence = "jump_up_fence_5m",
			vertical_length = 5,
			height_threshold = math.huge,
			animation_edge = {
				"jump_up_5m",
				"jump_up_5m_2"
			}
		}
	},
	jump_down_anim_thresholds = {
		{
			animation_edge = "jump_down_1m",
			animation_fence = "jump_down_fence_1m",
			height_threshold = 1.5,
			vertical_length = 1,
			fence_horizontal_length = 1.5,
			fence_land_length = 0
		},
		{
			animation_fence = "jump_down_fence_3m",
			height_threshold = 4,
			vertical_length = 3,
			fence_horizontal_length = 1.1,
			fence_land_length = 0.4,
			animation_edge = {
				"jump_down",
				"jump_down_2"
			}
		},
		{
			animation_fence = "jump_down_fence_5m",
			vertical_length = 5,
			fence_horizontal_length = 1.1,
			fence_land_length = 0.4,
			height_threshold = math.huge,
			animation_edge = {
				"jump_down",
				"jump_down_2"
			}
		}
	}
}
SmartObjectSettings.templates.special = {
	jump_up_anim_thresholds = {
		{
			horizontal_length = 1,
			animation_fence = "jump_up_fence_1m",
			height_threshold = 1.5,
			vertical_length = 1,
			animation_edge = "jump_up_1m"
		},
		{
			horizontal_length = 1,
			animation_fence = "jump_up_fence_3m",
			vertical_length = 3,
			animation_edge = "jump_up_3m",
			height_threshold = math.huge
		}
	},
	jump_down_anim_thresholds = {
		{
			animation_edge = "jump_down_1m",
			animation_fence = "jump_down_fence_1m",
			height_threshold = 1.5,
			vertical_length = 1,
			fence_horizontal_length = 1.5,
			fence_land_length = 0
		},
		{
			animation_edge = "jump_down",
			animation_fence = "jump_down_fence_3m",
			vertical_length = 3,
			fence_horizontal_length = 1.1,
			fence_land_length = 0.4,
			height_threshold = math.huge
		}
	}
}
SmartObjectSettings.templates.rat_ogre = {
	jump_up_anim_thresholds = {
		{
			horizontal_length = 2,
			animation_fence = "jump_up_fence_1m",
			height_threshold = 1.5,
			vertical_length = 1,
			animation_edge = "jump_up_1m"
		},
		{
			fence_vertical_length = 3,
			animation_edge = "jump_up_2m",
			animation_fence = "jump_up_fence_3m",
			height_threshold = 2.5,
			vertical_length = 2.5,
			horizontal_length = 2
		},
		{
			horizontal_length = 2,
			animation_fence = "jump_up_fence_3m",
			height_threshold = 3.5,
			vertical_length = 3.5,
			animation_edge = "jump_up_3m"
		},
		{
			fence_vertical_length = 3,
			animation_edge = "jump_up_4m",
			animation_fence = "jump_up_fence_3m",
			vertical_length = 5,
			horizontal_length = 2,
			height_threshold = math.huge
		}
	},
	jump_down_anim_thresholds = {
		{
			animation_edge = "jump_down",
			animation_fence = "jump_down_fence_1m",
			height_threshold = 1.5,
			vertical_length = 1,
			fence_horizontal_length = 1.5,
			fence_land_length = 0
		},
		{
			animation_edge = "jump_down",
			animation_fence = "jump_down_fence_3m",
			vertical_length = 3,
			fence_horizontal_length = 1.1,
			fence_land_length = 0.4,
			height_threshold = math.huge
		}
	}
}

return
