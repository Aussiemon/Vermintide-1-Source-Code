return function ()
	define_rule({
		response = "nde_objective_dwarf_int_brewery_engineer",
		name = "nde_objective_dwarf_int_brewery_engineer",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_brewery_stabilize pressure",
		name = "nde_objective_dwarf_int_brewery_stabilize pressure",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_stabilize_pressure"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_brewery_valve_guide",
		name = "nde_objective_dwarf_int_brewery_valve_guide",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_valve_guide"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_main_hall_engineer",
		name = "nde_objective_dwarf_int_main_hall_engineer",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_engineer"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_main_hall_explosive_ready",
		name = "nde_objective_dwarf_int_main_hall_explosive_ready",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_explosive_ready"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_brewery_start",
		name = "nde_objective_dwarf_int_brewery_start",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_start"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_main_hall_start",
		name = "nde_objective_dwarf_int_main_hall_start",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_start"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_brewery_stabilize_pressure_success",
		name = "nde_objective_dwarf_int_brewery_stabilize_pressure_success",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_stabilize_pressure_success"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_brewery_stabilize_pressure_fail",
		name = "nde_objective_dwarf_int_brewery_stabilize_pressure_fail",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_stabilize_pressure_fail"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_brewery_stabilize pressure_success_final",
		name = "nde_objective_dwarf_int_brewery_stabilize pressure_success_final",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_stabilize_pressure_success_final"
			}
		}
	})
	define_rule({
		response = "nde_objective_dwarf_int_main_hall_mission_complete",
		name = "nde_objective_dwarf_int_main_hall_mission_complete",
		criterias = {
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_engineer"
			},
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_mission_complete"
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_crossroad_top_open",
		response = "pes_objective_dwarf_int_crossroad_top_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_top_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_crossroad_bottom_open",
		response = "pes_objective_dwarf_int_crossroad_bottom_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_bottom_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_hallway",
		response = "pes_objective_dwarf_int_hallway",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_hallway"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_barricades",
		response = "pes_objective_dwarf_int_barricades",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_barricades"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_temple_of_valaya",
		response = "pes_objective_dwarf_int_temple_of_valaya",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_temple_of_valaya"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_brewery_aroma",
		response = "pes_objective_dwarf_int_brewery_aroma",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_aroma"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pes_objective_dwarf_int_brewery_engineer_search",
		name = "pes_objective_dwarf_int_brewery_engineer_search",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_search"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pes_objective_dwarf_int_brewery_engineer_reply",
		name = "pes_objective_dwarf_int_brewery_engineer_reply",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_skaven_territory",
		response = "pes_objective_dwarf_int_skaven_territory",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_skaven_territory"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_main_hall_pc_acknowledge",
		response = "pes_objective_dwarf_int_main_hall_pc_acknowledge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_pc_acknowledge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_pc_acknowledge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_pc_acknowledge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_main_hall_unstable",
		response = "pes_objective_dwarf_int_main_hall_unstable",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_pickup"
			},
			{
				"query_context",
				"pickup_name",
				OP.EQ,
				"pickup_explosive_barrel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pes_objective_dwarf_int_main_hall_tunnel_bombed",
		name = "pes_objective_dwarf_int_main_hall_tunnel_bombed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel_bombed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_main_hall_end",
		response = "pes_objective_dwarf_int_main_hall_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_main_hall_tunnel",
		response = "pes_objective_dwarf_int_main_hall_tunnel",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_brewery_end",
		response = "pes_objective_dwarf_int_brewery_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_long_way_down",
		response = "pes_objective_dwarf_ext_long_way_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_long_way_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_guard_post",
		response = "pes_objective_dwarf_ext_guard_post",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_guard_post"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_spotting_karak_azgaraz",
		response = "pes_objective_dwarf_ext_spotting_karak_azgaraz",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_karak_azgaraz"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_frozen_lake",
		response = "pes_objective_dwarf_ext_frozen_lake",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_frozen_lake"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_trading_road",
		response = "pes_objective_dwarf_ext_trading_road",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_trading_road"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_mining_path",
		response = "pes_objective_dwarf_ext_mining_path",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_mining_path"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_railyard",
		response = "pes_objective_dwarf_ext_railyard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_railyard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_spotting_chamber_area",
		response = "pes_objective_dwarf_ext_spotting_chamber_area",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_chamber_area"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_waterfall",
		response = "pes_objective_dwarf_ext_waterfall",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_waterfall"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_open_chamber",
		response = "pes_objective_dwarf_ext_open_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_open_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_grab_artifact",
		response = "pes_objective_dwarf_ext_grab_artifact",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_grab_artifact"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_lets_go",
		response = "pes_objective_dwarf_ext_lets_go",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_lets_go"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pes_objective_dwarf_ext_up_ramp",
		name = "pes_objective_dwarf_ext_up_ramp",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_up_ramp"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		response = "pes_objective_dwarf_ext_keep_running",
		name = "pes_objective_dwarf_ext_keep_running",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_keep_running"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_weathercomplaints",
		response = "pes_objective_beacons_weathercomplaints",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_weathercomplaints"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_dwarftown",
		response = "pes_objective_beacons_dwarftown",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_dwarftown"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_lowergate",
		response = "pes_objective_beacons_lowergate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_lowergatex2",
		response = "pes_objective_beacons_lowergatex2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergatex2"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex3",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_gatedone",
		response = "pes_objective_beacons_gatedone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_gatedone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_beacon_visible",
		response = "pes_objective_beacons_beacon_visible",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_beacon_visible"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_pressureplate",
		response = "pes_objective_beacons_pressureplate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_pressureplate_progress",
		response = "pes_objective_beacons_pressureplate_progress",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate_progress"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_lit",
		response = "pes_objective_beacons_lit",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_beacons_background",
		response = "pes_objective_beacons_background",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_background"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pes_objective_dwarf_int_brewery_engineer_reply_keystoine",
		name = "pes_objective_dwarf_int_brewery_engineer_reply_keystoine",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply_keystone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_intro",
		response = "pes_objective_dwarf_int_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_intro_b",
		response = "pes_objective_dwarf_int_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_int_intro_c",
		response = "pes_objective_dwarf_int_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_intro",
		response = "pes_objective_dwarf_ext_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_intro_b",
		response = "pes_objective_dwarf_ext_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_ext_intro_c",
		response = "pes_objective_dwarf_ext_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_beacons_intro",
		response = "pes_objective_dwarf_beacons_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_beacons_intro_b",
		response = "pes_objective_dwarf_beacons_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dwarf_beacons_intro_c",
		response = "pes_objective_dwarf_beacons_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_intro",
		response = "pwh_objective_dwarf_int_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_intro_b",
		response = "pwh_objective_dwarf_int_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_intro_c",
		response = "pwh_objective_dwarf_int_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_intro",
		response = "pwh_objective_dwarf_ext_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_intro_b",
		response = "pwh_objective_dwarf_ext_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_intro_c",
		response = "pwh_objective_dwarf_ext_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_beacons_intro",
		response = "pwh_objective_dwarf_beacons_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_beacons_intro_b",
		response = "pwh_objective_dwarf_beacons_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_beacons_intro_c",
		response = "pwh_objective_dwarf_beacons_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_crossroad_top_open",
		response = "pbw_objective_dwarf_int_crossroad_top_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_top_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_dwarf_int_crossroad_top_open",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dwarf_int_crossroad_top_open",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_crossroad_bottom_open",
		response = "pbw_objective_dwarf_int_crossroad_bottom_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_bottom_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_hallway",
		response = "pbw_objective_dwarf_int_hallway",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_hallway"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_barricades",
		response = "pbw_objective_dwarf_int_barricades",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_barricades"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_temple_of_valaya",
		response = "pbw_objective_dwarf_int_temple_of_valaya",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_temple_of_valaya"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_brewery_aroma",
		response = "pbw_objective_dwarf_int_brewery_aroma",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_aroma"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_int_brewery_engineer_search",
		name = "pbw_objective_dwarf_int_brewery_engineer_search",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_search"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_int_brewery_engineer_reply",
		name = "pbw_objective_dwarf_int_brewery_engineer_reply",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_skaven_territory",
		response = "pbw_objective_dwarf_int_skaven_territory",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_skaven_territory"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_int_main_hall_pc_acknowledge",
		name = "pbw_objective_dwarf_int_main_hall_pc_acknowledge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_pc_acknowledge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_main_hall_unstable",
		response = "pbw_objective_dwarf_int_main_hall_unstable",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_pickup"
			},
			{
				"query_context",
				"pickup_name",
				OP.EQ,
				"pickup_explosive_barrel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_int_main_hall_tunnel_bombed",
		name = "pbw_objective_dwarf_int_main_hall_tunnel_bombed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel_bombed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_main_hall_end",
		response = "pbw_objective_dwarf_int_main_hall_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_main_hall_tunnel",
		response = "pbw_objective_dwarf_int_main_hall_tunnel",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_brewery_end",
		response = "pbw_objective_dwarf_int_brewery_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_long_way_down",
		response = "pbw_objective_dwarf_ext_long_way_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_long_way_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_guard_post",
		response = "pbw_objective_dwarf_ext_guard_post",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_guard_post"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_spotting_karak_azgaraz",
		response = "pbw_objective_dwarf_ext_spotting_karak_azgaraz",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_karak_azgaraz"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_frozen_lake",
		response = "pbw_objective_dwarf_ext_frozen_lake",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_frozen_lake"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_trading_road",
		response = "pbw_objective_dwarf_ext_trading_road",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_trading_road"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_mining_path",
		response = "pbw_objective_dwarf_ext_mining_path",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_mining_path"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_railyard",
		response = "pbw_objective_dwarf_ext_railyard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_railyard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_spotting_chamber_area",
		response = "pbw_objective_dwarf_ext_spotting_chamber_area",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_chamber_area"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_waterfall",
		response = "pbw_objective_dwarf_ext_waterfall",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_waterfall"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_open_chamber",
		response = "pbw_objective_dwarf_ext_open_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_open_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_grab_artifact",
		response = "pbw_objective_dwarf_ext_grab_artifact",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_grab_artifact"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_lets_go",
		response = "pbw_objective_dwarf_ext_lets_go",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_lets_go"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_ext_up_ramp",
		name = "pbw_objective_dwarf_ext_up_ramp",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_up_ramp"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_ext_keep_running",
		name = "pbw_objective_dwarf_ext_keep_running",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_keep_running"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_weathercomplaints",
		response = "pbw_objective_beacons_weathercomplaints",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_weathercomplaints"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_dwarftown",
		response = "pbw_objective_beacons_dwarftown",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_dwarftown"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_lowergate",
		response = "pbw_objective_beacons_lowergate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_lowergatex2",
		response = "pbw_objective_beacons_lowergatex2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergatex2"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex3",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_gatedone",
		response = "pbw_objective_beacons_gatedone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_gatedone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_beacon_visible",
		response = "pbw_objective_beacons_beacon_visible",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_beacon_visible"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_pressureplate",
		response = "pbw_objective_beacons_pressureplate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_pressureplate_progress",
		response = "pbw_objective_beacons_pressureplate_progress",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate_progress"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_lit",
		response = "pbw_objective_beacons_lit",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_background",
		response = "pbw_objective_beacons_background",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_background"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pbw_objective_dwarf_int_brewery_engineer_reply_keystone",
		name = "pbw_objective_dwarf_int_brewery_engineer_reply_keystone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply_keystone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		}
	})
	define_rule({
		name = "pbw_objective_beacons_ulgu",
		response = "pbw_objective_beacons_ulgu",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_ulgu"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_ulgu",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_ulgu",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_crossroad_top_open",
		response = "pdr_objective_dwarf_int_crossroad_top_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_top_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_crossroad_bottom_open",
		response = "pdr_objective_dwarf_int_crossroad_bottom_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_bottom_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_hallway",
		response = "pdr_objective_dwarf_int_hallway",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_hallway"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_barricades",
		response = "pdr_objective_dwarf_int_barricades",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_barricades"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_temple_of_valaya",
		response = "pdr_objective_dwarf_int_temple_of_valaya",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_temple_of_valaya"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_brewery_aroma",
		response = "pdr_objective_dwarf_int_brewery_aroma",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_aroma"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_int_brewery_engineer_search",
		name = "pdr_objective_dwarf_int_brewery_engineer_search",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_search"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_int_brewery_engineer_reply",
		name = "pdr_objective_dwarf_int_brewery_engineer_reply",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_skaven_territory",
		response = "pdr_objective_dwarf_int_skaven_territory",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_skaven_territory"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_int_main_hall_pc_acknowledge",
		name = "pdr_objective_dwarf_int_main_hall_pc_acknowledge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_pc_acknowledge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_main_hall_unstable",
		response = "pdr_objective_dwarf_int_main_hall_unstable",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_pickup"
			},
			{
				"query_context",
				"pickup_name",
				OP.EQ,
				"pickup_explosive_barrel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_int_main_hall_tunnel_bombed",
		name = "pdr_objective_dwarf_int_main_hall_tunnel_bombed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel_bombed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_main_hall_end",
		response = "pdr_objective_dwarf_int_main_hall_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_main_hall_tunnel",
		response = "pdr_objective_dwarf_int_main_hall_tunnel",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_brewery_end",
		response = "pdr_objective_dwarf_int_brewery_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_long_way_down",
		response = "pdr_objective_dwarf_ext_long_way_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_long_way_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_guard_post",
		response = "pdr_objective_dwarf_ext_guard_post",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_guard_post"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_spotting_karak_azgaraz",
		response = "pdr_objective_dwarf_ext_spotting_karak_azgaraz",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_karak_azgaraz"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_frozen_lake",
		response = "pdr_objective_dwarf_ext_frozen_lake",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_frozen_lake"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_trading_road",
		response = "pdr_objective_dwarf_ext_trading_road",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_trading_road"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_mining_path",
		response = "pdr_objective_dwarf_ext_mining_path",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_mining_path"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_railyard",
		response = "pdr_objective_dwarf_ext_railyard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_railyard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_spotting_chamber_area",
		response = "pdr_objective_dwarf_ext_spotting_chamber_area",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_chamber_area"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_waterfall",
		response = "pdr_objective_dwarf_ext_waterfall",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_waterfall"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_open_chamber",
		response = "pdr_objective_dwarf_ext_open_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_open_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_grab_artifact",
		response = "pdr_objective_dwarf_ext_grab_artifact",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_grab_artifact"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_lets_go",
		response = "pdr_objective_dwarf_ext_lets_go",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_lets_go"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_ext_up_ramp",
		name = "pdr_objective_dwarf_ext_up_ramp",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_up_ramp"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_ext_keep_running",
		name = "pdr_objective_dwarf_ext_keep_running",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_keep_running"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_weathercomplaints",
		response = "pdr_objective_beacons_weathercomplaints",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_weathercomplaints"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_dwarftown",
		response = "pdr_objective_beacons_dwarftown",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_dwarftown"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_lowergate",
		response = "pdr_objective_beacons_lowergate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_lowergatex2",
		response = "pdr_objective_beacons_lowergatex2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergatex2"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex3",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_gatedone",
		response = "pdr_objective_beacons_gatedone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_gatedone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_beacon_visible",
		response = "pdr_objective_beacons_beacon_visible",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_beacon_visible"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_pressureplate",
		response = "pdr_objective_beacons_pressureplate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_pressureplate_progress",
		response = "pdr_objective_beacons_pressureplate_progress",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate_progress"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_lit",
		response = "pdr_objective_beacons_lit",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_background",
		response = "pdr_objective_beacons_background",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_background"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pdr_objective_dwarf_int_brewery_engineer_reply_keystone",
		name = "pdr_objective_dwarf_int_brewery_engineer_reply_keystone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply_keystone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		}
	})
	define_rule({
		name = "pdr_objective_beacons_ulgu",
		response = "pdr_objective_beacons_ulgu",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_ulgu"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_crossroad_top_open",
		response = "pwe_objective_dwarf_int_crossroad_top_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_top_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_crossroad_bottom_open",
		response = "pwe_objective_dwarf_int_crossroad_bottom_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_bottom_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_hallway",
		response = "pwe_objective_dwarf_int_hallway",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_hallway"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_barricades",
		response = "pwe_objective_dwarf_int_barricades",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_barricades"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_temple_of_valaya",
		response = "pwe_objective_dwarf_int_temple_of_valaya",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_temple_of_valaya"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_brewery_aroma",
		response = "pwe_objective_dwarf_int_brewery_aroma",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_aroma"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwe_objective_dwarf_int_brewery_engineer_search",
		name = "pwe_objective_dwarf_int_brewery_engineer_search",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_search"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pwe_objective_dwarf_int_brewery_engineer_reply",
		name = "pwe_objective_dwarf_int_brewery_engineer_reply",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_skaven_territory",
		response = "pwe_objective_dwarf_int_skaven_territory",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_skaven_territory"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwe_objective_dwarf_int_main_hall_pc_acknowledge",
		name = "pwe_objective_dwarf_int_main_hall_pc_acknowledge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_pc_acknowledge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_main_hall_unstable",
		response = "pwe_objective_dwarf_int_main_hall_unstable",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_pickup"
			},
			{
				"query_context",
				"pickup_name",
				OP.EQ,
				"pickup_explosive_barrel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_unstable",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pwe_objective_dwarf_int_main_hall_tunnel_bombed",
		name = "pwe_objective_dwarf_int_main_hall_tunnel_bombed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel_bombed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_main_hall_end",
		response = "pwe_objective_dwarf_int_main_hall_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_main_hall_tunnel",
		response = "pwe_objective_dwarf_int_main_hall_tunnel",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_brewery_end",
		response = "pwe_objective_dwarf_int_brewery_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_long_way_down",
		response = "pwe_objective_dwarf_ext_long_way_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_long_way_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_guard_post",
		response = "pwe_objective_dwarf_ext_guard_post",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_guard_post"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_spotting_karak_azgaraz",
		response = "pwe_objective_dwarf_ext_spotting_karak_azgaraz",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_karak_azgaraz"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_frozen_lake",
		response = "pwe_objective_dwarf_ext_frozen_lake",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_frozen_lake"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_trading_road",
		response = "pwe_objective_dwarf_ext_trading_road",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_trading_road"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_mining_path",
		response = "pwe_objective_dwarf_ext_mining_path",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_mining_path"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_railyard",
		response = "pwe_objective_dwarf_ext_railyard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_railyard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_spotting_chamber_area",
		response = "pwe_objective_dwarf_ext_spotting_chamber_area",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_chamber_area"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_waterfall",
		response = "pwe_objective_dwarf_ext_waterfall",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_waterfall"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_open_chamber",
		response = "pwe_objective_dwarf_ext_open_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_open_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_grab_artifact",
		response = "pwe_objective_dwarf_ext_grab_artifact",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_grab_artifact"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_lets_go",
		response = "pwe_objective_dwarf_ext_lets_go",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_lets_go"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwe_objective_dwarf_ext_up_ramp",
		name = "pwe_objective_dwarf_ext_up_ramp",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_up_ramp"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		response = "pwe_objective_dwarf_ext_keep_running",
		name = "pwe_objective_dwarf_ext_keep_running",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_keep_running"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_weathercomplaints",
		response = "pwe_objective_beacons_weathercomplaints",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_weathercomplaints"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_dwarftown",
		response = "pwe_objective_beacons_dwarftown",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_dwarftown"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_lowergate",
		response = "pwe_objective_beacons_lowergate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_lowergatex2",
		response = "pwe_objective_beacons_lowergatex2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergatex2"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex3",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_gatedone",
		response = "pwe_objective_beacons_gatedone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_gatedone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_beacon_visible",
		response = "pwe_objective_beacons_beacon_visible",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_beacon_visible"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_pressureplate",
		response = "pwe_objective_beacons_pressureplate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_pressureplate_progress",
		response = "pwe_objective_beacons_pressureplate_progress",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate_progress"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_lit",
		response = "pwe_objective_beacons_lit",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_background",
		response = "pwe_objective_beacons_background",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_background"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_beacons_ulgu",
		response = "pwe_objective_beacons_ulgu",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_ulgu"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_ulgu",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_ulgu",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_crossroad_top_open",
		response = "pwh_objective_dwarf_int_crossroad_top_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_top_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_view",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_crossroad_bottom_open",
		response = "pwh_objective_dwarf_int_crossroad_bottom_open",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_crossroad_bottom_open"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_crossroad_bottom_open",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_hallway",
		response = "pwh_objective_dwarf_int_hallway",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_hallway"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_hallway",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_barricades",
		response = "pwh_objective_dwarf_int_barricades",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_barricades"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_barricades",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_temple_of_valaya",
		response = "pwh_objective_dwarf_int_temple_of_valaya",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_temple_of_valaya"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_temple_of_valaya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_brewery_aroma",
		response = "pwh_objective_dwarf_int_brewery_aroma",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_aroma"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_aroma",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_int_brewery_engineer_search",
		name = "pwh_objective_dwarf_int_brewery_engineer_search",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_search"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_int_brewery_engineer_reply",
		name = "pwh_objective_dwarf_int_brewery_engineer_reply",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_int_brewery_engineer_reply_keystone",
		name = "pwh_objective_dwarf_int_brewery_engineer_reply_keystone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_engineer_reply_keystone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_skaven_territory",
		response = "pwh_objective_dwarf_int_skaven_territory",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_skaven_territory"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_skaven_territory",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_int_main_hall_pc_acknowledge",
		name = "pwh_objective_dwarf_int_main_hall_pc_acknowledge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_pc_acknowledge"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_main_hall_unstable",
		response = "pwh_objective_dwarf_int_main_hall_unstable",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"on_pickup"
			},
			{
				"query_context",
				"pickup_name",
				OP.EQ,
				"pickup_explosive_barrel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_pickup_explosive_barrel",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_pickup_explosive_barrel",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_int_main_hall_tunnel_bombed",
		name = "pwh_objective_dwarf_int_main_hall_tunnel_bombed",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel_bombed"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_main_hall_end",
		response = "pwh_objective_dwarf_int_main_hall_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_main_hall_tunnel",
		response = "pwh_objective_dwarf_int_main_hall_tunnel",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_main_hall_tunnel"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_main_hall_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_int_brewery_end",
		response = "pwh_objective_dwarf_int_brewery_end",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_brewery_end"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_brewery_end",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_long_way_down",
		response = "pwh_objective_dwarf_ext_long_way_down",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_long_way_down"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_long_way_down",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_guard_post",
		response = "pwh_objective_dwarf_ext_guard_post",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_guard_post"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_guard_post",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_spotting_karak_azgaraz",
		response = "pwh_objective_dwarf_ext_spotting_karak_azgaraz",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_karak_azgaraz"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_karak_azgaraz",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_frozen_lake",
		response = "pwh_objective_dwarf_ext_frozen_lake",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_frozen_lake"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_frozen_lake",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_trading_road",
		response = "pwh_objective_dwarf_ext_trading_road",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_trading_road"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_trading_road",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_mining_path",
		response = "pwh_objective_dwarf_ext_mining_path",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_mining_path"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_mining_path",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_railyard",
		response = "pwh_objective_dwarf_ext_railyard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_railyard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_railyard",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_spotting_chamber_area",
		response = "pwh_objective_dwarf_ext_spotting_chamber_area",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_spotting_chamber_area"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_spotting_chamber_area",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_waterfall",
		response = "pwh_objective_dwarf_ext_waterfall",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_waterfall"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_waterfall",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_open_chamber",
		response = "pwh_objective_dwarf_ext_open_chamber",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_open_chamber"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_open_chamber",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_grab_artifact",
		response = "pwh_objective_dwarf_ext_grab_artifact",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_grab_artifact"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_grab_artifact",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dwarf_ext_lets_go",
		response = "pwh_objective_dwarf_ext_lets_go",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_lets_go"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_lets_go",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_ext_up_ramp",
		name = "pwh_objective_dwarf_ext_up_ramp",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_up_ramp"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		response = "pwh_objective_dwarf_ext_keep_running",
		name = "pwh_objective_dwarf_ext_keep_running",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_keep_running"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_weathercomplaints",
		response = "pwh_objective_beacons_weathercomplaints",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_weathercomplaints"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_weathercomplaints",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_dwarftown",
		response = "pwh_objective_beacons_dwarftown",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_dwarftown"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_dwarftown",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_lowergate",
		response = "pwh_objective_beacons_lowergate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_lowergatex2",
		response = "pwh_objective_beacons_lowergatex2",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lowergatex2"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lowergatex3",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_gatedone",
		response = "pwh_objective_beacons_gatedone",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_gatedone"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_gatedone",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_beacon_visible",
		response = "pwh_objective_beacons_beacon_visible",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_beacon_visible"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_beacon_visible",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_pressureplate",
		response = "pwh_objective_beacons_pressureplate",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_pressureplate_progress",
		response = "pwh_objective_beacons_pressureplate_progress",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_pressureplate_progress"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_pressureplate_progress",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_lit",
		response = "pwh_objective_beacons_lit",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_lit"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_lit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_background",
		response = "pwh_objective_beacons_background",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_background"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_background",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_beacons_ulgu",
		response = "pwh_objective_beacons_ulgu",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_beacons_ulgu"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_objective_beacons_ulgu",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_beacons_ulgu",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_intro",
		response = "pwe_objective_dwarf_int_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_intro_b",
		response = "pwe_objective_dwarf_int_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_int_intro_c",
		response = "pwe_objective_dwarf_int_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_intro",
		response = "pwe_objective_dwarf_ext_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_intro_b",
		response = "pwe_objective_dwarf_ext_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_ext_intro_c",
		response = "pwe_objective_dwarf_ext_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_beacons_intro",
		response = "pwe_objective_dwarf_beacons_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_beacons_intro_b",
		response = "pwe_objective_dwarf_beacons_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dwarf_beacons_intro_c",
		response = "pwe_objective_dwarf_beacons_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_intro",
		response = "pbw_objective_dwarf_int_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_intro_b",
		response = "pbw_objective_dwarf_int_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_int_intro_c",
		response = "pbw_objective_dwarf_int_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_intro",
		response = "pbw_objective_dwarf_ext_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_intro_b",
		response = "pbw_objective_dwarf_ext_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_ext_intro_c",
		response = "pbw_objective_dwarf_ext_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_beacons_intro",
		response = "pbw_objective_dwarf_beacons_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_beacons_intro_b",
		response = "pbw_objective_dwarf_beacons_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dwarf_beacons_intro_c",
		response = "pbw_objective_dwarf_beacons_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_intro",
		response = "pdr_objective_dwarf_int_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_intro_b",
		response = "pdr_objective_dwarf_int_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_int_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_int_intro_c",
		response = "pdr_objective_dwarf_int_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_int_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_intro",
		response = "pdr_objective_dwarf_ext_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_intro_b",
		response = "pdr_objective_dwarf_ext_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_ext_intro_c",
		response = "pdr_objective_dwarf_ext_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_ext_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_ext_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_beacons_intro",
		response = "pdr_objective_dwarf_beacons_intro",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_beacons_intro_b",
		response = "pdr_objective_dwarf_beacons_intro_b",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dwarf_beacons_intro_c",
		response = "pdr_objective_dwarf_beacons_intro_c",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"dialogue_name_nopre",
				OP.EQ,
				"objective_dwarf_beacons_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dwarf_beacons_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_karak_azgaraz_dwarf_quest_story_one_01",
		response = "pbw_karak_azgaraz_dwarf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_one",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_one",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_one_01",
		response = "pdr_karak_azgaraz_dwarf_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_karak_azgaraz_dwarf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_karak_azgaraz_dwarf_quest_story_one_02",
		response = "pbw_karak_azgaraz_dwarf_quest_story_one_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_one_02",
		response = "pdr_karak_azgaraz_dwarf_quest_story_one_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_karak_azgaraz_dwarf_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_karak_azgaraz_dwarf_quest_story_one_03",
		response = "pbw_karak_azgaraz_dwarf_quest_story_one_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_karak_azgaraz_dwarf_quest_story_two_01",
		response = "pwh_karak_azgaraz_dwarf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_two",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_two",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_two_01",
		response = "pdr_karak_azgaraz_dwarf_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_karak_azgaraz_dwarf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_karak_azgaraz_dwarf_quest_story_two_02",
		response = "pwh_karak_azgaraz_dwarf_quest_story_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_two_02",
		response = "pdr_karak_azgaraz_dwarf_quest_story_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_karak_azgaraz_dwarf_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_dwarf_quest_story_three_01",
		response = "pes_karak_azgaraz_dwarf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_three",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_three",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_three_01",
		response = "pdr_karak_azgaraz_dwarf_quest_story_three_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_dwarf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_dwarf_quest_story_three_02",
		response = "pes_karak_azgaraz_dwarf_quest_story_three_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_three_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_three_02",
		response = "pdr_karak_azgaraz_dwarf_quest_story_three_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_dwarf_quest_story_three_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_karak_azgaraz_dwarf_quest_story_four_01",
		response = "pwe_karak_azgaraz_dwarf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_four",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_four",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_four_01",
		response = "pdr_karak_azgaraz_dwarf_quest_story_four_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_karak_azgaraz_dwarf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_karak_azgaraz_dwarf_quest_story_four_02",
		response = "pwe_karak_azgaraz_dwarf_quest_story_four_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_four_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_four_02",
		response = "pdr_karak_azgaraz_dwarf_quest_story_four_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_karak_azgaraz_dwarf_quest_story_four_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_karak_azgaraz_dwarf_quest_story_four_01_alt1",
		response = "pwe_karak_azgaraz_dwarf_quest_story_four_01_alt1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_four_alt",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_four_alt",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_four_01_alt1",
		response = "pdr_karak_azgaraz_dwarf_quest_story_four_01_alt1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_karak_azgaraz_dwarf_quest_story_four_01_alt1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_karak_azgaraz_dwarf_quest_story_four_02_alt1",
		response = "pwe_karak_azgaraz_dwarf_quest_story_four_02_alt1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_four_01_alt1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_four_02_alt1",
		response = "pdr_karak_azgaraz_dwarf_quest_story_four_02_alt1",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwe_karak_azgaraz_dwarf_quest_story_four_02_alt1"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_dwarf_quest_story_five_01",
		response = "pes_karak_azgaraz_dwarf_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"dwarf_ranger",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_five",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_dwarf_quest_story_five",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_five_01",
		response = "pdr_karak_azgaraz_dwarf_quest_story_five_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_dwarf_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_dwarf_quest_story_five_02",
		response = "pes_karak_azgaraz_dwarf_quest_story_five_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_five_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_five_02",
		response = "pdr_karak_azgaraz_dwarf_quest_story_five_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_dwarf_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_dwarf_quest_story_five_03",
		response = "pes_karak_azgaraz_dwarf_quest_story_five_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pdr_karak_azgaraz_dwarf_quest_story_five_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_karak_azgaraz_dwarf_quest_story_five_03",
		response = "pdr_karak_azgaraz_dwarf_quest_story_five_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_dwarf_quest_story_five_03"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_karak_azgaraz_witch_hunter_quest_story_one_01",
		response = "pwh_karak_azgaraz_witch_hunter_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GTEQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"global_context",
				"bright_wizard",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_witch_hunter_quest_story_one",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_witch_hunter_quest_story_one",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_karak_azgaraz_witch_hunter_quest_story_one_01",
		response = "pbw_karak_azgaraz_witch_hunter_quest_story_one_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_karak_azgaraz_witch_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_karak_azgaraz_witch_hunter_quest_story_one_02",
		response = "pwh_karak_azgaraz_witch_hunter_quest_story_one_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pbw_karak_azgaraz_witch_hunter_quest_story_one_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_karak_azgaraz_witch_hunter_quest_story_one_02",
		response = "pbw_karak_azgaraz_witch_hunter_quest_story_one_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_karak_azgaraz_witch_hunter_quest_story_one_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_witch_hunter_quest_story_two_01",
		response = "pes_karak_azgaraz_witch_hunter_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"story_trigger"
			},
			{
				"user_context",
				"enemies_close",
				OP.LT,
				4
			},
			{
				"user_context",
				"pacing_state",
				OP.EQ,
				"pacing_relax"
			},
			{
				"user_context",
				"intensity",
				OP.LT,
				40
			},
			{
				"user_context",
				"friends_close",
				OP.GT,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"global_context",
				"witch_hunter",
				OP.EQ,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMEDIFF,
				OP.GT,
				300
			},
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_witch_hunter_quest_story_two",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"once_per_level_karak_azgaraz_witch_hunter_quest_story_two",
				OP.ADD,
				1
			},
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_karak_azgaraz_witch_hunter_quest_story_two_01",
		response = "pwh_karak_azgaraz_witch_hunter_quest_story_two_01",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_witch_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_witch_hunter_quest_story_two_02",
		response = "pes_karak_azgaraz_witch_hunter_quest_story_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_karak_azgaraz_witch_hunter_quest_story_two_01"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_karak_azgaraz_witch_hunter_quest_story_two_02",
		response = "pwh_karak_azgaraz_witch_hunter_quest_story_two_02",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pes_karak_azgaraz_witch_hunter_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_karak_azgaraz_witch_hunter_quest_story_two_03",
		response = "pes_karak_azgaraz_witch_hunter_quest_story_two_03",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_speak"
			},
			{
				"query_context",
				"sound_event",
				OP.EQ,
				"pwh_karak_azgaraz_witch_hunter_quest_story_two_02"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_conversation",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwh_objective_dwarf_int_brewery_aroma = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_brewery_aroma_01",
				"pwh_objective_dwarf_int_brewery_aroma_02",
				"pwh_objective_dwarf_int_brewery_aroma_03",
				"pwh_objective_dwarf_int_brewery_aroma_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_brewery_aroma_01",
				"pwh_objective_dwarf_int_brewery_aroma_02",
				"pwh_objective_dwarf_int_brewery_aroma_03",
				"pwh_objective_dwarf_int_brewery_aroma_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_brewery_aroma = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_brewery_aroma_01",
				"pwe_objective_dwarf_int_brewery_aroma_02",
				"pwe_objective_dwarf_int_brewery_aroma_03",
				"pwe_objective_dwarf_int_brewery_aroma_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_brewery_aroma_01",
				"pwe_objective_dwarf_int_brewery_aroma_02",
				"pwe_objective_dwarf_int_brewery_aroma_03",
				"pwe_objective_dwarf_int_brewery_aroma_04"
			},
			randomize_indexes = {}
		},
		pbw_karak_azgaraz_dwarf_quest_story_one_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_karak_azgaraz_dwarf_quest_story_one_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_karak_azgaraz_dwarf_quest_story_one_03"
			}
		},
		pwe_objective_dwarf_int_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_int_intro_a_01",
				[2.0] = "pwe_objective_dwarf_int_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_int_intro_a_01",
				[2.0] = "pwe_objective_dwarf_int_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_brewery_aroma = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_brewery_aroma_01",
				"pdr_objective_dwarf_int_brewery_aroma_02",
				"pdr_objective_dwarf_int_brewery_aroma_03",
				"pdr_objective_dwarf_int_brewery_aroma_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_brewery_aroma_01",
				"pdr_objective_dwarf_int_brewery_aroma_02",
				"pdr_objective_dwarf_int_brewery_aroma_03",
				"pdr_objective_dwarf_int_brewery_aroma_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_beacons_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pwh_objective_dwarf_beacons_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pwh_objective_dwarf_beacons_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_open_chamber = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_open_chamber_01",
				"pwh_objective_dwarf_ext_open_chamber_02",
				"pwh_objective_dwarf_ext_open_chamber_03",
				"pwh_objective_dwarf_ext_open_chamber_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_open_chamber_01",
				"pwh_objective_dwarf_ext_open_chamber_02",
				"pwh_objective_dwarf_ext_open_chamber_03",
				"pwh_objective_dwarf_ext_open_chamber_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_beacons_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pes_objective_dwarf_beacons_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pes_objective_dwarf_beacons_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_beacons_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pdr_objective_dwarf_beacons_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pdr_objective_dwarf_beacons_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_spotting_chamber_area = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_spotting_chamber_area_01",
				"pwe_objective_dwarf_ext_spotting_chamber_area_02",
				"pwe_objective_dwarf_ext_spotting_chamber_area_03",
				"pwe_objective_dwarf_ext_spotting_chamber_area_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_spotting_chamber_area_01",
				"pwe_objective_dwarf_ext_spotting_chamber_area_02",
				"pwe_objective_dwarf_ext_spotting_chamber_area_03",
				"pwe_objective_dwarf_ext_spotting_chamber_area_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_spotting_chamber_area = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_spotting_chamber_area_01",
				"pwh_objective_dwarf_ext_spotting_chamber_area_02",
				"pwh_objective_dwarf_ext_spotting_chamber_area_03",
				"pwh_objective_dwarf_ext_spotting_chamber_area_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_spotting_chamber_area_01",
				"pwh_objective_dwarf_ext_spotting_chamber_area_02",
				"pwh_objective_dwarf_ext_spotting_chamber_area_03",
				"pwh_objective_dwarf_ext_spotting_chamber_area_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_beacons_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pbw_objective_dwarf_beacons_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pbw_objective_dwarf_beacons_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_spotting_chamber_area = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_spotting_chamber_area_01",
				"pdr_objective_dwarf_ext_spotting_chamber_area_02",
				"pdr_objective_dwarf_ext_spotting_chamber_area_03",
				"pdr_objective_dwarf_ext_spotting_chamber_area_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_spotting_chamber_area_01",
				"pdr_objective_dwarf_ext_spotting_chamber_area_02",
				"pdr_objective_dwarf_ext_spotting_chamber_area_03",
				"pdr_objective_dwarf_ext_spotting_chamber_area_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_spotting_chamber_area = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_spotting_chamber_area_01",
				"pes_objective_dwarf_ext_spotting_chamber_area_02",
				"pes_objective_dwarf_ext_spotting_chamber_area_03",
				"pes_objective_dwarf_ext_spotting_chamber_area_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_spotting_chamber_area_01",
				"pes_objective_dwarf_ext_spotting_chamber_area_02",
				"pes_objective_dwarf_ext_spotting_chamber_area_03",
				"pes_objective_dwarf_ext_spotting_chamber_area_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_open_chamber = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_open_chamber_01",
				"pdr_objective_dwarf_ext_open_chamber_02",
				"pdr_objective_dwarf_ext_open_chamber_03",
				"pdr_objective_dwarf_ext_open_chamber_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_open_chamber_01",
				"pdr_objective_dwarf_ext_open_chamber_02",
				"pdr_objective_dwarf_ext_open_chamber_03",
				"pdr_objective_dwarf_ext_open_chamber_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_hallway = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_hallway_01",
				"pwh_objective_dwarf_int_hallway_02",
				"pwh_objective_dwarf_int_hallway_03",
				"pwh_objective_dwarf_int_hallway_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_hallway_01",
				"pwh_objective_dwarf_int_hallway_02",
				"pwh_objective_dwarf_int_hallway_03",
				"pwh_objective_dwarf_int_hallway_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_int_intro_b_01",
				[2.0] = "pbw_objective_dwarf_int_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_int_intro_b_01",
				[2.0] = "pbw_objective_dwarf_int_intro_b_02"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_01"
			}
		},
		pwe_karak_azgaraz_dwarf_quest_story_four_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_01"
			}
		},
		pes_objective_beacons_lit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_lit_01",
				"pes_objective_beacons_lit_02",
				"pes_objective_beacons_lit_03",
				"pes_objective_beacons_lit_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_lit_01",
				"pes_objective_beacons_lit_02",
				"pes_objective_beacons_lit_03",
				"pes_objective_beacons_lit_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_ext_intro_a_01",
				[2.0] = "pes_objective_dwarf_ext_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_ext_intro_a_01",
				[2.0] = "pes_objective_dwarf_ext_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_lit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_lit_01",
				"pbw_objective_beacons_lit_02",
				"pbw_objective_beacons_lit_03",
				"pbw_objective_beacons_lit_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_lit_01",
				"pbw_objective_beacons_lit_02",
				"pbw_objective_beacons_lit_03",
				"pbw_objective_beacons_lit_04"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_lowergate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_lowergate_01",
				"pes_objective_beacons_lowergate_02",
				"pes_objective_beacons_lowergate_03",
				"pes_objective_beacons_lowergate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_lowergate_01",
				"pes_objective_beacons_lowergate_02",
				"pes_objective_beacons_lowergate_03",
				"pes_objective_beacons_lowergate_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_spotting_karak_azgaraz = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pwe_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_brewery_engineer_reply_keystoine = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_dwarf_int_brewery_engineer_reply_keystoine_01",
				"pes_objective_dwarf_int_brewery_engineer_reply_keystoine_02",
				"pes_objective_dwarf_int_brewery_engineer_reply_keystoine_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_brewery_engineer_reply_keystoine_01",
				"pes_objective_dwarf_int_brewery_engineer_reply_keystoine_02",
				"pes_objective_dwarf_int_brewery_engineer_reply_keystoine_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_int_intro_b_01",
				[2.0] = "pdr_objective_dwarf_int_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_int_intro_b_01",
				[2.0] = "pdr_objective_dwarf_int_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_ext_intro_b_01",
				[2.0] = "pes_objective_dwarf_ext_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_ext_intro_b_01",
				[2.0] = "pes_objective_dwarf_ext_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_pressureplate_progress = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_pressureplate_progress_01",
				"pbw_objective_beacons_pressureplate_progress_02",
				"pbw_objective_beacons_pressureplate_progress_03",
				"pbw_objective_beacons_pressureplate_progress_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_pressureplate_progress_01",
				"pbw_objective_beacons_pressureplate_progress_02",
				"pbw_objective_beacons_pressureplate_progress_03",
				"pbw_objective_beacons_pressureplate_progress_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_pressureplate_progress = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_pressureplate_progress_01",
				"pdr_objective_beacons_pressureplate_progress_02",
				"pdr_objective_beacons_pressureplate_progress_03",
				"pdr_objective_beacons_pressureplate_progress_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_pressureplate_progress_01",
				"pdr_objective_beacons_pressureplate_progress_02",
				"pdr_objective_beacons_pressureplate_progress_03",
				"pdr_objective_beacons_pressureplate_progress_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_spotting_karak_azgaraz = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pbw_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_beacons_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pdr_objective_dwarf_beacons_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pdr_objective_dwarf_beacons_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_beacons_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pes_objective_dwarf_beacons_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pes_objective_dwarf_beacons_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_beacons_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pwh_objective_dwarf_beacons_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pwh_objective_dwarf_beacons_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_ext_intro_b_01",
				[2.0] = "pwh_objective_dwarf_ext_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_ext_intro_b_01",
				[2.0] = "pwh_objective_dwarf_ext_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_spotting_karak_azgaraz = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pes_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_spotting_karak_azgaraz = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pdr_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_up_ramp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_up_ramp_01",
				"pbw_objective_dwarf_ext_up_ramp_02",
				"pbw_objective_dwarf_ext_up_ramp_03",
				"pbw_objective_dwarf_ext_up_ramp_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_up_ramp_01",
				"pbw_objective_dwarf_ext_up_ramp_02",
				"pbw_objective_dwarf_ext_up_ramp_03",
				"pbw_objective_dwarf_ext_up_ramp_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_int_intro_c_01",
				[2.0] = "pes_objective_dwarf_int_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_int_intro_c_01",
				[2.0] = "pes_objective_dwarf_int_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_ext_intro_a_01",
				[2.0] = "pdr_objective_dwarf_ext_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_ext_intro_a_01",
				[2.0] = "pdr_objective_dwarf_ext_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_pressureplate_progress = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_pressureplate_progress_01",
				"pwe_objective_beacons_pressureplate_progress_02",
				"pwe_objective_beacons_pressureplate_progress_03",
				"pwe_objective_beacons_pressureplate_progress_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_pressureplate_progress_01",
				"pwe_objective_beacons_pressureplate_progress_02",
				"pwe_objective_beacons_pressureplate_progress_03",
				"pwe_objective_beacons_pressureplate_progress_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_ext_intro_b_01",
				[2.0] = "pwe_objective_dwarf_ext_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_ext_intro_b_01",
				[2.0] = "pwe_objective_dwarf_ext_intro_b_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_lit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_lit_01",
				"pdr_objective_beacons_lit_02",
				"pdr_objective_beacons_lit_03",
				"pdr_objective_beacons_lit_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_lit_01",
				"pdr_objective_beacons_lit_02",
				"pdr_objective_beacons_lit_03",
				"pdr_objective_beacons_lit_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_brewery_aroma = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"pbw_objective_dwarf_int_brewery_aroma_01",
				"pbw_objective_dwarf_int_brewery_aroma_02",
				"pbw_objective_dwarf_int_brewery_aroma_03",
				"pbw_objective_dwarf_int_brewery_aroma_04",
				"pbw_objective_dwarf_int_brewery_aroma_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_brewery_aroma_01",
				"pbw_objective_dwarf_int_brewery_aroma_02",
				"pbw_objective_dwarf_int_brewery_aroma_03",
				"pbw_objective_dwarf_int_brewery_aroma_04",
				"pbw_objective_dwarf_int_brewery_aroma_05"
			},
			randomize_indexes = {}
		},
		pwh_karak_azgaraz_witch_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_one_01"
			}
		},
		pes_objective_dwarf_int_brewery_aroma = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_brewery_aroma_01",
				"pes_objective_dwarf_int_brewery_aroma_02",
				"pes_objective_dwarf_int_brewery_aroma_03",
				"pes_objective_dwarf_int_brewery_aroma_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_brewery_aroma_01",
				"pes_objective_dwarf_int_brewery_aroma_02",
				"pes_objective_dwarf_int_brewery_aroma_03",
				"pes_objective_dwarf_int_brewery_aroma_04"
			},
			randomize_indexes = {}
		},
		pbw_karak_azgaraz_witch_hunter_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_karak_azgaraz_witch_hunter_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_karak_azgaraz_witch_hunter_quest_story_one_01"
			}
		},
		pbw_objective_dwarf_ext_mining_path = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_mining_path_01",
				"pbw_objective_dwarf_ext_mining_path_02",
				"pbw_objective_dwarf_ext_mining_path_03",
				"pbw_objective_dwarf_ext_mining_path_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_mining_path_01",
				"pbw_objective_dwarf_ext_mining_path_02",
				"pbw_objective_dwarf_ext_mining_path_03",
				"pbw_objective_dwarf_ext_mining_path_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_dwarf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_three_01"
			}
		},
		nde_objective_dwarf_int_main_hall_engineer = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "npc_talk_special",
			dialogue_animations_n = 4,
			sound_events = {
				"nde_objective_dwarf_int_main_hall_engineer_01",
				"nde_objective_dwarf_int_main_hall_engineer_02",
				"nde_objective_dwarf_int_main_hall_engineer_03",
				"nde_objective_dwarf_int_main_hall_engineer_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_main_hall_engineer_01",
				"nde_objective_dwarf_int_main_hall_engineer_02",
				"nde_objective_dwarf_int_main_hall_engineer_03",
				"nde_objective_dwarf_int_main_hall_engineer_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_background = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_background_01",
				"pwe_objective_beacons_background_02",
				"pwe_objective_beacons_background_03",
				"pwe_objective_beacons_background_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_background_01",
				"pwe_objective_beacons_background_02",
				"pwe_objective_beacons_background_03",
				"pwe_objective_beacons_background_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_mining_path = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_mining_path_01",
				"pes_objective_dwarf_ext_mining_path_02",
				"pes_objective_dwarf_ext_mining_path_03",
				"pes_objective_dwarf_ext_mining_path_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_mining_path_01",
				"pes_objective_dwarf_ext_mining_path_02",
				"pes_objective_dwarf_ext_mining_path_03",
				"pes_objective_dwarf_ext_mining_path_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_mining_path = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_mining_path_01",
				"pdr_objective_dwarf_ext_mining_path_02",
				"pdr_objective_dwarf_ext_mining_path_03",
				"pdr_objective_dwarf_ext_mining_path_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_mining_path_01",
				"pdr_objective_dwarf_ext_mining_path_02",
				"pdr_objective_dwarf_ext_mining_path_03",
				"pdr_objective_dwarf_ext_mining_path_04"
			},
			randomize_indexes = {}
		},
		["nde_objective_dwarf_int_brewery_stabilize pressure_success_final"] = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "npc_talk_interrupt_special",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "nde_objective_dwarf_int_brewery_stabilize_pressure_success_final_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nde_objective_dwarf_int_brewery_stabilize_pressure_success_final_02"
			}
		},
		pdr_objective_beacons_lowergatex2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_lowergatex2_01",
				"pdr_objective_beacons_lowergatex2_02",
				"pdr_objective_beacons_lowergatex2_03",
				"pdr_objective_beacons_lowergatex2_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_lowergatex2_01",
				"pdr_objective_beacons_lowergatex2_02",
				"pdr_objective_beacons_lowergatex2_03",
				"pdr_objective_beacons_lowergatex2_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_int_intro_b_01",
				[2.0] = "pwe_objective_dwarf_int_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_int_intro_b_01",
				[2.0] = "pwe_objective_dwarf_int_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_brewery_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_brewery_end_01",
				"pwe_objective_dwarf_int_brewery_end_02",
				"pwe_objective_dwarf_int_brewery_end_03",
				"pwe_objective_dwarf_int_brewery_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_brewery_end_01",
				"pwe_objective_dwarf_int_brewery_end_02",
				"pwe_objective_dwarf_int_brewery_end_03",
				"pwe_objective_dwarf_int_brewery_end_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_temple_of_valaya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_temple_of_valaya_01",
				"pwe_objective_dwarf_int_temple_of_valaya_02",
				"pwe_objective_dwarf_int_temple_of_valaya_03",
				"pwe_objective_dwarf_int_temple_of_valaya_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_temple_of_valaya_01",
				"pwe_objective_dwarf_int_temple_of_valaya_02",
				"pwe_objective_dwarf_int_temple_of_valaya_03",
				"pwe_objective_dwarf_int_temple_of_valaya_04"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_lowergatex2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_lowergatex2_01",
				"pes_objective_beacons_lowergatex2_02",
				"pes_objective_beacons_lowergatex2_03",
				"pes_objective_beacons_lowergatex2_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_lowergatex2_01",
				"pes_objective_beacons_lowergatex2_02",
				"pes_objective_beacons_lowergatex2_03",
				"pes_objective_beacons_lowergatex2_04"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_main_hall_explosive_ready = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "dwarf_dlc",
			category = "npc_talk_special",
			dialogue_animations_n = 7,
			sound_events = {
				"nde_objective_dwarf_int_main_hall_explosive_ready_01",
				"nde_objective_dwarf_int_main_hall_explosive_ready_01",
				"nde_objective_dwarf_int_main_hall_explosive_ready_02",
				"nde_objective_dwarf_int_main_hall_explosive_ready_02",
				"nde_objective_dwarf_int_main_hall_explosive_ready_03",
				"nde_objective_dwarf_int_main_hall_explosive_ready_03",
				"nde_objective_dwarf_int_main_hall_explosive_ready_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_main_hall_explosive_ready_01",
				"nde_objective_dwarf_int_main_hall_explosive_ready_01",
				"nde_objective_dwarf_int_main_hall_explosive_ready_02",
				"nde_objective_dwarf_int_main_hall_explosive_ready_02",
				"nde_objective_dwarf_int_main_hall_explosive_ready_03",
				"nde_objective_dwarf_int_main_hall_explosive_ready_03",
				"nde_objective_dwarf_int_main_hall_explosive_ready_04"
			},
			randomize_indexes = {}
		},
		["nde_objective_dwarf_int_brewery_stabilize pressure"] = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "npc_talk_interrupt_special",
			dialogue_animations_n = 4,
			sound_events = {
				"nde_objective_dwarf_int_brewery_stabilize_pressure_01",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_02",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_03",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_brewery_stabilize_pressure_01",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_02",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_03",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_dwarftown = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_dwarftown_01",
				"pwh_objective_beacons_dwarftown_02",
				"pwh_objective_beacons_dwarftown_03",
				"pwh_objective_beacons_dwarftown_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_dwarftown_01",
				"pwh_objective_beacons_dwarftown_02",
				"pwh_objective_beacons_dwarftown_03",
				"pwh_objective_beacons_dwarftown_04"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_background = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_background_01",
				"pes_objective_beacons_background_02",
				"pes_objective_beacons_background_03",
				"pes_objective_beacons_background_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_background_01",
				"pes_objective_beacons_background_02",
				"pes_objective_beacons_background_03",
				"pes_objective_beacons_background_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_background = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_background_01",
				"pdr_objective_beacons_background_02",
				"pdr_objective_beacons_background_03",
				"pdr_objective_beacons_background_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_background_01",
				"pdr_objective_beacons_background_02",
				"pdr_objective_beacons_background_03",
				"pdr_objective_beacons_background_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_background = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 5,
			sound_events = {
				"pbw_objective_beacons_background_01",
				"pbw_objective_beacons_background_02",
				"pbw_objective_beacons_background_03",
				"pbw_objective_beacons_background_04",
				"pbw_objective_beacons_background_05"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_background_01",
				"pbw_objective_beacons_background_02",
				"pbw_objective_beacons_background_03",
				"pbw_objective_beacons_background_04",
				"pbw_objective_beacons_background_05"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_beacons_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pbw_objective_dwarf_beacons_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pbw_objective_dwarf_beacons_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_skaven_territory = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_skaven_territory_01",
				"pbw_objective_dwarf_int_skaven_territory_02",
				"pbw_objective_dwarf_int_skaven_territory_03",
				"pbw_objective_dwarf_int_skaven_territory_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_skaven_territory_01",
				"pbw_objective_dwarf_int_skaven_territory_02",
				"pbw_objective_dwarf_int_skaven_territory_03",
				"pbw_objective_dwarf_int_skaven_territory_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_skaven_territory = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_skaven_territory_01",
				"pdr_objective_dwarf_int_skaven_territory_02",
				"pdr_objective_dwarf_int_skaven_territory_03",
				"pdr_objective_dwarf_int_skaven_territory_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_skaven_territory_01",
				"pdr_objective_dwarf_int_skaven_territory_02",
				"pdr_objective_dwarf_int_skaven_territory_03",
				"pdr_objective_dwarf_int_skaven_territory_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_skaven_territory = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_skaven_territory_01",
				"pes_objective_dwarf_int_skaven_territory_02",
				"pes_objective_dwarf_int_skaven_territory_03",
				"pes_objective_dwarf_int_skaven_territory_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_skaven_territory_01",
				"pes_objective_dwarf_int_skaven_territory_02",
				"pes_objective_dwarf_int_skaven_territory_03",
				"pes_objective_dwarf_int_skaven_territory_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_skaven_territory = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_skaven_territory_01",
				"pwe_objective_dwarf_int_skaven_territory_02",
				"pwe_objective_dwarf_int_skaven_territory_03",
				"pwe_objective_dwarf_int_skaven_territory_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_skaven_territory_01",
				"pwe_objective_dwarf_int_skaven_territory_02",
				"pwe_objective_dwarf_int_skaven_territory_03",
				"pwe_objective_dwarf_int_skaven_territory_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_hallway = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_hallway_01",
				"pwe_objective_dwarf_int_hallway_02",
				"pwe_objective_dwarf_int_hallway_03",
				"pwe_objective_dwarf_int_hallway_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_hallway_01",
				"pwe_objective_dwarf_int_hallway_02",
				"pwe_objective_dwarf_int_hallway_03",
				"pwe_objective_dwarf_int_hallway_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_dwarf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_three_02"
			}
		},
		pdr_objective_dwarf_int_temple_of_valaya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_temple_of_valaya_01",
				"pdr_objective_dwarf_int_temple_of_valaya_02",
				"pdr_objective_dwarf_int_temple_of_valaya_03",
				"pdr_objective_dwarf_int_temple_of_valaya_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_temple_of_valaya_01",
				"pdr_objective_dwarf_int_temple_of_valaya_02",
				"pdr_objective_dwarf_int_temple_of_valaya_03",
				"pdr_objective_dwarf_int_temple_of_valaya_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_temple_of_valaya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_temple_of_valaya_01",
				"pes_objective_dwarf_int_temple_of_valaya_02",
				"pes_objective_dwarf_int_temple_of_valaya_03",
				"pes_objective_dwarf_int_temple_of_valaya_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_temple_of_valaya_01",
				"pes_objective_dwarf_int_temple_of_valaya_02",
				"pes_objective_dwarf_int_temple_of_valaya_03",
				"pes_objective_dwarf_int_temple_of_valaya_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_int_intro_c_01",
				[2.0] = "pwh_objective_dwarf_int_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_int_intro_c_01",
				[2.0] = "pwh_objective_dwarf_int_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_ext_intro_b_01",
				[2.0] = "pdr_objective_dwarf_ext_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_ext_intro_b_01",
				[2.0] = "pdr_objective_dwarf_ext_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_brewery_engineer_search = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_brewery_engineer_search_01",
				"pes_objective_dwarf_int_brewery_engineer_search_02",
				"pes_objective_dwarf_int_brewery_engineer_search_03",
				"pes_objective_dwarf_int_brewery_engineer_search_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_brewery_engineer_search_01",
				"pes_objective_dwarf_int_brewery_engineer_search_02",
				"pes_objective_dwarf_int_brewery_engineer_search_03",
				"pes_objective_dwarf_int_brewery_engineer_search_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_int_intro_c_01",
				[2.0] = "pbw_objective_dwarf_int_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_int_intro_c_01",
				[2.0] = "pbw_objective_dwarf_int_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_brewery_engineer_search = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_brewery_engineer_search_01",
				"pdr_objective_dwarf_int_brewery_engineer_search_02",
				"pdr_objective_dwarf_int_brewery_engineer_search_03",
				"pdr_objective_dwarf_int_brewery_engineer_search_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_brewery_engineer_search_01",
				"pdr_objective_dwarf_int_brewery_engineer_search_02",
				"pdr_objective_dwarf_int_brewery_engineer_search_03",
				"pdr_objective_dwarf_int_brewery_engineer_search_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_up_ramp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_up_ramp_01",
				"pes_objective_dwarf_ext_up_ramp_02",
				"pes_objective_dwarf_ext_up_ramp_03",
				"pes_objective_dwarf_ext_up_ramp_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_up_ramp_01",
				"pes_objective_dwarf_ext_up_ramp_02",
				"pes_objective_dwarf_ext_up_ramp_03",
				"pes_objective_dwarf_ext_up_ramp_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_lit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_lit_01",
				"pwe_objective_beacons_lit_02",
				"pwe_objective_beacons_lit_03",
				"pwe_objective_beacons_lit_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_lit_01",
				"pwe_objective_beacons_lit_02",
				"pwe_objective_beacons_lit_03",
				"pwe_objective_beacons_lit_04"
			},
			randomize_indexes = {}
		},
		pwe_karak_azgaraz_dwarf_quest_story_four_01_alt1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_01_alt1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_01_alt1"
			}
		},
		nde_objective_dwarf_int_brewery_start = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "npc_talk_interrupt_special",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nde_objective_dwarf_int_brewery_start_03",
				[2.0] = "nde_objective_dwarf_int_brewery_start_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nde_objective_dwarf_int_brewery_start_03",
				[2.0] = "nde_objective_dwarf_int_brewery_start_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_brewery_engineer_search = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_brewery_engineer_search_01",
				"pwh_objective_dwarf_int_brewery_engineer_search_02",
				"pwh_objective_dwarf_int_brewery_engineer_search_03",
				"pwh_objective_dwarf_int_brewery_engineer_search_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_brewery_engineer_search_01",
				"pwh_objective_dwarf_int_brewery_engineer_search_02",
				"pwh_objective_dwarf_int_brewery_engineer_search_03",
				"pwh_objective_dwarf_int_brewery_engineer_search_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_brewery_engineer_search = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_brewery_engineer_search_01",
				"pwe_objective_dwarf_int_brewery_engineer_search_02",
				"pwe_objective_dwarf_int_brewery_engineer_search_03",
				"pwe_objective_dwarf_int_brewery_engineer_search_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_brewery_engineer_search_01",
				"pwe_objective_dwarf_int_brewery_engineer_search_02",
				"pwe_objective_dwarf_int_brewery_engineer_search_03",
				"pwe_objective_dwarf_int_brewery_engineer_search_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_frozen_lake = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_frozen_lake_01",
				"pbw_objective_dwarf_ext_frozen_lake_02",
				"pbw_objective_dwarf_ext_frozen_lake_03",
				"pbw_objective_dwarf_ext_frozen_lake_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_frozen_lake_01",
				"pbw_objective_dwarf_ext_frozen_lake_02",
				"pbw_objective_dwarf_ext_frozen_lake_03",
				"pbw_objective_dwarf_ext_frozen_lake_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_main_hall_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_main_hall_end_01",
				"pwh_objective_dwarf_int_main_hall_end_02",
				"pwh_objective_dwarf_int_main_hall_end_03",
				"pwh_objective_dwarf_int_main_hall_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_main_hall_end_01",
				"pwh_objective_dwarf_int_main_hall_end_02",
				"pwh_objective_dwarf_int_main_hall_end_03",
				"pwh_objective_dwarf_int_main_hall_end_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_keep_running = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_keep_running_01",
				"pwe_objective_dwarf_ext_keep_running_02",
				"pwe_objective_dwarf_ext_keep_running_03",
				"pwe_objective_dwarf_ext_keep_running_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_keep_running_01",
				"pwe_objective_dwarf_ext_keep_running_02",
				"pwe_objective_dwarf_ext_keep_running_03",
				"pwe_objective_dwarf_ext_keep_running_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_ext_intro_a_01",
				[2.0] = "pbw_objective_dwarf_ext_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_ext_intro_a_01",
				[2.0] = "pbw_objective_dwarf_ext_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_brewery_engineer_search = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_brewery_engineer_search_01",
				"pbw_objective_dwarf_int_brewery_engineer_search_02",
				"pbw_objective_dwarf_int_brewery_engineer_search_03",
				"pbw_objective_dwarf_int_brewery_engineer_search_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_brewery_engineer_search_01",
				"pbw_objective_dwarf_int_brewery_engineer_search_02",
				"pbw_objective_dwarf_int_brewery_engineer_search_03",
				"pbw_objective_dwarf_int_brewery_engineer_search_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_main_hall_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_main_hall_end_01",
				"pwe_objective_dwarf_int_main_hall_end_02",
				"pwe_objective_dwarf_int_main_hall_end_03",
				"pwe_objective_dwarf_int_main_hall_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_main_hall_end_01",
				"pwe_objective_dwarf_int_main_hall_end_02",
				"pwe_objective_dwarf_int_main_hall_end_03",
				"pwe_objective_dwarf_int_main_hall_end_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_ulgu = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_ulgu_01",
				"pbw_objective_beacons_ulgu_02",
				"pbw_objective_beacons_ulgu_03",
				"pbw_objective_beacons_ulgu_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_ulgu_01",
				"pbw_objective_beacons_ulgu_02",
				"pbw_objective_beacons_ulgu_03",
				"pbw_objective_beacons_ulgu_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_main_hall_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_main_hall_end_01",
				"pbw_objective_dwarf_int_main_hall_end_02",
				"pbw_objective_dwarf_int_main_hall_end_03",
				"pbw_objective_dwarf_int_main_hall_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_main_hall_end_01",
				"pbw_objective_dwarf_int_main_hall_end_02",
				"pbw_objective_dwarf_int_main_hall_end_03",
				"pbw_objective_dwarf_int_main_hall_end_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_frozen_lake = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_frozen_lake_01",
				"pwe_objective_dwarf_ext_frozen_lake_02",
				"pwe_objective_dwarf_ext_frozen_lake_03",
				"pwe_objective_dwarf_ext_frozen_lake_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_frozen_lake_01",
				"pwe_objective_dwarf_ext_frozen_lake_02",
				"pwe_objective_dwarf_ext_frozen_lake_03",
				"pwe_objective_dwarf_ext_frozen_lake_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_lets_go = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_lets_go_01",
				"pbw_objective_dwarf_ext_lets_go_02",
				"pbw_objective_dwarf_ext_lets_go_03",
				"pbw_objective_dwarf_ext_lets_go_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_lets_go_01",
				"pbw_objective_dwarf_ext_lets_go_02",
				"pbw_objective_dwarf_ext_lets_go_03",
				"pbw_objective_dwarf_ext_lets_go_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_lowergatex2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_lowergatex2_01",
				"pwh_objective_beacons_lowergatex2_02",
				"pwh_objective_beacons_lowergatex2_03",
				"pwh_objective_beacons_lowergatex2_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_lowergatex2_01",
				"pwh_objective_beacons_lowergatex2_02",
				"pwh_objective_beacons_lowergatex2_03",
				"pwh_objective_beacons_lowergatex2_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_main_hall_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_main_hall_end_01",
				"pes_objective_dwarf_int_main_hall_end_02",
				"pes_objective_dwarf_int_main_hall_end_03",
				"pes_objective_dwarf_int_main_hall_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_main_hall_end_01",
				"pes_objective_dwarf_int_main_hall_end_02",
				"pes_objective_dwarf_int_main_hall_end_03",
				"pes_objective_dwarf_int_main_hall_end_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_frozen_lake = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_frozen_lake_01",
				"pes_objective_dwarf_ext_frozen_lake_02",
				"pes_objective_dwarf_ext_frozen_lake_03",
				"pes_objective_dwarf_ext_frozen_lake_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_frozen_lake_01",
				"pes_objective_dwarf_ext_frozen_lake_02",
				"pes_objective_dwarf_ext_frozen_lake_03",
				"pes_objective_dwarf_ext_frozen_lake_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_gatedone = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_gatedone_01",
				"pbw_objective_beacons_gatedone_02",
				"pbw_objective_beacons_gatedone_03",
				"pbw_objective_beacons_gatedone_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_gatedone_01",
				"pbw_objective_beacons_gatedone_02",
				"pbw_objective_beacons_gatedone_03",
				"pbw_objective_beacons_gatedone_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_mining_path = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_mining_path_01",
				"pwh_objective_dwarf_ext_mining_path_02",
				"pwh_objective_dwarf_ext_mining_path_03",
				"pwh_objective_dwarf_ext_mining_path_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_mining_path_01",
				"pwh_objective_dwarf_ext_mining_path_02",
				"pwh_objective_dwarf_ext_mining_path_03",
				"pwh_objective_dwarf_ext_mining_path_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_int_intro_c_01",
				[2.0] = "pdr_objective_dwarf_int_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_int_intro_c_01",
				[2.0] = "pdr_objective_dwarf_int_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_mining_path = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_mining_path_01",
				"pwe_objective_dwarf_ext_mining_path_02",
				"pwe_objective_dwarf_ext_mining_path_03",
				"pwe_objective_dwarf_ext_mining_path_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_mining_path_01",
				"pwe_objective_dwarf_ext_mining_path_02",
				"pwe_objective_dwarf_ext_mining_path_03",
				"pwe_objective_dwarf_ext_mining_path_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_up_ramp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_up_ramp_01",
				"pwe_objective_dwarf_ext_up_ramp_02",
				"pwe_objective_dwarf_ext_up_ramp_03",
				"pwe_objective_dwarf_ext_up_ramp_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_up_ramp_01",
				"pwe_objective_dwarf_ext_up_ramp_02",
				"pwe_objective_dwarf_ext_up_ramp_03",
				"pwe_objective_dwarf_ext_up_ramp_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_weathercomplaints = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_weathercomplaints_01",
				"pwe_objective_beacons_weathercomplaints_02",
				"pwe_objective_beacons_weathercomplaints_03",
				"pwe_objective_beacons_weathercomplaints_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_weathercomplaints_01",
				"pwe_objective_beacons_weathercomplaints_02",
				"pwe_objective_beacons_weathercomplaints_03",
				"pwe_objective_beacons_weathercomplaints_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_waterfall = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_waterfall_01",
				"pwh_objective_dwarf_ext_waterfall_02",
				"pwh_objective_dwarf_ext_waterfall_03",
				"pwh_objective_dwarf_ext_waterfall_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_waterfall_01",
				"pwh_objective_dwarf_ext_waterfall_02",
				"pwh_objective_dwarf_ext_waterfall_03",
				"pwh_objective_dwarf_ext_waterfall_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_crossroad_top_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_crossroad_top_open_01",
				"pes_objective_dwarf_int_crossroad_top_open_02",
				"pes_objective_dwarf_int_crossroad_top_open_03",
				"pes_objective_dwarf_int_crossroad_top_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_crossroad_top_open_01",
				"pes_objective_dwarf_int_crossroad_top_open_02",
				"pes_objective_dwarf_int_crossroad_top_open_03",
				"pes_objective_dwarf_int_crossroad_top_open_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_beacons_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pdr_objective_dwarf_beacons_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pdr_objective_dwarf_beacons_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_main_hall_tunnel_bombed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pbw_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_crossroad_top_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_crossroad_top_open_01",
				"pbw_objective_dwarf_int_crossroad_top_open_02",
				"pbw_objective_dwarf_int_crossroad_top_open_03",
				"pbw_objective_dwarf_int_crossroad_top_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_crossroad_top_open_01",
				"pbw_objective_dwarf_int_crossroad_top_open_02",
				"pbw_objective_dwarf_int_crossroad_top_open_03",
				"pbw_objective_dwarf_int_crossroad_top_open_04"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_gatedone = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_gatedone_01",
				"pes_objective_beacons_gatedone_02",
				"pes_objective_beacons_gatedone_03",
				"pes_objective_beacons_gatedone_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_gatedone_01",
				"pes_objective_beacons_gatedone_02",
				"pes_objective_beacons_gatedone_03",
				"pes_objective_beacons_gatedone_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_dwarf_quest_story_five_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_five_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_five_03"
			}
		},
		pes_objective_dwarf_ext_waterfall = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_waterfall_01",
				"pes_objective_dwarf_ext_waterfall_02",
				"pes_objective_dwarf_ext_waterfall_03",
				"pes_objective_dwarf_ext_waterfall_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_waterfall_01",
				"pes_objective_dwarf_ext_waterfall_02",
				"pes_objective_dwarf_ext_waterfall_03",
				"pes_objective_dwarf_ext_waterfall_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_waterfall = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_waterfall_01",
				"pdr_objective_dwarf_ext_waterfall_02",
				"pdr_objective_dwarf_ext_waterfall_03",
				"pdr_objective_dwarf_ext_waterfall_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_waterfall_01",
				"pdr_objective_dwarf_ext_waterfall_02",
				"pdr_objective_dwarf_ext_waterfall_03",
				"pdr_objective_dwarf_ext_waterfall_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_waterfall = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_waterfall_01",
				"pbw_objective_dwarf_ext_waterfall_02",
				"pbw_objective_dwarf_ext_waterfall_03",
				"pbw_objective_dwarf_ext_waterfall_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_waterfall_01",
				"pbw_objective_dwarf_ext_waterfall_02",
				"pbw_objective_dwarf_ext_waterfall_03",
				"pbw_objective_dwarf_ext_waterfall_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_weathercomplaints = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_weathercomplaints_01",
				"pwh_objective_beacons_weathercomplaints_02",
				"pwh_objective_beacons_weathercomplaints_03",
				"pwh_objective_beacons_weathercomplaints_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_weathercomplaints_01",
				"pwh_objective_beacons_weathercomplaints_02",
				"pwh_objective_beacons_weathercomplaints_03",
				"pwh_objective_beacons_weathercomplaints_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_lowergate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_lowergate_01",
				"pwh_objective_beacons_lowergate_02",
				"pwh_objective_beacons_lowergate_03",
				"pwh_objective_beacons_lowergate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_lowergate_01",
				"pwh_objective_beacons_lowergate_02",
				"pwh_objective_beacons_lowergate_03",
				"pwh_objective_beacons_lowergate_04"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_weathercomplaints = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_weathercomplaints_01",
				"pes_objective_beacons_weathercomplaints_02",
				"pes_objective_beacons_weathercomplaints_03",
				"pes_objective_beacons_weathercomplaints_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_weathercomplaints_01",
				"pes_objective_beacons_weathercomplaints_02",
				"pes_objective_beacons_weathercomplaints_03",
				"pes_objective_beacons_weathercomplaints_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_railyard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_railyard_01",
				"pbw_objective_dwarf_ext_railyard_02",
				"pbw_objective_dwarf_ext_railyard_03",
				"pbw_objective_dwarf_ext_railyard_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_railyard_01",
				"pbw_objective_dwarf_ext_railyard_02",
				"pbw_objective_dwarf_ext_railyard_03",
				"pbw_objective_dwarf_ext_railyard_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_railyard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_railyard_01",
				"pes_objective_dwarf_ext_railyard_02",
				"pes_objective_dwarf_ext_railyard_03",
				"pes_objective_dwarf_ext_railyard_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_railyard_01",
				"pes_objective_dwarf_ext_railyard_02",
				"pes_objective_dwarf_ext_railyard_03",
				"pes_objective_dwarf_ext_railyard_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_weathercomplaints = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_weathercomplaints_01",
				"pdr_objective_beacons_weathercomplaints_02",
				"pdr_objective_beacons_weathercomplaints_03",
				"pdr_objective_beacons_weathercomplaints_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_weathercomplaints_01",
				"pdr_objective_beacons_weathercomplaints_02",
				"pdr_objective_beacons_weathercomplaints_03",
				"pdr_objective_beacons_weathercomplaints_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_dwarftown = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_dwarftown_01",
				"pwe_objective_beacons_dwarftown_02",
				"pwe_objective_beacons_dwarftown_03",
				"pwe_objective_beacons_dwarftown_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_dwarftown_01",
				"pwe_objective_beacons_dwarftown_02",
				"pwe_objective_beacons_dwarftown_03",
				"pwe_objective_beacons_dwarftown_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_beacons_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pbw_objective_dwarf_beacons_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pbw_objective_dwarf_beacons_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_ulgu = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_ulgu_01",
				"pwe_objective_beacons_ulgu_02",
				"pwe_objective_beacons_ulgu_03",
				"pwe_objective_beacons_ulgu_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_ulgu_01",
				"pwe_objective_beacons_ulgu_02",
				"pwe_objective_beacons_ulgu_03",
				"pwe_objective_beacons_ulgu_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_crossroad_top_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_crossroad_top_open_01",
				"pwh_objective_dwarf_int_crossroad_top_open_02",
				"pwh_objective_dwarf_int_crossroad_top_open_03",
				"pwh_objective_dwarf_int_crossroad_top_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_crossroad_top_open_01",
				"pwh_objective_dwarf_int_crossroad_top_open_02",
				"pwh_objective_dwarf_int_crossroad_top_open_03",
				"pwh_objective_dwarf_int_crossroad_top_open_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_weathercomplaints = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_weathercomplaints_01",
				"pbw_objective_beacons_weathercomplaints_02",
				"pbw_objective_beacons_weathercomplaints_03",
				"pbw_objective_beacons_weathercomplaints_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_weathercomplaints_01",
				"pbw_objective_beacons_weathercomplaints_02",
				"pbw_objective_beacons_weathercomplaints_03",
				"pbw_objective_beacons_weathercomplaints_04"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_brewery_stabilize_pressure_fail = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "npc_talk_special",
			dialogue_animations_n = 4,
			sound_events = {
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_01",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_02",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_03",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_01",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_02",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_03",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_fail_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_keep_running = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_keep_running_01",
				"pbw_objective_dwarf_ext_keep_running_02",
				"pbw_objective_dwarf_ext_keep_running_03",
				"pbw_objective_dwarf_ext_keep_running_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_keep_running_01",
				"pbw_objective_dwarf_ext_keep_running_02",
				"pbw_objective_dwarf_ext_keep_running_03",
				"pbw_objective_dwarf_ext_keep_running_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_keep_running = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_keep_running_01",
				"pes_objective_dwarf_ext_keep_running_02",
				"pes_objective_dwarf_ext_keep_running_03",
				"pes_objective_dwarf_ext_keep_running_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_keep_running_01",
				"pes_objective_dwarf_ext_keep_running_02",
				"pes_objective_dwarf_ext_keep_running_03",
				"pes_objective_dwarf_ext_keep_running_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_keep_running = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_keep_running_01",
				"pdr_objective_dwarf_ext_keep_running_02",
				"pdr_objective_dwarf_ext_keep_running_03",
				"pdr_objective_dwarf_ext_keep_running_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_keep_running_01",
				"pdr_objective_dwarf_ext_keep_running_02",
				"pdr_objective_dwarf_ext_keep_running_03",
				"pdr_objective_dwarf_ext_keep_running_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_railyard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_railyard_01",
				"pwh_objective_dwarf_ext_railyard_02",
				"pwh_objective_dwarf_ext_railyard_03",
				"pwh_objective_dwarf_ext_railyard_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_railyard_01",
				"pwh_objective_dwarf_ext_railyard_02",
				"pwh_objective_dwarf_ext_railyard_03",
				"pwh_objective_dwarf_ext_railyard_04"
			},
			randomize_indexes = {}
		},
		pbw_karak_azgaraz_dwarf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_karak_azgaraz_dwarf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_karak_azgaraz_dwarf_quest_story_one_02"
			}
		},
		pdr_karak_azgaraz_dwarf_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_one_02"
			}
		},
		pbw_objective_beacons_beacon_visible = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_beacon_visible_01",
				"pbw_objective_beacons_beacon_visible_02",
				"pbw_objective_beacons_beacon_visible_03",
				"pbw_objective_beacons_beacon_visible_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_beacon_visible_01",
				"pbw_objective_beacons_beacon_visible_02",
				"pbw_objective_beacons_beacon_visible_03",
				"pbw_objective_beacons_beacon_visible_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_beacon_visible = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_beacon_visible_01",
				"pdr_objective_beacons_beacon_visible_02",
				"pdr_objective_beacons_beacon_visible_03",
				"pdr_objective_beacons_beacon_visible_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_beacon_visible_01",
				"pdr_objective_beacons_beacon_visible_02",
				"pdr_objective_beacons_beacon_visible_03",
				"pdr_objective_beacons_beacon_visible_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_gatedone = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_gatedone_01",
				"pwe_objective_beacons_gatedone_02",
				"pwe_objective_beacons_gatedone_03",
				"pwe_objective_beacons_gatedone_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_gatedone_01",
				"pwe_objective_beacons_gatedone_02",
				"pwe_objective_beacons_gatedone_03",
				"pwe_objective_beacons_gatedone_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_beacon_visible = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_beacon_visible_01",
				"pwh_objective_beacons_beacon_visible_02",
				"pwh_objective_beacons_beacon_visible_03",
				"pwh_objective_beacons_beacon_visible_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_beacon_visible_01",
				"pwh_objective_beacons_beacon_visible_02",
				"pwh_objective_beacons_beacon_visible_03",
				"pwh_objective_beacons_beacon_visible_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_lets_go = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_lets_go_01",
				"pwe_objective_dwarf_ext_lets_go_02",
				"pwe_objective_dwarf_ext_lets_go_03",
				"pwe_objective_dwarf_ext_lets_go_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_lets_go_01",
				"pwe_objective_dwarf_ext_lets_go_02",
				"pwe_objective_dwarf_ext_lets_go_03",
				"pwe_objective_dwarf_ext_lets_go_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_beacons_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pwe_objective_dwarf_beacons_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pwe_objective_dwarf_beacons_intro_c_02"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_main_hall_mission_complete = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "npc_talk_interrupt_special",
			dialogue_animations_n = 4,
			sound_events = {
				"nde_objective_dwarf_int_main_hall_mission_complete_01",
				"nde_objective_dwarf_int_main_hall_mission_complete_02",
				"nde_objective_dwarf_int_main_hall_mission_complete_03",
				"nde_objective_dwarf_int_main_hall_mission_complete_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_main_hall_mission_complete_01",
				"nde_objective_dwarf_int_main_hall_mission_complete_02",
				"nde_objective_dwarf_int_main_hall_mission_complete_03",
				"nde_objective_dwarf_int_main_hall_mission_complete_04"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_four_01_alt1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_01_alt1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_01_alt1"
			}
		},
		pwe_objective_dwarf_ext_waterfall = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_waterfall_01",
				"pwe_objective_dwarf_ext_waterfall_02",
				"pwe_objective_dwarf_ext_waterfall_03",
				"pwe_objective_dwarf_ext_waterfall_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_waterfall_01",
				"pwe_objective_dwarf_ext_waterfall_02",
				"pwe_objective_dwarf_ext_waterfall_03",
				"pwe_objective_dwarf_ext_waterfall_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_grab_artifact = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_grab_artifact_01",
				"pbw_objective_dwarf_ext_grab_artifact_02",
				"pbw_objective_dwarf_ext_grab_artifact_03",
				"pbw_objective_dwarf_ext_grab_artifact_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_grab_artifact_01",
				"pbw_objective_dwarf_ext_grab_artifact_02",
				"pbw_objective_dwarf_ext_grab_artifact_03",
				"pbw_objective_dwarf_ext_grab_artifact_04"
			},
			randomize_indexes = {}
		},
		pwh_karak_azgaraz_witch_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_two_01"
			}
		},
		pes_objective_dwarf_int_hallway = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_hallway_01",
				"pes_objective_dwarf_int_hallway_02",
				"pes_objective_dwarf_int_hallway_03",
				"pes_objective_dwarf_int_hallway_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_hallway_01",
				"pes_objective_dwarf_int_hallway_02",
				"pes_objective_dwarf_int_hallway_03",
				"pes_objective_dwarf_int_hallway_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_witch_hunter_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_witch_hunter_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_witch_hunter_quest_story_two_02"
			}
		},
		pwh_objective_dwarf_ext_lets_go = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_lets_go_01",
				"pwh_objective_dwarf_ext_lets_go_02",
				"pwh_objective_dwarf_ext_lets_go_03",
				"pwh_objective_dwarf_ext_lets_go_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_lets_go_01",
				"pwh_objective_dwarf_ext_lets_go_02",
				"pwh_objective_dwarf_ext_lets_go_03",
				"pwh_objective_dwarf_ext_lets_go_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_witch_hunter_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_witch_hunter_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_witch_hunter_quest_story_two_01"
			}
		},
		pwe_objective_dwarf_ext_grab_artifact = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_grab_artifact_01",
				"pwe_objective_dwarf_ext_grab_artifact_02",
				"pwe_objective_dwarf_ext_grab_artifact_03",
				"pwe_objective_dwarf_ext_grab_artifact_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_grab_artifact_01",
				"pwe_objective_dwarf_ext_grab_artifact_02",
				"pwe_objective_dwarf_ext_grab_artifact_03",
				"pwe_objective_dwarf_ext_grab_artifact_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_grab_artifact = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_grab_artifact_01",
				"pwh_objective_dwarf_ext_grab_artifact_02",
				"pwh_objective_dwarf_ext_grab_artifact_03",
				"pwh_objective_dwarf_ext_grab_artifact_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_grab_artifact_01",
				"pwh_objective_dwarf_ext_grab_artifact_02",
				"pwh_objective_dwarf_ext_grab_artifact_03",
				"pwh_objective_dwarf_ext_grab_artifact_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_trading_road = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_trading_road_01",
				"pes_objective_dwarf_ext_trading_road_02",
				"pes_objective_dwarf_ext_trading_road_03",
				"pes_objective_dwarf_ext_trading_road_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_trading_road_01",
				"pes_objective_dwarf_ext_trading_road_02",
				"pes_objective_dwarf_ext_trading_road_03",
				"pes_objective_dwarf_ext_trading_road_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_barricades = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_barricades_01",
				"pwe_objective_dwarf_int_barricades_02",
				"pwe_objective_dwarf_int_barricades_03",
				"pwe_objective_dwarf_int_barricades_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_barricades_01",
				"pwe_objective_dwarf_int_barricades_02",
				"pwe_objective_dwarf_int_barricades_03",
				"pwe_objective_dwarf_int_barricades_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_trading_road = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_trading_road_01",
				"pbw_objective_dwarf_ext_trading_road_02",
				"pbw_objective_dwarf_ext_trading_road_03",
				"pbw_objective_dwarf_ext_trading_road_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_trading_road_01",
				"pbw_objective_dwarf_ext_trading_road_02",
				"pbw_objective_dwarf_ext_trading_road_03",
				"pbw_objective_dwarf_ext_trading_road_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_brewery_engineer_reply = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_int_brewery_engineer_reply_01",
				[2.0] = "pwe_objective_dwarf_int_brewery_engineer_reply_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_int_brewery_engineer_reply_01",
				[2.0] = "pwe_objective_dwarf_int_brewery_engineer_reply_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_trading_road = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_trading_road_01",
				"pdr_objective_dwarf_ext_trading_road_02",
				"pdr_objective_dwarf_ext_trading_road_03",
				"pdr_objective_dwarf_ext_trading_road_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_trading_road_01",
				"pdr_objective_dwarf_ext_trading_road_02",
				"pdr_objective_dwarf_ext_trading_road_03",
				"pdr_objective_dwarf_ext_trading_road_04"
			},
			randomize_indexes = {}
		},
		pwh_karak_azgaraz_witch_hunter_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_two_02"
			}
		},
		pdr_objective_dwarf_ext_grab_artifact = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_grab_artifact_01",
				"pdr_objective_dwarf_ext_grab_artifact_02",
				"pdr_objective_dwarf_ext_grab_artifact_03",
				"pdr_objective_dwarf_ext_grab_artifact_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_grab_artifact_01",
				"pdr_objective_dwarf_ext_grab_artifact_02",
				"pdr_objective_dwarf_ext_grab_artifact_03",
				"pdr_objective_dwarf_ext_grab_artifact_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_grab_artifact = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_grab_artifact_01",
				"pes_objective_dwarf_ext_grab_artifact_02",
				"pes_objective_dwarf_ext_grab_artifact_03",
				"pes_objective_dwarf_ext_grab_artifact_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_grab_artifact_01",
				"pes_objective_dwarf_ext_grab_artifact_02",
				"pes_objective_dwarf_ext_grab_artifact_03",
				"pes_objective_dwarf_ext_grab_artifact_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_up_ramp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_up_ramp_01",
				"pwh_objective_dwarf_ext_up_ramp_02",
				"pwh_objective_dwarf_ext_up_ramp_03",
				"pwh_objective_dwarf_ext_up_ramp_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_up_ramp_01",
				"pwh_objective_dwarf_ext_up_ramp_02",
				"pwh_objective_dwarf_ext_up_ramp_03",
				"pwh_objective_dwarf_ext_up_ramp_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_main_hall_unstable = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_main_hall_unstable_01",
				"pwh_objective_dwarf_int_main_hall_unstable_02",
				"pwh_objective_dwarf_int_main_hall_unstable_03",
				"pwh_objective_dwarf_int_main_hall_unstable_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_main_hall_unstable_01",
				"pwh_objective_dwarf_int_main_hall_unstable_02",
				"pwh_objective_dwarf_int_main_hall_unstable_03",
				"pwh_objective_dwarf_int_main_hall_unstable_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_brewery_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_brewery_end_01",
				"pdr_objective_dwarf_int_brewery_end_02",
				"pdr_objective_dwarf_int_brewery_end_03",
				"pdr_objective_dwarf_int_brewery_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_brewery_end_01",
				"pdr_objective_dwarf_int_brewery_end_02",
				"pdr_objective_dwarf_int_brewery_end_03",
				"pdr_objective_dwarf_int_brewery_end_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_trading_road = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_trading_road_01",
				"pwe_objective_dwarf_ext_trading_road_02",
				"pwe_objective_dwarf_ext_trading_road_03",
				"pwe_objective_dwarf_ext_trading_road_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_trading_road_01",
				"pwe_objective_dwarf_ext_trading_road_02",
				"pwe_objective_dwarf_ext_trading_road_03",
				"pwe_objective_dwarf_ext_trading_road_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_brewery_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_brewery_end_01",
				"pwh_objective_dwarf_int_brewery_end_02",
				"pwh_objective_dwarf_int_brewery_end_03",
				"pwh_objective_dwarf_int_brewery_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_brewery_end_01",
				"pwh_objective_dwarf_int_brewery_end_02",
				"pwh_objective_dwarf_int_brewery_end_03",
				"pwh_objective_dwarf_int_brewery_end_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_dwarftown = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_dwarftown_01",
				"pbw_objective_beacons_dwarftown_02",
				"pbw_objective_beacons_dwarftown_03",
				"pbw_objective_beacons_dwarftown_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_dwarftown_01",
				"pbw_objective_beacons_dwarftown_02",
				"pbw_objective_beacons_dwarftown_03",
				"pbw_objective_beacons_dwarftown_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_int_intro_c_01",
				[2.0] = "pwe_objective_dwarf_int_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_int_intro_c_01",
				[2.0] = "pwe_objective_dwarf_int_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_main_hall_unstable = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_main_hall_unstable_01",
				"pbw_objective_dwarf_int_main_hall_unstable_02",
				"pbw_objective_dwarf_int_main_hall_unstable_03",
				"pbw_objective_dwarf_int_main_hall_unstable_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_main_hall_unstable_01",
				"pbw_objective_dwarf_int_main_hall_unstable_02",
				"pbw_objective_dwarf_int_main_hall_unstable_03",
				"pbw_objective_dwarf_int_main_hall_unstable_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_lowergate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_lowergate_01",
				"pbw_objective_beacons_lowergate_02",
				"pbw_objective_beacons_lowergate_03",
				"pbw_objective_beacons_lowergate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_lowergate_01",
				"pbw_objective_beacons_lowergate_02",
				"pbw_objective_beacons_lowergate_03",
				"pbw_objective_beacons_lowergate_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_main_hall_unstable = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_main_hall_unstable_01",
				"pdr_objective_dwarf_int_main_hall_unstable_02",
				"pdr_objective_dwarf_int_main_hall_unstable_03",
				"pdr_objective_dwarf_int_main_hall_unstable_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_main_hall_unstable_01",
				"pdr_objective_dwarf_int_main_hall_unstable_02",
				"pdr_objective_dwarf_int_main_hall_unstable_03",
				"pdr_objective_dwarf_int_main_hall_unstable_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_brewery_engineer_reply = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_01",
				[2.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_01",
				[2.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_brewery_engineer_reply = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_01",
				[2.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_01",
				[2.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_main_hall_tunnel_bombed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pwe_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_ext_intro_a_01",
				[2.0] = "pwh_objective_dwarf_ext_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_ext_intro_a_01",
				[2.0] = "pwh_objective_dwarf_ext_intro_a_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_barricades = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_barricades_01",
				"pes_objective_dwarf_int_barricades_02",
				"pes_objective_dwarf_int_barricades_03",
				"pes_objective_dwarf_int_barricades_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_barricades_01",
				"pes_objective_dwarf_int_barricades_02",
				"pes_objective_dwarf_int_barricades_03",
				"pes_objective_dwarf_int_barricades_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_barricades = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_barricades_01",
				"pdr_objective_dwarf_int_barricades_02",
				"pdr_objective_dwarf_int_barricades_03",
				"pdr_objective_dwarf_int_barricades_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_barricades_01",
				"pdr_objective_dwarf_int_barricades_02",
				"pdr_objective_dwarf_int_barricades_03",
				"pdr_objective_dwarf_int_barricades_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_lowergate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_lowergate_01",
				"pdr_objective_beacons_lowergate_02",
				"pdr_objective_beacons_lowergate_03",
				"pdr_objective_beacons_lowergate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_lowergate_01",
				"pdr_objective_beacons_lowergate_02",
				"pdr_objective_beacons_lowergate_03",
				"pdr_objective_beacons_lowergate_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_barricades = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_barricades_01",
				"pbw_objective_dwarf_int_barricades_02",
				"pbw_objective_dwarf_int_barricades_03",
				"pbw_objective_dwarf_int_barricades_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_barricades_01",
				"pbw_objective_dwarf_int_barricades_02",
				"pbw_objective_dwarf_int_barricades_03",
				"pbw_objective_dwarf_int_barricades_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_guard_post = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_guard_post_01",
				"pbw_objective_dwarf_ext_guard_post_02",
				"pbw_objective_dwarf_ext_guard_post_03",
				"pbw_objective_dwarf_ext_guard_post_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_guard_post_01",
				"pbw_objective_dwarf_ext_guard_post_02",
				"pbw_objective_dwarf_ext_guard_post_03",
				"pbw_objective_dwarf_ext_guard_post_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_guard_post = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_guard_post_01",
				"pes_objective_dwarf_ext_guard_post_02",
				"pes_objective_dwarf_ext_guard_post_03",
				"pes_objective_dwarf_ext_guard_post_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_guard_post_01",
				"pes_objective_dwarf_ext_guard_post_02",
				"pes_objective_dwarf_ext_guard_post_03",
				"pes_objective_dwarf_ext_guard_post_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_guard_post = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_guard_post_01",
				"pdr_objective_dwarf_ext_guard_post_02",
				"pdr_objective_dwarf_ext_guard_post_03",
				"pdr_objective_dwarf_ext_guard_post_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_guard_post_01",
				"pdr_objective_dwarf_ext_guard_post_02",
				"pdr_objective_dwarf_ext_guard_post_03",
				"pdr_objective_dwarf_ext_guard_post_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_main_hall_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_main_hall_tunnel_01",
				"pbw_objective_dwarf_int_main_hall_tunnel_02",
				"pbw_objective_dwarf_int_main_hall_tunnel_03",
				"pbw_objective_dwarf_int_main_hall_tunnel_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_main_hall_tunnel_01",
				"pbw_objective_dwarf_int_main_hall_tunnel_02",
				"pbw_objective_dwarf_int_main_hall_tunnel_03",
				"pbw_objective_dwarf_int_main_hall_tunnel_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_witch_hunter_quest_story_two_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_witch_hunter_quest_story_two_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_witch_hunter_quest_story_two_03"
			}
		},
		pbw_karak_azgaraz_witch_hunter_quest_story_one_02 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_karak_azgaraz_witch_hunter_quest_story_one_02",
				[2.0] = "pbw_karak_azgaraz_witch_hunter_quest_story_one_02_b"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_karak_azgaraz_witch_hunter_quest_story_one_02",
				[2.0] = "pbw_karak_azgaraz_witch_hunter_quest_story_one_02_b"
			},
			randomize_indexes = {}
		},
		pwh_karak_azgaraz_witch_hunter_quest_story_one_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_one_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_karak_azgaraz_witch_hunter_quest_story_one_02"
			}
		},
		pdr_objective_dwarf_int_main_hall_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_main_hall_tunnel_01",
				"pdr_objective_dwarf_int_main_hall_tunnel_02",
				"pdr_objective_dwarf_int_main_hall_tunnel_03",
				"pdr_objective_dwarf_int_main_hall_tunnel_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_main_hall_tunnel_01",
				"pdr_objective_dwarf_int_main_hall_tunnel_02",
				"pdr_objective_dwarf_int_main_hall_tunnel_03",
				"pdr_objective_dwarf_int_main_hall_tunnel_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_main_hall_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_main_hall_tunnel_01",
				"pes_objective_dwarf_int_main_hall_tunnel_02",
				"pes_objective_dwarf_int_main_hall_tunnel_03",
				"pes_objective_dwarf_int_main_hall_tunnel_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_main_hall_tunnel_01",
				"pes_objective_dwarf_int_main_hall_tunnel_02",
				"pes_objective_dwarf_int_main_hall_tunnel_03",
				"pes_objective_dwarf_int_main_hall_tunnel_04"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_five_03 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_five_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_five_03"
			}
		},
		pwh_objective_beacons_background = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_background_01",
				"pwh_objective_beacons_background_02",
				"pwh_objective_beacons_background_03",
				"pwh_objective_beacons_background_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_background_01",
				"pwh_objective_beacons_background_02",
				"pwh_objective_beacons_background_03",
				"pwh_objective_beacons_background_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_int_intro_a_01",
				[2.0] = "pbw_objective_dwarf_int_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_int_intro_a_01",
				[2.0] = "pbw_objective_dwarf_int_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_beacons_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pwh_objective_dwarf_beacons_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pwh_objective_dwarf_beacons_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_four_02_alt1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_02_alt1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_02_alt1"
			}
		},
		pes_karak_azgaraz_dwarf_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_five_01"
			}
		},
		pwe_karak_azgaraz_dwarf_quest_story_four_02_alt1 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_02_alt1"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_02_alt1"
			}
		},
		pdr_karak_azgaraz_dwarf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_four_02"
			}
		},
		pwe_karak_azgaraz_dwarf_quest_story_four_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_karak_azgaraz_dwarf_quest_story_four_02"
			}
		},
		pdr_karak_azgaraz_dwarf_quest_story_three_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_three_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_three_02"
			}
		},
		pdr_karak_azgaraz_dwarf_quest_story_three_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_three_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_three_01"
			}
		},
		pdr_karak_azgaraz_dwarf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_two_02"
			}
		},
		pwh_karak_azgaraz_dwarf_quest_story_two_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_karak_azgaraz_dwarf_quest_story_two_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_karak_azgaraz_dwarf_quest_story_two_02"
			}
		},
		pwe_objective_dwarf_int_main_hall_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_main_hall_tunnel_01",
				"pwe_objective_dwarf_int_main_hall_tunnel_02",
				"pwe_objective_dwarf_int_main_hall_tunnel_03",
				"pwe_objective_dwarf_int_main_hall_tunnel_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_main_hall_tunnel_01",
				"pwe_objective_dwarf_int_main_hall_tunnel_02",
				"pwe_objective_dwarf_int_main_hall_tunnel_03",
				"pwe_objective_dwarf_int_main_hall_tunnel_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_open_chamber = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_open_chamber_01",
				"pwe_objective_dwarf_ext_open_chamber_02",
				"pwe_objective_dwarf_ext_open_chamber_03",
				"pwe_objective_dwarf_ext_open_chamber_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_open_chamber_01",
				"pwe_objective_dwarf_ext_open_chamber_02",
				"pwe_objective_dwarf_ext_open_chamber_03",
				"pwe_objective_dwarf_ext_open_chamber_04"
			},
			randomize_indexes = {}
		},
		pwh_karak_azgaraz_dwarf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pwh_karak_azgaraz_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_karak_azgaraz_dwarf_quest_story_two_01"
			}
		},
		pes_objective_dwarf_int_crossroad_bottom_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_crossroad_bottom_open_01",
				"pes_objective_dwarf_int_crossroad_bottom_open_02",
				"pes_objective_dwarf_int_crossroad_bottom_open_03",
				"pes_objective_dwarf_int_crossroad_bottom_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_crossroad_bottom_open_01",
				"pes_objective_dwarf_int_crossroad_bottom_open_02",
				"pes_objective_dwarf_int_crossroad_bottom_open_03",
				"pes_objective_dwarf_int_crossroad_bottom_open_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_pressureplate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_pressureplate_01",
				"pwe_objective_beacons_pressureplate_02",
				"pwe_objective_beacons_pressureplate_03",
				"pwe_objective_beacons_pressureplate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_pressureplate_01",
				"pwe_objective_beacons_pressureplate_02",
				"pwe_objective_beacons_pressureplate_03",
				"pwe_objective_beacons_pressureplate_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_guard_post = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_guard_post_01",
				"pwe_objective_dwarf_ext_guard_post_02",
				"pwe_objective_dwarf_ext_guard_post_03",
				"pwe_objective_dwarf_ext_guard_post_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_guard_post_01",
				"pwe_objective_dwarf_ext_guard_post_02",
				"pwe_objective_dwarf_ext_guard_post_03",
				"pwe_objective_dwarf_ext_guard_post_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_crossroad_bottom_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_crossroad_bottom_open_01",
				"pdr_objective_dwarf_int_crossroad_bottom_open_02",
				"pdr_objective_dwarf_int_crossroad_bottom_open_03",
				"pdr_objective_dwarf_int_crossroad_bottom_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_crossroad_bottom_open_01",
				"pdr_objective_dwarf_int_crossroad_bottom_open_02",
				"pdr_objective_dwarf_int_crossroad_bottom_open_03",
				"pdr_objective_dwarf_int_crossroad_bottom_open_04"
			},
			randomize_indexes = {}
		},
		pbw_karak_azgaraz_dwarf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_karak_azgaraz_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_karak_azgaraz_dwarf_quest_story_one_01"
			}
		},
		pdr_objective_dwarf_int_main_hall_tunnel_bombed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pdr_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_crossroad_top_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_crossroad_top_open_01",
				"pdr_objective_dwarf_int_crossroad_top_open_02",
				"pdr_objective_dwarf_int_crossroad_top_open_03",
				"pdr_objective_dwarf_int_crossroad_top_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_crossroad_top_open_01",
				"pdr_objective_dwarf_int_crossroad_top_open_02",
				"pdr_objective_dwarf_int_crossroad_top_open_03",
				"pdr_objective_dwarf_int_crossroad_top_open_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_ext_intro_c_01",
				[2.0] = "pdr_objective_dwarf_ext_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_ext_intro_c_01",
				[2.0] = "pdr_objective_dwarf_ext_intro_c_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_beacons_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pes_objective_dwarf_beacons_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_beacons_intro_c_01",
				[2.0] = "pes_objective_dwarf_beacons_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_spotting_karak_azgaraz = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_01",
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_02",
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_03",
				"pwh_objective_dwarf_ext_spotting_karak_azgaraz_04"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_five_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_five_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_five_01"
			}
		},
		pbw_objective_dwarf_ext_long_way_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_long_way_down_01",
				"pbw_objective_dwarf_ext_long_way_down_02",
				"pbw_objective_dwarf_ext_long_way_down_03",
				"pbw_objective_dwarf_ext_long_way_down_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_long_way_down_01",
				"pbw_objective_dwarf_ext_long_way_down_02",
				"pbw_objective_dwarf_ext_long_way_down_03",
				"pbw_objective_dwarf_ext_long_way_down_04"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_two_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_two_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_two_01"
			}
		},
		pwh_objective_dwarf_int_crossroad_bottom_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_crossroad_bottom_open_01",
				"pwh_objective_dwarf_int_crossroad_bottom_open_02",
				"pwh_objective_dwarf_int_crossroad_bottom_open_03",
				"pwh_objective_dwarf_int_crossroad_bottom_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_crossroad_bottom_open_01",
				"pwh_objective_dwarf_int_crossroad_bottom_open_02",
				"pwh_objective_dwarf_int_crossroad_bottom_open_03",
				"pwh_objective_dwarf_int_crossroad_bottom_open_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_crossroad_bottom_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_crossroad_bottom_open_01",
				"pwe_objective_dwarf_int_crossroad_bottom_open_02",
				"pwe_objective_dwarf_int_crossroad_bottom_open_03",
				"pwe_objective_dwarf_int_crossroad_bottom_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_crossroad_bottom_open_01",
				"pwe_objective_dwarf_int_crossroad_bottom_open_02",
				"pwe_objective_dwarf_int_crossroad_bottom_open_03",
				"pwe_objective_dwarf_int_crossroad_bottom_open_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_ext_intro_c_01",
				[2.0] = "pwe_objective_dwarf_ext_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_ext_intro_c_01",
				[2.0] = "pwe_objective_dwarf_ext_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_railyard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_railyard_01",
				"pdr_objective_dwarf_ext_railyard_02",
				"pdr_objective_dwarf_ext_railyard_03",
				"pdr_objective_dwarf_ext_railyard_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_railyard_01",
				"pdr_objective_dwarf_ext_railyard_02",
				"pdr_objective_dwarf_ext_railyard_03",
				"pdr_objective_dwarf_ext_railyard_04"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_five_02"
			}
		},
		pwe_objective_dwarf_int_crossroad_top_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_crossroad_top_open_01",
				"pwe_objective_dwarf_int_crossroad_top_open_02",
				"pwe_objective_dwarf_int_crossroad_top_open_03",
				"pwe_objective_dwarf_int_crossroad_top_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_crossroad_top_open_01",
				"pwe_objective_dwarf_int_crossroad_top_open_02",
				"pwe_objective_dwarf_int_crossroad_top_open_03",
				"pwe_objective_dwarf_int_crossroad_top_open_04"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_brewery_engineer = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_dlc",
			category = "npc_talk_special",
			dialogue_animations_n = 3,
			sound_events = {
				"nde_objective_dwarf_int_brewery_engineer_01",
				"nde_objective_dwarf_int_brewery_engineer_02",
				"nde_objective_dwarf_int_brewery_engineer_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_brewery_engineer_01",
				"nde_objective_dwarf_int_brewery_engineer_02",
				"nde_objective_dwarf_int_brewery_engineer_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_pressureplate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_pressureplate_01",
				"pdr_objective_beacons_pressureplate_02",
				"pdr_objective_beacons_pressureplate_03",
				"pdr_objective_beacons_pressureplate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_pressureplate_01",
				"pdr_objective_beacons_pressureplate_02",
				"pdr_objective_beacons_pressureplate_03",
				"pdr_objective_beacons_pressureplate_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_ext_intro_c_01",
				[2.0] = "pbw_objective_dwarf_ext_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_ext_intro_c_01",
				[2.0] = "pbw_objective_dwarf_ext_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_int_intro_b_01",
				[2.0] = "pwh_objective_dwarf_int_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_int_intro_b_01",
				[2.0] = "pwh_objective_dwarf_int_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_ext_intro_a_01",
				[2.0] = "pwe_objective_dwarf_ext_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_ext_intro_a_01",
				[2.0] = "pwe_objective_dwarf_ext_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_open_chamber = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_open_chamber_01",
				"pbw_objective_dwarf_ext_open_chamber_02",
				"pbw_objective_dwarf_ext_open_chamber_03",
				"pbw_objective_dwarf_ext_open_chamber_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_open_chamber_01",
				"pbw_objective_dwarf_ext_open_chamber_02",
				"pbw_objective_dwarf_ext_open_chamber_03",
				"pbw_objective_dwarf_ext_open_chamber_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_ext_intro_b_01",
				[2.0] = "pbw_objective_dwarf_ext_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_ext_intro_b_01",
				[2.0] = "pbw_objective_dwarf_ext_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_ext_spotting_chamber_area = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_ext_spotting_chamber_area_01",
				"pbw_objective_dwarf_ext_spotting_chamber_area_02",
				"pbw_objective_dwarf_ext_spotting_chamber_area_03",
				"pbw_objective_dwarf_ext_spotting_chamber_area_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_ext_spotting_chamber_area_01",
				"pbw_objective_dwarf_ext_spotting_chamber_area_02",
				"pbw_objective_dwarf_ext_spotting_chamber_area_03",
				"pbw_objective_dwarf_ext_spotting_chamber_area_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_railyard = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_railyard_01",
				"pwe_objective_dwarf_ext_railyard_02",
				"pwe_objective_dwarf_ext_railyard_03",
				"pwe_objective_dwarf_ext_railyard_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_railyard_01",
				"pwe_objective_dwarf_ext_railyard_02",
				"pwe_objective_dwarf_ext_railyard_03",
				"pwe_objective_dwarf_ext_railyard_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_crossroad_bottom_open = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_crossroad_bottom_open_01",
				"pbw_objective_dwarf_int_crossroad_bottom_open_02",
				"pbw_objective_dwarf_int_crossroad_bottom_open_03",
				"pbw_objective_dwarf_int_crossroad_bottom_open_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_crossroad_bottom_open_01",
				"pbw_objective_dwarf_int_crossroad_bottom_open_02",
				"pbw_objective_dwarf_int_crossroad_bottom_open_03",
				"pbw_objective_dwarf_int_crossroad_bottom_open_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_main_hall_tunnel_bombed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pes_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			randomize_indexes = {}
		},
		pes_karak_azgaraz_dwarf_quest_story_five_02 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_five_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_karak_azgaraz_dwarf_quest_story_five_02"
			}
		},
		pbw_objective_beacons_pressureplate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_pressureplate_01",
				"pbw_objective_beacons_pressureplate_02",
				"pbw_objective_beacons_pressureplate_03",
				"pbw_objective_beacons_pressureplate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_pressureplate_01",
				"pbw_objective_beacons_pressureplate_02",
				"pbw_objective_beacons_pressureplate_03",
				"pbw_objective_beacons_pressureplate_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_ulgu = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_ulgu_01",
				"pdr_objective_beacons_ulgu_02",
				"pdr_objective_beacons_ulgu_03",
				"pdr_objective_beacons_ulgu_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_ulgu_01",
				"pdr_objective_beacons_ulgu_02",
				"pdr_objective_beacons_ulgu_03",
				"pdr_objective_beacons_ulgu_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_lets_go = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_lets_go_01",
				"pes_objective_dwarf_ext_lets_go_02",
				"pes_objective_dwarf_ext_lets_go_03",
				"pes_objective_dwarf_ext_lets_go_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_lets_go_01",
				"pes_objective_dwarf_ext_lets_go_02",
				"pes_objective_dwarf_ext_lets_go_03",
				"pes_objective_dwarf_ext_lets_go_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_brewery_engineer_reply_keystone = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_keystone_03",
				[2.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_keystone_04"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_keystone_03",
				[2.0] = "pbw_objective_dwarf_int_brewery_engineer_reply_keystone_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_beacons_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pwe_objective_dwarf_beacons_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_beacons_intro_b_01",
				[2.0] = "pwe_objective_dwarf_beacons_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_beacon_visible = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_beacon_visible_01",
				"pes_objective_beacons_beacon_visible_02",
				"pes_objective_beacons_beacon_visible_03",
				"pes_objective_beacons_beacon_visible_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_beacon_visible_01",
				"pes_objective_beacons_beacon_visible_02",
				"pes_objective_beacons_beacon_visible_03",
				"pes_objective_beacons_beacon_visible_04"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_main_hall_start = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "npc_talk_interrupt_special",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nde_objective_dwarf_int_main_hall_start_02",
				[2.0] = "nde_objective_dwarf_int_main_hall_start_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "nde_objective_dwarf_int_main_hall_start_02",
				[2.0] = "nde_objective_dwarf_int_main_hall_start_03"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_beacons_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pwe_objective_dwarf_beacons_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwe_objective_dwarf_beacons_intro_a_01",
				[2.0] = "pwe_objective_dwarf_beacons_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_beacon_visible = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_beacon_visible_01",
				"pwe_objective_beacons_beacon_visible_02",
				"pwe_objective_beacons_beacon_visible_03",
				"pwe_objective_beacons_beacon_visible_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_beacon_visible_01",
				"pwe_objective_beacons_beacon_visible_02",
				"pwe_objective_beacons_beacon_visible_03",
				"pwe_objective_beacons_beacon_visible_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_main_hall_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_main_hall_tunnel_01",
				"pwh_objective_dwarf_int_main_hall_tunnel_02",
				"pwh_objective_dwarf_int_main_hall_tunnel_03",
				"pwh_objective_dwarf_int_main_hall_tunnel_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_main_hall_tunnel_01",
				"pwh_objective_dwarf_int_main_hall_tunnel_02",
				"pwh_objective_dwarf_int_main_hall_tunnel_03",
				"pwh_objective_dwarf_int_main_hall_tunnel_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_ulgu = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_ulgu_01",
				"pwh_objective_beacons_ulgu_02",
				"pwh_objective_beacons_ulgu_03",
				"pwh_objective_beacons_ulgu_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_ulgu_01",
				"pwh_objective_beacons_ulgu_02",
				"pwh_objective_beacons_ulgu_03",
				"pwh_objective_beacons_ulgu_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_open_chamber = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_open_chamber_01",
				"pes_objective_dwarf_ext_open_chamber_02",
				"pes_objective_dwarf_ext_open_chamber_03",
				"pes_objective_dwarf_ext_open_chamber_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_open_chamber_01",
				"pes_objective_dwarf_ext_open_chamber_02",
				"pes_objective_dwarf_ext_open_chamber_03",
				"pes_objective_dwarf_ext_open_chamber_04"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_dwarftown = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_dwarftown_01",
				"pes_objective_beacons_dwarftown_02",
				"pes_objective_beacons_dwarftown_03",
				"pes_objective_beacons_dwarftown_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_dwarftown_01",
				"pes_objective_beacons_dwarftown_02",
				"pes_objective_beacons_dwarftown_03",
				"pes_objective_beacons_dwarftown_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_lit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_lit_01",
				"pwh_objective_beacons_lit_02",
				"pwh_objective_beacons_lit_03",
				"pwh_objective_beacons_lit_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_lit_01",
				"pwh_objective_beacons_lit_02",
				"pwh_objective_beacons_lit_03",
				"pwh_objective_beacons_lit_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_main_hall_pc_acknowledge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pes_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_pressureplate_progress = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_pressureplate_progress_01",
				"pwh_objective_beacons_pressureplate_progress_02",
				"pwh_objective_beacons_pressureplate_progress_03",
				"pwh_objective_beacons_pressureplate_progress_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_pressureplate_progress_01",
				"pwh_objective_beacons_pressureplate_progress_02",
				"pwh_objective_beacons_pressureplate_progress_03",
				"pwh_objective_beacons_pressureplate_progress_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_pressureplate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_pressureplate_01",
				"pwh_objective_beacons_pressureplate_02",
				"pwh_objective_beacons_pressureplate_03",
				"pwh_objective_beacons_pressureplate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_pressureplate_01",
				"pwh_objective_beacons_pressureplate_02",
				"pwh_objective_beacons_pressureplate_03",
				"pwh_objective_beacons_pressureplate_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_temple_of_valaya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_temple_of_valaya_01",
				"pwh_objective_dwarf_int_temple_of_valaya_02",
				"pwh_objective_dwarf_int_temple_of_valaya_03",
				"pwh_objective_dwarf_int_temple_of_valaya_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_temple_of_valaya_01",
				"pwh_objective_dwarf_int_temple_of_valaya_02",
				"pwh_objective_dwarf_int_temple_of_valaya_03",
				"pwh_objective_dwarf_int_temple_of_valaya_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_keep_running = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_keep_running_01",
				"pwh_objective_dwarf_ext_keep_running_02",
				"pwh_objective_dwarf_ext_keep_running_03",
				"pwh_objective_dwarf_ext_keep_running_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_keep_running_01",
				"pwh_objective_dwarf_ext_keep_running_02",
				"pwh_objective_dwarf_ext_keep_running_03",
				"pwh_objective_dwarf_ext_keep_running_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_trading_road = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_trading_road_01",
				"pwh_objective_dwarf_ext_trading_road_02",
				"pwh_objective_dwarf_ext_trading_road_03",
				"pwh_objective_dwarf_ext_trading_road_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_trading_road_01",
				"pwh_objective_dwarf_ext_trading_road_02",
				"pwh_objective_dwarf_ext_trading_road_03",
				"pwh_objective_dwarf_ext_trading_road_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_int_intro_b_01",
				[2.0] = "pes_objective_dwarf_int_intro_b_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_int_intro_b_01",
				[2.0] = "pes_objective_dwarf_int_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_beacons_pressureplate_progress = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_pressureplate_progress_01",
				"pes_objective_beacons_pressureplate_progress_02",
				"pes_objective_beacons_pressureplate_progress_03",
				"pes_objective_beacons_pressureplate_progress_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_pressureplate_progress_01",
				"pes_objective_beacons_pressureplate_progress_02",
				"pes_objective_beacons_pressureplate_progress_03",
				"pes_objective_beacons_pressureplate_progress_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_lowergate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_lowergate_01",
				"pwe_objective_beacons_lowergate_02",
				"pwe_objective_beacons_lowergate_03",
				"pwe_objective_beacons_lowergate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_lowergate_01",
				"pwe_objective_beacons_lowergate_02",
				"pwe_objective_beacons_lowergate_03",
				"pwe_objective_beacons_lowergate_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_frozen_lake = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_frozen_lake_01",
				"pwh_objective_dwarf_ext_frozen_lake_02",
				"pwh_objective_dwarf_ext_frozen_lake_03",
				"pwh_objective_dwarf_ext_frozen_lake_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_frozen_lake_01",
				"pwh_objective_dwarf_ext_frozen_lake_02",
				"pwh_objective_dwarf_ext_frozen_lake_03",
				"pwh_objective_dwarf_ext_frozen_lake_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_main_hall_unstable = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_main_hall_unstable_01",
				"pwe_objective_dwarf_int_main_hall_unstable_02",
				"pwe_objective_dwarf_int_main_hall_unstable_03",
				"pwe_objective_dwarf_int_main_hall_unstable_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_main_hall_unstable_01",
				"pwe_objective_dwarf_int_main_hall_unstable_02",
				"pwe_objective_dwarf_int_main_hall_unstable_03",
				"pwe_objective_dwarf_int_main_hall_unstable_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_brewery_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_brewery_end_01",
				"pes_objective_dwarf_int_brewery_end_02",
				"pes_objective_dwarf_int_brewery_end_03",
				"pes_objective_dwarf_int_brewery_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_brewery_end_01",
				"pes_objective_dwarf_int_brewery_end_02",
				"pes_objective_dwarf_int_brewery_end_03",
				"pes_objective_dwarf_int_brewery_end_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_brewery_engineer_reply_keystone = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_keystone_02",
				[2.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_keystone_03"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned",
				[2.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_keystone_02",
				[2.0] = "pdr_objective_dwarf_int_brewery_engineer_reply_keystone_03"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_hallway = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_hallway_01",
				"pbw_objective_dwarf_int_hallway_02",
				"pbw_objective_dwarf_int_hallway_03",
				"pbw_objective_dwarf_int_hallway_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_hallway_01",
				"pbw_objective_dwarf_int_hallway_02",
				"pbw_objective_dwarf_int_hallway_03",
				"pbw_objective_dwarf_int_hallway_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_guard_post = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_guard_post_01",
				"pwh_objective_dwarf_ext_guard_post_02",
				"pwh_objective_dwarf_ext_guard_post_03",
				"pwh_objective_dwarf_ext_guard_post_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_guard_post_01",
				"pwh_objective_dwarf_ext_guard_post_02",
				"pwh_objective_dwarf_ext_guard_post_03",
				"pwh_objective_dwarf_ext_guard_post_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_main_hall_pc_acknowledge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pdr_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_int_intro_01",
				[2.0] = "pwh_objective_dwarf_int_intro_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_int_intro_01",
				[2.0] = "pwh_objective_dwarf_int_intro_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_main_hall_unstable = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_int_main_hall_unstable_01",
				"pes_objective_dwarf_int_main_hall_unstable_02",
				"pes_objective_dwarf_int_main_hall_unstable_03",
				"pes_objective_dwarf_int_main_hall_unstable_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_main_hall_unstable_01",
				"pes_objective_dwarf_int_main_hall_unstable_02",
				"pes_objective_dwarf_int_main_hall_unstable_03",
				"pes_objective_dwarf_int_main_hall_unstable_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_int_main_hall_pc_acknowledge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pwe_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_main_hall_tunnel_bombed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_01",
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_02",
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_03",
				"pwh_objective_dwarf_int_main_hall_tunnel_bombed_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_brewery_engineer_reply = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_dlc",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_dwarf_int_brewery_engineer_reply_01",
				"pes_objective_dwarf_int_brewery_engineer_reply_03",
				"pes_objective_dwarf_int_brewery_engineer_reply_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_int_brewery_engineer_reply_01",
				"pes_objective_dwarf_int_brewery_engineer_reply_03",
				"pes_objective_dwarf_int_brewery_engineer_reply_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dwarf_int_intro_01",
				[2.0] = "pdr_objective_dwarf_int_intro_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_objective_dwarf_int_intro_01",
				[2.0] = "pdr_objective_dwarf_int_intro_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_dwarftown = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_dwarftown_01",
				"pdr_objective_beacons_dwarftown_02",
				"pdr_objective_beacons_dwarftown_03",
				"pdr_objective_beacons_dwarftown_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_dwarftown_01",
				"pdr_objective_beacons_dwarftown_02",
				"pdr_objective_beacons_dwarftown_03",
				"pdr_objective_beacons_dwarftown_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_long_way_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dwarf_ext_long_way_down_01",
				"pes_objective_dwarf_ext_long_way_down_02",
				"pes_objective_dwarf_ext_long_way_down_03",
				"pes_objective_dwarf_ext_long_way_down_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_dwarf_ext_long_way_down_01",
				"pes_objective_dwarf_ext_long_way_down_02",
				"pes_objective_dwarf_ext_long_way_down_03",
				"pes_objective_dwarf_ext_long_way_down_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_long_way_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_long_way_down_01",
				"pdr_objective_dwarf_ext_long_way_down_02",
				"pdr_objective_dwarf_ext_long_way_down_03",
				"pdr_objective_dwarf_ext_long_way_down_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_long_way_down_01",
				"pdr_objective_dwarf_ext_long_way_down_02",
				"pdr_objective_dwarf_ext_long_way_down_03",
				"pdr_objective_dwarf_ext_long_way_down_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_brewery_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_brewery_end_01",
				"pbw_objective_dwarf_int_brewery_end_02",
				"pbw_objective_dwarf_int_brewery_end_03",
				"pbw_objective_dwarf_int_brewery_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_brewery_end_01",
				"pbw_objective_dwarf_int_brewery_end_02",
				"pbw_objective_dwarf_int_brewery_end_03",
				"pbw_objective_dwarf_int_brewery_end_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_main_hall_pc_acknowledge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pwh_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_brewery_stabilize_pressure_success = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "dwarf_dlc",
			category = "npc_talk_special",
			dialogue_animations_n = 5,
			sound_events = {
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_01",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_02",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_03",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_04",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_final_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_01",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_02",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_03",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_04",
				"nde_objective_dwarf_int_brewery_stabilize_pressure_success_final_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_lets_go = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_lets_go_01",
				"pdr_objective_dwarf_ext_lets_go_02",
				"pdr_objective_dwarf_ext_lets_go_03",
				"pdr_objective_dwarf_ext_lets_go_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_lets_go_01",
				"pdr_objective_dwarf_ext_lets_go_02",
				"pdr_objective_dwarf_ext_lets_go_03",
				"pdr_objective_dwarf_ext_lets_go_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_skaven_territory = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_skaven_territory_01",
				"pwh_objective_dwarf_int_skaven_territory_02",
				"pwh_objective_dwarf_int_skaven_territory_03",
				"pwh_objective_dwarf_int_skaven_territory_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_skaven_territory_01",
				"pwh_objective_dwarf_int_skaven_territory_02",
				"pwh_objective_dwarf_int_skaven_territory_03",
				"pwh_objective_dwarf_int_skaven_territory_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_brewery_engineer_reply_keystone = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_dwarf_int_brewery_engineer_reply_keystone_01",
				"pwh_objective_dwarf_int_brewery_engineer_reply_keystone_03",
				"pwh_objective_dwarf_int_brewery_engineer_reply_keystone_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_brewery_engineer_reply_keystone_01",
				"pwh_objective_dwarf_int_brewery_engineer_reply_keystone_03",
				"pwh_objective_dwarf_int_brewery_engineer_reply_keystone_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_brewery_engineer_reply = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "dwarf_dlc",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_dwarf_int_brewery_engineer_reply_01",
				"pwh_objective_dwarf_int_brewery_engineer_reply_02",
				"pwh_objective_dwarf_int_brewery_engineer_reply_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_brewery_engineer_reply_01",
				"pwh_objective_dwarf_int_brewery_engineer_reply_02",
				"pwh_objective_dwarf_int_brewery_engineer_reply_03"
			},
			randomize_indexes = {}
		},
		pwh_objective_beacons_gatedone = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_beacons_gatedone_01",
				"pwh_objective_beacons_gatedone_02",
				"pwh_objective_beacons_gatedone_03",
				"pwh_objective_beacons_gatedone_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_beacons_gatedone_01",
				"pwh_objective_beacons_gatedone_02",
				"pwh_objective_beacons_gatedone_03",
				"pwh_objective_beacons_gatedone_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_int_barricades = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_int_barricades_01",
				"pwh_objective_dwarf_int_barricades_02",
				"pwh_objective_dwarf_int_barricades_03",
				"pwh_objective_dwarf_int_barricades_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_int_barricades_01",
				"pwh_objective_dwarf_int_barricades_02",
				"pwh_objective_dwarf_int_barricades_03",
				"pwh_objective_dwarf_int_barricades_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_beacons_lowergatex2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_beacons_lowergatex2_01",
				"pbw_objective_beacons_lowergatex2_02",
				"pbw_objective_beacons_lowergatex2_03",
				"pbw_objective_beacons_lowergatex2_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_beacons_lowergatex2_01",
				"pbw_objective_beacons_lowergatex2_02",
				"pbw_objective_beacons_lowergatex2_03",
				"pbw_objective_beacons_lowergatex2_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_main_hall_pc_acknowledge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_01",
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_02",
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_03",
				"pbw_objective_dwarf_int_main_hall_pc_acknowledge_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_beacons_lowergatex2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_beacons_lowergatex2_01",
				"pwe_objective_beacons_lowergatex2_02",
				"pwe_objective_beacons_lowergatex2_03",
				"pwe_objective_beacons_lowergatex2_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_beacons_lowergatex2_01",
				"pwe_objective_beacons_lowergatex2_02",
				"pwe_objective_beacons_lowergatex2_03",
				"pwe_objective_beacons_lowergatex2_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_hallway = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_hallway_01",
				"pdr_objective_dwarf_int_hallway_02",
				"pdr_objective_dwarf_int_hallway_03",
				"pdr_objective_dwarf_int_hallway_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_hallway_01",
				"pdr_objective_dwarf_int_hallway_02",
				"pdr_objective_dwarf_int_hallway_03",
				"pdr_objective_dwarf_int_hallway_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dwarf_ext_intro_c_01",
				[2.0] = "pwh_objective_dwarf_ext_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pwh_objective_dwarf_ext_intro_c_01",
				[2.0] = "pwh_objective_dwarf_ext_intro_c_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_int_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_int_intro_a_01",
				[2.0] = "pes_objective_dwarf_int_intro_a_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_int_intro_a_01",
				[2.0] = "pes_objective_dwarf_int_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_karak_azgaraz_dwarf_quest_story_one_01 = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "dwarf_dlc",
			category = "story_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_one_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pdr_karak_azgaraz_dwarf_quest_story_one_01"
			}
		},
		pes_objective_beacons_pressureplate = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_beacons_pressureplate_01",
				"pes_objective_beacons_pressureplate_02",
				"pes_objective_beacons_pressureplate_03",
				"pes_objective_beacons_pressureplate_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_objective_beacons_pressureplate_01",
				"pes_objective_beacons_pressureplate_02",
				"pes_objective_beacons_pressureplate_03",
				"pes_objective_beacons_pressureplate_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dwarf_int_temple_of_valaya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dwarf_int_temple_of_valaya_01",
				"pbw_objective_dwarf_int_temple_of_valaya_02",
				"pbw_objective_dwarf_int_temple_of_valaya_03",
				"pbw_objective_dwarf_int_temple_of_valaya_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_objective_dwarf_int_temple_of_valaya_01",
				"pbw_objective_dwarf_int_temple_of_valaya_02",
				"pbw_objective_dwarf_int_temple_of_valaya_03",
				"pbw_objective_dwarf_int_temple_of_valaya_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dwarf_ext_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dwarf_ext_intro_c_01",
				[2.0] = "pes_objective_dwarf_ext_intro_c_02"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk",
				[2.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_neutral",
				[2.0] = "face_neutral"
			},
			localization_strings = {
				[1.0] = "pes_objective_dwarf_ext_intro_c_01",
				[2.0] = "pes_objective_dwarf_ext_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_frozen_lake = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_frozen_lake_01",
				"pdr_objective_dwarf_ext_frozen_lake_02",
				"pdr_objective_dwarf_ext_frozen_lake_03",
				"pdr_objective_dwarf_ext_frozen_lake_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_frozen_lake_01",
				"pdr_objective_dwarf_ext_frozen_lake_02",
				"pdr_objective_dwarf_ext_frozen_lake_03",
				"pdr_objective_dwarf_ext_frozen_lake_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dwarf_ext_long_way_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dwarf_ext_long_way_down_01",
				"pwe_objective_dwarf_ext_long_way_down_02",
				"pwe_objective_dwarf_ext_long_way_down_03",
				"pwe_objective_dwarf_ext_long_way_down_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwe_objective_dwarf_ext_long_way_down_01",
				"pwe_objective_dwarf_ext_long_way_down_02",
				"pwe_objective_dwarf_ext_long_way_down_03",
				"pwe_objective_dwarf_ext_long_way_down_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_beacons_gatedone = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_beacons_gatedone_01",
				"pdr_objective_beacons_gatedone_02",
				"pdr_objective_beacons_gatedone_03",
				"pdr_objective_beacons_gatedone_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_beacons_gatedone_01",
				"pdr_objective_beacons_gatedone_02",
				"pdr_objective_beacons_gatedone_03",
				"pdr_objective_beacons_gatedone_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_ext_up_ramp = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_ext_up_ramp_01",
				"pdr_objective_dwarf_ext_up_ramp_02",
				"pdr_objective_dwarf_ext_up_ramp_03",
				"pdr_objective_dwarf_ext_up_ramp_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_ext_up_ramp_01",
				"pdr_objective_dwarf_ext_up_ramp_02",
				"pdr_objective_dwarf_ext_up_ramp_03",
				"pdr_objective_dwarf_ext_up_ramp_04"
			},
			randomize_indexes = {}
		},
		nde_objective_dwarf_int_brewery_valve_guide = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "npc_talk_interrupt_special",
			dialogue_animations_n = 4,
			sound_events = {
				"nde_objective_dwarf_int_brewery_valve_guide_01",
				"nde_objective_dwarf_int_brewery_valve_guide_02",
				"nde_objective_dwarf_int_brewery_valve_guide_03",
				"nde_objective_dwarf_int_brewery_valve_guide_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"nde_objective_dwarf_int_brewery_valve_guide_01",
				"nde_objective_dwarf_int_brewery_valve_guide_02",
				"nde_objective_dwarf_int_brewery_valve_guide_03",
				"nde_objective_dwarf_int_brewery_valve_guide_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dwarf_int_main_hall_end = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dwarf_int_main_hall_end_01",
				"pdr_objective_dwarf_int_main_hall_end_02",
				"pdr_objective_dwarf_int_main_hall_end_03",
				"pdr_objective_dwarf_int_main_hall_end_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pdr_objective_dwarf_int_main_hall_end_01",
				"pdr_objective_dwarf_int_main_hall_end_02",
				"pdr_objective_dwarf_int_main_hall_end_03",
				"pdr_objective_dwarf_int_main_hall_end_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dwarf_ext_long_way_down = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "dwarf_dlc",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dwarf_ext_long_way_down_01",
				"pwh_objective_dwarf_ext_long_way_down_02",
				"pwh_objective_dwarf_ext_long_way_down_03",
				"pwh_objective_dwarf_ext_long_way_down_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_objective_dwarf_ext_long_way_down_01",
				"pwh_objective_dwarf_ext_long_way_down_02",
				"pwh_objective_dwarf_ext_long_way_down_03",
				"pwh_objective_dwarf_ext_long_way_down_04"
			},
			randomize_indexes = {}
		}
	})
end
