require("scripts/settings/explosion_templates")

ProjectileGravitySettings = {
	default = -9.82,
	bolts = -0.5,
	drakegun = -9.82,
	spark = -0.5,
	drake_pistols = 0,
	arrows = -5,
	fireball = -9.82,
	staff = -9.82,
	flame_wave_fireball = -6
}
Projectiles = {
	normal_arrow = {
		impact_type = "raycast",
		trajectory_template_name = "throw_trajectory",
		projectile_unit_template_name = "player_projectile_unit",
		gravity_settings = "arrows",
		dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3p",
		projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3ps",
		dummy_linker_broken_units = {
			"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_01_3ps",
			"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_02_3ps",
			"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_03_3ps"
		},
		impact_data = {
			wall_nail = true,
			depth = 0.1,
			targets = 1,
			link = true,
			depth_offset = -0.6,
			damage = {
				enemy_unit_hit = {
					default_target = {
						attack_template_damage_type = "no_damage",
						attack_template = "arrow_carbine"
					}
				},
				damagable_prop_hit = {
					attack_template_damage_type = "no_damage",
					attack_template = "arrow_carbine"
				}
			}
		}
	}
}
Projectiles.default = table.create_copy(Projectiles.normal_arrow, Projectiles.normal_arrow) or table.clone(Projectiles.normal_arrow)
Projectiles.normal_arrow = table.create_copy(Projectiles.normal_arrow, Projectiles.normal_arrow) or table.clone(Projectiles.default)
Projectiles.machinegun_arrow = {
	impact_type = "raycast",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	gravity_settings = "arrows",
	dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3p",
	projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3ps",
	dummy_linker_broken_units = {
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_01_3ps",
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_02_3ps",
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_03_3ps"
	},
	impact_data = {
		wall_nail = true,
		depth = 0.075,
		targets = 1,
		link = true,
		depth_offset = -0.6,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "machinegun",
					attack_template = "arrow_machinegun"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "machinegun",
				attack_template = "arrow_machinegun"
			}
		}
	}
}
Projectiles.machinegun_arrow = table.clone(Projectiles.machinegun_arrow) or table.clone(Projectiles.default)
Projectiles.machinegun_arrow_t2 = table.clone(Projectiles.machinegun_arrow)
Projectiles.machinegun_arrow_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps"
Projectiles.machinegun_arrow_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Projectiles.machinegun_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "machinegun_t2"
Projectiles.machinegun_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "machinegun_t2"
Projectiles.machinegun_arrow_t3 = table.clone(Projectiles.machinegun_arrow)
Projectiles.machinegun_arrow_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps"
Projectiles.machinegun_arrow_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Projectiles.machinegun_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "machinegun_t3"
Projectiles.machinegun_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "machinegun_t3"
Projectiles.carbine_arrow = {
	impact_type = "raycast",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	gravity_settings = "arrows",
	dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3p",
	projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3ps",
	dummy_linker_broken_units = {
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_01_3ps",
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_02_3ps",
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_03_3ps"
	},
	impact_data = {
		wall_nail = true,
		depth = 0.1,
		targets = 1,
		link = true,
		depth_offset = -0.6,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine",
					attack_template = "arrow_carbine"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine",
				attack_template = "arrow_carbine"
			}
		}
	}
}
Projectiles.carbine_arrow = table.clone(Projectiles.carbine_arrow) or table.clone(Projectiles.default)
Projectiles.carbine_arrow_t2 = table.clone(Projectiles.carbine_arrow)
Projectiles.carbine_arrow_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps"
Projectiles.carbine_arrow_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Projectiles.carbine_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_t2"
Projectiles.carbine_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_t2"
Projectiles.carbine_arrow_t3 = table.clone(Projectiles.carbine_arrow)
Projectiles.carbine_arrow_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps"
Projectiles.carbine_arrow_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Projectiles.carbine_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_t3"
Projectiles.carbine_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_t3"
Projectiles.sniper_arrow = {
	impact_type = "raycast",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	gravity_settings = "arrows",
	dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3p",
	projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t1_3ps",
	dummy_linker_broken_units = {
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_01_3ps",
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_02_3ps",
		"units/weapons/player/wpn_we_quiver_t1/wpn_we_broken_arrow_03_3ps"
	},
	impact_data = {
		wall_nail = true,
		depth = 0.15,
		targets = 3,
		link = true,
		depth_offset = -0.6,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "sniper",
					attack_template = "arrow_sniper_1"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "sniper",
				attack_template = "arrow_sniper_1"
			}
		}
	}
}
Projectiles.sniper_arrow = table.clone(Projectiles.sniper_arrow) or table.clone(Projectiles.default)
Projectiles.sniper_arrow_t2 = table.clone(Projectiles.sniper_arrow)
Projectiles.sniper_arrow_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps"
Projectiles.sniper_arrow_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Projectiles.sniper_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_t2"
Projectiles.sniper_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_t2"
Projectiles.sniper_arrow_t3 = table.clone(Projectiles.sniper_arrow)
Projectiles.sniper_arrow_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps"
Projectiles.sniper_arrow_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Projectiles.sniper_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_t3"
Projectiles.sniper_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_t3"
Projectiles.machinegun_bodkin_arrow = table.clone(Projectiles.machinegun_arrow) or table.clone(Projectiles.default)
Projectiles.machinegun_bodkin_arrow.impact_data.targets = 2
Projectiles.machinegun_bodkin_arrow.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "machinegun_AP"
Projectiles.machinegun_bodkin_arrow.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "machinegun_AP"
Projectiles.machinegun_bodkin_arrow_t2 = table.clone(Projectiles.machinegun_bodkin_arrow)
Projectiles.machinegun_bodkin_arrow_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps"
Projectiles.machinegun_bodkin_arrow_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Projectiles.machinegun_bodkin_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "machinegun_AP_t2"
Projectiles.machinegun_bodkin_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "machinegun_AP_t2"
Projectiles.machinegun_bodkin_arrow_t3 = table.clone(Projectiles.machinegun_bodkin_arrow)
Projectiles.machinegun_bodkin_arrow_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps"
Projectiles.machinegun_bodkin_arrow_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Projectiles.machinegun_bodkin_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "machinegun_AP_t3"
Projectiles.machinegun_bodkin_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "machinegun_AP_t3"
Projectiles.carbine_arrow_bodkin = table.clone(Projectiles.carbine_arrow) or table.clone(Projectiles.default)
Projectiles.carbine_arrow_bodkin.impact_data.targets = 3
Projectiles.carbine_arrow_bodkin.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP"
Projectiles.carbine_arrow_bodkin.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP"
Projectiles.carbine_arrow_bodkin_t2 = table.clone(Projectiles.carbine_arrow_bodkin)
Projectiles.carbine_arrow_bodkin_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps"
Projectiles.carbine_arrow_bodkin_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Projectiles.carbine_arrow_bodkin_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t2"
Projectiles.carbine_arrow_bodkin_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP_t2"
Projectiles.carbine_arrow_bodkin_t3 = table.clone(Projectiles.carbine_arrow_bodkin)
Projectiles.carbine_arrow_bodkin_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps"
Projectiles.carbine_arrow_bodkin_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Projectiles.carbine_arrow_bodkin_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t3"
Projectiles.carbine_arrow_bodkin_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP_t3"
Projectiles.sniper_arrow_bodkin = table.clone(Projectiles.sniper_arrow) or table.clone(Projectiles.default)
Projectiles.sniper_arrow_bodkin.impact_data.targets = 5
Projectiles.sniper_arrow_bodkin.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP"
Projectiles.sniper_arrow_bodkin.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP"
Projectiles.sniper_arrow_bodkin_t2 = table.clone(Projectiles.sniper_arrow_bodkin)
Projectiles.sniper_arrow_bodkin_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3ps"
Projectiles.sniper_arrow_bodkin_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t2_3p"
Projectiles.sniper_arrow_bodkin_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP_t2"
Projectiles.sniper_arrow_bodkin_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t2"
Projectiles.sniper_arrow_bodkin_t3 = table.clone(Projectiles.sniper_arrow_bodkin)
Projectiles.sniper_arrow_bodkin_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3ps"
Projectiles.sniper_arrow_bodkin_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_arrow_t3_3p"
Projectiles.sniper_arrow_bodkin_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP_t3"
Projectiles.sniper_arrow_bodkin_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t3"
Projectiles.true_flight_machinegun = table.clone(Projectiles.machinegun_arrow) or table.clone(Projectiles.default)
Projectiles.true_flight_machinegun.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_machinegun.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_machinegun_t2 = table.clone(Projectiles.machinegun_arrow_t2) or table.clone(Projectiles.default)
Projectiles.true_flight_machinegun_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_machinegun_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_machinegun_t3 = table.clone(Projectiles.machinegun_arrow_t3) or table.clone(Projectiles.default)
Projectiles.true_flight_machinegun_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_machinegun_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_carbine = table.clone(Projectiles.carbine_arrow) or table.clone(Projectiles.default)
Projectiles.true_flight_carbine.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_carbine.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_carbine_t2 = table.clone(Projectiles.carbine_arrow_t2) or table.clone(Projectiles.default)
Projectiles.true_flight_carbine_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_carbine_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_carbine_t3 = table.clone(Projectiles.carbine_arrow_t3) or table.clone(Projectiles.default)
Projectiles.true_flight_carbine_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_carbine_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_sniper = table.clone(Projectiles.sniper_arrow) or table.clone(Projectiles.default)
Projectiles.true_flight_sniper.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_sniper.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_sniper.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_sniper_1"
Projectiles.true_flight_sniper_t2 = table.clone(Projectiles.sniper_arrow_t2) or table.clone(Projectiles.default)
Projectiles.true_flight_sniper_t2.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_sniper_t2.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_sniper_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_sniper_1"
Projectiles.true_flight_sniper_t3 = table.clone(Projectiles.sniper_arrow_t3) or table.clone(Projectiles.default)
Projectiles.true_flight_sniper_t3.projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3ps"
Projectiles.true_flight_sniper_t3.dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_homing_arrow_t1_3p"
Projectiles.true_flight_sniper_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_sniper_1"
Projectiles.sniper_poison_arrow = {
	dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3p",
	impact_type = "raycast",
	gravity_settings = "arrows",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "arrow_poison_sniper",
					attack_template = "arrow_poison_sniper"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "arrow_poison_sniper",
				attack_template = "arrow_poison_sniper"
			}
		},
		aoe = ExplosionTemplates.sniper_poison_arrow
	}
}
Projectiles.sniper_poison_arrow = table.clone(Projectiles.sniper_poison_arrow) or table.clone(Projectiles.default)
Projectiles.sniper_poison_arrow_t2 = table.clone(Projectiles.sniper_poison_arrow)
Projectiles.sniper_poison_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_poison_sniper_t2"
Projectiles.sniper_poison_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "arrow_poison_sniper_t2"
Projectiles.sniper_poison_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template = "arrow_poison_sniper_t2"
Projectiles.sniper_poison_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "arrow_poison_sniper_t2"
Projectiles.sniper_poison_arrow_t2.impact_data.aoe = ExplosionTemplates.sniper_poison_arrow_t2
Projectiles.sniper_poison_arrow_t3 = table.clone(Projectiles.sniper_poison_arrow)
Projectiles.sniper_poison_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_poison_sniper_t3"
Projectiles.sniper_poison_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "arrow_poison_sniper_t3"
Projectiles.sniper_poison_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template = "arrow_poison_sniper_t3"
Projectiles.sniper_poison_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "arrow_poison_sniper_t3"
Projectiles.sniper_poison_arrow_t3.impact_data.aoe = ExplosionTemplates.sniper_poison_arrow_t3
Projectiles.machinegun_poison_arrow = {
	dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3p",
	impact_type = "raycast",
	gravity_settings = "arrows",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "arrow_poison_machinegun",
					attack_template = "arrow_poison_machinegun"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "arrow_poison_machinegun",
				attack_template = "arrow_poison_machinegun"
			}
		},
		aoe = ExplosionTemplates.machinegun_poison_arrow
	}
}
Projectiles.machinegun_poison_arrow = table.clone(Projectiles.machinegun_poison_arrow) or table.clone(Projectiles.default)
Projectiles.machinegun_poison_arrow_t2 = table.clone(Projectiles.machinegun_poison_arrow)
Projectiles.machinegun_poison_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_poison_machinegun"
Projectiles.machinegun_poison_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "arrow_poison_machinegun_t2"
Projectiles.machinegun_poison_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template = "arrow_poison_machinegun"
Projectiles.machinegun_poison_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "arrow_poison_machinegun_t2"
Projectiles.machinegun_poison_arrow_t2.impact_data.aoe = ExplosionTemplates.machinegun_poison_arrow_t2
Projectiles.machinegun_poison_arrow_t3 = table.clone(Projectiles.machinegun_poison_arrow)
Projectiles.machinegun_poison_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_poison_machinegun"
Projectiles.machinegun_poison_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "arrow_poison_machinegun_t3"
Projectiles.machinegun_poison_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template = "arrow_poison_machinegun"
Projectiles.machinegun_poison_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "arrow_poison_machinegun_t3"
Projectiles.machinegun_poison_arrow_t3.impact_data.aoe = ExplosionTemplates.machinegun_poison_arrow_t3
Projectiles.carbine_poison_arrow = {
	dummy_linker_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3p",
	impact_type = "raycast",
	gravity_settings = "arrows",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/wpn_we_quiver_t1/wpn_we_poison_arrow_t1_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "arrow_poison_carbine",
					attack_template = "arrow_poison_carbine"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "arrow_poison_carbine",
				attack_template = "arrow_poison_carbine"
			}
		},
		aoe = ExplosionTemplates.carbine_poison_arrow
	}
}
Projectiles.carbine_poison_arrow = table.clone(Projectiles.carbine_poison_arrow) or table.clone(Projectiles.default)
Projectiles.carbine_poison_arrow_t2 = table.clone(Projectiles.carbine_poison_arrow)
Projectiles.carbine_poison_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_poison_carbine"
Projectiles.carbine_poison_arrow_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "arrow_poison_carbine_t2"
Projectiles.carbine_poison_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template = "arrow_poison_carbine"
Projectiles.carbine_poison_arrow_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "arrow_poison_carbine_t2"
Projectiles.carbine_poison_arrow_t2.impact_data.aoe = ExplosionTemplates.carbine_poison_arrow_t2
Projectiles.carbine_poison_arrow_t3 = table.clone(Projectiles.carbine_poison_arrow)
Projectiles.carbine_poison_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template = "arrow_poison_carbine"
Projectiles.carbine_poison_arrow_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "arrow_poison_carbine_t3"
Projectiles.carbine_poison_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template = "arrow_poison_carbine"
Projectiles.carbine_poison_arrow_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "arrow_poison_carbine_t3"
Projectiles.carbine_poison_arrow_t3.impact_data.aoe = ExplosionTemplates.carbine_poison_arrow_t3
Projectiles.crossbow_bolt = {
	dummy_linker_unit_name = "units/weapons/player/wpn_crossbow_quiver/wpn_crossbow_bolt_3p",
	impact_type = "raycast",
	gravity_settings = "bolts",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/wpn_crossbow_quiver/wpn_crossbow_bolt_3ps",
	impact_data = {
		wall_nail = true,
		depth = 0.025,
		targets = 3,
		link = true,
		depth_offset = -0.2,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "sniper_AP",
					attack_template = "bolt_sniper"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "sniper_AP",
				attack_template = "bolt_sniper"
			}
		}
	}
}
Projectiles.crossbow_bolt = table.clone(Projectiles.crossbow_bolt) or table.clone(Projectiles.default)
Projectiles.crossbow_bolt_t2 = table.clone(Projectiles.crossbow_bolt)
Projectiles.crossbow_bolt_t2.impact_data.targets = 4
Projectiles.crossbow_bolt_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP_t2"
Projectiles.crossbow_bolt_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t2"
Projectiles.crossbow_bolt_t3 = table.clone(Projectiles.crossbow_bolt)
Projectiles.crossbow_bolt_t3.impact_data.targets = 5
Projectiles.crossbow_bolt_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP_t3"
Projectiles.crossbow_bolt_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t3"
Projectiles.repeating_crossbow_bolt = table.clone(Projectiles.crossbow_bolt) or table.clone(Projectiles.default)
Projectiles.repeating_crossbow_bolt.impact_data.targets = 2
Projectiles.repeating_crossbow_bolt.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_bolt_AP"
Projectiles.repeating_crossbow_bolt.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_bolt_AP"
Projectiles.repeating_crossbow_bolt_t2 = table.clone(Projectiles.repeating_crossbow_bolt)
Projectiles.repeating_crossbow_bolt_t2.impact_data.targets = 2
Projectiles.repeating_crossbow_bolt_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_bolt_AP_t2"
Projectiles.repeating_crossbow_bolt_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_bolt_AP_t2"
Projectiles.repeating_crossbow_bolt_t3 = table.clone(Projectiles.repeating_crossbow_bolt)
Projectiles.repeating_crossbow_bolt_t3.impact_data.targets = 2
Projectiles.repeating_crossbow_bolt_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_bolt_AP_t3"
Projectiles.repeating_crossbow_bolt_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_bolt_AP_t3"
Projectiles.drakegun_projectile = {
	radius = 0.2,
	gravity_settings = "drakegun",
	fire_from_muzzle = true,
	trajectory_template_name = "throw_trajectory",
	impact_type = "sphere_sweep",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/drakegun_projectile/drakegun_projectile_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine_AP",
					attack_template = "drakegun_shot"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine_AP",
				attack_template = "drakegun_shot"
			}
		}
	}
}
Projectiles.drakegun_projectile = table.clone(Projectiles.drakegun_projectile) or table.clone(Projectiles.default)
Projectiles.drakegun_projectile_t2 = table.clone(Projectiles.drakegun_projectile)
Projectiles.drakegun_projectile_t2.impact_data.targets = 2
Projectiles.drakegun_projectile_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t2"
Projectiles.drakegun_projectile_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP_t2"
Projectiles.drakegun_projectile_t3 = table.clone(Projectiles.drakegun_projectile)
Projectiles.drakegun_projectile_t3.impact_data.targets = 3
Projectiles.drakegun_projectile_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t3"
Projectiles.drakegun_projectile_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP_t3"
Projectiles.drakegun_projectile_charged = {
	impact_type = "sphere_sweep",
	fire_from_muzzle = true,
	radius_max = 0.3,
	trajectory_template_name = "throw_trajectory",
	radius_min = 0.2,
	projectile_unit_name = "units/weapons/player/drakegun_projectile_charged/drakegun_projectile_charged_3ps",
	gravity_settings = "drakegun",
	times_bigger = 4,
	projectile_unit_template_name = "player_projectile_unit",
	impact_data = {
		targets = 1,
		aoe = ExplosionTemplates.drakegun_charged
	},
	timed_data = {
		life_time = 1.5,
		aoe = ExplosionTemplates.drakegun_charged
	}
}
Projectiles.drakegun_projectile_charged = table.clone(Projectiles.drakegun_projectile_charged) or table.clone(Projectiles.default)
Projectiles.drakegun_projectile_charged_t2 = table.clone(Projectiles.drakegun_projectile_charged)
Projectiles.drakegun_projectile_charged_t2.impact_data.aoe = ExplosionTemplates.drakegun_charged_t2
Projectiles.drakegun_projectile_charged_t3 = table.clone(Projectiles.drakegun_projectile_charged)
Projectiles.drakegun_projectile_charged_t3.impact_data.aoe = ExplosionTemplates.drakegun_charged_t3
Projectiles.brace_of_drake_pistols_shot = {
	radius = 0.15,
	impact_type = "sphere_sweep",
	gravity_settings = "drakegun",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/drake_pistol_projectile/drake_pistol_projectile_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "no_damage",
					attack_template = "drake_pistol_shot"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "no_damage",
				attack_template = "drake_pistol_shot"
			}
		}
	},
	timed_data = {
		life_time = 1,
		aoe = {
			explosion = {
				attack_template_damage_type = "default",
				max_damage_radius_min = 0.1,
				radius_max = 1,
				attack_template_glance = "drakegun_glance",
				damage_type_glance = "drakegun_glance",
				radius_min = 0.5,
				attack_template = "drakegun",
				sound_event_name = "drakepistol_hit",
				max_damage_radius_max = 0.75,
				damage_type = "drakegun",
				effect_name = "fx/wpnfx_drake_pistols_projectile_impact",
				damage_min = {
					1,
					1,
					1,
					1
				},
				damage_max = {
					1,
					1,
					1,
					1
				}
			}
		}
	}
}
Projectiles.brace_of_drake_pistols_shot = table.clone(Projectiles.brace_of_drake_pistols_shot) or table.clone(Projectiles.default)
Projectiles.brace_of_drake_pistols_shot_t2 = table.clone(Projectiles.brace_of_drake_pistols_shot)
Projectiles.brace_of_drake_pistols_shot_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template = "drake_pistol_shot_t2"
Projectiles.brace_of_drake_pistols_shot_t2.impact_data.damage.damagable_prop_hit.attack_template = "drake_pistol_shot_t2"
Projectiles.brace_of_drake_pistols_shot_t3 = table.clone(Projectiles.brace_of_drake_pistols_shot)
Projectiles.brace_of_drake_pistols_shot_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template = "drake_pistol_shot_t3"
Projectiles.brace_of_drake_pistols_shot_t3.impact_data.damage.damagable_prop_hit.attack_template = "drake_pistol_shot_t3"
Projectiles.fireball = {
	radius = 0.2,
	impact_type = "sphere_sweep",
	fire_from_muzzle = false,
	trajectory_template_name = "throw_trajectory",
	muzzle_name = "fx_01",
	projectile_unit_name = "units/weapons/player/fireball_projectile/fireball_projectile_3ps",
	gravity_settings = "drakegun",
	projectile_unit_template_name = "player_projectile_unit",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine_AP",
					attack_template = "drakegun_shot"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine_AP",
				attack_template = "drakegun_shot"
			}
		}
	}
}
Projectiles.fireball = table.clone(Projectiles.fireball) or table.clone(Projectiles.default)
Projectiles.fireball_t2 = table.clone(Projectiles.fireball)
Projectiles.fireball_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t2"
Projectiles.fireball_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP_t2"
Projectiles.fireball_t3 = table.clone(Projectiles.fireball)
Projectiles.fireball_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t3"
Projectiles.fireball_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "carbine_AP_t3"
Projectiles.fireball_charged = {
	impact_type = "sphere_sweep",
	fire_from_muzzle = false,
	radius_max = 0.5,
	trajectory_template_name = "throw_trajectory",
	muzzle_name = "fx_01",
	radius_min = 0.2,
	projectile_unit_name = "units/weapons/player/fireball_projectile/charged_fireball_projectile_3ps",
	gravity_settings = "drakegun",
	times_bigger = 4,
	projectile_unit_template_name = "player_projectile_unit",
	impact_data = {
		targets = 8,
		aoe = ExplosionTemplates.fireball_charged,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "boomer",
					attack_template = "drakegun_shot"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "boomer",
				attack_template = "drakegun_shot"
			}
		}
	},
	timed_data = {
		life_time = 1.5,
		aoe = ExplosionTemplates.fireball_charged
	}
}
Projectiles.fireball_charged = table.clone(Projectiles.fireball_charged) or table.clone(Projectiles.default)
Projectiles.fireball_charged_t2 = table.clone(Projectiles.fireball_charged)
Projectiles.fireball_charged_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "boomer_t2"
Projectiles.fireball_charged_t2.impact_data.aoe = ExplosionTemplates.fireball_charged_t2
Projectiles.fireball_charged_t2.timed_data.aoe = ExplosionTemplates.fireball_charged_t2
Projectiles.fireball_charged_t3 = table.clone(Projectiles.fireball_charged)
Projectiles.fireball_charged_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "boomer_t3"
Projectiles.fireball_charged_t3.impact_data.aoe = ExplosionTemplates.fireball_charged_t3
Projectiles.fireball_charged_t3.timed_data.aoe = ExplosionTemplates.fireball_charged_t3
local flame_wave_fireball = {
	radius = 0.2,
	gravity_settings = "flame_wave_fireball",
	impact_type = "sphere_sweep",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/fireball_projectile/fireball_projectile_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine_AP",
					attack_template = "drakegun_shot"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine_AP",
				attack_template = "drakegun_shot"
			}
		},
		projectile_spawn = {
			scale = 0,
			initial_forward_speed = 20,
			spawner_function = "flame_wave",
			sub_action_name = "flame_wave"
		}
	}
}
Projectiles.flame_wave_fireball = table.create_copy(Projectiles.flame_wave_fireball, flame_wave_fireball)
local flame_wave = {
	radius = 1,
	impact_type = "sphere_sweep",
	scene_query_height_offset = 1,
	trajectory_template_name = "throw_trajectory",
	collision_filter = "filter_enemy_unit",
	projectile_unit_name = "units/weapons/player/flame_wave_projectile/flame_wave_projectile_3ps",
	gravity_settings = "drakegun",
	times_bigger = 4,
	projectile_unit_template_name = "flame_wave_projectile_unit",
	impact_data = {
		targets = math.huge,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine_AP",
					attack_template = "flame_wave"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine_AP",
				attack_template = "flame_wave"
			}
		}
	}
}
Projectiles.flame_wave = table.create_copy(Projectiles.flame_wave, flame_wave)
local bouncing_fireball = {
	radius = 0.2,
	gravity_settings = "drakegun",
	impact_type = "sphere_sweep",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/fireball_projectile/fireball_projectile_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine_AP",
					attack_template = "drakegun_shot"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine_AP",
				attack_template = "drakegun_shot"
			}
		},
		projectile_spawn = {
			spawner_function = "split_bounce",
			sub_action_name = "bouncing_fireball_2"
		}
	}
}
Projectiles.bouncing_fireball = table.create_copy(Projectiles.bouncing_fireball, bouncing_fireball)
local bouncing_fireball_2 = table.clone(bouncing_fireball)
bouncing_fireball_2.impact_data.projectile_spawn.sub_action_name = "bouncing_fireball_3"
Projectiles.bouncing_fireball_2 = table.create_copy(Projectiles.bouncing_fireball_2, bouncing_fireball_2)
local bouncing_fireball_3 = table.clone(bouncing_fireball)
bouncing_fireball_3.impact_data.projectile_spawn = nil
Projectiles.bouncing_fireball_3 = table.create_copy(Projectiles.bouncing_fireball_3, bouncing_fireball_3)
Projectiles.spark = {
	radius = 0.1,
	impact_type = "sphere_sweep",
	gravity_settings = "spark",
	trajectory_template_name = "throw_trajectory",
	projectile_unit_template_name = "player_projectile_unit",
	projectile_unit_name = "units/weapons/player/spear_projectile/spark_3ps",
	impact_data = {
		targets = 1,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "spark_AP",
					attack_template = "wizard_staff_spark"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "spark_AP",
				attack_template = "wizard_staff_spark"
			}
		}
	},
	timed_data = {
		sound_event_name = "magic_hit",
		life_time = 1.5
	}
}
Projectiles.spark = table.clone(Projectiles.spark) or table.clone(Projectiles.default)
Projectiles.spark_t2 = table.clone(Projectiles.spark)
Projectiles.spark_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "spark_AP_t2"
Projectiles.spark_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "spark_AP_t2"
Projectiles.spark_t3 = table.clone(Projectiles.spark)
Projectiles.spark_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "spark_AP_t3"
Projectiles.spark_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "spark_AP_t3"
Projectiles.spear = {
	impact_type = "sphere_sweep",
	radius_max = 0.35,
	trajectory_template_name = "throw_trajectory",
	radius_min = 0.25,
	projectile_unit_name = "units/weapons/player/spear_projectile/spear_3ps",
	gravity_settings = "spark",
	projectile_unit_template_name = "player_projectile_unit",
	impact_data = {
		targets = 2,
		damage = {
			enemy_unit_hit = {
				default_target = {
					attack_template_damage_type = "carbine_AP",
					attack_template = "wizard_staff_spear"
				}
			},
			damagable_prop_hit = {
				attack_template_damage_type = "carbine_AP",
				attack_template = "wizard_staff_spear"
			}
		}
	},
	timed_data = {
		sound_event_name = "magic_hit",
		life_time = 1.5
	}
}
Projectiles.spear = table.clone(Projectiles.spear) or table.clone(Projectiles.default)
Projectiles.spear_2 = table.clone(Projectiles.spear)
Projectiles.spear_2.impact_data.targets = 2
Projectiles.spear_2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP"
Projectiles.spear_2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP"
Projectiles.spear_3 = table.clone(Projectiles.spear)
Projectiles.spear_3.impact_data.targets = 5
Projectiles.spear_3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_shot_AP"
Projectiles.spear_3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP"
Projectiles.spear_t2 = table.clone(Projectiles.spear)
Projectiles.spear_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t2"
Projectiles.spear_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t2"
Projectiles.spear_2_t2 = table.clone(Projectiles.spear)
Projectiles.spear_2_t2.impact_data.targets = 2
Projectiles.spear_2_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP_t2"
Projectiles.spear_2_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t2"
Projectiles.spear_3_t2 = table.clone(Projectiles.spear)
Projectiles.spear_3_t2.impact_data.targets = 5
Projectiles.spear_3_t2.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_shot_AP_t2"
Projectiles.spear_3_t2.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t2"
Projectiles.spear_t3 = table.clone(Projectiles.spear)
Projectiles.spear_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "carbine_AP_t3"
Projectiles.spear_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t3"
Projectiles.spear_2_t3 = table.clone(Projectiles.spear)
Projectiles.spear_2_t3.impact_data.targets = 2
Projectiles.spear_2_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_AP_t3"
Projectiles.spear_2_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t3"
Projectiles.spear_3_t3 = table.clone(Projectiles.spear)
Projectiles.spear_3_t3.impact_data.targets = 5
Projectiles.spear_3_t3.impact_data.damage.enemy_unit_hit.default_target.attack_template_damage_type = "sniper_shot_AP_t3"
Projectiles.spear_3_t3.impact_data.damage.damagable_prop_hit.attack_template_damage_type = "sniper_AP_t3"
Projectiles.grenade = {
	projectile_template_name = "explosion",
	radius = 0.1,
	impact_type = "sphere_sweep",
	life_time = 3,
	trajectory_template_name = "throw_trajectory",
	pickup_name = "grenade",
	projectile_unit_name = "units/weapons/player/wpn_emp_grenade_01_t1/wpn_emp_grenade_01_t1_3p",
	projectile_type = "impact_grenade",
	is_grenade = true,
	gravity_settings = "drakegun",
	projectile_unit_template_name = "player_projectile_unit",
	time_to_trigger_impact = 1,
	impact_data = {
		grenade = true,
		targets = 1,
		aoe = {
			explosion = {
				damage_type = "grenade",
				radius = 5,
				max_damage_radius = 2,
				sound_event_name = "player_combat_weapon_grenade_explosion",
				damage_type_glance = "grenade_glance",
				alert_enemies = true,
				attack_template = "grenade",
				alert_enemies_radius = 20,
				attack_template_glance = "grenade_glance",
				effect_name = "fx/wpnfx_frag_grenade_impact",
				damage = {
					20,
					7,
					80,
					20
				},
				fallof_damage = {
					5,
					5,
					80,
					20
				}
			}
		}
	},
	timed_data = {
		life_time = 3,
		aoe = {
			explosion = {
				damage_type = "grenade",
				radius = 5,
				max_damage_radius = 2,
				sound_event_name = "player_combat_weapon_grenade_explosion",
				damage_type_glance = "grenade_glance",
				alert_enemies = true,
				attack_template = "grenade",
				alert_enemies_radius = 20,
				attack_template_glance = "grenade_glance",
				effect_name = "fx/wpnfx_frag_grenade_impact",
				damage = {
					20,
					7,
					80,
					20
				},
				fallof_damage = {
					5,
					5,
					80,
					20
				}
			}
		}
	}
}
Projectiles.grenade_fire = {
	projectile_template_name = "explosion",
	radius = 0.1,
	impact_type = "sphere_sweep",
	life_time = 3,
	trajectory_template_name = "throw_trajectory",
	pickup_name = "grenade",
	projectile_unit_name = "units/weapons/player/wpn_emp_grenade_01_t1/wpn_emp_grenade_01_t1_3p",
	projectile_type = "impact_grenade",
	is_grenade = true,
	gravity_settings = "drakegun",
	projectile_unit_template_name = "player_projectile_unit",
	time_to_trigger_impact = 1,
	impact_data = {
		sound_event_name = "player_combat_weapon_fire_grenade_explosion",
		grenade = true,
		targets = 1,
		aoe = ExplosionTemplates.fire_grenade
	},
	timed_data = {
		life_time = 3,
		aoe = ExplosionTemplates.fire_grenade
	}
}
Projectiles.conflag_aoe_t1 = {
	impact_data = {
		sound_event_name = "player_combat_weapon_fire_grenade_explosion",
		targets = 1,
		aoe = ExplosionTemplates.conflag_t1
	},
	timed_data = {
		life_time = 3,
		aoe = ExplosionTemplates.conflag_t1
	}
}
Projectiles.conflag_aoe_t2 = {
	impact_data = {
		sound_event_name = "player_combat_weapon_fire_grenade_explosion",
		targets = 1,
		aoe = ExplosionTemplates.conflag_t2
	},
	timed_data = {
		life_time = 3,
		aoe = ExplosionTemplates.conflag_t2
	}
}
Projectiles.conflag_aoe_t3 = {
	impact_data = {
		sound_event_name = "player_combat_weapon_fire_grenade_explosion",
		targets = 1,
		aoe = ExplosionTemplates.conflag_t3
	},
	timed_data = {
		life_time = 3,
		aoe = ExplosionTemplates.conflag_t3
	}
}
Projectiles.grenade_gas = {
	projectile_template_name = "explosion",
	radius = 0.1,
	impact_type = "sphere_sweep",
	life_time = 3,
	trajectory_template_name = "throw_trajectory",
	pickup_name = "grenade",
	projectile_unit_name = "units/weapons/player/wpn_emp_grenade_01_t1/wpn_emp_grenade_01_t1_3p",
	projectile_type = "impact_grenade",
	is_grenade = true,
	gravity_settings = "drakegun",
	projectile_unit_template_name = "player_projectile_unit",
	time_to_trigger_impact = 1,
	impact_data = {
		grenade = true,
		targets = 1,
		aoe = ExplosionTemplates.smoke_grenade
	},
	timed_data = {
		life_time = 15,
		aoe = ExplosionTemplates.smoke_grenade
	}
}

for name, data in pairs(Projectiles) do
	data.name = name
end

return 
