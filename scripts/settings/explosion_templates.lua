ExplosionTemplates = {
	sniper_poison_arrow = {
		explosion = {
			attack_template_damage_type = "no_damage",
			radius = 3,
			effect_name = "fx/wpnfx_poison_arrow_impact_sniper",
			sound_event_name = "arrow_hit_poison_cloud",
			no_friendly_fire = true,
			attack_template = "arrow_poison_aoe"
		}
	},
	machinegun_poison_arrow = {
		explosion = {
			attack_template_damage_type = "no_damage",
			radius = 1,
			effect_name = "fx/wpnfx_poison_arrow_impact_machinegun",
			sound_event_name = "arrow_hit_poison_cloud",
			no_friendly_fire = true,
			attack_template = "arrow_poison_aoe"
		}
	},
	carbine_poison_arrow = {
		explosion = {
			attack_template_damage_type = "no_damage",
			radius = 2,
			effect_name = "fx/wpnfx_poison_arrow_impact_carbine",
			sound_event_name = "arrow_hit_poison_cloud",
			no_friendly_fire = true,
			attack_template = "arrow_poison_aoe"
		}
	},
	drakegun_charged = {
		explosion = {
			max_damage_radius_min = 0.5,
			radius_max = 4,
			attack_template_glance = "drakegun_glance",
			damage_type_glance = "drakegun_glance",
			radius_min = 1.25,
			attack_template = "drakegun",
			alert_enemies = true,
			alert_enemies_radius = 10,
			max_damage_radius_max = 1,
			damage_type = "drakegun",
			sound_event_name = "drakegun_hit",
			effect_name = "fx/wpnfx_drake_projectile_impact_charged",
			damage_min = {
				3,
				1,
				12,
				2
			},
			damage_max = {
				4,
				2,
				24,
				4
			}
		}
	},
	fireball_charged = {
		explosion = {
			max_damage_radius_min = 0.5,
			radius_max = 3,
			attack_template_glance = "drakegun_glance",
			damage_type_glance = "drakegun_glance",
			radius_min = 3,
			attack_template = "drakegun",
			alert_enemies = true,
			alert_enemies_radius = 10,
			max_damage_radius_max = 1,
			damage_type = "drakegun",
			sound_event_name = "fireball_big_hit",
			effect_name = "fx/wpnfx_fireball_charged_impact",
			damage_min = {
				2,
				1,
				12,
				1
			},
			damage_max = {
				4,
				2,
				24,
				2
			}
		}
	},
	grenade = {
		explosion = {
			damage_type = "grenade",
			radius = 5,
			max_damage_radius = 2,
			attack_template_glance = "drakegun_glance",
			damage_type_glance = "grenade_glance",
			alert_enemies_radius = 15,
			attack_template = "drakegun",
			sound_event_name = "fireball_big_hit",
			alert_enemies = true,
			effect_name = "fx/wpnfx_frag_grenade_impact",
			damage = {
				5,
				5,
				80,
				5
			}
		}
	},
	explosive_barrel = {
		explosion = {
			always_hurt_players = true,
			radius = 4,
			max_damage_radius = 3,
			alert_enemies = true,
			damage_type_glance = "grenade_glance",
			alert_enemies_radius = 10,
			attack_template = "drakegun",
			damage_type = "grenade",
			sound_event_name = "player_combat_weapon_grenade_explosion",
			effect_name = "fx/wpnfx_barrel_explosion",
			damage = {
				20,
				5,
				80,
				20
			}
		}
	},
	overcharge_explosion_dwarf = {
		explosion = {
			always_hurt_players = false,
			radius = 5,
			max_damage_radius = 4,
			alert_enemies = true,
			damage_type_glance = "grenade_glance",
			alert_enemies_radius = 10,
			attack_template = "drakegun",
			damage_type = "grenade",
			sound_event_name = "emitter_dwarf_bomb_explosion",
			ignore_attacker_unit = true,
			effect_name = "fx/player_overcharge_explosion_dwarf",
			damage = {
				20,
				5,
				80,
				20
			}
		}
	},
	overcharge_explosion_brw = {
		explosion = {
			always_hurt_players = false,
			radius = 5,
			max_damage_radius = 4,
			alert_enemies = true,
			damage_type_glance = "player_overcharge_explosion_brw",
			alert_enemies_radius = 10,
			attack_template = "drakegun",
			damage_type = "grenade",
			sound_event_name = "player_combat_weapon_staff_overcharge_explosion",
			ignore_attacker_unit = true,
			effect_name = "fx/player_overcharge_explosion_brw",
			damage = {
				20,
				5,
				200,
				20
			}
		}
	},
	smoke_grenade = {
		aoe = {
			extra_effect_name = "fx/chr_gutter_foff",
			radius = 5,
			nav_tag_volume_layer = "smoke_grenade",
			create_nav_tag_volume = true,
			sound_event_name = "player_combat_weapon_smoke_grenade_explosion",
			damage_interval = 1,
			duration = 10,
			area_damage_template = "explosion_template_aoe",
			effect_name = "fx/wpnfx_smoke_grenade_impact"
		}
	},
	fire_grenade = {
		explosion = {
			alert_enemies_radius = 15,
			radius = 6,
			max_damage_radius = 2.5,
			damage_type = "fire_grenade",
			damage_type_glance = "fire_grenade_glance",
			sound_event_name = "fireball_big_hit",
			attack_template = "fire_grenade_explosion",
			alert_enemies = true,
			effect_name = "fx/wpnfx_fire_grenade_impact",
			damage = {
				6,
				3,
				30,
				10
			}
		},
		aoe = {
			nav_tag_volume_layer = "fire_grenade",
			radius = 6,
			create_nav_tag_volume = true,
			attack_template = "fire_grenade_dot",
			sound_event_name = "player_combat_weapon_fire_grenade_explosion",
			damage_interval = 1,
			duration = 5,
			area_damage_template = "explosion_template_aoe",
			nav_mesh_effect = {
				particle_radius = 2,
				particle_name = "fx/wpnfx_fire_grenade_impact_remains",
				particle_spacing = 0.9
			}
		}
	},
	fire_grenade = {
		explosion = {
			alert_enemies_radius = 15,
			radius = 6,
			max_damage_radius = 2.5,
			damage_type = "fire_grenade",
			damage_type_glance = "fire_grenade_glance",
			sound_event_name = "fireball_big_hit",
			attack_template = "fire_grenade_explosion",
			alert_enemies = true,
			effect_name = "fx/wpnfx_fire_grenade_impact",
			damage = {
				6,
				3,
				30,
				10
			}
		},
		aoe = {
			nav_tag_volume_layer = "fire_grenade",
			radius = 6,
			create_nav_tag_volume = true,
			attack_template = "fire_grenade_dot",
			sound_event_name = "player_combat_weapon_fire_grenade_explosion",
			damage_interval = 1,
			duration = 5,
			area_damage_template = "explosion_template_aoe",
			nav_mesh_effect = {
				particle_radius = 2,
				particle_name = "fx/wpnfx_fire_grenade_impact_remains",
				particle_spacing = 0.9
			}
		}
	},
	conflag_t1 = {
		aoe = {
			nav_tag_volume_layer = "fire_grenade",
			radius = 4,
			create_nav_tag_volume = true,
			attack_template = "fire_grenade_dot",
			sound_event_name = "player_combat_weapon_fire_grenade_explosion",
			damage_interval = 1,
			duration = 4,
			area_damage_template = "explosion_template_aoe",
			nav_mesh_effect = {
				particle_radius = 2,
				particle_name = "fx/wpnfx_fire_grenade_impact_remains",
				particle_spacing = 0.9
			}
		}
	},
	conflag_t2 = {
		aoe = {
			nav_tag_volume_layer = "fire_grenade",
			radius = 4,
			create_nav_tag_volume = true,
			attack_template = "fire_grenade_dot",
			sound_event_name = "player_combat_weapon_fire_grenade_explosion",
			damage_interval = 1,
			duration = 4,
			area_damage_template = "explosion_template_aoe",
			nav_mesh_effect = {
				particle_radius = 2,
				particle_name = "fx/wpnfx_fire_grenade_impact_remains",
				particle_spacing = 0.9
			}
		}
	},
	conflag_t3 = {
		aoe = {
			nav_tag_volume_layer = "fire_grenade",
			radius = 4,
			create_nav_tag_volume = true,
			attack_template = "fire_grenade_dot",
			sound_event_name = "player_combat_weapon_fire_grenade_explosion",
			damage_interval = 1,
			duration = 4,
			area_damage_template = "explosion_template_aoe",
			nav_mesh_effect = {
				particle_radius = 2,
				particle_name = "fx/wpnfx_fire_grenade_impact_remains",
				particle_spacing = 0.9
			}
		}
	},
	portal_transformer = {
		explosion = {
			always_hurt_players = true,
			radius = 5,
			max_damage_radius = 2,
			attack_template_glance = "drakegun_glance",
			damage_type_glance = "grenade_glance",
			player_push_speed = 5,
			attack_template = "drakegun",
			damage_type = "grenade",
			alert_enemies = false,
			level_unit_damage = true,
			damage = {
				20,
				10,
				80,
				20
			}
		}
	}
}
ExplosionTemplates.sniper_poison_arrow_t2 = table.clone(ExplosionTemplates.sniper_poison_arrow)
ExplosionTemplates.sniper_poison_arrow_t2.explosion.attack_template = "arrow_poison_aoe_t2"
ExplosionTemplates.sniper_poison_arrow_t3 = table.clone(ExplosionTemplates.sniper_poison_arrow)
ExplosionTemplates.sniper_poison_arrow_t3.explosion.attack_template = "arrow_poison_aoe_t3"
ExplosionTemplates.machinegun_poison_arrow_t2 = table.clone(ExplosionTemplates.machinegun_poison_arrow)
ExplosionTemplates.machinegun_poison_arrow_t2.explosion.attack_template = "arrow_poison_aoe_t2"
ExplosionTemplates.machinegun_poison_arrow_t3 = table.clone(ExplosionTemplates.machinegun_poison_arrow)
ExplosionTemplates.machinegun_poison_arrow_t3.explosion.attack_template = "arrow_poison_aoe_t3"
ExplosionTemplates.carbine_poison_arrow_t2 = table.clone(ExplosionTemplates.carbine_poison_arrow)
ExplosionTemplates.carbine_poison_arrow_t2.explosion.attack_template = "arrow_poison_aoe_t2"
ExplosionTemplates.carbine_poison_arrow_t3 = table.clone(ExplosionTemplates.carbine_poison_arrow)
ExplosionTemplates.carbine_poison_arrow_t3.explosion.attack_template = "arrow_poison_aoe_t3"
ExplosionTemplates.drakegun_charged_t2 = table.clone(ExplosionTemplates.drakegun_charged)
ExplosionTemplates.drakegun_charged_t2.explosion.damage_min = {
	4,
	1,
	12,
	2
}
ExplosionTemplates.drakegun_charged_t2.explosion.damage_max = {
	6,
	2,
	24,
	4
}
ExplosionTemplates.drakegun_charged_t2.explosion.attack_template = "drakegun_t2"
ExplosionTemplates.drakegun_charged_t2.explosion.attack_template_glance = "drakegun_glance_t2"
ExplosionTemplates.drakegun_charged_t3 = table.clone(ExplosionTemplates.drakegun_charged)
ExplosionTemplates.drakegun_charged_t3.explosion.damage_min = {
	5,
	1,
	12,
	2
}
ExplosionTemplates.drakegun_charged_t3.explosion.damage_max = {
	9,
	2,
	24,
	4
}
ExplosionTemplates.drakegun_charged_t3.explosion.attack_template = "drakegun_t3"
ExplosionTemplates.drakegun_charged_t3.explosion.attack_template_glance = "drakegun_glance_t3"
ExplosionTemplates.fireball_charged_t2 = table.clone(ExplosionTemplates.fireball_charged)
ExplosionTemplates.fireball_charged_t2.explosion.damage_min = {
	4,
	3,
	18,
	2
}
ExplosionTemplates.fireball_charged_t2.explosion.damage_max = {
	6,
	5,
	30,
	3
}
ExplosionTemplates.fireball_charged_t2.explosion.attack_template = "drakegun_t2"
ExplosionTemplates.fireball_charged_t2.explosion.attack_template_glance = "drakegun_glance_t2"
ExplosionTemplates.fireball_charged_t3 = table.clone(ExplosionTemplates.fireball_charged)
ExplosionTemplates.fireball_charged_t3.explosion.damage_min = {
	5,
	4,
	22,
	2.5
}
ExplosionTemplates.fireball_charged_t3.explosion.damage_max = {
	8,
	7,
	36,
	4
}
ExplosionTemplates.fireball_charged_t3.explosion.attack_template = "drakegun_t3"
ExplosionTemplates.fireball_charged_t3.explosion.attack_template_glance = "drakegun_glance_t3"

for name, templates in pairs(ExplosionTemplates) do
	templates.name = name
end

return 
