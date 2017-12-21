GraphHelper = GraphHelper or {}
GraphHelper._known_stats = GraphHelper._known_stats or {}
GraphHelper._known_graphs = GraphHelper._known_graphs or {}
local build = Application.build()
local console_command = Application.console_command
local record_statistics = Profiler.record_statistics

if console_command == nil or build == "release" or build == "public_dev" then
	function console_command()
		return 
	end
end

if record_statistics == nil or build == "release" or build == "public_dev" then
	function record_statistics()
		return 
	end
end

GraphHelper.create = function (graph_name, stat_names, stat_names_vector3)
	if GraphHelper._known_graphs[graph_name] ~= nil then
		return 
	end

	console_command("graph", "make", graph_name)

	slot3 = 1
	slot4 = stat_names or {}

	for i = slot3, #slot4, 1 do
		local stat = stat_names[i]

		if GraphHelper._known_stats[stat] == nil then
			record_statistics(stat, 0)
			console_command("graph", "add", graph_name, stat)
			record_statistics(stat, 0)

			GraphHelper._known_stats[stat] = "number"
		end
	end

	slot3 = 1
	slot4 = stat_names_vector3 or {}

	for i = slot3, #slot4, 1 do
		local stat = stat_names_vector3[i]

		if GraphHelper._known_stats[stat] == nil then
			record_statistics(stat, Vector3.zero())
			console_command("graph", "add_vector3", graph_name, stat)
			record_statistics(stat, Vector3.zero())

			GraphHelper._known_stats[stat] = "userdata"
		end
	end

	console_command("graph", "show", graph_name)

	return 
end
GraphHelper.show = function (graph_name)
	console_command("graph", "show", graph_name)

	return 
end
GraphHelper.hide = function (graph_name)
	console_command("graph", "hide", graph_name)

	return 
end
GraphHelper.set_range = function (graph_name, min, max)
	console_command("graph", "range", graph_name, tostring(min), tostring(max))

	return 
end
GraphHelper.update_range = function (graph_name)
	console_command("graph", "range", graph_name)

	return 
end
GraphHelper.set_color = function (stat, color)
	console_command("graph", "color", color)

	return 
end
GraphHelper.record_statistics = function (stat, value)
	assert(GraphHelper._known_stats[stat] == type(value))
	record_statistics(stat, value)

	return 
end

return 