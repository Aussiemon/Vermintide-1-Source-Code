ScoreboardHelper = ScoreboardHelper or {}
ScoreboardHelper.scoreboard_topic_stats = {
	{
		stat_type = "kills_total",
		display_text = "scoreboard_topic_kills_total",
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		stat_type = "headshots",
		display_text = "scoreboard_topic_headshots",
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		stat_type = "kills_melee",
		display_text = "scoreboard_topic_kills_melee",
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		stat_type = "kills_ranged",
		display_text = "scoreboard_topic_kills_ranged",
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		stat_type = "damage_taken",
		display_text = "scoreboard_topic_damage_taken",
		sort_function = function (a, b)
			return a.score < b.score
		end
	},
	{
		stat_type = "damage_dealt",
		display_text = "scoreboard_topic_damage_dealt",
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		display_text = "scoreboard_topic_kills_skaven_core_rats",
		stat_types = {
			{
				"kills_per_breed",
				"skaven_clan_rat"
			},
			{
				"kills_per_breed",
				"skaven_slave"
			}
		},
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		display_text = "scoreboard_topic_kills_skaven_storm_vermin",
		stat_types = {
			{
				"kills_per_breed",
				"skaven_storm_vermin"
			},
			{
				"kills_per_breed",
				"skaven_storm_vermin_commander"
			}
		},
		sort_function = function (a, b)
			return b.score < a.score
		end
	},
	{
		display_text = "scoreboard_topic_kills_specials",
		stat_types = {
			{
				"kills_per_breed",
				"skaven_gutter_runner"
			},
			{
				"kills_per_breed",
				"skaven_poison_wind_globadier"
			},
			{
				"kills_per_breed",
				"skaven_pack_master"
			}
		},
		sort_function = function (a, b)
			return b.score < a.score
		end
	}
}

local function get_score(statistics_db, stats_id, stat_type)
	if type(stat_type) == "table" then
		return statistics_db.get_stat(statistics_db, stats_id, unpack(stat_type))
	else
		return statistics_db.get_stat(statistics_db, stats_id, stat_type)
	end

	return 
end

ScoreboardHelper.get_sorted_topic_statistics = function (statistics_db, profile_synchronizer)
	assert(statistics_db, "Missing statistics_database reference.")
	assert(profile_synchronizer, "Missing profile_synchronizer reference.")

	local bots_and_players = Managers.player:human_and_bot_players()
	local own_player_stats_id = nil
	local player_list = {}

	for _, player in pairs(bots_and_players) do
		local is_local_player = player.local_player
		local player_peer_id = player.network_id(player)
		local player_name = player.name(player)
		local stats_id = player.stats_id(player)
		local profile_index = profile_synchronizer.profile_by_peer(profile_synchronizer, player_peer_id, player.local_player_id(player))
		local is_player_controlled = player.is_player_controlled(player)
		player_list[stats_id] = {
			name = player_name,
			peer_id = player_peer_id,
			local_player_id = player.local_player_id(player),
			stats_id = stats_id,
			profile_index = profile_index,
			is_player_controlled = is_player_controlled
		}

		if is_local_player then
			own_player_stats_id = stats_id
		end
	end

	local topic_stats_table = {}
	local scoreboard_topic_stats = ScoreboardHelper.scoreboard_topic_stats

	local function sort_by_player_performance(a, b)
		local a_scores = a.scores
		local b_scores = b.scores
		local my_position_a = math.huge
		local my_position_b = math.huge

		for i = 1, #a_scores, 1 do
			if a_scores[i].stats_id == own_player_stats_id then
				my_position_a = i
			end
		end

		for i = 1, #b_scores, 1 do
			if b_scores[i].stats_id == own_player_stats_id then
				my_position_b = i
			end
		end

		return my_position_a < my_position_b
	end

	for i, topic in ipairs(scoreboard_topic_stats) do
		local stat_types = topic.stat_types
		local scores = {}
		local scores_n = 0

		for stats_id, player_data in pairs(player_list) do
			scores_n = scores_n + 1

			if stat_types ~= nil then
				local stat_types_n = #stat_types
				local score = 0

				for i = 1, stat_types_n, 1 do
					local stat_type = stat_types[i]
					score = score + get_score(statistics_db, player_data.stats_id, stat_type)
				end

				scores[scores_n] = {
					score = score,
					stats_id = stats_id
				}
			else
				local stat_type = topic.stat_type
				local score = get_score(statistics_db, player_data.stats_id, stat_type)
				scores[scores_n] = {
					score = score,
					stats_id = stats_id
				}
			end

			assert(scores[scores_n].score ~= nil, "Couldn't find scoreboard statistic for '%s'", topic.display_text)
		end

		table.sort(scores, topic.sort_function)

		topic_stats_table[i] = {
			scores = scores,
			display_text = topic.display_text
		}

		if own_player_stats_id then
			table.sort(topic_stats_table, sort_by_player_performance)
		end
	end

	return {
		topic_stats_table,
		player_list
	}
end

return 
