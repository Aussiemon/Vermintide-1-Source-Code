require("scripts/unit_extensions/human/ai_player_unit/ai_utils")

PlayerBots = PlayerBots or {}
BotActions = BotActions or {}
BotActions.default = {
	follow = {
		action_weight = 1
	},
	successful_follow = {
		action_weight = 1
	},
	goto_transport = {
		name = "goto_transport",
		move_anim = "move_start_fwd",
		goal_selection = "new_goal_in_transport",
		action_weight = 1,
		considerations = UtilityConsiderations.follow
	},
	shoot = {
		evaluation_duration = 2,
		maximum_obstruction_reevaluation_time = 0.3,
		evaluation_duration_without_firing = 3,
		minimum_obstruction_reevaluation_time = 0.2,
		action_weight = 1
	},
	switch_melee = {
		wanted_slot = "slot_melee",
		action_weight = 1
	},
	switch_ranged = {
		wanted_slot = "slot_ranged",
		action_weight = 1
	},
	switch_heal = {
		wanted_slot = "slot_healthkit",
		action_weight = 1
	},
	switch_potion = {
		wanted_slot = "slot_potion"
	},
	switch_grenade = {
		wanted_slot = "slot_grenade"
	},
	fight_melee_priority_target = {
		engage_range = math.huge,
		engage_range_near_follow_pos = math.huge,
		override_engage_range_to_follow_pos = math.huge,
		override_engage_range_to_follow_pos_horde = math.huge
	},
	fight_melee = {
		override_engage_range_to_follow_pos_horde = 9,
		override_engage_range_to_follow_pos = 20,
		engage_range_near_follow_pos = 15,
		engage_range = 6
	},
	destroy_object_melee = {
		override_engage_range_to_follow_pos_horde = 9,
		destroy_object = true,
		override_engage_range_to_follow_pos = 20,
		engage_range = 6,
		engage_range_near_follow_pos = 15
	},
	combat = {
		action_weight = 1
	},
	revive = {
		aim_node = "j_head",
		use_block_interaction = true
	},
	use_heal_on_player = {
		aim_node = "j_head"
	},
	do_give_grenade = {
		aim_node = "j_head",
		input = "interact"
	},
	do_give_potion = {
		aim_node = "j_head",
		input = "interact"
	},
	do_give_heal_item = {
		aim_node = "j_head",
		input = "interact"
	},
	rescue_hanging_from_hook = {
		aim_node = "j_hips",
		use_block_interaction = true
	},
	rescue_ledge_hanging = {
		aim_node = "j_head",
		use_block_interaction = true
	}
}

for category_name, category_table in pairs(BotActions) do
	for action_name, action_table in pairs(category_table) do
		action_table.name = action_name
		action_table.considerations = UtilityConsiderations["player_bot_" .. category_name .. "_" .. action_name] or nil
	end
end

PlayerBots.default = {
	walk_speed = 1.9,
	radius = 1,
	behavior = "default",
	run_speed = 4,
	perception = "regular",
	blackboard_allocation_size = 128
}
local PerceptionTypes = {
	regular = true,
	no_seeing = true,
	all_seeing = true
}
local TargetSelectionTypes = {
	pick_closest_target_only_human = true,
	pick_closest_target = true,
	pick_pounce_down_target = true
}

for name, bot in pairs(PlayerBots) do
	bot.name = name

	if bot.perception and not PerceptionTypes[bot.perception] then
		error("Bad perception type '" .. bot.perception .. "' specified in bot .. '" .. bot.name .. "'.")
	end

	if bot.target_selection and not TargetSelectionTypes[bot.target_selection] then
		error("Bad 'target_selection' type '" .. bot.target_selection .. "' specified in bot .. '" .. bot.name .. "'.")
	end
end

return
