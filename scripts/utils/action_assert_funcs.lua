ActionAssertFuncs = {
	handgun = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	sweep = function (weapon_name, action_name, sub_action_name, action)
		local default_target = action.default_target

		assert(default_target, "Default target settings not set")

		local attack_template = default_target.attack_template

		assert(attack_template, "Attack template not set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	push_stagger = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	shield_slam = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")

		local push_attack_template = action.push_attack_template

		assert(push_attack_template, "No push attack template set")
		assert(AttackTemplates[push_attack_template], "Attack template does not exist")
	end,
	shotgun = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	geiser = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	beam = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	handgun_lock = function (weapon_name, action_name, sub_action_name, action)
		local attack_template = action.attack_template

		assert(attack_template, "No attack template set")
		assert(AttackTemplates[attack_template], "Attack template does not exist")
	end,
	charge = function (weapon_name, action_name, sub_action_name, action)
		local charge_time = action.charge_time

		assert(charge_time, "No charge time set")
	end
}

return
