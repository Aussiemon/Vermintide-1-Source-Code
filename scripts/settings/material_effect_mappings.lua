MaterialEffectSettings = {
	material_query_depth = 0.4,
	blood_splat_raycast_max_range = 3,
	footstep_raycast_offset = 0.4,
	footstep_raycast_max_range = 0.6,
	material_contexts = {
		surface_material = {
			"armored",
			"cloth",
			"dirt",
			"flesh",
			"fruit",
			"forest_grass",
			"glass",
			"grass",
			"hay",
			"ice",
			"metal_solid",
			"metal_hollow",
			"mud",
			"fruit",
			"plaster",
			"sand",
			"stone",
			"stone_dirt",
			"stone_wet",
			"snow",
			"water",
			"wood_bridge",
			"wood_solid",
			"wood_hollow"
		}
	}
}
DefaultSurfaceMaterial = "stone"
MaterialEffectMappings = MaterialEffectMappings or {}
MaterialEffectMappings.melee_hit_piercing = MaterialEffectMappings.melee_hit_piercing or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.1,
			width = 0.1,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			event = "melee_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "piercing"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "melee_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "melee_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "melee_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "melee_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "melee_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "melee_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "melee_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "melee_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		fruit = "fx/hit_fruit_pierce",
		dirt = "fx/hit_dirt_pierce",
		stone = "fx/hit_stone_pierce",
		water = "fx/hit_snow_pierce",
		wood_bridge = "fx/hit_wood_hollow_pierce",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_pierce",
		stone_dirt = "fx/hit_stone_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow_pierce",
		ice = "fx/hit_ice_pierce",
		forest_grass = "fx/hit_grass_pierce",
		grass = "fx/hit_grass_pierce",
		hay = "fx/hit_hay_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		stone_wet = "fx/hit_stone_pierce",
		mud = "fx/hit_dirt_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		metal_solid = "fx/hit_metal_solid_pierce",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	}
}
MaterialEffectMappings.melee_hit_slashing = MaterialEffectMappings.melee_hit_slashing or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			dirt = "hit_dirt_slash_1",
			stone = "hit_stone_slash_1",
			water = "empty",
			glass = "hit_glass_slash_1",
			sand = "hit_sand_slash_1",
			stone_dirt = "hit_stone_slash_1",
			snow = "hit_snow_slash_1",
			ice = "hit_ice_slash_1",
			forest_grass = "hit_grass_slash_1",
			grass = "hit_grass_slash_1",
			hay = "empty",
			stone_wet = "hit_stone_slash_1",
			mud = "hit_dirt_slash_1",
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_2"
			},
			flesh = {
				"hit_flesh_slash_1",
				"hit_flesh_slash_2",
				"hit_flesh_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			armored = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			},
			wood_bridge = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_solid = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_hollow = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			}
		},
		settings = {
			depth = 2,
			height = 2,
			width = 1,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "melee_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "slashing"
			}
		},
		dirt = {
			event = "melee_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "slashing"
			}
		},
		flesh = {
			event = "melee_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "slashing"
			}
		},
		fruit = {
			event = "melee_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "slashing"
			}
		},
		forest_grass = {
			event = "melee_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "slashing"
			}
		},
		glass = {
			event = "melee_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "slashing"
			}
		},
		grass = {
			event = "melee_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		hay = {
			event = "melee_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "slashing"
			}
		},
		ice = {
			event = "melee_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "slashing"
			}
		},
		metal_hollow = {
			event = "melee_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		armored = {
			event = "melee_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		metal_solid = {
			event = "melee_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "slashing"
			}
		},
		mud = {
			event = "melee_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "slashing"
			}
		},
		plaster = {
			event = "melee_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "slashing"
			}
		},
		sand = {
			event = "melee_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		stone = {
			event = "melee_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "slashing"
			}
		},
		stone_dirt = {
			event = "melee_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "slashing"
			}
		},
		stone_wet = {
			event = "melee_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "slashing"
			}
		},
		snow = {
			event = "melee_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "slashing"
			}
		},
		water = {
			event = "melee_hit_statics",
			parameters = {
				material = "water",
				damage_type = "slashing"
			}
		},
		wood_bridge = {
			event = "melee_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "slashing"
			}
		},
		wood_hollow = {
			event = "melee_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "slashing"
			}
		},
		wood_solid = {
			event = "melee_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "slashing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		fruit = "fx/hit_fruit_slash",
		dirt = "fx/hit_dirt_slash",
		stone = "fx/hit_stone_slash",
		water = "fx/hit_water_slash",
		wood_bridge = "fx/hit_wood_hollow_slash",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_slash",
		stone_dirt = "fx/hit_stone_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow_slash",
		ice = "fx/hit_ice_slash",
		forest_grass = "fx/hit_grass_slash",
		grass = "fx/hit_grass_slash",
		hay = "fx/hit_hay_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		stone_wet = "fx/hit_stone_slash",
		mud = "fx/hit_dirt_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		metal_solid = "fx/hit_metal_solid_slash",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_sword_2h = MaterialEffectMappings.melee_hit_sword_2h or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			dirt = "hit_dirt_slash_1",
			stone = "hit_stone_slash_1",
			water = "empty",
			glass = "hit_glass_slash_1",
			sand = "hit_sand_slash_1",
			stone_dirt = "hit_stone_slash_1",
			snow = "hit_snow_slash_1",
			ice = "hit_ice_slash_1",
			forest_grass = "hit_grass_slash_1",
			grass = "hit_grass_slash_1",
			hay = "empty",
			stone_wet = "hit_stone_slash_1",
			mud = "hit_dirt_slash_1",
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_2"
			},
			flesh = {
				"hit_flesh_slash_1",
				"hit_flesh_slash_2",
				"hit_flesh_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			armored = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			},
			wood_bridge = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_solid = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_hollow = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.3,
			width = 0.3,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "slashing"
			}
		},
		dirt = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "slashing"
			}
		},
		flesh = {
			event = "sword_2h_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "slashing"
			}
		},
		fruit = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "slashing"
			}
		},
		forest_grass = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "slashing"
			}
		},
		glass = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "slashing"
			}
		},
		grass = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		hay = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "slashing"
			}
		},
		ice = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "slashing"
			}
		},
		metal_hollow = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		armored = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		metal_solid = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "slashing"
			}
		},
		mud = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "slashing"
			}
		},
		plaster = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "slashing"
			}
		},
		sand = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		stone = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "slashing"
			}
		},
		stone_dirt = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "slashing"
			}
		},
		stone_wet = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "slashing"
			}
		},
		snow = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "slashing"
			}
		},
		water = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "water",
				damage_type = "slashing"
			}
		},
		wood_bridge = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "slashing"
			}
		},
		wood_hollow = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "slashing"
			}
		},
		wood_solid = {
			event = "sword_2h_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "slashing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		fruit = "fx/hit_fruit_slash",
		dirt = "fx/hit_dirt_slash",
		stone = "fx/hit_stone_slash",
		water = "fx/hit_water_slash",
		wood_bridge = "fx/hit_wood_hollow_slash",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_slash",
		stone_dirt = "fx/hit_stone_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow_slash",
		ice = "fx/hit_ice_slash",
		forest_grass = "fx/hit_grass_slash",
		grass = "fx/hit_grass_slash",
		hay = "fx/hit_hay_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		stone_wet = "fx/hit_stone_slash",
		mud = "fx/hit_dirt_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		metal_solid = "fx/hit_metal_solid_slash",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_sword_1h = MaterialEffectMappings.melee_hit_sword_1h or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			dirt = "hit_dirt_slash_1",
			stone = "hit_stone_slash_1",
			water = "empty",
			glass = "hit_glass_slash_1",
			sand = "hit_sand_slash_1",
			stone_dirt = "hit_stone_slash_1",
			snow = "hit_snow_slash_1",
			ice = "hit_ice_slash_1",
			forest_grass = "hit_grass_slash_1",
			grass = "hit_grass_slash_1",
			hay = "empty",
			stone_wet = "hit_stone_slash_1",
			mud = "hit_dirt_slash_1",
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_2"
			},
			flesh = {
				"hit_flesh_slash_1",
				"hit_flesh_slash_2",
				"hit_flesh_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			armored = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			},
			wood_bridge = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_solid = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_hollow = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.1,
			width = 0.5,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "slashing"
			}
		},
		dirt = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "slashing"
			}
		},
		flesh = {
			event = "sword_1h_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "slashing"
			}
		},
		fruit = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "slashing"
			}
		},
		forest_grass = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "slashing"
			}
		},
		glass = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "slashing"
			}
		},
		grass = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		hay = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "slashing"
			}
		},
		ice = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "slashing"
			}
		},
		metal_hollow = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		armored = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		metal_solid = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "slashing"
			}
		},
		mud = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "slashing"
			}
		},
		plaster = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "slashing"
			}
		},
		sand = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		stone = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "slashing"
			}
		},
		stone_dirt = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "slashing"
			}
		},
		stone_wet = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "slashing"
			}
		},
		snow = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "slashing"
			}
		},
		water = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "water",
				damage_type = "slashing"
			}
		},
		wood_bridge = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "slashing"
			}
		},
		wood_hollow = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "slashing"
			}
		},
		wood_solid = {
			event = "sword_1h_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "slashing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		fruit = "fx/hit_fruit_slash",
		dirt = "fx/hit_dirt_slash",
		stone = "fx/hit_stone_slash",
		water = "fx/hit_water_slash",
		wood_bridge = "fx/hit_wood_hollow_slash",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_slash",
		stone_dirt = "fx/hit_stone_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow_slash",
		ice = "fx/hit_ice_slash",
		forest_grass = "fx/hit_grass_slash",
		grass = "fx/hit_grass_slash",
		hay = "fx/hit_hay_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		stone_wet = "fx/hit_stone_slash",
		mud = "fx/hit_dirt_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		metal_solid = "fx/hit_metal_solid_slash",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_dagger = MaterialEffectMappings.melee_hit_dagger or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			dirt = "hit_dirt_slash_1",
			stone = "hit_stone_slash_1",
			water = "empty",
			glass = "hit_glass_slash_1",
			sand = "hit_sand_slash_1",
			stone_dirt = "hit_stone_slash_1",
			snow = "hit_snow_slash_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_slash_1",
			grass = "hit_grass_slash_1",
			hay = "empty",
			stone_wet = "hit_stone_slash_1",
			mud = "hit_dirt_slash_1",
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_2"
			},
			flesh = {
				"hit_flesh_slash_1",
				"hit_flesh_slash_2",
				"hit_flesh_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			armored = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			},
			wood_bridge = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_solid = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_hollow = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.04,
			width = 0.3,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "dagger_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "slashing"
			}
		},
		dirt = {
			event = "dagger_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "slashing"
			}
		},
		flesh = {
			event = "dagger_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "slashing"
			}
		},
		fruit = {
			event = "dagger_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "slashing"
			}
		},
		forest_grass = {
			event = "dagger_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "slashing"
			}
		},
		glass = {
			event = "dagger_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "slashing"
			}
		},
		grass = {
			event = "dagger_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		hay = {
			event = "dagger_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "slashing"
			}
		},
		ice = {
			event = "dagger_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "slashing"
			}
		},
		metal_hollow = {
			event = "dagger_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		armored = {
			event = "dagger_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		metal_solid = {
			event = "dagger_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "slashing"
			}
		},
		mud = {
			event = "dagger_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "slashing"
			}
		},
		plaster = {
			event = "dagger_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "slashing"
			}
		},
		sand = {
			event = "dagger_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		stone = {
			event = "dagger_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "slashing"
			}
		},
		stone_dirt = {
			event = "dagger_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "slashing"
			}
		},
		stone_wet = {
			event = "dagger_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "slashing"
			}
		},
		snow = {
			event = "dagger_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "slashing"
			}
		},
		water = {
			event = "dagger_hit_statics",
			parameters = {
				material = "water",
				damage_type = "slashing"
			}
		},
		wood_bridge = {
			event = "dagger_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "slashing"
			}
		},
		wood_hollow = {
			event = "dagger_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "slashing"
			}
		},
		wood_solid = {
			event = "dagger_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "slashing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		fruit = "fx/hit_fruit_slash",
		dirt = "fx/hit_dirt_slash",
		stone = "fx/hit_stone_slash",
		water = "fx/hit_water_slash",
		wood_bridge = "fx/hit_wood_hollow_slash",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_slash",
		stone_dirt = "fx/hit_stone_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow_slash",
		ice = "fx/hit_ice_slash",
		forest_grass = "fx/hit_grass_slash",
		grass = "fx/hit_grass_slash",
		hay = "fx/hit_hay_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		stone_wet = "fx/hit_stone_slash",
		mud = "fx/hit_dirt_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		metal_solid = "fx/hit_metal_solid_slash",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_axes_2h = MaterialEffectMappings.melee_hit_axes_2h or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			dirt = "hit_dirt_slash_1",
			stone = "hit_stone_slash_1",
			water = "empty",
			glass = "hit_glass_slash_1",
			sand = "hit_sand_slash_1",
			stone_dirt = "hit_stone_slash_1",
			snow = "hit_snow_slash_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_slash_1",
			grass = "hit_grass_slash_1",
			hay = "empty",
			stone_wet = "hit_stone_slash_1",
			mud = "hit_dirt_slash_1",
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_2"
			},
			flesh = {
				"hit_flesh_slash_1",
				"hit_flesh_slash_2",
				"hit_flesh_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			armored = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			},
			wood_bridge = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_solid = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_hollow = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.04,
			width = 0.3,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "slashing"
			}
		},
		dirt = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "slashing"
			}
		},
		flesh = {
			event = "axe_2h_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "slashing"
			}
		},
		fruit = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "slashing"
			}
		},
		forest_grass = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "slashing"
			}
		},
		glass = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "slashing"
			}
		},
		grass = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		hay = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "slashing"
			}
		},
		ice = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "slashing"
			}
		},
		metal_hollow = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		armored = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		metal_solid = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "slashing"
			}
		},
		mud = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "slashing"
			}
		},
		plaster = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "slashing"
			}
		},
		sand = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		stone = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "slashing"
			}
		},
		stone_dirt = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "slashing"
			}
		},
		stone_wet = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "slashing"
			}
		},
		snow = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "slashing"
			}
		},
		water = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "water",
				damage_type = "slashing"
			}
		},
		wood_bridge = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "slashing"
			}
		},
		wood_hollow = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "slashing"
			}
		},
		wood_solid = {
			event = "axe_2h_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "slashing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		fruit = "fx/hit_fruit_slash",
		dirt = "fx/hit_dirt_slash",
		stone = "fx/hit_stone_slash",
		water = "fx/hit_water_slash",
		wood_bridge = "fx/hit_wood_hollow_slash",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_slash",
		stone_dirt = "fx/hit_stone_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow_slash",
		ice = "fx/hit_ice_slash",
		forest_grass = "fx/hit_grass_slash",
		grass = "fx/hit_grass_slash",
		hay = "fx/hit_hay_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		stone_wet = "fx/hit_stone_slash",
		mud = "fx/hit_dirt_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		metal_solid = "fx/hit_metal_solid_slash",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_axes_1h = MaterialEffectMappings.melee_hit_axes_1h or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_slash_1",
			dirt = "hit_dirt_slash_1",
			stone = "hit_stone_slash_1",
			water = "empty",
			glass = "hit_glass_slash_1",
			sand = "hit_sand_slash_1",
			stone_dirt = "hit_stone_slash_1",
			snow = "hit_snow_slash_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_slash_1",
			grass = "hit_grass_slash_1",
			hay = "empty",
			stone_wet = "hit_stone_slash_1",
			mud = "hit_dirt_slash_1",
			cloth = {
				"hit_cloth_slash_1",
				"hit_cloth_slash_2"
			},
			flesh = {
				"hit_flesh_slash_1",
				"hit_flesh_slash_2",
				"hit_flesh_slash_3"
			},
			metal_hollow = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			armored = {
				"hit_metal_hollow_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_hollow_slash_3"
			},
			metal_solid = {
				"hit_metal_solid_slash_1",
				"hit_metal_hollow_slash_2",
				"hit_metal_solid_slash_3"
			},
			plaster = {
				"hit_plaster_slash_1",
				"hit_plaster_slash_2"
			},
			wood_bridge = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_solid = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			},
			wood_hollow = {
				"hit_wood_slash_1",
				"hit_wood_slash_2",
				"hit_wood_slash_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.04,
			width = 0.3,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "slashing"
			}
		},
		dirt = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "slashing"
			}
		},
		flesh = {
			event = "axe_1h_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "slashing"
			}
		},
		fruit = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "slashing"
			}
		},
		forest_grass = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "slashing"
			}
		},
		glass = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "slashing"
			}
		},
		grass = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		hay = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "slashing"
			}
		},
		ice = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "slashing"
			}
		},
		metal_hollow = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		armored = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "slashing"
			}
		},
		metal_solid = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "slashing"
			}
		},
		mud = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "slashing"
			}
		},
		plaster = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "slashing"
			}
		},
		sand = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "slashing"
			}
		},
		stone = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "slashing"
			}
		},
		stone_dirt = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "slashing"
			}
		},
		stone_wet = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "slashing"
			}
		},
		snow = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "slashing"
			}
		},
		water = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "water",
				damage_type = "slashing"
			}
		},
		wood_bridge = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "slashing"
			}
		},
		wood_hollow = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "slashing"
			}
		},
		wood_solid = {
			event = "axe_1h_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "slashing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_slash",
		fruit = "fx/hit_fruit_slash",
		dirt = "fx/hit_dirt_slash",
		stone = "fx/hit_stone_slash",
		water = "fx/hit_water_slash",
		wood_bridge = "fx/hit_wood_hollow_slash",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_slash",
		stone_dirt = "fx/hit_stone_slash",
		cloth = "fx/hit_cloth_slash",
		snow = "fx/hit_snow_slash",
		ice = "fx/hit_ice_slash",
		forest_grass = "fx/hit_grass_slash",
		grass = "fx/hit_grass_slash",
		hay = "fx/hit_hay_slash",
		wood_hollow = "fx/hit_wood_hollow_slash",
		stone_wet = "fx/hit_stone_slash",
		mud = "fx/hit_dirt_slash",
		wood_solid = "fx/hit_wood_solid_slash",
		metal_solid = "fx/hit_metal_solid_slash",
		metal_hollow = "fx/hit_metal_hollow_slash"
	}
}
MaterialEffectMappings.melee_hit_hammers_2h = MaterialEffectMappings.melee_hit_hammers_2h or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.6,
			width = 0.6,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			event = "hammer_2h_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "piercing"
			}
		},
		fruit = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "hammer_2h_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		fruit = "fx/hit_fruit_blunt",
		dirt = "fx/hit_dirt_blunt",
		stone = "fx/hit_stone_blunt",
		water = "fx/hit_water_blunt",
		wood_bridge = "fx/hit_wood_hollow_blunt",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_blunt",
		stone_dirt = "fx/hit_stone_blunt",
		cloth = "fx/hit_cloth_blunt",
		snow = "fx/hit_snow_blunt",
		ice = "fx/hit_ice_blunt",
		forest_grass = "fx/hit_grass_blunt",
		grass = "fx/hit_grass_blunt",
		hay = "fx/hit_hay_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		stone_wet = "fx/hit_stone_blunt",
		mud = "fx/hit_dirt_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		metal_solid = "fx/hit_metal_solid_blunt",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.melee_hit_hammers_1h = MaterialEffectMappings.melee_hit_hammers_1h or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.6,
			width = 0.6,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			event = "hammer_1h_hit_statics",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "piercing"
			}
		},
		fruit = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "hammer_1h_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		fruit = "fx/hit_fruit_blunt",
		dirt = "fx/hit_dirt_blunt",
		stone = "fx/hit_stone_blunt",
		water = "fx/hit_water_blunt",
		wood_bridge = "fx/hit_wood_hollow_blunt",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_blunt",
		stone_dirt = "fx/hit_stone_blunt",
		cloth = "fx/hit_cloth_blunt",
		snow = "fx/hit_snow_blunt",
		ice = "fx/hit_ice_blunt",
		forest_grass = "fx/hit_grass_blunt",
		grass = "fx/hit_grass_blunt",
		hay = "fx/hit_hay_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		stone_wet = "fx/hit_stone_blunt",
		mud = "fx/hit_dirt_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		metal_solid = "fx/hit_metal_solid_blunt",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.punch_hit = MaterialEffectMappings.punch_hit or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.6,
			width = 0.6,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "piercing"
			}
		},
		fruit = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		water = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "Play_melee_punch_hit_static",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		fruit = "fx/hit_fruit_blunt",
		dirt = "fx/hit_dirt_blunt",
		stone = "fx/hit_stone_blunt",
		water = "fx/hit_water_blunt",
		wood_bridge = "fx/hit_wood_hollow_blunt",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_blunt",
		stone_dirt = "fx/hit_stone_blunt",
		cloth = "fx/hit_cloth_blunt",
		forest_grass = "fx/hit_grass_blunt",
		grass = "fx/hit_grass_blunt",
		hay = "fx/hit_hay_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		stone_wet = "fx/hit_stone_blunt",
		mud = "fx/hit_dirt_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		metal_solid = "fx/hit_metal_solid_blunt",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.wooden_sword_hit = MaterialEffectMappings.wooden_sword_hit or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.6,
			height = 0.6,
			width = 0.6,
			depth_offset = -0.2
		}
	},
	sound = {
		cloth = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				weapon_type = "1h_sword",
				material = "cloth",
				damage_type = "piercing"
			}
		},
		fruit = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		water = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "Play_weapon_wooden_sword_hit_static",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_blunt",
		fruit = "fx/hit_fruit_blunt",
		dirt = "fx/hit_dirt_blunt",
		stone = "fx/hit_stone_blunt",
		water = "fx/hit_water_blunt",
		wood_bridge = "fx/hit_wood_hollow_blunt",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_flesh_blunt",
		stone_dirt = "fx/hit_stone_blunt",
		cloth = "fx/hit_cloth_blunt",
		forest_grass = "fx/hit_grass_blunt",
		grass = "fx/hit_grass_blunt",
		hay = "fx/hit_hay_blunt",
		wood_hollow = "fx/hit_wood_hollow_blunt",
		stone_wet = "fx/hit_stone_blunt",
		mud = "fx/hit_dirt_blunt",
		wood_solid = "fx/hit_wood_solid_blunt",
		metal_solid = "fx/hit_metal_solid_blunt",
		metal_hollow = "fx/hit_metal_hollow_blunt"
	}
}
MaterialEffectMappings.bullet_impact = MaterialEffectMappings.bullet_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.8,
			height = 0.6,
			width = 0.6,
			depth_offset = 0.5
		}
	},
	sound = {
		cloth = {
			event = "bullet_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "bullet_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "bullet_hit",
			parameters = {}
		},
		fruit = {
			event = "bullet_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "bullet_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "bullet_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "bullet_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "bullet_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "slashing_hit_armour",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "slashing_hit_armour",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "bullet_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "bullet_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "bullet_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "bullet_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "bullet_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "bullet_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "bullet_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "bullet_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "bullet_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "bullet_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "bullet_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		hay = "fx/hit_hay_pierce",
		fruit = "fx/hit_fruit_pierce",
		stone = "fx/hit_stone_pierce",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_snow_pierce",
		wood_bridge = "fx/hit_wood_hollow_pierce",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_metal_hollow_pierce",
		stone_dirt = "fx/hit_stone_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow_pierce",
		ice = "fx/hit_ice_pierce",
		forest_grass = "fx/hit_grass_pierce",
		grass = "fx/hit_grass_pierce",
		dirt = "fx/hit_dirt_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		stone_wet = "fx/hit_stone_pierce",
		mud = "fx/hit_mud_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		metal_solid = "fx/hit_metal_solid_pierce",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.shotgun_bullet_impact = MaterialEffectMappings.shotgun_bullet_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.8,
			height = 0.6,
			width = 0.6,
			depth_offset = 0.5
		}
	},
	sound = {
		cloth = {
			event = "bullet_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "bullet_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "bullet_hit",
			parameters = {}
		},
		fruit = {
			event = "bullet_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "bullet_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "bullet_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "bullet_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "bullet_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "slashing_hit_armour",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "slashing_hit_armour",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "bullet_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "bullet_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "bullet_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "bullet_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "bullet_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "bullet_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "bullet_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "bullet_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "bullet_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "bullet_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "bullet_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/arrow_hit_generic",
		hay = "fx/hit_hay_pierce",
		fruit = "fx/arrow_hit_generic",
		stone = "fx/arrow_hit_stone",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_snow_pierce",
		wood_bridge = "fx/arrow_hit_wood_hollow",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/arrow_hit_flesh",
		stone_dirt = "fx/arrow_hit_stone",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/arrow_hit_snow",
		ice = "fx/hit_ice_pierce",
		forest_grass = "fx/arrow_hit_generic",
		grass = "fx/arrow_hit_generic",
		dirt = "fx/arrow_hit_dirt",
		wood_hollow = "fx/arrow_hit_wood_hollow",
		stone_wet = "fx/arrow_hit_stone",
		mud = "fx/arrow_hit_generic",
		wood_solid = "fx/arrow_hit_wood_solid",
		metal_solid = "fx/arrow_hit_metal_solid",
		metal_hollow = "fx/arrow_hit_metal_hollow"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.nodecals = MaterialEffectMappings.nodecals or {
	sound = {
		cloth = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "enemy_bullet_hit_statics",
			parameters = {}
		},
		fruit = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		hay = "fx/hit_hay_pierce",
		fruit = "fx/hit_fruit_pierce",
		stone = "fx/hit_stone_pierce",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_snow_pierce",
		wood_bridge = "fx/hit_wood_hollow_pierce",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_metal_hollow_pierce",
		stone_dirt = "fx/hit_stone_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow_pierce",
		ice = "fx/hit_ice_pierce",
		forest_grass = "fx/hit_grass_pierce",
		grass = "fx/hit_grass_pierce",
		dirt = "fx/hit_dirt_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		stone_wet = "fx/hit_stone_pierce",
		mud = "fx/hit_mud_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		metal_solid = "fx/hit_metal_solid_pierce",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.enemy_bullet_impact = MaterialEffectMappings.enemy_bullet_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.8,
			height = 0.6,
			width = 0.6,
			depth_offset = 0.5
		}
	},
	sound = {
		cloth = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "enemy_bullet_hit_statics",
			parameters = {}
		},
		fruit = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "enemy_bullet_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/hit_plaster_pierce",
		hay = "fx/hit_hay_pierce",
		fruit = "fx/hit_fruit_pierce",
		stone = "fx/hit_stone_pierce",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_snow_pierce",
		wood_bridge = "fx/hit_wood_hollow_pierce",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/hit_metal_hollow_pierce",
		stone_dirt = "fx/hit_stone_pierce",
		cloth = "fx/hit_cloth_pierce",
		snow = "fx/hit_snow_pierce",
		ice = "fx/hit_ice_pierce",
		forest_grass = "fx/hit_grass_pierce",
		grass = "fx/hit_grass_pierce",
		dirt = "fx/hit_dirt_pierce",
		wood_hollow = "fx/hit_wood_hollow_pierce",
		stone_wet = "fx/hit_stone_pierce",
		mud = "fx/hit_mud_pierce",
		wood_solid = "fx/hit_wood_solid_pierce",
		metal_solid = "fx/hit_metal_solid_pierce",
		metal_hollow = "fx/hit_metal_hollow_pierce"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.drakefire_pistol = MaterialEffectMappings.drakefire_pistol or {
	sound = {
		armored = {
			event = "drakepistol_hit",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		cloth = {
			event = "drakepistol_hit",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "drakepistol_hit",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "drakepistol_hit",
			parameters = {}
		},
		fruit = {
			event = "drakepistol_hit",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "drakepistol_hit",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "drakepistol_hit",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "drakepistol_hit",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "drakepistol_hit",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "drakepistol_hit",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "drakepistol_hit",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "drakepistol_hit",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "drakepistol_hit",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "drakepistol_hit",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "drakepistol_hit",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "drakepistol_hit",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "drakepistol_hit",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "drakepistol_hit",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "drakepistol_hit",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "drakepistol_hit",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "drakepistol_hit",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "drakepistol_hit",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "drakepistol_hit",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/wpnfx_drake_pistols_projectile_impact",
		hay = "fx/wpnfx_drake_pistols_projectile_impact",
		fruit = "fx/wpnfx_drake_pistols_projectile_impact",
		stone = "fx/wpnfx_drake_pistols_projectile_impact",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_water_with_fire_projectile",
		wood_bridge = "fx/wpnfx_drake_pistols_projectile_impact",
		glass = "fx/wpnfx_drake_pistols_projectile_impact",
		sand = "fx/wpnfx_drake_pistols_projectile_impact",
		armored = "fx/hit_armored_with_fire",
		flesh = "fx/wpnfx_drake_pistols_projectile_impact",
		stone_dirt = "fx/wpnfx_drake_pistols_projectile_impact",
		cloth = "fx/wpnfx_drake_pistols_projectile_impact",
		snow = "fx/wpnfx_drake_pistols_projectile_impact",
		ice = "fx/wpnfx_drake_pistols_projectile_impact",
		forest_grass = "fx/wpnfx_drake_pistols_projectile_impact",
		grass = "fx/wpnfx_drake_pistols_projectile_impact",
		dirt = "fx/wpnfx_drake_pistols_projectile_impact",
		wood_hollow = "fx/wpnfx_drake_pistols_projectile_impact",
		stone_wet = "fx/wpnfx_drake_pistols_projectile_impact",
		mud = "fx/wpnfx_drake_pistols_projectile_impact",
		wood_solid = "fx/wpnfx_drake_pistols_projectile_impact",
		metal_solid = "fx/wpnfx_drake_pistols_projectile_impact",
		metal_hollow = "fx/wpnfx_drake_pistols_projectile_impact"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.staff_spark = MaterialEffectMappings.staff_spark or {
	sound = {
		armored = {
			event = "magic_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		cloth = {
			event = "magic_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "magic_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "magic_hit_statics",
			parameters = {}
		},
		fruit = {
			event = "magic_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "magic_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "magic_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "magic_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "magic_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "magic_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "magic_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "magic_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "magic_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "magic_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "magic_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "magic_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "magic_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "magic_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "magic_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "magic_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "magic_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "magic_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "magic_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/wpnfx_staff_spark_impact",
		hay = "fx/wpnfx_staff_spark_impact",
		fruit = "fx/wpnfx_staff_spark_impact",
		stone = "fx/wpnfx_staff_spark_impact",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_water_with_fire_projectile",
		wood_bridge = "fx/wpnfx_staff_spark_impact",
		glass = "fx/wpnfx_staff_spark_impact",
		sand = "fx/wpnfx_staff_spark_impact",
		armored = "fx/hit_armored_with_fire",
		flesh = "fx/wpnfx_staff_spark_impact",
		stone_dirt = "fx/wpnfx_staff_spark_impact",
		cloth = "fx/wpnfx_staff_spark_impact",
		snow = "fx/wpnfx_staff_spark_impact",
		ice = "fx/wpnfx_staff_spark_impact",
		forest_grass = "fx/wpnfx_staff_spark_impact",
		grass = "fx/wpnfx_staff_spark_impact",
		dirt = "fx/wpnfx_staff_spark_impact",
		wood_hollow = "fx/wpnfx_staff_spark_impact",
		stone_wet = "fx/wpnfx_staff_spark_impact",
		mud = "fx/wpnfx_staff_spark_impact",
		wood_solid = "fx/wpnfx_staff_spark_impact",
		metal_solid = "fx/wpnfx_staff_spark_impact",
		metal_hollow = "fx/wpnfx_staff_spark_impact"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.staff_spear = MaterialEffectMappings.staff_spear or {
	sound = {
		armored = {
			event = "magic_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		cloth = {
			event = "magic_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "magic_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "magic_hit_statics",
			parameters = {}
		},
		fruit = {
			event = "magic_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "magic_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "magic_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "magic_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "magic_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "magic_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "magic_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "magic_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "magic_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "magic_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "magic_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "magic_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "magic_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "magic_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "magic_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "magic_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "magic_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "magic_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "magic_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/wpnfx_staff_spear_impact",
		hay = "fx/wpnfx_staff_spear_impact",
		fruit = "fx/wpnfx_staff_spear_impact",
		stone = "fx/wpnfx_staff_spear_impact",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_water_with_fire_projectile",
		wood_bridge = "fx/wpnfx_staff_spear_impact",
		glass = "fx/wpnfx_staff_spear_impact",
		sand = "fx/wpnfx_staff_spear_impact",
		armored = "fx/hit_armored_with_fire",
		flesh = "fx/wpnfx_staff_spear_impact",
		stone_dirt = "fx/wpnfx_staff_spear_impact",
		cloth = "fx/wpnfx_staff_spear_impact",
		snow = "fx/wpnfx_staff_spear_impact",
		ice = "fx/wpnfx_staff_spear_impact",
		forest_grass = "fx/wpnfx_staff_spear_impact",
		grass = "fx/wpnfx_staff_spear_impact",
		dirt = "fx/wpnfx_staff_spear_impact",
		wood_hollow = "fx/wpnfx_staff_spear_impact",
		stone_wet = "fx/wpnfx_staff_spear_impact",
		mud = "fx/wpnfx_staff_spear_impact",
		wood_solid = "fx/wpnfx_staff_spear_impact",
		metal_solid = "fx/wpnfx_staff_spear_impact",
		metal_hollow = "fx/wpnfx_staff_spear_impact"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.fireball_impact = MaterialEffectMappings.fireball_impact or {
	sound = {
		cloth = {
			event = "fireball_small_hit",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "fireball_small_hit",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "bullet_hit_armour",
			event = "fireball_small_hit",
			parameters = {}
		},
		fruit = {
			event = "fireball_small_hit",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "fireball_small_hit",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "fireball_small_hit",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "fireball_small_hit",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "fireball_small_hit",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "fireball_small_hit",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "fireball_small_hit",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "fireball_small_hit",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "fireball_small_hit",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "fireball_small_hit",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "fireball_small_hit",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "fireball_small_hit",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "fireball_small_hit",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "fireball_small_hit",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "fireball_small_hit",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "fireball_small_hit",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "fireball_small_hit",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "fireball_small_hit",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "fireball_small_hit",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "fireball_small_hit",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/wpnfx_staff_spark_impact",
		hay = "fx/wpnfx_staff_spark_impact",
		fruit = "fx/wpnfx_staff_spark_impact",
		stone = "fx/wpnfx_staff_spark_impact",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/wpnfx_staff_spark_impact",
		wood_bridge = "fx/wpnfx_staff_spark_impact",
		glass = "fx/wpnfx_staff_spark_impact",
		sand = "fx/wpnfx_staff_spark_impact",
		armored = "fx/hit_armored_with_fire",
		flesh = "fx/wpnfx_staff_spark_impact",
		stone_dirt = "fx/wpnfx_staff_spark_impact",
		cloth = "fx/wpnfx_staff_spark_impact",
		snow = "fx/wpnfx_staff_spark_impact",
		ice = "fx/wpnfx_staff_spark_impact",
		forest_grass = "fx/wpnfx_staff_spark_impact",
		grass = "fx/wpnfx_staff_spark_impact",
		dirt = "fx/wpnfx_staff_spark_impact",
		wood_hollow = "fx/wpnfx_staff_spark_impact",
		stone_wet = "fx/wpnfx_staff_spark_impact",
		mud = "fx/wpnfx_staff_spark_impact",
		wood_solid = "fx/wpnfx_staff_spark_impact",
		metal_solid = "fx/wpnfx_staff_spark_impact",
		metal_hollow = "fx/wpnfx_staff_spark_impact"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.arrow_impact = MaterialEffectMappings.arrow_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.8,
			height = 0.6,
			width = 0.6,
			depth_offset = 0.5
		}
	},
	sound = {
		cloth = {
			event = "arrow_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "arrow_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "arrow_hit_armour",
			event = "arrow_hit",
			parameters = {}
		},
		fruit = {
			event = "arrow_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "arrow_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "arrow_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "arrow_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "arrow_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "arrow_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "slashing_hit_armour",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "slashing_hit_armour",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "arrow_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "arrow_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "arrow_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "arrow_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "arrow_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "arrow_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "arrow_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "arrow_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "arrow_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "arrow_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "arrow_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "arrow_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/arrow_hit_generic",
		fruit = "fx/arrow_hit_generic",
		dirt = "fx/arrow_hit_dirt",
		stone = "fx/arrow_hit_stone",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/hit_snow_pierce",
		wood_bridge = "fx/arrow_hit_wood_hollow",
		glass = "fx/hit_glass",
		sand = "fx/hit_sand",
		armored = "fx/hit_armored",
		flesh = "fx/arrow_hit_flesh",
		stone_dirt = "fx/arrow_hit_stone",
		cloth = "fx/arrow_hit_cloth",
		snow = "fx/arrow_hit_snow",
		ice = "fx/arrow_hit_generic",
		forest_grass = "fx/hit_grass_pierce",
		grass = "fx/arrow_hit_generic",
		hay = "fx/arrow_hit_generic",
		wood_hollow = "fx/arrow_hit_wood_hollow",
		stone_wet = "fx/arrow_hit_stone",
		mud = "fx/arrow_hit_generic",
		wood_solid = "fx/arrow_hit_wood_solid",
		metal_solid = "fx/arrow_hit_metal_solid",
		metal_hollow = "fx/arrow_hit_metal_hollow"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.poison_arrow_impact = MaterialEffectMappings.poison_arrow_impact or {
	decal = {
		material_drawer_mapping = {
			fruit = "hit_fruit_pierce_1",
			dirt = "hit_dirt_pierce_1",
			stone = "hit_stone_pierce_1",
			water = "empty",
			glass = "hit_glass_pierce_1",
			sand = "hit_sand_pierce_1",
			armored = "hit_metal_hollow_pierce_1",
			flesh = "hit_flesh_pierce_1",
			stone_dirt = "hit_stone_pierce_1",
			snow = "hit_snow_pierce_1",
			ice = "hit_ice_pierce_1",
			forest_grass = "hit_grass_pierce_1",
			grass = "hit_grass_pierce_1",
			hay = "empty",
			stone_wet = "hit_stone_pierce_1",
			mud = "hit_dirt_pierce_1",
			metal_solid = "hit_metal_solid_pierce_1",
			metal_hollow = "hit_metal_hollow_pierce_1",
			cloth = {
				"hit_cloth_pierce_1",
				"hit_cloth_pierce_2"
			},
			plaster = {
				"hit_plaster_pierce_1",
				"hit_plaster_pierce_2"
			},
			wood_bridge = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_solid = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			},
			wood_hollow = {
				"hit_wood_pierce_1",
				"hit_wood_pierce_2",
				"hit_wood_pierce_3"
			}
		},
		settings = {
			depth = 0.8,
			height = 0.6,
			width = 0.6,
			depth_offset = 0.5
		}
	},
	sound = {
		cloth = {
			event = "arrow_hit_statics",
			parameters = {
				material = "cloth",
				damage_type = "piercing"
			}
		},
		dirt = {
			event = "arrow_hit_statics",
			parameters = {
				material = "dirt",
				damage_type = "piercing"
			}
		},
		flesh = {
			no_damage_event = "arrow_hit_armour",
			event = "arrow_hit_statics",
			parameters = {}
		},
		fruit = {
			event = "arrow_hit_statics",
			parameters = {
				material = "fruit",
				damage_type = "piercing"
			}
		},
		forest_grass = {
			event = "arrow_hit_statics",
			parameters = {
				material = "forest_grass",
				damage_type = "piercing"
			}
		},
		glass = {
			event = "arrow_hit_statics",
			parameters = {
				material = "glass",
				damage_type = "piercing"
			}
		},
		grass = {
			event = "arrow_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		hay = {
			event = "arrow_hit_statics",
			parameters = {
				material = "hay",
				damage_type = "piercing"
			}
		},
		ice = {
			event = "arrow_hit_statics",
			parameters = {
				material = "ice",
				damage_type = "piercing"
			}
		},
		metal_hollow = {
			event = "arrow_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		armored = {
			event = "arrow_hit_statics",
			parameters = {
				material = "metal_hollow",
				damage_type = "piercing"
			}
		},
		metal_solid = {
			event = "arrow_hit_statics",
			parameters = {
				material = "metal_solid",
				damage_type = "piercing"
			}
		},
		mud = {
			event = "arrow_hit_statics",
			parameters = {
				material = "mud",
				damage_type = "piercing"
			}
		},
		plaster = {
			event = "arrow_hit_statics",
			parameters = {
				material = "plaster",
				damage_type = "piercing"
			}
		},
		sand = {
			event = "arrow_hit_statics",
			parameters = {
				material = "grass",
				damage_type = "piercing"
			}
		},
		stone = {
			event = "arrow_hit_statics",
			parameters = {
				material = "stone",
				damage_type = "piercing"
			}
		},
		stone_dirt = {
			event = "arrow_hit_statics",
			parameters = {
				material = "stone_dirt",
				damage_type = "piercing"
			}
		},
		stone_wet = {
			event = "arrow_hit_statics",
			parameters = {
				material = "stone_wet",
				damage_type = "piercing"
			}
		},
		snow = {
			event = "arrow_hit_statics",
			parameters = {
				material = "snow",
				damage_type = "piercing"
			}
		},
		water = {
			event = "arrow_hit_statics",
			parameters = {
				material = "water",
				damage_type = "piercing"
			}
		},
		wood_bridge = {
			event = "arrow_hit_statics",
			parameters = {
				material = "wood_bridge",
				damage_type = "piercing"
			}
		},
		wood_hollow = {
			event = "arrow_hit_statics",
			parameters = {
				material = "wood_hollow",
				damage_type = "piercing"
			}
		},
		wood_solid = {
			event = "arrow_hit_statics",
			parameters = {
				material = "wood_solid",
				damage_type = "piercing"
			}
		}
	},
	particles = {
		plaster = "fx/wpnfx_poison_arrow_impact",
		fruit = "fx/wpnfx_poison_arrow_impact",
		dirt = "fx/wpnfx_poison_arrow_impact",
		stone = "fx/wpnfx_poison_arrow_impact",
		ward = "fx/chr_stormvermin_champion_shield_dot",
		water = "fx/wpnfx_poison_arrow_impact",
		wood_bridge = "fx/wpnfx_poison_arrow_impact",
		glass = "fx/wpnfx_poison_arrow_impact",
		sand = "fx/wpnfx_poison_arrow_impact",
		armored = "fx/wpnfx_poison_arrow_impact",
		flesh = "fx/wpnfx_poison_arrow_impact",
		stone_dirt = "fx/wpnfx_poison_arrow_impact",
		cloth = "fx/wpnfx_poison_arrow_impact",
		snow = "fx/wpnfx_poison_arrow_impact",
		ice = "fx/hit_ice_pierce",
		forest_grass = "fx/wpnfx_poison_arrow_impact",
		grass = "fx/wpnfx_poison_arrow_impact",
		hay = "fx/hit_hay_pierce",
		wood_hollow = "fx/wpnfx_poison_arrow_impact",
		stone_wet = "fx/wpnfx_poison_arrow_impact",
		mud = "fx/wpnfx_poison_arrow_impact",
		wood_solid = "fx/wpnfx_poison_arrow_impact",
		metal_solid = "fx/wpnfx_poison_arrow_impact",
		metal_hollow = "fx/wpnfx_poison_arrow_impact"
	},
	flow_event = {
		ward = "ward_impact"
	}
}
MaterialEffectMappings.footstep_walk = MaterialEffectMappings.footstep_walk or {
	sound = {
		cloth = {
			event = "walk",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "walk",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "walk",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "walk",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "walk",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "walk",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "walk",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "walk",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "walk",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "walk",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "walk",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "walk",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "walk",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "walk",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "walk",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "walk",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "walk",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "walk",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "walk",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "walk",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "walk",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "walk",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "walk",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/footstep_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.footstep_sneak = MaterialEffectMappings.footstep_sneak or {
	sound = {
		cloth = {
			event = "sneak",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "sneak",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "sneak",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "sneak",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "sneak",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "sneak",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "sneak",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "sneak",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "sneak",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "sneak",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "sneak",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "sneak",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "sneak",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "sneak",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "sneak",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "sneak",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "sneak",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "sneak",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "sneak",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "sneak",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "sneak",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "sneak",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "sneak",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/footstep_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.footstep_run = MaterialEffectMappings.footstep_run or {
	sound = {
		cloth = {
			event = "run",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "run",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "run",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "run",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "run",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "run",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "run",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "run",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "run",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "run",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "run",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "run",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "run",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "run",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "run",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "run",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "run",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "run",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "run",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "run",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "run",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "run",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "run",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/footstep_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.footstep_jump = MaterialEffectMappings.footstep_jump or {
	sound = {
		cloth = {
			event = "jump",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "jump",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "jump",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "jump",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "jump",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "jump",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "jump",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "jump",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "jump",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "jump",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "jump",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "jump",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "jump",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "jump",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "jump",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "jump",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "jump",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "jump",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "jump",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "jump",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "jump",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "jump",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "jump",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/footstep_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.footstep_land = MaterialEffectMappings.footstep_land or {
	sound = {
		cloth = {
			event = "land",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "land",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "land",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "land",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "land",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "land",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "land",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "land",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "land",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "land",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "land",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "land",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "land",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "land",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "land",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "land",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "land",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "land",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "land",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "land",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "land",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "land",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "land",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/footstep_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.enemy_footstep_walk = MaterialEffectMappings.enemy_footstep_walk or {
	sound = {
		cloth = {
			event = "enemy_walk",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_walk",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_walk",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_walk",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_walk",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_walk",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_walk",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_walk",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_walk",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "enemy_walk",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_walk",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "enemy_walk",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_walk",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_walk",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_walk",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_walk",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_walk",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_walk",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_walk",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "enemy_walk",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_walk",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_walk",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_walk",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.enemy_footstep_run = MaterialEffectMappings.enemy_footstep_run or {
	sound = {
		cloth = {
			event = "enemy_run",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_run",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_run",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_run",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_run",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_run",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_run",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_run",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_run",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "enemy_run",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_run",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "enemy_run",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_run",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_run",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_run",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_run",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_run",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_run",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_run",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "enemy_run",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_run",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_run",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_run",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.enemy_footstep_land = MaterialEffectMappings.enemy_footstep_land or {
	sound = {
		cloth = {
			event = "enemy_land",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_land",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_land",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_land",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_land",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_land",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_land",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_land",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_land",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "enemy_land",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_land",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "enemy_land",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_land",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_land",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_land",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_land",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_land",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_land",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_land",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "enemy_land",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_land",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_land",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_land",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.enemy_ratogre_run = {
	sound = {
		cloth = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_ratogre_run",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_ogre_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.enemy_footstep_ratogre_land = MaterialEffectMappings.enemy_footstep_ratogre_land or {
	sound = {
		cloth = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "ice"
			}
		},
		metal_solid = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "snow"
			}
		},
		water = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_ratogre_land",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_ogre_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.grenade_bounce = {
	sound = {
		cloth = {
			event = "grenade_hit_statics",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "grenade_hit_statics",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "grenade_hit_statics",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "grenade_hit_statics",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "grenade_hit_statics",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "grenade_hit_statics",
			parameters = {
				material = "glass"
			}
		},
		metal_solid = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_hollow"
			}
		},
		armored = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "grenade_hit_statics",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "grenade_hit_statics",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "water"
			}
		},
		water = {
			event = "grenade_hit_statics",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_hollow"
			}
		}
	}
}
MaterialEffectMappings.enemy_ratogre_slide = {
	sound = {
		cloth = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "glass"
			}
		},
		metal_solid = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "water"
			}
		},
		water = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_ratogre_slide",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_ogre_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.grenade_bounce = {
	sound = {
		cloth = {
			event = "grenade_hit_statics",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "grenade_hit_statics",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "grenade_hit_statics",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "grenade_hit_statics",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "grenade_hit_statics",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "grenade_hit_statics",
			parameters = {
				material = "glass"
			}
		},
		metal_solid = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "grenade_hit_statics",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "grenade_hit_statics",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "water"
			}
		},
		water = {
			event = "grenade_hit_statics",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_hollow"
			}
		}
	}
}
MaterialEffectMappings.enemy_ratogre_footstep_single = {
	sound = {
		cloth = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "glass"
			}
		},
		metal_solid = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "water"
			}
		},
		water = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "enemy_ratogre_footstep_single",
			parameters = {
				material = "wood_hollow"
			}
		}
	},
	particles = {
		plaster = "fx/footstep_walk_dirt",
		fruit = "fx/footstep_walk_dirt",
		dirt = "fx/footstep_walk_dirt",
		stone = "fx/footstep_walk_dirt",
		water = "fx/footstep_walk_water",
		wood_bridge = "fx/footstep_walk_dirt",
		glass = "fx/footstep_walk_dirt",
		sand = "fx/footstep_walk_dirt",
		armored = "fx/footstep_walk_dirt",
		flesh = "fx/footstep_walk_dirt",
		stone_dirt = "fx/footstep_walk_dirt",
		cloth = "fx/footstep_walk_dirt",
		snow = "fx/pawprint_ogre_walk_snow",
		ice = "fx/footstep_walk_ice",
		forest_grass = "fx/footstep_walk_dirt",
		grass = "fx/footstep_walk_dirt",
		hay = "fx/footstep_walk_dirt",
		wood_hollow = "fx/footstep_walk_dirt",
		stone_wet = "fx/footstep_walk_dirt",
		mud = "fx/footstep_walk_dirt",
		wood_solid = "fx/footstep_walk_dirt",
		metal_solid = "fx/footstep_walk_dirt",
		metal_hollow = "fx/footstep_walk_dirt"
	}
}
MaterialEffectMappings.grenade_bounce = {
	sound = {
		cloth = {
			event = "grenade_hit_statics",
			parameters = {
				material = "cloth"
			}
		},
		dirt = {
			event = "grenade_hit_statics",
			parameters = {
				material = "dirt"
			}
		},
		flesh = {
			event = "grenade_hit_statics",
			parameters = {
				material = "flesh"
			}
		},
		forest_grass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "forest_grass"
			}
		},
		fruit = {
			event = "grenade_hit_statics",
			parameters = {
				material = "fruit"
			}
		},
		grass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "grass"
			}
		},
		glass = {
			event = "grenade_hit_statics",
			parameters = {
				material = "glass"
			}
		},
		hay = {
			event = "grenade_hit_statics",
			parameters = {
				material = "hay"
			}
		},
		ice = {
			event = "grenade_hit_statics",
			parameters = {
				material = "glass"
			}
		},
		metal_solid = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_solid"
			}
		},
		metal_hollow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "metal_hollow"
			}
		},
		mud = {
			event = "grenade_hit_statics",
			parameters = {
				material = "mud"
			}
		},
		plaster = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone"
			}
		},
		sand = {
			event = "grenade_hit_statics",
			parameters = {
				material = "sand"
			}
		},
		stone = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone"
			}
		},
		stone_dirt = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone_dirt"
			}
		},
		stone_wet = {
			event = "grenade_hit_statics",
			parameters = {
				material = "stone_wet"
			}
		},
		snow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "water"
			}
		},
		water = {
			event = "grenade_hit_statics",
			parameters = {
				material = "water"
			}
		},
		wood_bridge = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_bridge"
			}
		},
		wood_solid = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_solid"
			}
		},
		wood_hollow = {
			event = "grenade_hit_statics",
			parameters = {
				material = "wood_hollow"
			}
		}
	}
}
MaterialIDToName = {}

for context_name, context_materials in pairs(MaterialEffectSettings.material_contexts) do
	MaterialIDToName[context_name] = {}

	for _, material_name in ipairs(context_materials) do
		MaterialIDToName[context_name][Unit.material_id(material_name)] = material_name
	end
end

return 
