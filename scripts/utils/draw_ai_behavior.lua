require("scripts/utils/script_gui")

local font_size = 26
local font = "arial_26"
local font_mtrl = "materials/fonts/" .. font
local tiny_font_size = 16
local tiny_font = "arial_16"
local tiny_font_mtrl = "materials/fonts/" .. tiny_font
local layer = 100
local res_x, res_y = Application.resolution()
local small_font_size = 16
local node_height = 0.04
local min_node_width = res_x/140
local node_spacing = res_x*1e-05
local text_spacing = res_x/2
local thin_border = res_x/5
local show_blackboard_data = {
	BTFallAction = {
		"is_falling",
		"fall_done",
		"fall_state"
	},
	BTChaseAction = {
		"move_state"
	},
	BTFollowAction = {
		"move_state"
	},
	BTMeleeSlamAction = {
		"move_state",
		"attack_anim",
		"attack_anim_driven"
	},
	BTTargetUnreachableAction = {
		"move_state"
	},
	BTCrazyJumpAction = {
		"jump_data"
	},
	BTSkulkAroundAction = {
		"in_los",
		"skulk_pos",
		"debug_state"
	},
	BTCirclePreyAction = {
		"move_state"
	},
	BTAttackAction = {
		"attacks_done",
		"target_dist",
		"slot_layer"
	},
	BTClanRatFollowAction = {
		"move_state",
		"using_smart_object"
	},
	BTCombatShoutAction = {
		"nav_target_dist_sq",
		"slot_layer"
	},
	BTClimbAction = {
		"is_in_smartobject_range",
		"is_climbing"
	},
	BTSkulkAroundAction = {
		"skulk_jump_tries"
	},
	BTPackMasterSkulkAroundAction = {
		"skulk_in_los",
		"skulk_dogpile",
		"skulk_time_left",
		"skulk_debug_state"
	},
	BTPackMasterDragAction = {
		"drag_check_index",
		"drag_check_time_debug"
	},
	BTSkulkApproachAction = {
		"target_dist"
	},
	BTSkulkIdleAction = {
		"skulk_data"
	},
	BTNinjaApproachAction = {
		"skulk_pos_is_jump_off_point"
	}
}
local time_to_fade = 3
local draw_timers = {}
DrawAiBehaviour = {}
local nodes = {}
DrawAiBehaviour.tree_width = function (gui, node)
	local id = node._identifier
	local min, max = Gui.text_extents(gui, id, font_mtrl, font_size)
	local text_width = (max.x - min.x)/res_x + res_x*5e-06

	if text_width < min_node_width and not min_node_width then
	end

	nodes[id] = {
		w = text_width
	}

	if node._children then
		local n = 0
		local w = 0

		for k, child in pairs(node._children) do
			local amount, width = DrawAiBehaviour.tree_width(gui, child)
			n = n + amount

			if node.name == "BTSequence" then
			else
				w = w + width
			end
		end

		nodes[id].total_w = w

		return n, w
	else
		return 1, text_width
	end

	return 
end
DrawAiBehaviour.draw_tree = function (bt, gui, node, blackboard, row, t, dt, x, y, draw_utility)
	local nodes = nodes

	if row == 1 then
	end

	local identifier = node._identifier
	local last_identifier = DrawAiBehaviour.last_running_node
	local running = nil

	for node_id, running_data in pairs(blackboard.running_nodes) do
		if running_data._identifier == identifier then
			running = identifier

			if not node._children then
				if DrawAiBehaviour.running_node ~= identifier then
					DrawAiBehaviour.last_running_node = DrawAiBehaviour.running_node
				end

				DrawAiBehaviour.running_node = running
			end

			break
		end
	end

	local color = nil

	if running then
		color = Color(200, 242, 152, 7)

		if draw_timers[node] ~= time_to_fade then
			for id, timer in pairs(draw_timers) do
				draw_timers[id] = timer*0.9
			end

			draw_timers[node] = time_to_fade
		end
	else
		local green = 60
		local timer = draw_timers[node]

		if timer then
			timer = timer - dt

			if timer <= 0 then
				draw_timers[node] = nil
			else
				green = math.lerp(60, 255, timer/time_to_fade)
				draw_timers[node] = timer
			end
		end

		if node._children then
			color = Color(200, 130, 170, green)
		else
			color = Color(200, 30, 170, green)
		end
	end

	local tcolor = Color(240, 255, 255, 255)
	local lcolor = Color(150, 100, 255, 100)
	local node_width = nodes[node._identifier].w
	local total_width = nodes[node._identifier].total_w
	local y1 = row*(node_height + node_height) + y
	local x1 = x
	local text = node._identifier
	local extra_height = 0
	local node_type = node.name

	ScriptGUI.itext(gui, res_x, res_y, node_type, font_mtrl, small_font_size, font, x1 + text_spacing, y1 + node_height*0.28, layer + 1, tcolor)

	if not running then
	end

	local bb_color = Color(255, 0, 0, 0)
	local bb_items = show_blackboard_data[node_type]

	if bb_items then
		for k, key in ipairs(bb_items) do
			if type(blackboard[key]) == "table" then
				extra_height = extra_height + res_y/11
				local bb_text = "[" .. key .. "]"

				ScriptGUI.itext(gui, res_x, res_y, bb_text, font_mtrl, small_font_size, font, x1 + text_spacing, y1 + node_height*0.8 + extra_height, layer + 1, bb_color)

				local sub_table = blackboard[key]

				for t2, v in pairs(sub_table) do
					extra_height = extra_height + res_y/11
					local bb_text = " > " .. t2 .. "=" .. tostring(v)

					ScriptGUI.itext(gui, res_x, res_y, bb_text, font_mtrl, small_font_size, font, x1 + text_spacing, y1 + node_height*0.8 + extra_height, layer + 1, bb_color)
				end
			else
				extra_height = extra_height + res_y/11
				local bb_text = key .. "=" .. tostring(blackboard[key])

				ScriptGUI.itext(gui, res_x, res_y, bb_text, font_mtrl, small_font_size, font, x1 + text_spacing, y1 + node_height*0.8 + extra_height, layer + 1, bb_color)
			end
		end
	end

	local extra_utility_height = 0

	if draw_utility and node._tree_node and node._tree_node.action_data.considerations then
		local yellow = Color(255, 240, 200, 10)
		local cons = node._tree_node.action_data.considerations
		local size = Vector2(140, 100)
		local step_y = size.y + 20
		local pos_y = -205
		local pos = Vector3(x1*res_x, ((y1 - 1 + node_height) - extra_height)*res_y, layer + 10)
		local num = 0

		for name, consideration_data in pairs(cons) do
			local npos = pos + Vector3(0, pos_y, 0)

			EditAiUtility.draw_utility_info(gui, consideration_data, nil, name, npos, size, 1, "tiny")

			if consideration_data.is_condition then
				EditAiUtility.draw_utility_condition(gui, text, consideration_data, npos, size, blackboard, Color(92, 28, 128, 44))
			else
				EditAiUtility.draw_utility_spline(gui, t, consideration_data, nil, name, npos, size, Color(92, 28, 128, 44), 1, 2)
				EditAiUtility.draw_realtime_utility(gui, text, consideration_data, npos, size, blackboard)
			end

			pos_y = pos_y - step_y
			num = num + 1
		end

		local action = bt.action_data(bt)
		local breed_action = action[text]
		local utility = math.floor(Utility.get_action_utility(breed_action, text, blackboard, t)*10)/10

		ScriptGUI.text(gui, "sum: " .. utility, tiny_font_mtrl, tiny_font_size, tiny_font, pos + Vector3(3, -102, 0), yellow)

		extra_utility_height = num*0.1
	end

	if last_identifier == identifier then
		ScriptGUI.irect(gui, res_x, res_y, x1 - thin_border, y1 - thin_border, x1 + node_width + thin_border, y1 + node_height + extra_height + thin_border, layer - 1, Color(255, 242, 152, 7))
	end

	ScriptGUI.irect(gui, res_x, res_y, x1, y1, x1 + node_width, y1 + node_height + extra_height, layer, color)
	ScriptGUI.itext(gui, res_x, res_y, text, font_mtrl, font_size, font, x1 + text_spacing, y1 + node_height*0.7, layer + 1, tcolor)

	local running_outside_offset = nil

	if node._children then
		local child_y = y1 + node_height + node_height
		local start_x = nil
		local cy = 0

		if node.name == "BTSequence" then
			start_x = x1
			cy = extra_utility_height
		else
			start_x = x1 - total_width*0.5 + node_width*0.5
		end

		local cx = start_x
		local child_width = nil

		for k, child in pairs(node._children) do
			child_width = nodes[child._identifier].w
			local child_total_width = nodes[child._identifier].total_w or 0
			cx = cx + child_total_width*0.5
			local draw_utility = node.name == "BTUtilityNode"
			local node_running_outside_offset, temp_extra_height = DrawAiBehaviour.draw_tree(bt, gui, child, blackboard, row + 1, t, dt, cx, cy, draw_utility)

			if node_running_outside_offset then
				running_outside_offset = node_running_outside_offset
			end

			if node.name == "BTSequence" then
				local p1 = Vector2(x1 + node_width*0.5, y1 + node_height)
				local p2 = Vector2(cx + child_width*0.5, child_y + cy)

				ScriptGUI.hud_iline(gui, res_x, res_y, p1, p2, layer - 1, 2, lcolor)

				cy = cy + node_height*1.5 + temp_extra_height
			else
				local p1 = Vector2(x1 + node_width*0.5, y1 + node_height)
				local p2 = Vector2(cx + child_width*0.5, child_y)

				ScriptGUI.hud_iline(gui, res_x, res_y, p1, p2, layer - 1, 2, lcolor)

				cx = cx + child_width + node_spacing
				cx = cx + child_total_width*0.5
			end
		end

		local ocolor = Color(70, 55, 155, 255)
		local xb = res_x/5
		local yb = res_y/5

		ScriptGUI.irect(gui, res_x, res_y, start_x - xb, child_y - yb, (cx + xb) - node_spacing, child_y + node_height + yb, layer - 1, ocolor)
	end

	if running and 0.8 < x1 then
		return x1 - 0.8, extra_height
	elseif running and x1 < 0 then
		return x1, extra_height
	else
		return running_outside_offset, extra_height
	end

	return 
end

return 
