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
	fight_melee_priority_target = {
		engage_range_passive_patrol = math.huge,
		engage_range = math.huge,
		engage_range_near_follow_pos = math.huge,
		override_engage_range_to_follow_pos = math.huge
	},
	fight_melee = {
		engage_range_near_follow_pos = 15,
		engage_range_passive_patrol = 0,
		engage_range = 10,
		override_engage_range_to_follow_pos = 20
	},
	destroy_object_melee = {
		engage_range_passive_patrol = 10,
		destroy_object = true,
		engage_range = 10,
		override_engage_range_to_follow_pos = 20,
		engage_range_near_follow_pos = 15
	},
	combat = {
		action_weight = 1
	},
	revive = {
		aim_node = "j_head"
	},
	use_heal_on_player = {
		aim_node = "j_head"
	},
	rescue_hanging_from_hook = {
		aim_node = "j_hips"
	},
	rescue_ledge_hanging = {
		aim_node = "j_head"
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
	behavior = "witch_hunter",
	run_speed = 4,
	perception = "regular"
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
