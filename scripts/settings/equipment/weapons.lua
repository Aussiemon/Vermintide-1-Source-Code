require("scripts/settings/attachment_node_linking")
require("scripts/unit_extensions/generic/interactions")
require("scripts/utils/action_assert_funcs")
require("scripts/settings/dlc_settings")
dofile("scripts/settings/explosion_templates")
dofile("scripts/settings/equipment/projectiles")
require("scripts/settings/action_templates")
dofile("scripts/settings/equipment/1h_swords")
dofile("scripts/settings/equipment/1h_dagger_wizard")
dofile("scripts/settings/equipment/1h_swords_wood_elf")
dofile("scripts/settings/equipment/1h_swords_wizard")
dofile("scripts/settings/equipment/1h_swords_shield")
dofile("scripts/settings/equipment/1h_axes_shield")
dofile("scripts/settings/equipment/1h_hammers_shield")
dofile("scripts/settings/equipment/fencing_swords")
dofile("scripts/settings/equipment/dual_wield_swords")
dofile("scripts/settings/equipment/dual_wield_sword_dagger")
dofile("scripts/settings/equipment/dual_wield_daggers")
dofile("scripts/settings/equipment/1h_falchions")
dofile("scripts/settings/equipment/1h_axes")
dofile("scripts/settings/equipment/1h_hammers")
dofile("scripts/settings/equipment/1h_hammers_wizard")
dofile("scripts/settings/equipment/2h_swords")
dofile("scripts/settings/equipment/2h_axes")
dofile("scripts/settings/equipment/2h_axes_wood_elf")
dofile("scripts/settings/equipment/2h_hammers")
dofile("scripts/settings/equipment/2h_hammers_wizard")
dofile("scripts/settings/equipment/2h_picks")
dofile("scripts/settings/equipment/shortbows")
dofile("scripts/settings/equipment/shortbows_bodkin")
dofile("scripts/settings/equipment/shortbows_trueflight")
dofile("scripts/settings/equipment/shortbows_hagbane")
dofile("scripts/settings/equipment/longbows")
dofile("scripts/settings/equipment/longbows_bodkin")
dofile("scripts/settings/equipment/longbows_hagbane")
dofile("scripts/settings/equipment/longbows_trueflight")
dofile("scripts/settings/equipment/crossbows")
dofile("scripts/settings/equipment/repeating_crossbows")
dofile("scripts/settings/equipment/brace_of_pistols")
dofile("scripts/settings/equipment/brace_of_drake_pistols")
dofile("scripts/settings/equipment/repeating_pistols")
dofile("scripts/settings/equipment/brace_of_repeating_pistols")
dofile("scripts/settings/equipment/blunderbusses")
dofile("scripts/settings/equipment/grudge_raker")
dofile("scripts/settings/equipment/handguns")
dofile("scripts/settings/equipment/repeating_handguns")
dofile("scripts/settings/equipment/drakegun")
dofile("scripts/settings/equipment/staff_spark_spear")
dofile("scripts/settings/equipment/staff_fireball_fireball")
dofile("scripts/settings/equipment/staff_fireball_geiser")
dofile("scripts/settings/equipment/staff_slam_geiser")
dofile("scripts/settings/equipment/staff_blast_beam")
dofile("scripts/settings/equipment/staff_firefly_flamewave")
dofile("scripts/settings/equipment/potions")
dofile("scripts/settings/equipment/scrolls")
dofile("scripts/settings/equipment/first_aid_kits")
dofile("scripts/settings/equipment/healing_draught")
dofile("scripts/settings/equipment/sacks")
dofile("scripts/settings/equipment/statues")
dofile("scripts/settings/equipment/barrels")
dofile("scripts/settings/equipment/grenades")
dofile("scripts/settings/equipment/torches")
dofile("scripts/settings/equipment/grimoire")
dofile("scripts/settings/equipment/brawl_weapons")
dofile("scripts/settings/equipment/packmaster_claw")

for dlc_name, dlc in pairs(DLCSettings) do
	local weapons = dlc.weapons

	for _, weapon in ipairs(weapons) do
		dofile(weapon)
	end
end

Weapons = Weapons or {}
local POSITION_LOOKUP = POSITION_LOOKUP
Attacks = {
	damage = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)
			local damage = attack_damage_value or attack_template.damage
			local damage_amount = DamageUtils.calculate_damage(damage, hit_unit, attacker_unit, hit_zone_name, nil, backstab_multiplier, hawkeye_multiplier)

			return damage_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, damage_amount)
			local damage_type = attack_template.damage_type

			DamageUtils.add_damage_network(hit_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, attack_direction, damage_source, hit_ragdoll_actor)
		end
	},
	damage_headshot = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)
			local damage = attack_damage_value or attack_template.damage
			local damage_amount = DamageUtils.calculate_damage(damage, hit_unit, attacker_unit, hit_zone_name, attack_template.headshot_multiplier, backstab_multiplier, hawkeye_multiplier)

			return damage_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, damage_amount)
			local damage_type = attack_template.damage_type

			DamageUtils.add_damage_network(hit_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, attack_direction, damage_source, hit_ragdoll_actor)
		end
	},
	hacky_damage_burn = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, backstab_multiplier, hawkeye_multiplier)
			local damage = attack_damage_value or attack_template.damage
			local damage_amount = DamageUtils.calculate_damage(damage, hit_unit, attacker_unit, hit_zone_name, nil, backstab_multiplier, hawkeye_multiplier)

			return damage_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, damage_amount)
			local damage_type = attack_template.damage_type
			local hit_zone = hit_zone_name or "full"

			DamageUtils.add_damage_network(hit_unit, attacker_unit, damage_amount, hit_zone, damage_type, attack_direction, damage_source)
		end
	},
	heal = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value)
			return attack_template.heal_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, heal_amount)
			local heal_type = attack_template.heal_type

			DamageUtils.heal_network(hit_unit, attacker_unit, heal_amount, heal_type, damage_source)
		end
	},
	damage_dropoff = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value)
			local range_dropoff_settings = attack_template.range_dropoff_settings
			local damage_amount = DamageUtils.calculate_damage_range_dropoff(attack_template.damage_near, attack_template.damage_far, range_dropoff_settings, hit_unit, attacker_unit, hit_zone_name, attack_template.headshot_multiplier)

			return damage_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, damage_amount)
			local damage_type = attack_template.damage_type

			DamageUtils.add_damage_network(hit_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, attack_direction, damage_source)
		end
	},
	grenade = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value)
			local damage_amount = attack_template.damage_amount

			return damage_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, damage_amount)
			local damage_type = attack_template.damage_type

			DamageUtils.add_damage_network(hit_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, attack_direction, damage_source)
		end
	},
	debug_damage_player = {
		get_damage_amount = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value)
			local damage_amount = attack_template.damage

			return damage_amount
		end,
		do_damage = function (damage_source, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, hit_ragdoll_actor, damage_amount)
			local damage_type = attack_template.damage_type

			DamageUtils.add_damage_network(hit_unit, attacker_unit, damage_amount, hit_zone_name, damage_type, attack_direction, damage_source)
		end
	}
}
Staggers = {
	ai_stagger = function (attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, t)
		if not DamageUtils.is_enemy(hit_unit) then
			return
		end

		local ai_extension = ScriptUnit.extension(hit_unit, "ai_system")
		local blackboard = ai_extension:blackboard()
		local breed_data = Unit.get_data(hit_unit, "breed")
		local hit_unit_pos = POSITION_LOOKUP[hit_unit] or Unit.world_position(hit_unit, 0)
		local attacker_pos = POSITION_LOOKUP[attacker_unit] or Unit.world_position(attacker_unit, 0)
		local breed = blackboard and blackboard.breed
		local ranged_shield = breed and breed.ranged_shield

		if ranged_shield then
			local attacker_distance = Vector3.distance(attacker_pos, hit_unit_pos)
			local ranged_shield_distance = ranged_shield.distance

			if ranged_shield_distance < attacker_distance then
				local hit_flow_event = ranged_shield.hit_flow_event

				if hit_flow_event then
					Unit.flow_event(hit_unit, hit_flow_event)
				end

				return
			end
		end

		local stagger_type_table = attack_template.stagger_impact or nil
		local stagger_duration_table = attack_template.stagger_duration or nil
		local stagger_type, stagger_duration = DamageUtils.calculate_stagger(stagger_type_table, stagger_duration_table, hit_unit, attacker_unit, attack_template)
		local angle = attack_template.stagger_angle or 0

		if angle == "stab" or angle == "smiter" then
			attack_direction = Vector3.normalize(hit_unit_pos - attacker_pos)
		elseif angle == "down" then
			attack_direction = Vector3.normalize(hit_unit_pos - attacker_pos)
			attack_direction.z = -1
		end

		if stagger_type > 0 and (not breed_data.stagger_immune or stagger_type == 6) then
			local stagger_length = DamageUtils.modify_push_distance_with_buff(attacker_unit, attack_template.stagger_length)
			local blackboard = Unit.get_data(hit_unit, "blackboard")

			AiUtils.stagger(hit_unit, blackboard, attacker_unit, attack_direction, stagger_length, stagger_type, stagger_duration, attack_template.stagger_animation_scale, t)
		end
	end
}
local buff_params = {}
Dots = {
	poison_dot = function (attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, damage_source)
		local damage = attack_damage_value or attack_template.damage
		local damage_amount = nil

		if damage then
			damage_amount = DamageUtils.calculate_damage(damage, hit_unit, attacker_unit, hit_zone_name, attack_template.headshot_multiplier)
		end

		local armor = DamageUtils.get_breed_armor(hit_unit)
		local do_dot = true

		if armor == 2 then
			do_dot = damage_amount ~= 0
		end

		if ScriptUnit.has_extension(hit_unit, "buff_system") and do_dot then
			local buff_extension = ScriptUnit.extension(hit_unit, "buff_system")
			buff_params.attacker_unit = attacker_unit
			buff_params.damage_source = damage_source

			buff_extension:add_buff(attack_template.dot_template_name, buff_params)
		end
	end,
	burning_dot = function (attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, attack_damage_value, damage_source)
		if ScriptUnit.has_extension(hit_unit, "buff_system") then
			local buff_extension = ScriptUnit.extension(hit_unit, "buff_system")
			buff_params.attacker_unit = attacker_unit
			buff_params.damage_source = damage_source

			buff_extension:add_buff(attack_template.dot_template_name, buff_params)
		end
	end
}
AttackDamageValues = {
	default = {
		0,
		0,
		0,
		0
	},
	no_damage = {
		0,
		0,
		0,
		0
	},
	dropoff = {
		1,
		0,
		2,
		1
	},
	knockdown_bleed = {
		10,
		10,
		10,
		10
	},
	one_h_smiter_L = {
		4,
		2,
		14,
		2
	},
	one_h_smiter_L_t2 = {
		5,
		2.5,
		16,
		2
	},
	one_h_smiter_L_t3 = {
		6,
		3.5,
		18,
		2
	},
	one_h_smiter_L_ap = {
		4,
		3,
		16,
		2
	},
	one_h_smiter_L_ap_t2 = {
		5,
		4,
		18,
		2
	},
	one_h_smiter_L_ap_t3 = {
		6,
		5,
		20,
		2
	},
	one_h_smiter_H = {
		6,
		2.5,
		20,
		2
	},
	one_h_smiter_H_t2 = {
		8,
		3.5,
		24,
		2
	},
	one_h_smiter_H_t3 = {
		10,
		4.5,
		28,
		2
	},
	two_h_smiter_L = {
		4,
		5,
		16,
		2,
		1
	},
	two_h_smiter_L_t2 = {
		5,
		6.5,
		20,
		2
	},
	two_h_smiter_L_t3 = {
		9,
		8,
		24,
		2
	},
	two_h_smiter_L_1 = {
		5,
		4.5,
		20,
		2
	},
	two_h_smiter_L_1_t2 = {
		6,
		5.5,
		25,
		2
	},
	two_h_smiter_L_1_t3 = {
		10,
		7,
		30,
		2
	},
	two_h_smiter_H = {
		6,
		3.5,
		20,
		2
	},
	two_h_smiter_H_t2 = {
		7,
		4.5,
		25,
		2
	},
	two_h_smiter_H_t3 = {
		8,
		5.5,
		30,
		2
	},
	two_h_smiter_H_1 = {
		12,
		10,
		16,
		2
	},
	two_h_smiter_H_1_t2 = {
		15,
		12,
		18,
		2
	},
	two_h_smiter_H_1_t3 = {
		20,
		16,
		20,
		2
	},
	two_h_smiter_H_2 = {
		15,
		11,
		28,
		2
	},
	two_h_smiter_H_2_t2 = {
		20,
		14,
		34,
		2
	},
	two_h_smiter_H_2_t3 = {
		25,
		20,
		40,
		2
	},
	one_h_linesman_L = {
		1,
		0,
		6,
		2
	},
	one_h_linesman_L_t2 = {
		1.5,
		0,
		8,
		2
	},
	one_h_linesman_L_t3 = {
		2,
		0,
		10,
		2
	},
	one_h_linesman_L_1 = {
		2,
		0,
		6,
		2
	},
	one_h_linesman_L_1_t2 = {
		2.5,
		0,
		8,
		2
	},
	one_h_linesman_L_1_t3 = {
		3,
		0,
		10,
		2
	},
	one_h_linesman_H = {
		2,
		1,
		10,
		2
	},
	one_h_linesman_H_t2 = {
		2.5,
		1.25,
		12,
		2
	},
	one_h_linesman_H_t3 = {
		3,
		1.5,
		14,
		2
	},
	one_h_linesman_H_1 = {
		4,
		3,
		10,
		2
	},
	one_h_linesman_H_1_t2 = {
		5,
		4,
		12,
		2
	},
	one_h_linesman_H_1_t3 = {
		6,
		5,
		14,
		2
	},
	two_h_linesman_L = {
		2,
		0,
		8,
		2
	},
	two_h_linesman_L_t2 = {
		2.5,
		0,
		10,
		2
	},
	two_h_linesman_L_t3 = {
		3,
		0,
		12,
		2
	},
	two_h_linesman_L_1 = {
		2.5,
		0,
		8,
		2
	},
	two_h_linesman_L_1_t2 = {
		3,
		0,
		10,
		2
	},
	two_h_linesman_L_1_t3 = {
		4,
		0,
		12,
		2
	},
	two_h_linesman_L_2 = {
		4,
		2,
		8,
		2
	},
	two_h_linesman_L_2_t2 = {
		5,
		3,
		10,
		2
	},
	two_h_linesman_L_2_t3 = {
		6,
		4,
		12,
		2
	},
	two_h_linesman_L_3 = {
		2,
		1,
		8,
		2
	},
	two_h_linesman_L_3_t2 = {
		3,
		2,
		10,
		2
	},
	two_h_linesman_L_3_t3 = {
		4,
		3,
		12,
		2
	},
	two_h_linesman_H = {
		2.5,
		1,
		12,
		2
	},
	two_h_linesman_H_t2 = {
		3,
		1.5,
		14,
		2
	},
	two_h_linesman_H_t3 = {
		4,
		2,
		16,
		2
	},
	two_h_linesman_H_1 = {
		4,
		1.5,
		12,
		2
	},
	two_h_linesman_H_1_t2 = {
		5,
		2,
		14,
		2
	},
	two_h_linesman_H_1_t3 = {
		6,
		2.5,
		16,
		2
	},
	two_h_linesman_H_ap = {
		3,
		1.5,
		16,
		2
	},
	two_h_linesman_H_ap_t2 = {
		3.5,
		2,
		18,
		2
	},
	two_h_linesman_H_ap_t3 = {
		4,
		2.5,
		20,
		2
	},
	two_h_linesman_H_ap_1 = {
		4,
		2,
		16,
		2
	},
	two_h_linesman_H_ap_1_t2 = {
		5,
		3,
		18,
		2
	},
	two_h_linesman_H_ap_1_t3 = {
		6,
		4,
		20,
		2
	},
	one_h_ninja_L = {
		2,
		0,
		8,
		1
	},
	one_h_ninja_L_t2 = {
		2.5,
		0,
		10,
		1
	},
	one_h_ninja_L_t3 = {
		3.5,
		0,
		12,
		1
	},
	one_h_ninja_L_1 = {
		2.5,
		0.5,
		8,
		1
	},
	one_h_ninja_L_1_t2 = {
		3,
		0.75,
		10,
		1
	},
	one_h_ninja_L_1_t3 = {
		3.5,
		1,
		12,
		1
	},
	one_h_ninja_L_2 = {
		3,
		0,
		8,
		1
	},
	one_h_ninja_L_2_t2 = {
		3.5,
		0,
		10,
		1
	},
	one_h_ninja_L_2_t3 = {
		4,
		0,
		12,
		1
	},
	one_h_ninja_H = {
		3,
		1.5,
		8,
		2
	},
	one_h_ninja_H_t2 = {
		4,
		2,
		10,
		2
	},
	one_h_ninja_H_t3 = {
		5,
		2.5,
		12,
		2
	},
	two_h_ninja_L = {
		3,
		0,
		8,
		2
	},
	two_h_ninja_L_t2 = {
		4,
		0,
		10,
		2
	},
	two_h_ninja_L_t3 = {
		5,
		0,
		12,
		2
	},
	two_h_ninja_H = {
		4,
		2,
		12,
		2
	},
	two_h_ninja_H_t2 = {
		5,
		3,
		14,
		2
	},
	two_h_ninja_H_t3 = {
		6,
		4,
		16,
		2
	},
	one_h_tank_L = {
		1,
		0,
		6,
		2
	},
	one_h_tank_L_t2 = {
		1.5,
		0,
		7,
		2
	},
	one_h_tank_L_t3 = {
		2,
		0,
		8,
		2
	},
	one_h_tank_L_1 = {
		2,
		0,
		6,
		2
	},
	one_h_tank_L_1_t2 = {
		2.5,
		0,
		7,
		2
	},
	one_h_tank_L_1_t3 = {
		3,
		0,
		8,
		2
	},
	one_h_tank_H = {
		2,
		0,
		8,
		2
	},
	one_h_tank_H_t2 = {
		2.5,
		0,
		10,
		2
	},
	one_h_tank_H_t3 = {
		3,
		0,
		12,
		2
	},
	one_h_tank_H_1 = {
		2.5,
		1,
		8,
		2
	},
	one_h_tank_H_1_t2 = {
		3,
		1.5,
		10,
		2
	},
	one_h_tank_H_1_t3 = {
		3.5,
		2,
		12,
		2
	},
	two_h_tank_L = {
		2,
		0,
		8,
		2
	},
	two_h_tank_L_t2 = {
		2.5,
		0,
		10,
		2
	},
	two_h_tank_L_t3 = {
		3,
		0,
		12,
		2
	},
	two_h_tank_L_weak = {
		0.8,
		0,
		2,
		2
	},
	two_h_tank_L_weak_t2 = {
		1,
		0,
		4,
		2
	},
	two_h_tank_L_weak_t3 = {
		1.2,
		0,
		6,
		2
	},
	two_h_tank_H = {
		2.5,
		0,
		12,
		2
	},
	two_h_tank_H_t2 = {
		3,
		0,
		14,
		2
	},
	two_h_tank_H_t3 = {
		3.5,
		0,
		16,
		2
	},
	two_h_tank_H_1 = {
		3,
		2,
		12,
		2
	},
	two_h_tank_H_1_t2 = {
		4,
		3,
		14,
		2
	},
	two_h_tank_H_1_t3 = {
		5,
		4,
		16,
		2
	},
	one_h_brawl_L = {
		0,
		0,
		0,
		15
	},
	one_h_brawl_H = {
		0,
		0,
		0,
		35
	},
	sniper = {
		5,
		2,
		16,
		3
	},
	sniper_t2 = {
		6.5,
		3,
		20,
		3.5
	},
	sniper_t3 = {
		8,
		4,
		24,
		4
	},
	sniper_arrow = {
		5,
		2,
		16,
		3
	},
	sniper_arrow_t2 = {
		7.5,
		3,
		20,
		3.5
	},
	sniper_arrow_t3 = {
		10,
		4,
		24,
		4
	},
	sniper_AP = {
		5,
		5,
		25,
		3.5
	},
	sniper_AP_t2 = {
		7.5,
		7,
		30,
		4
	},
	sniper_AP_t3 = {
		10,
		8,
		35,
		5
	},
	sniper_shot_AP = {
		12,
		8,
		26,
		6
	},
	sniper_shot_AP_t2 = {
		16,
		10,
		31,
		8
	},
	sniper_shot_AP_t3 = {
		20,
		12,
		36,
		10
	},
	carbine = {
		4,
		1.5,
		8,
		2
	},
	carbine_t2 = {
		5,
		2,
		10,
		2.5
	},
	carbine_t3 = {
		6,
		2.5,
		12,
		3
	},
	carbine_AP = {
		4,
		1.5,
		8,
		2
	},
	carbine_AP_t2 = {
		5,
		2,
		10,
		2.5
	},
	carbine_AP_t3 = {
		6,
		2.5,
		12,
		3
	},
	carbine_bolt_AP = {
		5,
		2,
		15,
		2.5
	},
	carbine_bolt_AP_t2 = {
		6,
		2.5,
		20,
		3
	},
	carbine_bolt_AP_t3 = {
		7,
		3,
		25,
		3.5
	},
	machinegun = {
		4,
		0,
		8,
		2
	},
	machinegun_t2 = {
		5,
		0,
		10,
		2.5
	},
	machinegun_t3 = {
		6,
		0,
		12,
		3
	},
	machinegun_AP = {
		2,
		0.5,
		8,
		2
	},
	machinegun_AP_t2 = {
		2.5,
		1,
		10,
		2.5
	},
	machinegun_AP_t3 = {
		3.5,
		1.5,
		12,
		3
	},
	spark_AP = {
		2,
		0.5,
		4,
		2
	},
	spark_AP_t2 = {
		2.5,
		1,
		6,
		2.5
	},
	spark_AP_t3 = {
		3.5,
		1.5,
		8,
		3
	},
	shotgun = {
		3,
		0,
		1.5,
		2
	},
	shotgun_t2 = {
		3,
		0,
		2,
		2
	},
	shotgun_t3 = {
		3,
		0,
		2.5,
		2
	},
	boomer = {
		0.25,
		0,
		6,
		1
	},
	boomer_t2 = {
		0.5,
		0,
		8,
		1.5
	},
	boomer_t3 = {
		0.75,
		0,
		10,
		2
	},
	arrow_poison_machinegun = {
		1,
		0,
		4,
		1
	},
	arrow_poison_machinegun_t2 = {
		1.5,
		0,
		5,
		1.5
	},
	arrow_poison_machinegun_t3 = {
		2,
		0,
		6,
		2
	},
	arrow_poison_carbine = {
		2,
		0.25,
		4,
		2
	},
	arrow_poison_carbine_t2 = {
		2.5,
		0.5,
		5,
		2.5
	},
	arrow_poison_carbine_t3 = {
		3,
		1,
		6,
		3
	},
	arrow_poison_sniper = {
		3,
		1,
		8,
		2
	},
	arrow_poison_sniper_t2 = {
		3.5,
		1.5,
		10,
		2
	},
	arrow_poison_sniper_t3 = {
		4,
		2,
		12,
		2
	},
	poison = {
		1,
		1,
		4,
		0.25
	},
	poison_t2 = {
		1.5,
		1.5,
		5,
		0.25
	},
	poison_t3 = {
		2,
		2,
		6,
		0.25
	},
	poison_aoe = {
		1,
		0.25,
		2,
		0.25
	},
	poison_aoe_t2 = {
		1,
		0.5,
		3,
		0.25
	},
	poison_aoe_t3 = {
		1,
		1,
		4,
		0.25
	},
	burning_dot = {
		1,
		0.5,
		4,
		0.25
	},
	burning_dot_t2 = {
		1,
		0.75,
		6,
		0.25
	},
	burning_dot_t3 = {
		1,
		1,
		8,
		0.25
	},
	beam_burning_dot = {
		0.5,
		0.25,
		4,
		0.25
	},
	beam_burning_dot_t2 = {
		0.5,
		0.25,
		4,
		0.25
	},
	beam_burning_dot_t3 = {
		0.5,
		0.25,
		4,
		0.25
	},
	ratlinggun_easy = {
		3,
		0.5,
		1,
		0.25
	},
	ratlinggun_normal = {
		3,
		0.5,
		2,
		0.5
	},
	ratlinggun_hard = {
		3,
		0.5,
		3,
		1
	},
	ratlinggun_very_hard = {
		3,
		0.5,
		4,
		2
	}
}
AttackTemplates = {
	knockdown_bleed = {
		attack_type = "damage",
		damage_type = "knockdown_bleed"
	},
	poison_proc = {
		dot_template_name = "arrow_poison_dot",
		dot_type = "poison_dot"
	},
	added_push = {
		sound_type = "stun_heavy",
		stagger_type = "ai_stagger",
		stagger_length = 1.2,
		stagger_impact = {
			6,
			6,
			6,
			0
		},
		stagger_duration = {
			2,
			2,
			0,
			0
		}
	},
	killing_blow_proc = {
		attack_type = "damage",
		sound_type = "heavy",
		damage_type = "killing_blow",
		damage = {
			20,
			20,
			40
		}
	},
	heroic_killing_blow_proc = {
		attack_type = "damage",
		sound_type = "heavy",
		damage_type = "killing_blow",
		damage = {
			20,
			20,
			255
		}
	},
	basic_debug_damage_ai = {
		attack_type = "damage",
		sound_type = "light",
		damage_type = "slashing",
		damage = {
			1,
			1,
			10,
			1
		}
	},
	basic_debug_damage_player = {
		attack_type = "debug_damage_player",
		sound_type = "light",
		damage = 20,
		damage_type = "slashing"
	},
	basic_debug_damage_kill = {
		attack_type = "debug_damage_player",
		sound_type = "light",
		damage = 255,
		damage_type = "slashing"
	},
	slashing_buffed_damage = {
		sound_type = "light",
		attack_type = "damage",
		damage_type = "slashing_buffed"
	},
	all_inclusive = {
		sound_type = "light",
		dot_template_name = "weapon_bleed_dot_test",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "poison_dot",
		damage_type = "slashing",
		stagger_length = 1,
		damage = {
			9,
			9,
			9,
			9
		},
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	light_slashing_linesman = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		damage_type = "light_slashing_linesman",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 1,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	light_slashing_linesman_hs = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		damage_type = "light_slashing_linesman_hs",
		headshot_multiplier = 3,
		attack_type = "damage_headshot",
		stagger_length = 1,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	slashing_linesman_hs_2 = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		damage_type = "slashing_linesman",
		headshot_multiplier = 2.5,
		attack_type = "damage_headshot",
		stagger_length = 0.5,
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	slashing_linesman = {
		sound_type = "medium",
		damage_type = "slashing_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.75,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	slashing_linesman_hs = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		damage_type = "slashing_linesman",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 0.75,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	slashing_linesman_AP = {
		sound_type = "medium",
		damage_type = "slashing_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.75,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	heavy_slashing_linesman = {
		sound_type = "heavy",
		damage_type = "heavy_slashing_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1.25,
			0,
			0
		}
	},
	heavy_slashing_linesman_hs = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		damage_type = "heavy_slashing_linesman",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1.25,
			0,
			0
		}
	},
	slashing_linesman_no_hs = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		damage_type = "heavy_slashing_linesman",
		headshot_multiplier = -1,
		attack_type = "damage_headshot",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1.25,
			0,
			0
		}
	},
	light_slashing_smiter = {
		stagger_angle = "down",
		sound_type = "light",
		damage_type = "light_slashing_smiter",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			1,
			1,
			0,
			0
		},
		stagger_duration = {
			1.25,
			0.5,
			0,
			0
		}
	},
	slashing_smiter = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		headshot_multiplier = 1.5,
		attack_type = "damage_headshot",
		damage_type = "slashing_smiter",
		stagger_angle = "smiter",
		stagger_length = 0.75,
		stagger_impact = {
			1,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.75,
			0,
			0
		}
	},
	oneh_axe_slashing_smiter_ap = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		damage_type = "slashing_linesman",
		headshot_multiplier = 1.7,
		attack_type = "damage_headshot",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			1.5,
			0,
			0
		}
	},
	slashing_smiter_hs = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "slashing_linesman",
		stagger_angle = "smiter",
		stagger_length = 1,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			1,
			0,
			0
		}
	},
	heavy_slashing_smiter = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "heavy_slashing_smiter",
		stagger_angle = "smiter",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			2,
			0,
			0
		}
	},
	heavy_slashing_smiter_hs = {
		headshot_sound = "executioner_sword_critical",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "heavy_slashing_smiter",
		stagger_angle = "smiter",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			2,
			0,
			0
		}
	},
	light_slashing_fencer = {
		sound_type = "light",
		damage_type = "light_slashing_fencer",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	light_slashing_fencer_hs = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		damage_type = "light_slashing_fencer",
		headshot_multiplier = 3,
		attack_type = "damage_headshot",
		stagger_length = 1,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	slashing_fencer_hs = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		damage_type = "light_slashing_fencer",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 1,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			1,
			0,
			0
		}
	},
	slashing_fencer = {
		sound_type = "medium",
		attack_type = "damage",
		damage_type = "slashing_fencer"
	},
	heavy_slashing_fencer = {
		sound_type = "heavy",
		attack_type = "damage",
		damage_type = "heavy_slashing_fencer"
	},
	light_slashing_tank = {
		sound_type = "light",
		damage_type = "light_slashing_tank",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.7,
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	slashing_tank = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		damage_type = "slashing_tank",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.4,
			0,
			0
		}
	},
	slashing_tank_hs = {
		headshot_sound = "executioner_sword_critical",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		headshot_multiplier = 5,
		attack_type = "damage_headshot",
		damage_type = "slashing_tank",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.4,
			0,
			0
		}
	},
	heavy_slashing_tank = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		damage_type = "heavy_slashing_tank",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 1.25,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	heavy_slashing_upper = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "heavy_slashing_tank",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	light_slashing_HS = {
		headshot_multiplier = 3,
		sound_type = "light",
		attack_type = "damage_headshot",
		damage_type = "light_slashing"
	},
	light_blunt_linesman = {
		sound_type = "light",
		damage_type = "light_blunt_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	blunt_linesman = {
		sound_type = "medium",
		damage_type = "blunt_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	heavy_blunt_linesman = {
		sound_type = "heavy",
		damage_type = "heavy_blunt_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.8,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	light_blunt_smiter = {
		stagger_angle = "down",
		sound_type = "medium",
		damage_type = "light_blunt_smiter",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.5,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	blunt_smiter = {
		stagger_angle = "down",
		sound_type = "medium",
		damage_type = "blunt_smiter",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.5,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1.5,
			1.25,
			0,
			0
		}
	},
	heavy_blunt_smiter = {
		sound_type = "heavy",
		damage_type = "heavy_blunt_smiter",
		stagger_type = "ai_stagger",
		stagger_angle = "down",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.5,
			0,
			0
		}
	},
	heavy_blunt_burning_smiter = {
		dot_template_name = "burning_1W_dot",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "heavy_blunt_burning_smiter",
		stagger_angle = "down",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.5,
			0,
			0
		}
	},
	light_blunt_fencer = {
		stagger_angle = "stab",
		sound_type = "light",
		damage_type = "light_blunt_fencer",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	blunt_fencer = {
		stagger_angle = "stab",
		sound_type = "medium",
		damage_type = "blunt_fencer",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1.25,
			0,
			0
		}
	},
	heavy_blunt_fencer = {
		sound_type = "heavy",
		attack_type = "damage",
		damage_type = "heavy_blunt_fencer"
	},
	light_blunt_tank = {
		sound_type = "light",
		damage_type = "light_blunt_tank",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			0.75,
			0,
			0
		}
	},
	light_blunt_tank_hs = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		damage_type = "light_blunt_tank",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			0.75,
			0,
			0
		}
	},
	blunt_tank = {
		sound_type = "medium",
		damage_type = "blunt_tank",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	blunt_tank_hs = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		damage_type = "blunt_tank",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	blunt_tank_uppercut = {
		stagger_angle = "stab",
		sound_type = "medium",
		damage_type = "blunt_tank_uppercut",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.5,
		stagger_duration = {
			1,
			0.75,
			0,
			0
		},
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1.5,
			0,
			0
		}
	},
	heavy_blunt_tank = {
		sound_type = "heavy",
		damage_type = "heavy_blunt_tank",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			3.25,
			2.25,
			0,
			0
		}
	},
	light_blunt_HS = {
		headshot_multiplier = 3,
		sound_type = "light",
		attack_type = "damage_headshot",
		damage_type = "light_blunt"
	},
	light_stab_linesman = {
		sound_type = "light",
		attack_type = "damage",
		damage_type = "light_stab_linesman"
	},
	stab_linesman = {
		sound_type = "medium",
		attack_type = "damage",
		damage_type = "stab_linesman"
	},
	heavy_stab_linesman = {
		sound_type = "heavy",
		damage_type = "heavy_stab_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1.25,
			0,
			0
		}
	},
	light_stab_smiter = {
		sound_type = "light",
		attack_type = "damage",
		damage_type = "light_stab_smiter"
	},
	burning_stab_smiter = {
		damage_type = "stab_smiter",
		stagger_type = "ai_stagger",
		sound_type = "medium",
		dot_template_name = "burning_3W_dot_t2",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		dot_type = "burning_dot",
		stagger_angle = "smiter",
		stagger_length = 0.75,
		stagger_impact = {
			5,
			5,
			0,
			0
		},
		stagger_duration = {
			1,
			0.5,
			0,
			0
		}
	},
	stab_smiter = {
		sound_type = "medium",
		damage_type = "stab_smiter",
		stagger_type = "ai_stagger",
		stagger_angle = "smiter",
		attack_type = "damage",
		stagger_length = 0.75,
		stagger_impact = {
			5,
			5,
			0,
			0
		},
		stagger_duration = {
			1,
			0.5,
			0,
			0
		}
	},
	stab_smiter_1 = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		headshot_multiplier = "2.5",
		attack_type = "damage_headshot",
		damage_type = "stab_smiter",
		stagger_angle = "smiter",
		stagger_length = 0.75,
		stagger_impact = {
			5,
			5,
			0,
			0
		},
		stagger_duration = {
			1,
			0.5,
			0,
			0
		}
	},
	heavy_stab_smiter = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "heavy_stab_smiter",
		stagger_angle = "smiter",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			2,
			0,
			0
		}
	},
	heavy_stab_smiter_2 = {
		stagger_angle = "smiter",
		sound_type = "heavy",
		damage_type = "heavy_blunt_smiter",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			2,
			0,
			0
		}
	},
	light_stab_fencer = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		headshot_multiplier = 2.5,
		attack_type = "damage_headshot",
		damage_type = "light_stab_fencer",
		stagger_angle = "stab",
		stagger_length = 0.65,
		stagger_impact = {
			5,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	stab_fencer = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		headshot_multiplier = 1.75,
		attack_type = "damage_headshot",
		damage_type = "stab_fencer",
		stagger_angle = "stab",
		stagger_length = 0.5,
		stagger_impact = {
			5,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	burning_stab_fencer = {
		damage_type = "burning_stab_fencer",
		stagger_type = "ai_stagger",
		sound_type = "medium",
		dot_template_name = "burning_3W_dot_t2",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		dot_type = "burning_dot",
		stagger_angle = "stab",
		stagger_length = 0.5,
		stagger_impact = {
			5,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	heavy_stab_fencer = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "heavy_stab_fencer",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			5,
			2,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	light_stab_tank = {
		sound_type = "light",
		attack_type = "damage",
		damage_type = "light_stab_tank"
	},
	stab_tank = {
		sound_type = "medium",
		attack_type = "damage",
		damage_type = "stab_tank"
	},
	heavy_stab_tank = {
		sound_type = "heavy",
		attack_type = "damage",
		damage_type = "heavy_stab_tank"
	},
	light_burning_linesman = {
		sound_type = "light",
		damage_type = "light_burning_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	burning_linesman = {
		sound_type = "medium",
		damage_type = "burning_linesman",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.75,
		stagger_impact = {
			1,
			0,
			0,
			0
		},
		stagger_duration = {
			2.5,
			0,
			0,
			0
		}
	},
	dagger_burning_tank = {
		dot_template_name = "burning_1W_dot",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "dagger_burning_tank",
		stagger_length = 0.8,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			2.25,
			0.4,
			0,
			0
		}
	},
	burning_tank = {
		dot_template_name = "burning_3W_dot",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "burning_tank",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.25,
			0.4,
			0,
			0
		}
	},
	burning_blunt_tank = {
		dot_template_name = "burning_1W_dot",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "burning_blunt_tank",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.25,
			0.4,
			0,
			0
		}
	},
	heavy_burning_tank = {
		dot_type = "burning_dot",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_template_name = "burning_1W_dot",
		damage_type = "heavy_burning_tank",
		stagger_length = 1.25,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	heavy_blunt_burning_tank = {
		dot_type = "burning_dot",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_template_name = "burning_1W_dot",
		damage_type = "heavy_blunt_burning_tank",
		stagger_length = 1.25,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	basic_sweep_push = {
		is_push = true,
		sound_type = "stun_heavy",
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			0.75,
			0,
			0
		}
	},
	shield_slam = {
		is_push = true,
		stagger_angle = "stab",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			0.75,
			0,
			0
		}
	},
	burning_shield_slam = {
		dot_type = "burning_dot",
		sound_type = "heavy",
		stagger_type = "ai_stagger",
		dot_template_name = "burning_1W_dot",
		is_push = true,
		stagger_angle = "stab",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2,
			0.75,
			0,
			0
		}
	},
	weak_sweep_push = {
		is_push = true,
		sound_type = "stun_light",
		stagger_type = "ai_stagger",
		stagger_length = 0.75,
		stagger_impact = {
			7,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.75,
			0,
			0
		}
	},
	dagger_sweep_push = {
		is_push = true,
		sound_type = "stun_light",
		stagger_type = "ai_stagger",
		stagger_length = 0.75,
		stagger_impact = {
			7,
			1,
			0,
			0
		},
		stagger_duration = {
			1.25,
			1,
			0,
			0
		}
	},
	heavy_sweep_push = {
		is_push = true,
		sound_type = "stun_heavy",
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			3,
			1.5,
			0,
			0
		}
	},
	upgraded_sweep_push = {
		is_push = true,
		sound_type = "stun_heavy",
		stagger_type = "ai_stagger",
		stagger_length = 0.65,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			2,
			1.25,
			0,
			0
		}
	},
	super_heavy_sweep_push = {
		is_push = true,
		sound_type = "stun_heavy",
		stagger_type = "ai_stagger",
		stagger_length = 1.4,
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			2,
			2,
			0,
			0
		}
	},
	basic_block = {
		stagger_type = "ai_stagger",
		sound_type = "stun_light",
		stagger_length = 1
	},
	attack_charge_push = {
		stagger_type = "ai_stagger",
		sound_type = "light",
		stagger_length = 10
	},
	heal_bandage = {
		heal_percent = 0.8,
		heal_type = "bandage",
		sound_type = "light",
		attack_type = "heal"
	},
	healing_draught = {
		heal_amount = 40,
		heal_type = "potion",
		sound_type = "light",
		attack_type = "heal"
	},
	heal_on_killing_blow = {
		heal_amount = 4,
		heal_type = "heal_on_killing_blow",
		sound_type = "light",
		attack_type = "heal"
	},
	shot_sniper = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "shot_sniper",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			4,
			2,
			3,
			0
		},
		stagger_duration = {
			0.75,
			1.25,
			0,
			0
		}
	},
	shot_carbine = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "shot_carbine",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			3,
			0,
			0,
			0
		},
		stagger_duration = {
			2.25,
			0,
			0,
			0
		}
	},
	shot_repeating_handgun = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 1.5,
		attack_type = "damage_headshot",
		damage_type = "shot_sniper",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			2.25,
			1.25,
			0,
			0
		}
	},
	repeating_pistol_special = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			4,
			1,
			4,
			1
		},
		damage_far = {
			1,
			1,
			1,
			1
		},
		range_dropoff_settings = {
			dropoff_start = 5,
			dropoff_end = 30
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			1.5,
			0,
			0
		}
	},
	repeating_pistol_special_t2 = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			5,
			1.5,
			5,
			1
		},
		damage_far = {
			2,
			1,
			1,
			1
		},
		range_dropoff_settings = {
			dropoff_start = 5,
			dropoff_end = 30
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			1.5,
			0,
			0
		}
	},
	repeating_pistol_special_t3 = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			6,
			2,
			6,
			1
		},
		damage_far = {
			3,
			1,
			1,
			1
		},
		range_dropoff_settings = {
			dropoff_start = 5,
			dropoff_end = 30
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			1.5,
			0,
			0
		}
	},
	shot_machinegun = {
		stagger_angle = "stab",
		sound_type = "light",
		damage_type = "shot_machinegun",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.5,
		stagger_impact = {
			4,
			0,
			0,
			0
		},
		stagger_duration = {
			0.5,
			0,
			0,
			0
		}
	},
	shot_shotgun = {
		sound_type = "light",
		attack_type = "damage",
		damage_type = "shot_shotgun"
	},
	shot_blunderbuss = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_length = 1,
		damage_near = {
			2.5,
			0.25,
			1.5,
			0.5
		},
		damage_far = {
			1.5,
			0,
			1,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 10,
			dropoff_end = 30
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.25,
			0,
			0
		}
	},
	shot_blunderbuss_t2 = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_length = 1,
		damage_near = {
			3,
			0.5,
			2,
			0.5
		},
		damage_far = {
			2,
			0,
			1.5,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 10,
			dropoff_end = 30
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.25,
			0,
			0
		}
	},
	shot_blunderbuss_t3 = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_length = 1,
		damage_near = {
			6,
			0.75,
			2.5,
			0.5
		},
		damage_far = {
			2,
			0,
			2,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 10,
			dropoff_end = 30
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.25,
			0,
			0
		}
	},
	shot_grudgeraker_twinbarrel = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_length = 1,
		damage_near = {
			3,
			0.2,
			2,
			0.5
		},
		damage_far = {
			2,
			0,
			1,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 20,
			dropoff_end = 40
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.25,
			0,
			0
		}
	},
	shot_grudgeraker_twinbarrel_t2 = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_length = 1,
		damage_near = {
			5,
			0.4,
			2.5,
			0.5
		},
		damage_far = {
			2,
			0,
			1.5,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 20,
			dropoff_end = 40
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.25,
			0,
			0
		}
	},
	shot_grudgeraker_twinbarrel_t3 = {
		damage_type = "shot_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_length = 1,
		damage_near = {
			6,
			0.6,
			2.3,
			0.5
		},
		damage_far = {
			2,
			0,
			2,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 20,
			dropoff_end = 40
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0.25,
			0,
			0
		}
	},
	arrow_sniper = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 3,
		attack_type = "damage_headshot",
		damage_type = "arrow_sniper",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			4,
			4,
			2,
			0
		},
		stagger_duration = {
			1,
			0.5,
			0,
			0
		}
	},
	arrow_sniper_1 = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 4,
		attack_type = "damage_headshot",
		damage_type = "arrow_sniper",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			4,
			4,
			2,
			0
		},
		stagger_duration = {
			1,
			0.5,
			0,
			0
		}
	},
	arrow_carbine = {
		stagger_type = "ai_stagger",
		sound_type = "medium",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		damage_type = "arrow_carbine",
		stagger_angle = "stab",
		stagger_length = 0.5,
		stagger_impact = {
			4,
			0,
			0,
			0
		},
		stagger_duration = {
			0.75,
			0,
			0,
			0
		}
	},
	arrow_machinegun = {
		stagger_angle = "stab",
		sound_type = "light",
		damage_type = "arrow_machinegun",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 0.5,
		stagger_impact = {
			4,
			0,
			0,
			0
		},
		stagger_duration = {
			1.25,
			0,
			0,
			0
		}
	},
	arrow_poison_machinegun = {
		dot_template_name = "arrow_poison_dot",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "poison_dot",
		damage_type = "arrow_poison",
		stagger_length = 1,
		stagger_impact = {
			4,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	arrow_poison_carbine = {
		dot_template_name = "arrow_poison_dot",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "poison_dot",
		dot_on_wound = true,
		damage_type = "arrow_poison",
		stagger_length = 1,
		stagger_impact = {
			4,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	arrow_poison_sniper = {
		sound_type = "heavy",
		damage_type = "arrow_poison",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.75,
			0,
			0
		}
	},
	arrow_poison_aoe = {
		dot_template_name = "aoe_poison_dot",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "poison_dot",
		damage_type = "arrow_poison",
		stagger_length = 1,
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			2,
			0,
			0,
			0
		}
	},
	arrow_poison_aoe_t2 = {
		dot_template_name = "aoe_poison_dot_t2",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "poison_dot",
		damage_type = "arrow_poison",
		stagger_length = 1,
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			2.5,
			0,
			0,
			0
		}
	},
	arrow_poison_aoe_t3 = {
		dot_template_name = "aoe_poison_dot_t3",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "poison_dot",
		damage_type = "arrow_poison",
		stagger_length = 1,
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	bolt_sniper = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		damage_type = "bolt_sniper",
		headshot_multiplier = 2.5,
		attack_type = "damage_headshot",
		stagger_length = 1,
		stagger_impact = {
			4,
			2,
			0,
			0
		},
		stagger_duration = {
			1.5,
			1.25,
			0,
			0
		}
	},
	bolt_carbine = {
		sound_type = "heavy",
		attack_type = "damage",
		damage_type = "bolt_carbine"
	},
	bolt_machinegun = {
		sound_type = "medium",
		attack_type = "damage",
		damage_type = "bolt_machinegun"
	},
	wizard_staff_melee = {
		sound_type = "light",
		dot_template_name = "burning_dot",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "drakegun_shot",
		stagger_angle = "stab",
		stagger_length = 1,
		damage = {
			2,
			0,
			4,
			1
		},
		stagger_impact = {
			6,
			6,
			0,
			0
		},
		stagger_duration = {
			4,
			2.5,
			0,
			0
		}
	},
	wizard_staff_geiser = {
		sound_type = "light",
		dot_template_name = "burning_1W_dot",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "burn",
		stagger_length = 1,
		damage = {
			0,
			0,
			4,
			0
		},
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	wizard_staff_geiser_t2 = {
		sound_type = "light",
		dot_template_name = "burning_1W_dot_t2",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "burn",
		stagger_length = 1,
		damage = {
			0,
			0,
			4,
			0
		},
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	wizard_staff_geiser_t3 = {
		sound_type = "light",
		dot_template_name = "burning_1W_dot_t3",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "burn",
		stagger_length = 1,
		damage = {
			0,
			0,
			4,
			0
		},
		stagger_impact = {
			2,
			0,
			0,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	wizard_staff_geiser_fryem = {
		sound_type = "light",
		dot_template_name = "burning_3W_dot",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "burn",
		stagger_length = 1,
		damage = {
			0.5,
			0,
			8,
			0
		},
		stagger_impact = {
			3,
			2,
			0,
			1
		},
		stagger_duration = {
			2,
			1.5,
			0,
			0
		}
	},
	wizard_staff_geiser_fryem_t2 = {
		sound_type = "light",
		dot_template_name = "burning_3W_dot_t2",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "burn",
		stagger_length = 1,
		damage = {
			1,
			0,
			12,
			0
		},
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			2,
			1.5,
			0,
			0
		}
	},
	wizard_staff_geiser_fryem_t3 = {
		sound_type = "light",
		dot_template_name = "burning_3W_dot_t3",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "burn",
		stagger_length = 1,
		damage = {
			2,
			0,
			16,
			0
		},
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			2,
			1.5,
			0,
			0
		}
	},
	wizard_staff_geiser_crit = {
		sound_type = "light",
		dot_template_name = "burning_3W_dot",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "fire_grenade_glance",
		stagger_length = 1,
		damage = {
			3,
			1,
			16,
			2
		},
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4,
			2,
			0,
			0
		}
	},
	wizard_staff_geiser_crit_t2 = {
		sound_type = "light",
		dot_template_name = "burning_3W_dot_t2",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "fire_grenade_glance",
		stagger_length = 1,
		damage = {
			4,
			2,
			20,
			2.5
		},
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4,
			2,
			0,
			0
		}
	},
	wizard_staff_geiser_crit_t3 = {
		sound_type = "light",
		dot_template_name = "burning_3W_dot_t3",
		stagger_type = "ai_stagger",
		attack_type = "hacky_damage_burn",
		dot_type = "burning_dot",
		damage_type = "fire_grenade_glance",
		stagger_length = 1,
		damage = {
			5,
			3,
			24,
			4
		},
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4,
			2,
			0,
			0
		}
	},
	wizard_staff_beam = {
		damage_type = "burn",
		stagger_type = "ai_stagger",
		sound_type = "light",
		headshot_multiplier = -1,
		attack_type = "damage_headshot",
		dot_type = "burning_dot",
		dot_template_name = "beam_burning_dot",
		stagger_angle = "stab",
		stagger_length = 1,
		damage = {
			1,
			0.5,
			1.5,
			1
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	wizard_staff_beam_t2 = {
		damage_type = "burn",
		stagger_type = "ai_stagger",
		sound_type = "light",
		headshot_multiplier = -1,
		attack_type = "damage_headshot",
		dot_type = "burning_dot",
		dot_template_name = "beam_burning_dot_t2",
		stagger_angle = "stab",
		stagger_length = 1,
		damage = {
			1.25,
			0.5,
			2.5,
			1
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	wizard_staff_beam_t3 = {
		damage_type = "burn",
		stagger_type = "ai_stagger",
		sound_type = "light",
		headshot_multiplier = -1,
		attack_type = "damage_headshot",
		dot_type = "burning_dot",
		dot_template_name = "beam_burning_dot_t3",
		stagger_angle = "stab",
		stagger_length = 1,
		damage = {
			1.5,
			0.5,
			3.5,
			1
		},
		stagger_impact = {
			4,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	wizard_staff_beam_sniper = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		damage_type = "burn_sniper",
		headshot_multiplier = 2,
		attack_type = "damage_headshot",
		stagger_length = 1,
		stagger_impact = {
			4,
			4,
			0,
			0
		},
		stagger_duration = {
			1,
			0.5,
			0,
			0
		}
	},
	flame_blast = {
		damage_type = "burn_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			3,
			0.5,
			12,
			2
		},
		damage_far = {
			0,
			0,
			4,
			0
		},
		range_dropoff_settings = {
			dropoff_start = 2,
			dropoff_end = 10
		},
		stagger_impact = {
			3,
			0,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	flame_blast_t2 = {
		damage_type = "burn_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t2",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			3.5,
			0.75,
			14,
			2.5
		},
		damage_far = {
			0,
			0,
			4,
			0
		},
		range_dropoff_settings = {
			dropoff_start = 2,
			dropoff_end = 10
		},
		stagger_impact = {
			3,
			0,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	flame_blast_t3 = {
		damage_type = "burn_shotgun",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t3",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			4,
			1,
			16,
			3
		},
		damage_far = {
			0,
			0,
			4,
			0
		},
		range_dropoff_settings = {
			dropoff_start = 2,
			dropoff_end = 10
		},
		stagger_impact = {
			3,
			0,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0,
			0,
			0
		}
	},
	flame_wave = {
		dot_template_name = "burning_dot",
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "burn_shotgun",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			3,
			2,
			0,
			0
		},
		stagger_duration = {
			3,
			0.75,
			0,
			0
		}
	},
	wizard_staff_spark = {
		stagger_angle = "stab",
		sound_type = "medium",
		damage_type = "burn_machinegun",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		stagger_length = 1,
		stagger_impact = {
			4,
			0,
			0,
			0
		},
		stagger_duration = {
			1,
			0,
			0,
			0
		}
	},
	wizard_staff_spear = {
		stagger_type = "ai_stagger",
		sound_type = "heavy",
		headshot_multiplier = 3.5,
		attack_type = "damage_headshot",
		damage_type = "burn_sniper",
		stagger_angle = "stab",
		stagger_length = 1,
		stagger_impact = {
			4,
			2,
			0,
			0
		},
		stagger_duration = {
			1.5,
			1,
			0,
			0
		}
	},
	wizard_staff = {
		attack_type = "hacky_damage_burn",
		sound_type = "light",
		damage_type = "burn"
	},
	fireball = {
		dot_template_name = "burning_1W_dot",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "burn_shotgun",
		stagger_length = 1,
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	fireball_t2 = {
		dot_template_name = "burning_1W_dot_t2",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "burn_shotgun",
		stagger_length = 1,
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	fireball_t3 = {
		dot_template_name = "burning_1W_dot_t3",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		dot_type = "burning_dot",
		damage_type = "burn_shotgun",
		stagger_length = 1,
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			1,
			0.75,
			0,
			0
		}
	},
	drakegun = {
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot",
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4,
			1,
			0,
			0
		}
	},
	drakegun_t2 = {
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t2",
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4,
			1,
			0,
			0
		}
	},
	drakegun_t3 = {
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t3",
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			6,
			3,
			0,
			0
		},
		stagger_duration = {
			4,
			1,
			0,
			0
		}
	},
	drakegun_glance = {
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot",
		stagger_type = "ai_stagger",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	drakegun_glance_t2 = {
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t2",
		stagger_type = "ai_stagger",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	drakegun_glance_t3 = {
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t3",
		stagger_type = "ai_stagger",
		stagger_length = 0.75,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			2.5,
			1,
			0,
			0
		}
	},
	drake_pistol_shot = {
		damage_type = "burn_carbine",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			4,
			1,
			12,
			2
		},
		damage_far = {
			2,
			0.5,
			4,
			1
		},
		range_dropoff_settings = {
			dropoff_start = 5,
			dropoff_end = 20
		},
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			4,
			0,
			0,
			0
		}
	},
	drake_pistol_shot_t2 = {
		damage_type = "burn_carbine",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			5,
			1.5,
			12,
			2.5
		},
		damage_far = {
			3,
			0.75,
			4,
			1.5
		},
		range_dropoff_settings = {
			dropoff_start = 5,
			dropoff_end = 20
		},
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			4,
			0,
			0,
			0
		}
	},
	drake_pistol_shot_t3 = {
		damage_type = "burn_carbine",
		sound_type = "light",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			6,
			2,
			12,
			2.5
		},
		damage_far = {
			4,
			1,
			4,
			1.5
		},
		range_dropoff_settings = {
			dropoff_start = 5,
			dropoff_end = 20
		},
		stagger_impact = {
			3,
			1,
			0,
			0
		},
		stagger_duration = {
			4,
			0,
			0,
			0
		}
	},
	drake_pistol_charged = {
		headshot_multiplier = -1,
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot",
		damage_type = "burn_shotgun",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			3,
			0.5,
			8,
			2
		},
		damage_far = {
			0,
			0,
			4,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 3,
			dropoff_end = 7
		},
		stagger_impact = {
			3,
			2,
			3,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	drake_pistol_charged_t2 = {
		headshot_multiplier = -1,
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t2",
		damage_type = "burn_shotgun",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			4,
			1,
			10,
			2.5
		},
		damage_far = {
			0,
			0,
			4,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 3,
			dropoff_end = 7
		},
		stagger_impact = {
			3,
			2,
			3,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	drake_pistol_charged_t3 = {
		headshot_multiplier = -1,
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage_dropoff",
		dot_type = "burning_dot",
		dot_template_name = "burning_1W_dot_t3",
		damage_type = "burn_shotgun",
		stagger_angle = "stab",
		stagger_length = 1,
		damage_near = {
			5,
			1.5,
			12,
			3
		},
		damage_far = {
			0,
			0,
			4,
			0.5
		},
		range_dropoff_settings = {
			dropoff_start = 3,
			dropoff_end = 7
		},
		stagger_impact = {
			3,
			2,
			3,
			0
		},
		stagger_duration = {
			3,
			0,
			0,
			0
		}
	},
	burning = {
		attack_type = "hacky_damage_burn",
		sound_type = "light",
		damage_type = "burn",
		damage = {
			1,
			1,
			4,
			0.5
		}
	},
	poison_globe_ai_initial_damage = {
		attack_type = "damage",
		sound_type = "light",
		damage_type = "poison",
		damage = {
			10,
			10,
			10,
			30
		}
	},
	grenade = {
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			6,
			6,
			6,
			0
		},
		stagger_duration = {
			4.5,
			1.5,
			4,
			0
		}
	},
	grenade_glance = {
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			6,
			2,
			6,
			0
		},
		stagger_duration = {
			4.5,
			1,
			4,
			0
		}
	},
	fire_grenade_explosion = {
		dot_type = "burning_dot",
		dot_template_name = "burning_3W_dot",
		stagger_type = "ai_stagger",
		stagger_length = 1,
		stagger_impact = {
			2,
			2,
			0,
			0
		},
		stagger_duration = {
			4,
			1,
			0,
			0
		}
	},
	fire_grenade_dot = {
		dot_type = "burning_dot",
		dot_template_name = "burning_3W_dot",
		sound_type = "light",
		damage_type = "drakegun_shot"
	},
	spike_trap = {
		sound_type = "medium",
		stagger_type = "ai_stagger",
		attack_type = "damage",
		damage_type = "stab_smiter",
		stagger_angle = "stab",
		stagger_length = 1,
		damage = {
			4,
			0,
			8,
			1
		},
		stagger_impact = {
			6,
			6,
			0,
			0
		},
		stagger_duration = {
			4,
			2.5,
			0,
			0
		}
	},
	brawl_light = {
		attack_type = "damage",
		sound_type = "light",
		damage_type = "cutting",
		stagger_type = "ai_stagger",
		fatigue_type = "blocked_attack",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.4,
			0,
			0
		}
	},
	brawl_light_slap = {
		attack_type = "damage",
		sound_type = "light",
		damage_type = "cutting",
		stagger_type = "ai_stagger",
		fatigue_type = "blocked_attack",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.4,
			0,
			0
		}
	},
	brawl_heavy = {
		attack_type = "damage",
		sound_type = "heavy",
		damage_type = "cutting",
		stagger_type = "ai_stagger",
		fatigue_type = "complete",
		stagger_length = 0.8,
		stagger_impact = {
			2,
			1,
			0,
			0
		},
		stagger_duration = {
			1.5,
			0.4,
			0,
			0
		}
	}
}
ProjectileItemTypes = {}

for item_template_name, item_template in pairs(Weapons) do
	item_template.name = item_template_name
	item_template.crosshair_style = item_template.crosshair_style or "dot"
	local actions = item_template.actions

	for action_name, sub_actions in pairs(actions) do
		for sub_action_name, sub_action_data in pairs(sub_actions) do
			local lookup_data = {
				item_template_name = item_template_name,
				action_name = action_name,
				sub_action_name = sub_action_name
			}
			sub_action_data.lookup_data = lookup_data
			local allowed_chain_actions = sub_action_data.allowed_chain_actions

			if allowed_chain_actions and actions.action_use_consumable then
				local add_action = true

				for i = 1, #allowed_chain_actions, 1 do
					local chain_action_data = allowed_chain_actions[i]

					if chain_action_data.input == "action_use_consumable" then
						add_action = false

						break
					end
				end

				if add_action then
					allowed_chain_actions[#allowed_chain_actions + 1] = {
						start_time = 0.3,
						first_possible_sub_action = true,
						action = "action_use_consumable",
						input = "action_use_consumable"
					}
				end
			end
		end
	end
end

for item_template_name, item_template in pairs(Weapons) do
	for action_name, sub_actions in pairs(item_template.actions) do
		for sub_action_name, sub_action_data in pairs(sub_actions) do
			local action_kind = sub_action_data.kind
			local action_assert_func = ActionAssertFuncs[action_kind]

			if action_assert_func then
				action_assert_func(item_template_name, action_name, sub_action_name, sub_action_data)
			end
		end
	end
end

return
