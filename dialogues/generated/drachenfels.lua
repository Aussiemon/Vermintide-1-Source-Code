return function ()
	define_rule({
		response = "nik_map_brief_castle",
		name = "nik_map_brief_castle",
		criterias = {
			{
				"query_context",
				"speaker_name",
				OP.EQ,
				"inn_keeper"
			}
		}
	})
	define_rule({
		response = "nik_loading_screen_castle",
		name = "nik_loading_screen_castle",
		criterias = {}
	})
	define_rule({
		response = "nik_map_brief_dungeon",
		name = "nik_map_brief_dungeon",
		criterias = {}
	})
	define_rule({
		response = "nik_loading_screen_dungeon",
		name = "nik_loading_screen_dungeon",
		criterias = {}
	})
	define_rule({
		response = "nik_map_brief_portals",
		name = "nik_map_brief_portals",
		criterias = {}
	})
	define_rule({
		response = "nik_loading_screen_map",
		name = "nik_loading_screen_map",
		criterias = {}
	})
	define_rule({
		name = "pes_objective_castle_view",
		response = "pes_objective_castle_view",
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
				"objective_castle_view"
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
		name = "pes_objective_castle_broken_bridge",
		response = "pes_objective_castle_broken_bridge",
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
				"objective_castle_broken_bridge"
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
				"time_since_objective_castle_broken_bridge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_broken_bridge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_skaven_entry",
		response = "pes_objective_castle_skaven_entry",
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
				"objective_castle_skaven_entry"
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
				"time_since_objective_castle_skaven_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_skaven_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_catacombs_arrival",
		response = "pes_objective_castle_catacombs_arrival",
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
				"objective_castle_catacombs_arrival"
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
				"time_since_objective_castle_catacombs_arrival",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_catacombs_arrival",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_blood_pool",
		response = "pes_objective_castle_blood_pool",
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
				"objective_castle_blood_pool"
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
				"time_since_objective_castle_blood_pool",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_blood_pool",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_wood_door",
		response = "pes_objective_castle_wood_door",
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
				"objective_castle_wood_door"
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
				"time_since_objective_castle_wood_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_wood_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_ballroom",
		response = "pes_objective_castle_ballroom",
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
				"objective_castle_ballroom"
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
				"time_since_objective_castle_ballroom",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_ballroom",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_inner_sanctum",
		response = "pes_objective_castle_inner_sanctum",
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
				"objective_castle_inner_sanctum"
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
				"time_since_objective_castle_inner_sanctum",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_inner_sanctum",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_statue",
		response = "pes_objective_castle_statue",
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
				"objective_castle_statue"
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
				"time_since_objective_castle_statue",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_statue",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_placing_statuette",
		response = "pes_objective_castle_placing_statuette",
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
				"objective_castle_placing_statuette"
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
				"time_since_objective_castle_placing_statuette",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_placing_statuette",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_chalice_acquired",
		response = "pes_objective_castle_chalice_acquired",
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
				"objective_castle_chalice_acquired"
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
				"time_since_objective_castle_chalice_acquired",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_acquired",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_trap_door_activated",
		response = "pes_objective_castle_trap_door_activated",
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
				"objective_castle_trap_door_activated"
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
				"time_since_objective_castle_trap_door_activated",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_trap_door_activated",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_lever_2",
		response = "pes_objective_castle_lever_2",
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
				"objective_castle_lever_2"
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
				"time_since_objective_castle_lever_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_skaven_exit",
		response = "pes_objective_skaven_exit",
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
				"objective_skaven_exit"
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
				"time_since_objective_skaven_exit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_skaven_exit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_escaped",
		response = "pes_objective_castle_escaped",
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
				"objective_castle_escaped"
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
				"time_since_objective_castle_escaped",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_escaped",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_darkness_entry",
		response = "pes_objective_dungeon_darkness_entry",
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
				"objective_dungeon_darkness_entry"
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
				"time_since_objective_dungeon_darkness_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_darkness_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_traps_warning",
		response = "pes_objective_dungeon_traps_warning",
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
				"objective_dungeon_traps_warning"
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
				"time_since_objective_dungeon_traps_warning",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_traps_warning",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_traps_ally_hit",
		response = "pes_objective_dungeon_traps_ally_hit",
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
				"objective_dungeon_traps_ally_hit"
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
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_jump_challenge",
		response = "pes_objective_dungeon_jump_challenge",
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
				"objective_dungeon_jump_challenge"
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
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_spot_artifact_1",
		response = "pes_objective_dungeon_spot_artifact_1",
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
				"objective_dungeon_spot_artifact_1"
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
				"time_since_objective_dungeon_spot_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_acquire_artifact_1",
		response = "pes_objective_dungeon_acquire_artifact_1",
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
				"objective_dungeon_acquire_artifact_1"
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
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_outdoors_vista1",
		response = "pes_objective_dungeon_outdoors_vista1",
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
				"objective_dungeon_outdoors_vista1"
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
				"time_since_objective_dungeon_outdoors_vista1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_outdoors_vista1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pes_objective_dungeon_torch_1",
		name = "pes_objective_dungeon_torch_1",
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
				"objective_dungeon_torch_1"
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
		name = "pes_objective_dungeon_torture_racks",
		response = "pes_objective_dungeon_torture_racks",
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
				"objective_dungeon_torture_racks"
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
				"time_since_objective_dungeon_torture_racks",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torture_racks",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_balance",
		response = "pes_objective_dungeon_balance",
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
				"objective_dungeon_balance"
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
				"time_since_objective_dungeon_balance",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_balance",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_torch_2",
		response = "pes_objective_dungeon_torch_2",
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
				"objective_dungeon_torch_2"
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
				"time_since_objective_dungeon_torch_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torch_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_spot_artifact_2",
		response = "pes_objective_dungeon_spot_artifact_2",
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
				"objective_dungeon_spot_artifact_2"
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
				"time_since_objective_dungeon_spot_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_acquire_artifact_2",
		response = "pes_objective_dungeon_acquire_artifact_2",
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
				"objective_dungeon_acquire_artifact_2"
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
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_upward_tunnel",
		response = "pes_objective_dungeon_upward_tunnel",
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
				"objective_dungeon_upward_tunnel"
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
				"time_since_objective_dungeon_upward_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_upward_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_dungeon_olesya",
		response = "pes_objective_dungeon_olesya",
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
				"objective_dungeon_olesya"
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
				"time_since_objective_dungeon_olesya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_olesya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_chalice_rising",
		response = "pes_objective_castle_chalice_rising",
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
				"objective_castle_chalice_rising"
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
				"time_since_objective_castle_chalice_rising",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_rising",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_run",
		response = "pes_objective_castle_run",
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
				"objective_castle_run"
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
				"time_since_objective_castle_run",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_run",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_lever",
		response = "pes_objective_castle_lever",
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
				"objective_castle_lever_1"
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
				"time_since_objective_castle_lever_1",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_castle_closed_portcullis",
		response = "pes_objective_castle_closed_portcullis",
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
				"objective_castle_closed_portcullis"
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
				"time_since_objective_castle_closed_portcullis",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_closed_portcullis",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_arrive_first_portal",
		response = "pes_objective_portals_arrive_first_portal",
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
				"objective_portals_arrive_first_portal"
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
				"time_since_objective_portals_arrive_first_portal",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_arrive_first_portal",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_first_portal_instruction",
		response = "pes_objective_portals_first_portal_instruction",
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
				"objective_portals_first_portal_instruction"
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
				"time_since_objective_portals_first_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_first_portal_skaven_cooling",
		response = "pes_objective_portals_first_portal_skaven_cooling",
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
				"objective_portals_first_portal_skaven_cooling"
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
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMEDIFF,
				OP.GT,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_portal_overheat_near",
		response = "pes_objective_portals_portal_overheat_near",
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
				"objective_portals_portal_overheat_near"
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
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_overheat_failed",
		response = "pes_objective_portals_overheat_failed",
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
				"objective_portals_overheat_failed"
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
				"time_since_objective_portals_overheat_failed",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_failed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_overheat_successful",
		response = "pes_objective_portals_overheat_successful",
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
				"objective_portals_overheat_successful"
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
				"time_since_objective_portals_overheat_successful",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_successful",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_second_portal_instruction",
		response = "pes_objective_portals_second_portal_instruction",
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
				"objective_portals_second_portal_instruction"
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
				"time_since_objective_portals_second_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_second_portal_tips",
		response = "pes_objective_portals_second_portal_tips",
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
				"objective_portals_second_portal_tips"
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
				"time_since_objective_portals_second_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_third_portal_instruction",
		response = "pes_objective_portals_third_portal_instruction",
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
				"objective_portals_third_portal_instruction"
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
				"time_since_objective_portals_third_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_third_portal_tips",
		response = "pes_objective_portals_third_portal_tips",
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
				"objective_portals_third_portal_tips"
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
				"time_since_objective_portals_third_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_village",
		response = "pes_objective_portals_village",
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
				"objective_portals_village"
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
				"time_since_objective_portals_village",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_village",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_portals_mission_successful",
		response = "pes_objective_portals_mission_successful",
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
				"objective_portals_mission_successful"
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
				"time_since_objective_portals_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_spotting_sf_gear",
		response = "pes_objective_spotting_sf_gear",
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
				"objective_spotting_sf_gear"
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
				"time_since_objective_spotting_sf_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_sf_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_objective_spotting_pm_gear",
		response = "pes_objective_spotting_pm_gear",
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
				"objective_spotting_pm_gear"
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
				"time_since_objective_spotting_pm_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_pm_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "dlc_pm_pes_gameplay_seeing_a_pm",
		response = "dlc_pm_pes_gameplay_seeing_a_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_plague_monk",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_scr_pes_gameplay_seeing_a_scr",
		response = "dlc_scr_pes_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_plague_monk",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_pm_pes_gameplay_tips_pm",
		response = "dlc_pm_pes_gameplay_tips_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
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
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pes_gameplay_self_tag",
		name = "pes_gameplay_self_tag",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"target_name",
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
		name = "pes_gameplay_healing_draught",
		response = "pes_gameplay_healing_draught",
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
				"health"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_castle_intro",
		response = "pes_castle_intro",
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
				"objective_castle_intro"
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
				"time_since_castle_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_castle_intro_b",
		response = "pes_castle_intro_b",
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
				"castle_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_castle_intro_c",
		response = "pes_castle_intro_c",
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
				"castle_intro_b"
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
		name = "pes_dungeon_intro",
		response = "pes_dungeon_intro",
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
				"objective_dungeon_intro"
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
				"time_since_dungeon_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_dungeon_intro_b",
		response = "pes_dungeon_intro_b",
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
				"dungeon_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_dungeon_intro_c",
		response = "pes_dungeon_intro_c",
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
				"dungeon_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_portals_intro",
		response = "pes_portals_intro",
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
				"objective_portals_intro"
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
				"time_since_portals_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pes_portals_intro_b",
		response = "pes_portals_intro_b",
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
				"portals_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_portals_intro_c",
		response = "pes_portals_intro_c",
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
				"portals_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_castle_intro",
		response = "pwh_castle_intro",
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
				"objective_castle_intro"
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
				"time_since_castle_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_castle_intro_b",
		response = "pwh_castle_intro_b",
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
				"castle_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_castle_intro_c",
		response = "pwh_castle_intro_c",
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
				"castle_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
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
		name = "pwh_dungeon_intro",
		response = "pwh_dungeon_intro",
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
				"objective_dungeon_intro"
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
				"time_since_dungeon_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_dungeon_intro_b",
		response = "pwh_dungeon_intro_b",
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
				"dungeon_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_dungeon_intro_c",
		response = "pwh_dungeon_intro_c",
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
				"dungeon_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_portals_intro",
		response = "pwh_portals_intro",
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
				"objective_portals_intro"
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
				"time_since_portals_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_portals_intro_b",
		response = "pwh_portals_intro_b",
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
				"portals_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_portals_intro_c",
		response = "pwh_portals_intro_c",
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
				"portals_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_view",
		response = "pbw_objective_castle_view",
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
				"objective_castle_view"
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
		name = "pbw_objective_castle_broken_bridge",
		response = "pbw_objective_castle_broken_bridge",
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
				"objective_castle_broken_bridge"
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
				"time_since_objective_castle_broken_bridge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_broken_bridge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_skaven_entry",
		response = "pbw_objective_castle_skaven_entry",
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
				"objective_castle_skaven_entry"
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
				"time_since_objective_castle_skaven_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_skaven_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_catacombs_arrival",
		response = "pbw_objective_castle_catacombs_arrival",
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
				"objective_castle_catacombs_arrival"
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
				"time_since_objective_castle_catacombs_arrival",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_catacombs_arrival",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_blood_pool",
		response = "pbw_objective_castle_blood_pool",
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
				"objective_castle_blood_pool"
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
				"time_since_objective_castle_blood_pool",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_blood_pool",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_wood_door",
		response = "pbw_objective_castle_wood_door",
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
				"objective_castle_wood_door"
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
				"time_since_objective_castle_wood_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_wood_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_ballroom",
		response = "pbw_objective_castle_ballroom",
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
				"objective_castle_ballroom"
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
				"time_since_objective_castle_ballroom",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_ballroom",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_inner_sanctum",
		response = "pbw_objective_castle_inner_sanctum",
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
				"objective_castle_inner_sanctum"
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
				"time_since_objective_castle_inner_sanctum",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_inner_sanctum",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_statue",
		response = "pbw_objective_castle_statue",
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
				"objective_castle_statue"
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
				"time_since_objective_castle_statue",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_statue",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_placing_statuette",
		response = "pbw_objective_castle_placing_statuette",
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
				"objective_castle_placing_statuette"
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
				"time_since_objective_castle_placing_statuette",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_placing_statuette",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_chalice_acquired",
		response = "pbw_objective_castle_chalice_acquired",
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
				"objective_castle_chalice_acquired"
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
				"time_since_objective_castle_chalice_acquired",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_acquired",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_trap_door_activated",
		response = "pbw_objective_castle_trap_door_activated",
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
				"objective_castle_trap_door_activated"
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
				"time_since_objective_castle_trap_door_activated",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_trap_door_activated",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_lever_2",
		response = "pbw_objective_castle_lever_2",
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
				"objective_castle_lever_2"
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
				"time_since_objective_castle_lever_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_traps",
		response = "pbw_objective_castle_traps",
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
				"objective_castle_traps"
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
				"time_since_objective_castle_traps",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_traps",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_skaven_exit",
		response = "pbw_objective_skaven_exit",
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
				"objective_skaven_exit"
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
				"time_since_objective_skaven_exit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_skaven_exit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_escaped",
		response = "pbw_objective_castle_escaped",
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
				"objective_castle_escaped"
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
				"time_since_objective_castle_escaped",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_escaped",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_darkness_entry",
		response = "pbw_objective_dungeon_darkness_entry",
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
				"objective_dungeon_darkness_entry"
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
				"time_since_objective_dungeon_darkness_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_darkness_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_traps_warning",
		response = "pbw_objective_dungeon_traps_warning",
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
				"objective_dungeon_traps_warning"
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
				"time_since_objective_dungeon_traps_warning",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_traps_warning",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_traps_ally_hit",
		response = "pbw_objective_dungeon_traps_ally_hit",
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
				"objective_dungeon_traps_ally_hit"
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
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_jump_challenge",
		response = "pbw_objective_dungeon_jump_challenge",
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
				"objective_dungeon_jump_challenge"
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
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_spot_artifact_1",
		response = "pbw_objective_dungeon_spot_artifact_1",
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
				"objective_dungeon_spot_artifact_1"
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
				"time_since_objective_dungeon_spot_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_acquire_artifact_1",
		response = "pbw_objective_dungeon_acquire_artifact_1",
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
				"objective_dungeon_acquire_artifact_1"
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
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_outdoors_vista1",
		response = "pbw_objective_dungeon_outdoors_vista1",
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
				"objective_dungeon_outdoors_vista1"
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
				"time_since_objective_dungeon_outdoors_vista1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_outdoors_vista1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pbw_objective_dungeon_torch_1",
		name = "pbw_objective_dungeon_torch_1",
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
				"objective_dungeon_torch_1"
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
		name = "pbw_objective_dungeon_torture_racks",
		response = "pbw_objective_dungeon_torture_racks",
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
				"objective_dungeon_torture_racks"
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
				"time_since_objective_dungeon_torture_racks",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torture_racks",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_balance",
		response = "pbw_objective_dungeon_balance",
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
				"objective_dungeon_balance"
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
				"time_since_objective_dungeon_balance",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_balance",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_torch_2",
		response = "pbw_objective_dungeon_torch_2",
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
				"objective_dungeon_torch_2"
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
				"time_since_objective_dungeon_torch_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torch_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_spot_artifact_2",
		response = "pbw_objective_dungeon_spot_artifact_2",
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
				"objective_dungeon_spot_artifact_2"
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
				"time_since_objective_dungeon_spot_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_acquire_artifact_2",
		response = "pbw_objective_dungeon_acquire_artifact_2",
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
				"objective_dungeon_acquire_artifact_2"
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
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_upward_tunnel",
		response = "pbw_objective_dungeon_upward_tunnel",
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
				"objective_dungeon_upward_tunnel"
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
				"time_since_objective_dungeon_upward_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_upward_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_dungeon_olesya",
		response = "pbw_objective_dungeon_olesya",
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
				"objective_dungeon_olesya"
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
				"time_since_objective_dungeon_olesya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_olesya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_chalice_rising",
		response = "pbw_objective_castle_chalice_rising",
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
				"objective_castle_chalice_rising"
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
				"time_since_objective_castle_chalice_rising",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_rising",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_run",
		response = "pbw_objective_castle_run",
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
				"objective_castle_run"
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
				"time_since_objective_castle_run",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_run",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_lever",
		response = "pbw_objective_castle_lever",
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
				"objective_castle_lever_1"
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
				"time_since_objective_castle_lever_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_castle_closed_portcullis",
		response = "pbw_objective_castle_closed_portcullis",
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
				"objective_castle_closed_portcullis"
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
				"time_since_objective_castle_closed_portcullis",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_closed_portcullis",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_arrive_first_portal",
		response = "pbw_objective_portals_arrive_first_portal",
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
				"objective_portals_arrive_first_portal"
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
				"time_since_objective_portals_arrive_first_portal",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_arrive_first_portal",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_first_portal_instruction",
		response = "pbw_objective_portals_first_portal_instruction",
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
				"objective_portals_first_portal_instruction"
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
				"time_since_objective_portals_first_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_first_portal_skaven_cooling",
		response = "pbw_objective_portals_first_portal_skaven_cooling",
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
				"objective_portals_first_portal_skaven_cooling"
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
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMEDIFF,
				OP.GT,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_portal_overheat_near",
		response = "pbw_objective_portals_portal_overheat_near",
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
				"objective_portals_portal_overheat_near"
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
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_overheat_failed",
		response = "pbw_objective_portals_overheat_failed",
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
				"objective_portals_overheat_failed"
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
				"time_since_objective_portals_overheat_failed",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_failed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_overheat_successful",
		response = "pbw_objective_portals_overheat_successful",
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
				"objective_portals_overheat_successful"
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
				"time_since_objective_portals_overheat_successful",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_successful",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_unmarked_grave",
		response = "pbw_objective_portals_unmarked_grave",
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
				"objective_portals_unmarked_grave"
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
				"time_since_objective_portals_unmarked_grave",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_unmarked_grave",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_second_portal_instruction",
		response = "pbw_objective_portals_second_portal_instruction",
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
				"objective_portals_second_portal_instruction"
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
				"time_since_objective_portals_second_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_second_portal_tips",
		response = "pbw_objective_portals_second_portal_tips",
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
				"objective_portals_second_portal_tips"
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
				"time_since_objective_portals_second_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_third_portal_instruction",
		response = "pbw_objective_portals_third_portal_instruction",
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
				"objective_portals_third_portal_instruction"
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
				"time_since_objective_portals_third_portal_instruction",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_instruction",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_third_portal_tips",
		response = "pbw_objective_portals_third_portal_tips",
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
				"objective_portals_third_portal_tips"
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
				"time_since_objective_portals_third_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_village",
		response = "pbw_objective_portals_village",
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
				"objective_portals_village"
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
				"time_since_objective_portals_village",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_village",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_portals_mission_successful",
		response = "pbw_objective_portals_mission_successful",
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
				"objective_portals_mission_successful"
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
				"time_since_objective_portals_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_spotting_sf_gear",
		response = "pbw_objective_spotting_sf_gear",
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
				"objective_spotting_sf_gear"
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
				"time_since_objective_spotting_sf_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_sf_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_objective_spotting_pm_gear",
		response = "pbw_objective_spotting_pm_gear",
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
				"objective_spotting_pm_gear"
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
				"time_since_objective_spotting_pm_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_pm_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "dlc_pm_pbw_gameplay_seeing_a_pm",
		response = "dlc_pm_pbw_gameplay_seeing_a_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_plague_monk",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_scr_pbw_gameplay_seeing_a_scr",
		response = "dlc_scr_pbw_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_pm_pbw_gameplay_tips_pm",
		response = "dlc_pm_pbw_gameplay_tips_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
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
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pbw_gameplay_self_tag",
		name = "pbw_gameplay_self_tag",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"target_name",
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
		name = "pbw_gameplay_healing_draught",
		response = "pbw_gameplay_healing_draught",
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
				"health"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_view",
		response = "pdr_objective_castle_view",
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
				"objective_castle_view"
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
		name = "pdr_objective_castle_broken_bridge",
		response = "pdr_objective_castle_broken_bridge",
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
				"objective_castle_broken_bridge"
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
				"time_since_objective_castle_broken_bridge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_broken_bridge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_skaven_entry",
		response = "pdr_objective_castle_skaven_entry",
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
				"objective_castle_skaven_entry"
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
				"time_since_objective_castle_skaven_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_skaven_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_catacombs_arrival",
		response = "pdr_objective_castle_catacombs_arrival",
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
				"objective_castle_catacombs_arrival"
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
				"time_since_objective_castle_catacombs_arrival",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_catacombs_arrival",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_blood_pool",
		response = "pdr_objective_castle_blood_pool",
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
				"objective_castle_blood_pool"
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
				"time_since_objective_castle_blood_pool",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_blood_pool",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_wood_door",
		response = "pdr_objective_castle_wood_door",
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
				"objective_castle_wood_door"
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
				"time_since_objective_castle_wood_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_wood_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_ballroom",
		response = "pdr_objective_castle_ballroom",
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
				"objective_castle_ballroom"
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
				"time_since_objective_castle_ballroom",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_ballroom",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_inner_sanctum",
		response = "pdr_objective_castle_inner_sanctum",
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
				"objective_castle_inner_sanctum"
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
				"time_since_objective_castle_inner_sanctum",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_inner_sanctum",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_statue",
		response = "pdr_objective_castle_statue",
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
				"objective_castle_statue"
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
				"time_since_objective_castle_statue",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_statue",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_placing_statuette",
		response = "pdr_objective_castle_placing_statuette",
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
				"objective_castle_placing_statuette"
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
				"time_since_objective_castle_placing_statuette",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_placing_statuette",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_chalice_acquired",
		response = "pdr_objective_castle_chalice_acquired",
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
				"objective_castle_chalice_acquired"
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
				"time_since_objective_castle_chalice_acquired",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_acquired",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_trap_door_activated",
		response = "pdr_objective_castle_trap_door_activated",
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
				"objective_castle_trap_door_activated"
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
				"time_since_objective_castle_trap_door_activated",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_trap_door_activated",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_lever_2",
		response = "pdr_objective_castle_lever_2",
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
				"objective_castle_lever_2"
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
				"time_since_objective_castle_lever_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_traps",
		response = "pdr_objective_castle_traps",
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
				"objective_castle_traps"
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
				"time_since_objective_castle_traps",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_traps",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_skaven_exit",
		response = "pdr_objective_skaven_exit",
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
				"objective_skaven_exit"
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
				"time_since_objective_skaven_exit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_skaven_exit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_escaped",
		response = "pdr_objective_castle_escaped",
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
				"objective_castle_escaped"
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
				"time_since_objective_castle_escaped",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_escaped",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_darkness_entry",
		response = "pdr_objective_dungeon_darkness_entry",
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
				"objective_dungeon_darkness_entry"
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
				"time_since_objective_dungeon_darkness_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_darkness_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_traps_warning",
		response = "pdr_objective_dungeon_traps_warning",
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
				"objective_dungeon_traps_warning"
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
				"time_since_objective_dungeon_traps_warning",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_traps_warning",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_traps_ally_hit",
		response = "pdr_objective_dungeon_traps_ally_hit",
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
				"objective_dungeon_traps_ally_hit"
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
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_jump_challenge",
		response = "pdr_objective_dungeon_jump_challenge",
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
				"objective_dungeon_jump_challenge"
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
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_spot_artifact_1",
		response = "pdr_objective_dungeon_spot_artifact_1",
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
				"objective_dungeon_spot_artifact_1"
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
				"time_since_objective_dungeon_spot_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_acquire_artifact_1",
		response = "pdr_objective_dungeon_acquire_artifact_1",
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
				"objective_dungeon_acquire_artifact_1"
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
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_outdoors_vista1",
		response = "pdr_objective_dungeon_outdoors_vista1",
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
				"objective_dungeon_outdoors_vista1"
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
				"time_since_objective_dungeon_outdoors_vista1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_outdoors_vista1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pdr_objective_dungeon_torch_1",
		name = "pdr_objective_dungeon_torch_1",
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
				"objective_dungeon_torch_1"
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
		name = "pdr_objective_dungeon_torture_racks",
		response = "pdr_objective_dungeon_torture_racks",
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
				"objective_dungeon_torture_racks"
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
				"time_since_objective_dungeon_torture_racks",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torture_racks",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_balance",
		response = "pdr_objective_dungeon_balance",
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
				"objective_dungeon_balance"
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
				"time_since_objective_dungeon_balance",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_balance",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_torch_2",
		response = "pdr_objective_dungeon_torch_2",
		criterias = {
			{
				"query_context",
				"This forsaken darkness keeps following us around, dawri. ",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"objective_dungeon_torch_2"
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
				"time_since_objective_dungeon_torch_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torch_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_spot_artifact_2",
		response = "pdr_objective_dungeon_spot_artifact_2",
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
				"objective_dungeon_spot_artifact_2"
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
				"time_since_objective_dungeon_spot_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_acquire_artifact_2",
		response = "pdr_objective_dungeon_acquire_artifact_2",
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
				"objective_dungeon_acquire_artifact_2"
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
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_upward_tunnel",
		response = "pdr_objective_dungeon_upward_tunnel",
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
				"objective_dungeon_upward_tunnel"
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
				"time_since_objective_dungeon_upward_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_upward_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_dungeon_olesya",
		response = "pdr_objective_dungeon_olesya",
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
				"objective_dungeon_olesya"
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
				"time_since_objective_dungeon_olesya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_olesya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_run",
		response = "pdr_objective_castle_run",
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
				"objective_castle_run"
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
				"time_since_objective_castle_run",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_run",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_lever",
		response = "pdr_objective_castle_lever",
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
				"objective_castle_lever_1"
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
				"time_since_objective_castle_lever_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_closed_portcullis",
		response = "pdr_objective_castle_closed_portcullis",
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
				"objective_castle_closed_portcullis"
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
				"time_since_objective_castle_closed_portcullis",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_closed_portcullis",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_castle_chalice_rising",
		response = "pdr_objective_castle_chalice_rising",
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
				"objective_castle_chalice_rising"
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
				"time_since_objective_castle_chalice_rising",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_rising",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_arrive_first_portal",
		response = "pdr_objective_portals_arrive_first_portal",
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
				"objective_portals_arrive_first_portal"
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
				"time_since_objective_portals_arrive_first_portal",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_arrive_first_portal",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_first_portal_instruction",
		response = "pdr_objective_portals_first_portal_instruction",
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
				"objective_portals_first_portal_instruction"
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
				"time_since_objective_portals_first_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_first_portal_skaven_cooling",
		response = "pdr_objective_portals_first_portal_skaven_cooling",
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
				"objective_portals_first_portal_skaven_cooling"
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
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMEDIFF,
				OP.GT,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_portal_overheat_near",
		response = "pdr_objective_portals_portal_overheat_near",
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
				"objective_portals_portal_overheat_near"
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
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_overheat_failed",
		response = "pdr_objective_portals_overheat_failed",
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
				"objective_portals_overheat_failed"
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
				"time_since_objective_portals_overheat_failed",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_failed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_overheat_successful",
		response = "pdr_objective_portals_overheat_successful",
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
				"objective_portals_overheat_successful"
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
				"time_since_objective_portals_overheat_successful",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_successful",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_unmarked_grave",
		response = "pdr_objective_portals_unmarked_grave",
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
				"objective_portals_unmarked_grave"
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
				"time_since_objective_portals_unmarked_grave",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_unmarked_grave",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_second_portal_instruction",
		response = "pdr_objective_portals_second_portal_instruction",
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
				"objective_portals_second_portal_instruction"
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
				"time_since_objective_portals_second_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_second_portal_tips",
		response = "pdr_objective_portals_second_portal_tips",
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
				"objective_portals_second_portal_tips"
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
				"time_since_objective_portals_second_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_third_portal_instruction",
		response = "pdr_objective_portals_third_portal_instruction",
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
				"objective_portals_third_portal_instruction"
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
				"time_since_objective_portals_third_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_third_portal_tips",
		response = "pdr_objective_portals_third_portal_tips",
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
				"objective_portals_third_portal_tips"
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
				"time_since_objective_portals_third_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_village",
		response = "pdr_objective_portals_village",
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
				"objective_portals_village"
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
				"time_since_objective_portals_village",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_village",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_portals_mission_successful",
		response = "pdr_objective_portals_mission_successful",
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
				"objective_portals_mission_successful"
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
				"time_since_objective_portals_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_spotting_sf_gear",
		response = "pdr_objective_spotting_sf_gear",
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
				"objective_spotting_sf_gear"
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
				"time_since_objective_spotting_sf_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_sf_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_objective_spotting_pm_gear",
		response = "pdr_objective_spotting_pm_gear",
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
				"objective_spotting_pm_gear"
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
				"time_since_objective_spotting_pm_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_pm_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "dlc_pm_pdr_gameplay_seeing_a_pm",
		response = "dlc_pm_pdr_gameplay_seeing_a_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_plague_monk",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_scr_pdr_gameplay_seeing_a_scr",
		response = "dlc_scr_pdr_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_pm_pdr_gameplay_tips_pm",
		response = "dlc_pm_pdr_gameplay_tips_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
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
				"time_since_last_armor_hit",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_last_armor_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pdr_gameplay_self_tag",
		name = "pdr_gameplay_self_tag",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"armor_hit"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"target_name",
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
		name = "pdr_gameplay_healing_draught",
		response = "pdr_gameplay_healing_draught",
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
				"health"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"enemies_close",
				OP.EQ,
				0
			},
			{
				"query_context",
				"distance",
				OP.GT,
				1
			},
			{
				"query_context",
				"distance",
				OP.LT,
				25
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMEDIFF,
				OP.GT,
				60
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_saw_health",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_view",
		response = "pwe_objective_castle_view",
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
				"objective_castle_view"
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
		name = "pwe_objective_castle_broken_bridge",
		response = "pwe_objective_castle_broken_bridge",
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
				"objective_castle_broken_bridge"
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
				"time_since_objective_castle_broken_bridge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_broken_bridge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_skaven_entry",
		response = "pwe_objective_castle_skaven_entry",
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
				"objective_castle_skaven_entry"
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
				"time_since_objective_castle_skaven_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_skaven_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_catacombs_arrival",
		response = "pwe_objective_castle_catacombs_arrival",
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
				"objective_castle_catacombs_arrival"
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
				"time_since_objective_castle_catacombs_arrival",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_catacombs_arrival",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_blood_pool",
		response = "pwe_objective_castle_blood_pool",
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
				"objective_castle_blood_pool"
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
				"time_since_objective_castle_blood_pool",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_blood_pool",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_wood_door",
		response = "pwe_objective_castle_wood_door",
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
				"objective_castle_wood_door"
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
				"time_since_objective_castle_wood_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_wood_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_ballroom",
		response = "pwe_objective_castle_ballroom",
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
				"objective_castle_ballroom"
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
				"time_since_objective_castle_ballroom",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_ballroom",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_inner_sanctum",
		response = "pwe_objective_castle_inner_sanctum",
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
				"objective_castle_inner_sanctum"
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
				"time_since_objective_castle_inner_sanctum",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_inner_sanctum",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_statue",
		response = "pwe_objective_castle_statue",
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
				"objective_castle_statue"
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
				"time_since_objective_castle_statue",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_statue",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_placing_statuette",
		response = "pwe_objective_castle_placing_statuette",
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
				"objective_castle_placing_statuette"
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
				"time_since_objective_castle_placing_statuette",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_placing_statuette",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_chalice_acquired",
		response = "pwe_objective_castle_chalice_acquired",
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
				"objective_castle_chalice_acquired"
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
				"time_since_objective_castle_chalice_acquired",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_acquired",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_trap_door_activated",
		response = "pwe_objective_castle_trap_door_activated",
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
				"objective_castle_trap_door_activated"
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
				"time_since_objective_castle_trap_door_activated",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_trap_door_activated",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_lever_2",
		response = "pwe_objective_castle_lever_2",
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
				"objective_castle_lever_2"
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
				"time_since_objective_castle_lever_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_skaven_exit",
		response = "pwe_objective_skaven_exit",
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
				"objective_skaven_exit"
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
				"time_since_objective_skaven_exit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_skaven_exit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_escaped",
		response = "pwe_objective_castle_escaped",
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
				"objective_castle_escaped"
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
				"time_since_objective_castle_escaped",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_escaped",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_darkness_entry",
		response = "pwe_objective_dungeon_darkness_entry",
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
				"objective_dungeon_darkness_entry"
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
				"time_since_objective_dungeon_darkness_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_darkness_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_traps_warning",
		response = "pwe_objective_dungeon_traps_warning",
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
				"objective_dungeon_traps_warning"
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
				"time_since_objective_dungeon_traps_warning",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_traps_warning",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_traps_ally_hit",
		response = "pwe_objective_dungeon_traps_ally_hit",
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
				"objective_dungeon_traps_ally_hit"
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
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMEDIFF,
				OP.GT,
				10
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_jump_challenge",
		response = "pwe_objective_dungeon_jump_challenge",
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
				"objective_dungeon_jump_challenge"
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
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_spot_artifact_1",
		response = "pwe_objective_dungeon_spot_artifact_1",
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
				"objective_dungeon_spot_artifact_1"
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
				"time_since_objective_dungeon_spot_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_acquire_artifact_1",
		response = "pwe_objective_dungeon_acquire_artifact_1",
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
				"objective_dungeon_acquire_artifact_1"
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
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_outdoors_vista1",
		response = "pwe_objective_dungeon_outdoors_vista1",
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
				"objective_dungeon_outdoors_vista1"
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
				"time_since_objective_dungeon_outdoors_vista1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_outdoors_vista1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwe_objective_dungeon_torch_1",
		name = "pwe_objective_dungeon_torch_1",
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
				"objective_dungeon_torch_1"
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
		name = "pwe_objective_dungeon_torture_racks",
		response = "pwe_objective_dungeon_torture_racks",
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
				"objective_dungeon_torture_racks"
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
				"time_since_objective_dungeon_torture_racks",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torture_racks",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_balance",
		response = "pwe_objective_dungeon_balance",
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
				"objective_dungeon_balance"
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
				"time_since_objective_dungeon_balance",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_balance",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_torch_2",
		response = "pwe_objective_dungeon_torch_2",
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
				"objective_dungeon_torch_2"
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
				"time_since_objective_dungeon_torch_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torch_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_spot_artifact_2",
		response = "pwe_objective_dungeon_spot_artifact_2",
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
				"objective_dungeon_spot_artifact_2"
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
				"time_since_objective_dungeon_spot_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_acquire_artifact_2",
		response = "pwe_objective_dungeon_acquire_artifact_2",
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
				"objective_dungeon_acquire_artifact_2"
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
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_upward_tunnel",
		response = "pwe_objective_dungeon_upward_tunnel",
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
				"objective_dungeon_upward_tunnel"
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
				"time_since_objective_dungeon_upward_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_upward_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_dungeon_olesya",
		response = "pwe_objective_dungeon_olesya",
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
				"objective_dungeon_olesya"
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
				"time_since_objective_dungeon_olesya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_olesya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_chalice_rising",
		response = "pwe_objective_castle_chalice_rising",
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
				"objective_castle_chalice_rising"
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
				"time_since_objective_castle_chalice_rising",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_rising",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_run",
		response = "pwe_objective_castle_run",
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
				"objective_castle_run"
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
				"time_since_objective_castle_run",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_run",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_lever",
		response = "pwe_objective_castle_lever",
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
				"objective_castle_lever_1"
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
				"time_since_objective_castle_lever_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_castle_closed_portcullis",
		response = "pwe_objective_castle_closed_portcullis",
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
				"objective_castle_closed_portcullis"
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
				"time_since_objective_castle_closed_portcullis",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_closed_portcullis",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_arrive_first_portal",
		response = "pwe_objective_portals_arrive_first_portal",
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
				"objective_portals_arrive_first_portal"
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
				"time_since_objective_portals_arrive_first_portal",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_arrive_first_portal",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_first_portal_instruction",
		response = "pwe_objective_portals_first_portal_instruction",
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
				"objective_portals_first_portal_instruction"
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
				"time_since_objective_portals_first_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_first_portal_skaven_cooling",
		response = "pwe_objective_portals_first_portal_skaven_cooling",
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
				"objective_portals_first_portal_skaven_cooling"
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
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMEDIFF,
				OP.GT,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_portal_overheat_near",
		response = "pwe_objective_portals_portal_overheat_near",
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
				"objective_portals_portal_overheat_near"
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
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_overheat_failed",
		response = "pwe_objective_portals_overheat_failed",
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
				"objective_portals_overheat_failed"
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
				"time_since_objective_portals_overheat_failed",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_failed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_overheat_successful",
		response = "pwe_objective_portals_overheat_successful",
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
				"objective_portals_overheat_successful"
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
				"time_since_objective_portals_overheat_successful",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_successful",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_unmarked_grave",
		response = "pwe_objective_portals_unmarked_grave",
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
				"objective_portals_unmarked_grave"
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
				"time_since_objective_portals_unmarked_grave",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_unmarked_grave",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_second_portal_instruction",
		response = "pwe_objective_portals_second_portal_instruction",
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
				"objective_portals_second_portal_instruction"
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
				"time_since_objective_portals_second_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_second_portal_tips",
		response = "pwe_objective_portals_second_portal_tips",
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
				"objective_portals_second_portal_tips"
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
				"time_since_objective_portals_second_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_third_portal_instruction",
		response = "pwe_objective_portals_third_portal_instruction",
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
				"objective_portals_third_portal_instruction"
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
				"time_since_objective_portals_third_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_third_portal_tips",
		response = "pwe_objective_portals_third_portal_tips",
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
				"objective_portals_third_portal_tips"
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
				"time_since_objective_portals_third_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_portals_mission_successful",
		response = "pwe_objective_portals_mission_successful",
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
				"objective_portals_mission_successful"
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
				"time_since_objective_portals_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_spotting_sf_gear",
		response = "pwe_objective_spotting_sf_gear",
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
				"objective_spotting_sf_gear"
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
				"time_since_objective_spotting_sf_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_sf_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_objective_spotting_pm_gear",
		response = "pwe_objective_spotting_pm_gear",
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
				"objective_spotting_pm_gear"
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
				"time_since_objective_spotting_pm_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_pm_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "dlc_pm_pwe_gameplay_seeing_a_pm",
		name = "dlc_pm_pwe_gameplay_seeing_a_pm",
		criterias = {}
	})
	define_rule({
		response = "dlc_scr_pwe_gameplay_seeing_a_scr",
		name = "dlc_scr_pwe_gameplay_seeing_a_scr",
		criterias = {}
	})
	define_rule({
		response = "dlc_pm_pwe_gameplay_hearing_a_pm",
		name = "dlc_pm_pwe_gameplay_hearing_a_pm",
		criterias = {}
	})
	define_rule({
		response = "dlc_pm_pwe_gameplay_hearing_a_pm_in_combat",
		name = "dlc_pm_pwe_gameplay_hearing_a_pm_in_combat",
		criterias = {}
	})
	define_rule({
		response = "dlc_pm_pwe_gameplay_tips_pm",
		name = "dlc_pm_pwe_gameplay_tips_pm",
		criterias = {}
	})
	define_rule({
		response = "pwe_gameplay_self_tag",
		name = "pwe_gameplay_self_tag",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"self_tag"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"target_name",
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
		response = "pwe_gameplay_healing_draught",
		name = "pwe_gameplay_healing_draught",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"health"
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
		name = "pwh_objective_castle_view",
		response = "pwh_objective_castle_view",
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
				"objective_castle_view"
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
		name = "pwh_objective_castle_broken_bridge",
		response = "pwh_objective_castle_broken_bridge",
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
				"objective_castle_broken_bridge"
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
				"time_since_objective_castle_broken_bridge",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_broken_bridge",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_skaven_entry",
		response = "pwh_objective_castle_skaven_entry",
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
				"objective_castle_skaven_entry"
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
				"time_since_objective_castle_skaven_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_skaven_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_catacombs_arrival",
		response = "pwh_objective_castle_catacombs_arrival",
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
				"objective_castle_catacombs_arrival"
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
				"time_since_objective_castle_catacombs_arrival",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_catacombs_arrival",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_blood_pool",
		response = "pwh_objective_castle_blood_pool",
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
				"objective_castle_blood_pool"
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
				"time_since_objective_castle_blood_pool",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_blood_pool",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_wood_door",
		response = "pwh_objective_castle_wood_door",
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
				"objective_castle_wood_door"
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
				"time_since_objective_castle_wood_door",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_wood_door",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_ballroom",
		response = "pwh_objective_castle_ballroom",
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
				"objective_castle_ballroom"
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
				"time_since_objective_castle_ballroom",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_ballroom",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_inner_sanctum",
		response = "pwh_objective_castle_inner_sanctum",
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
				"objective_castle_inner_sanctum"
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
				"time_since_objective_castle_inner_sanctum",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_inner_sanctum",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_statue",
		response = "pwh_objective_castle_statue",
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
				"objective_castle_statue"
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
				"time_since_objective_castle_statue",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_statue",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_placing_statuette",
		response = "pwh_objective_castle_placing_statuette",
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
				"objective_castle_placing_statuette"
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
				"time_since_objective_castle_placing_statuette",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_placing_statuette",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_chalice_acquired",
		response = "pwh_objective_castle_chalice_acquired",
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
				"objective_castle_chalice_acquired"
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
				"time_since_objective_castle_chalice_acquired",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_acquired",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_trap_door_activated",
		response = "pwh_objective_castle_trap_door_activated",
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
				"objective_castle_trap_door_activated"
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
				"time_since_objective_castle_trap_door_activated",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_trap_door_activated",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_lever_2",
		response = "pwh_objective_castle_lever_2",
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
				"objective_castle_lever_2"
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
				"time_since_objective_castle_lever_2",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_skaven_exit",
		response = "pwh_objective_skaven_exit",
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
				"objective_skaven_exit"
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
				"time_since_objective_skaven_exit",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_skaven_exit",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_escaped",
		response = "pwh_objective_castle_escaped",
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
				"objective_castle_escaped"
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
				"time_since_objective_castle_escaped",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_escaped",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_darkness_entry",
		response = "pwh_objective_dungeon_darkness_entry",
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
				"objective_dungeon_darkness_entry"
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
				"time_since_objective_dungeon_darkness_entry",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_darkness_entry",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_traps_warning",
		response = "pwh_objective_dungeon_traps_warning",
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
				"objective_dungeon_traps_warning"
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
				"time_since_objective_dungeon_traps_warning",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_traps_warning",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_traps_ally_hit",
		response = "pwh_objective_dungeon_traps_ally_hit",
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
				"objective_dungeon_traps_ally_hit"
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
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_raps_ally_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_jump_challenge",
		response = "pwh_objective_dungeon_jump_challenge",
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
				"objective_dungeon_jump_challenge"
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
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMEDIFF,
				OP.GT,
				20
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_jump_challenge",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_spot_artifact_1",
		response = "pwh_objective_dungeon_spot_artifact_1",
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
				"objective_dungeon_spot_artifact_1"
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
				"time_since_objective_dungeon_spot_artifact_1",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_1",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_acquire_artifact_1",
		response = "pwh_objective_dungeon_acquire_artifact_1",
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
				"objective_dungeon_acquire_artifact_1"
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
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_outdoors_vista1",
		response = "pwh_objective_dungeon_outdoors_vista1",
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
				"objective_dungeon_outdoors_vista1"
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
				"time_since_objective_dungeon_outdoors_vista1",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_outdoors_vista1",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		response = "pwh_objective_dungeon_torch_1",
		name = "pwh_objective_dungeon_torch_1",
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
				"objective_dungeon_torch_1"
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
		name = "pwh_objective_dungeon_torture_racks",
		response = "pwh_objective_dungeon_torture_racks",
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
				"objective_dungeon_torture_racks"
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
				"time_since_objective_dungeon_torture_racks",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torture_racks",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_balance",
		response = "pwh_objective_dungeon_balance",
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
				"objective_dungeon_balance"
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
				"time_since_objective_dungeon_balance",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_balance",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_torch_2",
		response = "pwh_objective_dungeon_torch_2",
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
				"objective_dungeon_torch_2"
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
				"time_since_objective_dungeon_torch_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_torch_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_spot_artifact_2",
		response = "pwh_objective_dungeon_spot_artifact_2",
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
				"objective_dungeon_spot_artifact_2"
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
				"time_since_objective_dungeon_spot_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_spot_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_acquire_artifact_2",
		response = "pwh_objective_dungeon_acquire_artifact_2",
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
				"objective_dungeon_acquire_artifact_2"
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
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_acquire_artifact_2",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_upward_tunnel",
		response = "pwh_objective_dungeon_upward_tunnel",
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
				"objective_dungeon_upward_tunnel"
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
				"time_since_objective_dungeon_upward_tunnel",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_upward_tunnel",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_dungeon_olesya",
		response = "pwh_objective_dungeon_olesya",
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
				"objective_dungeon_olesya"
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
				"time_since_objective_dungeon_olesya",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_dungeon_olesya",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_chalice_rising",
		response = "pwh_objective_castle_chalice_rising",
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
				"objective_castle_chalice_rising"
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
				"time_since_objective_castle_chalice_rising",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_chalice_rising",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_run",
		response = "pwh_objective_castle_run",
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
				"objective_castle_run"
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
				"time_since_objective_castle_run",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_run",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_lever",
		response = "pwh_objective_castle_lever",
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
				"objective_castle_lever_1"
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
				"time_since_objective_castle_lever_1",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_lever_2",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_castle_closed_portcullis",
		response = "pwh_objective_castle_closed_portcullis",
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
				"objective_castle_closed_portcullis"
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
				"time_since_objective_castle_closed_portcullis",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_castle_closed_portcullis",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_arrive_first_portal",
		response = "pwh_objective_portals_arrive_first_portal",
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
				"objective_portals_arrive_first_portal"
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
				"time_since_objective_portals_arrive_first_portal",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_arrive_first_portal",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_first_portal_instruction",
		response = "pwh_objective_portals_first_portal_instruction",
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
				"objective_portals_first_portal_instruction"
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
				"time_since_objective_portals_first_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_first_portal_skaven_cooling",
		response = "pwh_objective_portals_first_portal_skaven_cooling",
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
				"objective_portals_first_portal_skaven_cooling"
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
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMEDIFF,
				OP.GT,
				4
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_first_portal_skaven_cooling",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_portal_overheat_near",
		response = "pwh_objective_portals_portal_overheat_near",
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
				"objective_portals_portal_overheat_near"
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
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_portal_overheat_near",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_overheat_failed",
		response = "pwh_objective_portals_overheat_failed",
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
				"objective_portals_overheat_failed"
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
				"time_since_objective_portals_overheat_failed",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_failed",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_overheat_successful",
		response = "pwh_objective_portals_overheat_successful",
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
				"objective_portals_overheat_successful"
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
				"time_since_objective_portals_overheat_successful",
				OP.TIMEDIFF,
				OP.GT,
				2
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_overheat_successful",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_unmarked_grave",
		response = "pwh_objective_portals_unmarked_grave",
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
				"objective_portals_unmarked_grave"
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
				"time_since_objective_portals_unmarked_grave",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_unmarked_grave",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_second_portal_instruction",
		response = "pwh_objective_portals_second_portal_instruction",
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
				"objective_portals_second_portal_instruction"
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
				"time_since_objective_portals_second_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_second_portal_tips",
		response = "pwh_objective_portals_second_portal_tips",
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
				"objective_portals_second_portal_tips"
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
				"time_since_objective_portals_second_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_second_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_third_portal_instruction",
		response = "pwh_objective_portals_third_portal_instruction",
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
				"objective_portals_third_portal_instruction"
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
				"time_since_objective_portals_third_portal_instruction",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_instruction",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_third_portal_tips",
		response = "pwh_objective_portals_third_portal_tips",
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
				"objective_portals_third_portal_tips"
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
				"time_since_objective_portals_third_portal_tips",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_third_portal_tips",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_mission_successful",
		response = "pwh_objective_portals_mission_successful",
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
				"objective_portals_mission_successful"
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
				"time_since_objective_portals_mission_successful",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_mission_successful",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_portals_village",
		response = "pwh_objective_portals_village",
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
				"objective_portals_village"
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
				"time_since_objective_portals_village",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_portals_village",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_spotting_sf_gear",
		response = "pwh_objective_spotting_sf_gear",
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
				"objective_spotting_sf_gear"
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
				"time_since_objective_spotting_sf_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_sf_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwh_objective_spotting_pm_gear",
		response = "pwh_objective_spotting_pm_gear",
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
				"objective_spotting_pm_gear"
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
				"time_since_objective_spotting_pm_gear",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_objective_spotting_pm_gear",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "dlc_pm_pwh_gameplay_seeing_a_pm",
		response = "dlc_pm_pwh_gameplay_seeing_a_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"query_context",
				"distance",
				OP.GTEQ,
				4
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
				"last_seen_skaven_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_skaven_plague_monk",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_scr_pwh_gameplay_seeing_a_scr",
		response = "dlc_scr_pwh_gameplay_seeing_a_scr",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_clan_rat_shield"
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
				"last_seen_",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_seen_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_pm_pwh_gameplay_hearing_a_pm",
		response = "dlc_pm_pwh_gameplay_hearing_a_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"user_context",
				"enemies_close",
				OP.EQ,
				0
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
				"last_seen_globadier",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_pm_pwh_gameplay_hearing_a_pm_in_combat",
		response = "dlc_pm_pwh_gameplay_hearing_a_pm_in_combat",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"heard_enemy"
			},
			{
				"query_context",
				"enemy_tag",
				OP.EQ,
				"skaven_plague_monk"
			},
			{
				"user_context",
				"enemies_close",
				OP.GT,
				0
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
				"last_seen_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				10
			},
			{
				"faction_memory",
				"last_heard_plague_monk",
				OP.TIMEDIFF,
				OP.GT,
				30
			}
		},
		on_done = {
			{
				"faction_memory",
				"last_heard_plague_monk",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "dlc_pm_pwh_gameplay_tips_pm",
		response = "dlc_pm_pwh_gameplay_tips_pm",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"enemy_attack"
			},
			{
				"query_context",
				"attack_tag",
				OP.EQ,
				"pm_attack"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"faction_memory",
				"pm_attack",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"faction_memory",
				"pm_attack",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pwh_gameplay_self_tag",
		name = "pwh_gameplay_self_tag",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"self_tag"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"target_name",
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
		response = "pwh_gameplay_healing_draught",
		name = "pwh_gameplay_healing_draught",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"is_ping",
				OP.EQ,
				1
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"health"
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
		name = "pwe_castle_intro",
		response = "pwe_castle_intro",
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
				"objective_castle_intro"
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
				"time_since_castle_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_castle_intro_b",
		response = "pwe_castle_intro_b",
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
				"castle_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_castle_intro_c",
		response = "pwe_castle_intro_c",
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
				"castle_intro_b"
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
		name = "pwe_dungeon_intro",
		response = "pwe_dungeon_intro",
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
				"objective_dungeon_intro"
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
				"time_since_dungeon_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_dungeon_intro_b",
		response = "pwe_dungeon_intro_b",
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
				"dungeon_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_dungeon_intro_c",
		response = "pwe_dungeon_intro_c",
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
				"dungeon_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_portals_intro",
		response = "pwe_portals_intro",
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
				"objective_portals_intro"
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
				"time_since_portals_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pwe_portals_intro_b",
		response = "pwe_portals_intro_b",
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
				"portals_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_portals_intro_c",
		response = "pwe_portals_intro_c",
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
				"portals_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_castle_intro",
		response = "pbw_castle_intro",
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
				"objective_castle_intro"
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
				"time_since_castle_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_castle_intro_b",
		response = "pbw_castle_intro_b",
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
				"castle_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_castle_intro_c",
		response = "pbw_castle_intro_c",
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
				"castle_intro_b"
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
		name = "pbw_dungeon_intro",
		response = "pbw_dungeon_intro",
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
				"objective_dungeon_intro"
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
				"time_since_dungeon_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_dungeon_intro_b",
		response = "pbw_dungeon_intro_b",
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
				"dungeon_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_dungeon_intro_c",
		response = "pbw_dungeon_intro_c",
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
				"dungeon_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_portals_intro",
		response = "pbw_portals_intro",
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
				"objective_portals_intro"
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
				"time_since_portals_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pbw_portals_intro_b",
		response = "pbw_portals_intro_b",
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
				"portals_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_portals_intro_c",
		response = "pbw_portals_intro_c",
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
				"portals_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_castle_intro",
		response = "pdr_castle_intro",
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
				"objective_castle_intro"
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
				"time_since_castle_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_castle_intro_b",
		response = "pdr_castle_intro_b",
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
				"castle_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_castle_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_castle_intro_c",
		response = "pdr_castle_intro_c",
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
				"castle_intro_b"
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
		name = "pdr_dungeon_intro",
		response = "pdr_dungeon_intro",
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
				"objective_dungeon_intro"
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
				"time_since_dungeon_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_dungeon_intro_b",
		response = "pdr_dungeon_intro_b",
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
				"dungeon_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_dungeon_intro_c",
		response = "pdr_dungeon_intro_c",
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
				"dungeon_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_dungeon_intro_c",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_portals_intro",
		response = "pdr_portals_intro",
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
				"objective_portals_intro"
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
				"time_since_portals_intro",
				OP.EQ,
				0
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro",
				OP.ADD,
				1
			}
		}
	})
	define_rule({
		name = "pdr_portals_intro_b",
		response = "pdr_portals_intro_b",
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
				"portals_intro"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_b",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_portals_intro_c",
		response = "pdr_portals_intro_c",
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
				"portals_intro_b"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMEDIFF,
				OP.GT,
				1
			}
		},
		on_done = {
			{
				"faction_memory",
				"time_since_portals_intro_c",
				OP.TIMESET
			}
		}
	})
	add_dialogues({
		pwe_objective_spotting_pm_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_spotting_pm_gear_01",
				[2.0] = "pwe_objective_spotting_pm_gear_02"
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
				[1.0] = "pwe_objective_spotting_pm_gear_01",
				[2.0] = "pwe_objective_spotting_pm_gear_02"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwe_gameplay_seeing_a_pm = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "default",
			dialogue_animations_n = 8,
			sound_events = {
				"dlc_pm_pwe_gameplay_seeing_a_pm_01",
				"dlc_pm_pwe_gameplay_seeing_a_pm_02",
				"dlc_pm_pwe_gameplay_seeing_a_pm_03",
				"dlc_pm_pwe_gameplay_seeing_a_pm_04",
				"dlc_pm_pwe_gameplay_seeing_a_pm_05",
				"dlc_pm_pwe_gameplay_seeing_a_pm_06",
				"dlc_pm_pwe_gameplay_seeing_a_pm_07",
				"dlc_pm_pwe_gameplay_seeing_a_pm_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"dlc_pm_pwe_gameplay_seeing_a_pm_01",
				"dlc_pm_pwe_gameplay_seeing_a_pm_02",
				"dlc_pm_pwe_gameplay_seeing_a_pm_03",
				"dlc_pm_pwe_gameplay_seeing_a_pm_04",
				"dlc_pm_pwe_gameplay_seeing_a_pm_05",
				"dlc_pm_pwe_gameplay_seeing_a_pm_06",
				"dlc_pm_pwe_gameplay_seeing_a_pm_07",
				"dlc_pm_pwe_gameplay_seeing_a_pm_08"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_unmarked_grave = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_portals_unmarked_grave_01",
				[2.0] = "pwe_objective_portals_unmarked_grave_02"
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
				[1.0] = "pwe_objective_portals_unmarked_grave_01",
				[2.0] = "pwe_objective_portals_unmarked_grave_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_view = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_view_01",
				"pbw_objective_castle_view_02",
				"pbw_objective_castle_view_03",
				"pbw_objective_castle_view_04"
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
				"pbw_objective_castle_view_01",
				"pbw_objective_castle_view_02",
				"pbw_objective_castle_view_03",
				"pbw_objective_castle_view_04"
			},
			randomize_indexes = {}
		},
		pes_objective_spotting_sf_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_spotting_sf_gear_01",
				[2.0] = "pes_objective_spotting_sf_gear_02"
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
				[1.0] = "pes_objective_spotting_sf_gear_01",
				[2.0] = "pes_objective_spotting_sf_gear_02"
			},
			randomize_indexes = {}
		},
		pwh_portals_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_portals_intro_a_01",
				[2.0] = "pwh_portals_intro_a_02"
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
				[1.0] = "pwh_portals_intro_a_01",
				[2.0] = "pwh_portals_intro_a_02"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwh_gameplay_tips_pm = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "player_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_pm_pwh_gameplay_tips_pm_01",
				"dlc_pm_pwh_gameplay_tips_pm_02",
				"dlc_pm_pwh_gameplay_tips_pm_03",
				"dlc_pm_pwh_gameplay_tips_pm_04",
				"dlc_pm_pwh_gameplay_tips_pm_05",
				"dlc_pm_pwh_gameplay_tips_pm_06",
				"dlc_pm_pwh_gameplay_tips_pm_07"
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
				"face_contempt",
				"face_fear",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"dlc_pm_pwh_gameplay_tips_pm_01",
				"dlc_pm_pwh_gameplay_tips_pm_02",
				"dlc_pm_pwh_gameplay_tips_pm_03",
				"dlc_pm_pwh_gameplay_tips_pm_04",
				"dlc_pm_pwh_gameplay_tips_pm_05",
				"dlc_pm_pwh_gameplay_tips_pm_06",
				"dlc_pm_pwh_gameplay_tips_pm_07"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_lever = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_lever_01",
				"pes_objective_castle_lever_02",
				"pes_objective_castle_lever_03",
				"pes_objective_castle_lever_04"
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
				"pes_objective_castle_lever_01",
				"pes_objective_castle_lever_02",
				"pes_objective_castle_lever_03",
				"pes_objective_castle_lever_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_inner_sanctum = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_inner_sanctum_01",
				"pwe_objective_castle_inner_sanctum_02",
				"pwe_objective_castle_inner_sanctum_03",
				"pwe_objective_castle_inner_sanctum_04"
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
				"pwe_objective_castle_inner_sanctum_01",
				"pwe_objective_castle_inner_sanctum_02",
				"pwe_objective_castle_inner_sanctum_03",
				"pwe_objective_castle_inner_sanctum_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_jump_challenge = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_objective_dungeon_jump_challenge_01",
				"pdr_objective_dungeon_jump_challenge_02",
				"pdr_objective_dungeon_jump_challenge_03"
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
				"pdr_objective_dungeon_jump_challenge_01",
				"pdr_objective_dungeon_jump_challenge_02",
				"pdr_objective_dungeon_jump_challenge_03"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_jump_challenge = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_dungeon_jump_challenge_01",
				"pes_objective_dungeon_jump_challenge_02",
				"pes_objective_dungeon_jump_challenge_03"
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
				"pes_objective_dungeon_jump_challenge_01",
				"pes_objective_dungeon_jump_challenge_02",
				"pes_objective_dungeon_jump_challenge_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_closed_portcullis = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_closed_portcullis_01",
				"pdr_objective_castle_closed_portcullis_02",
				"pdr_objective_castle_closed_portcullis_03",
				"pdr_objective_castle_closed_portcullis_04"
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
				"pdr_objective_castle_closed_portcullis_01",
				"pdr_objective_castle_closed_portcullis_02",
				"pdr_objective_castle_closed_portcullis_03",
				"pdr_objective_castle_closed_portcullis_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_closed_portcullis = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_closed_portcullis_01",
				"pes_objective_castle_closed_portcullis_02",
				"pes_objective_castle_closed_portcullis_03",
				"pes_objective_castle_closed_portcullis_04"
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
				"pes_objective_castle_closed_portcullis_01",
				"pes_objective_castle_closed_portcullis_02",
				"pes_objective_castle_closed_portcullis_03",
				"pes_objective_castle_closed_portcullis_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwh_gameplay_seeing_a_pm = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"dlc_pm_pwh_gameplay_seeing_a_pm_01",
				"dlc_pm_pwh_gameplay_seeing_a_pm_02",
				"dlc_pm_pwh_gameplay_seeing_a_pm_03",
				"dlc_pm_pwh_gameplay_seeing_a_pm_04",
				"dlc_pm_pwh_gameplay_seeing_a_pm_05",
				"dlc_pm_pwh_gameplay_seeing_a_pm_06",
				"dlc_pm_pwh_gameplay_seeing_a_pm_07",
				"dlc_pm_pwh_gameplay_seeing_a_pm_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"dlc_pm_pwh_gameplay_seeing_a_pm_01",
				"dlc_pm_pwh_gameplay_seeing_a_pm_02",
				"dlc_pm_pwh_gameplay_seeing_a_pm_03",
				"dlc_pm_pwh_gameplay_seeing_a_pm_04",
				"dlc_pm_pwh_gameplay_seeing_a_pm_05",
				"dlc_pm_pwh_gameplay_seeing_a_pm_06",
				"dlc_pm_pwh_gameplay_seeing_a_pm_07",
				"dlc_pm_pwh_gameplay_seeing_a_pm_08"
			},
			randomize_indexes = {}
		},
		pwh_dungeon_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_dungeon_intro_b_01",
				[2.0] = "pwh_dungeon_intro_b_02"
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
				[1.0] = "pwh_dungeon_intro_b_01",
				[2.0] = "pwh_dungeon_intro_b_02"
			},
			randomize_indexes = {}
		},
		dlc_scr_pbw_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_scr_pbw_gameplay_seeing_a_scr_01",
				"dlc_scr_pbw_gameplay_seeing_a_scr_02",
				"dlc_scr_pbw_gameplay_seeing_a_scr_03",
				"dlc_scr_pbw_gameplay_seeing_a_scr_04",
				"dlc_scr_pbw_gameplay_seeing_a_scr_05",
				"dlc_scr_pbw_gameplay_seeing_a_scr_06",
				"dlc_scr_pbw_gameplay_seeing_a_scr_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"dlc_scr_pbw_gameplay_seeing_a_scr_01",
				"dlc_scr_pbw_gameplay_seeing_a_scr_02",
				"dlc_scr_pbw_gameplay_seeing_a_scr_03",
				"dlc_scr_pbw_gameplay_seeing_a_scr_04",
				"dlc_scr_pbw_gameplay_seeing_a_scr_05",
				"dlc_scr_pbw_gameplay_seeing_a_scr_06",
				"dlc_scr_pbw_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_closed_portcullis = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_closed_portcullis_01",
				"pbw_objective_castle_closed_portcullis_02",
				"pbw_objective_castle_closed_portcullis_03",
				"pbw_objective_castle_closed_portcullis_04"
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
				"pbw_objective_castle_closed_portcullis_01",
				"pbw_objective_castle_closed_portcullis_02",
				"pbw_objective_castle_closed_portcullis_03",
				"pbw_objective_castle_closed_portcullis_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pdr_gameplay_tips_pm = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"dlc_pm_pdr_gameplay_tips_pm_01",
				"dlc_pm_pdr_gameplay_tips_pm_02",
				"dlc_pm_pdr_gameplay_tips_pm_03",
				"dlc_pm_pdr_gameplay_tips_pm_04",
				"dlc_pm_pdr_gameplay_tips_pm_05",
				"dlc_pm_pdr_gameplay_tips_pm_06"
			},
			dialogue_animations = {
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
				"face_neutral"
			},
			localization_strings = {
				"dlc_pm_pdr_gameplay_tips_pm_01",
				"dlc_pm_pdr_gameplay_tips_pm_02",
				"dlc_pm_pdr_gameplay_tips_pm_03",
				"dlc_pm_pdr_gameplay_tips_pm_04",
				"dlc_pm_pdr_gameplay_tips_pm_05",
				"dlc_pm_pdr_gameplay_tips_pm_06"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_outdoors_vista1 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pwe_objective_dungeon_outdoors_vista1_02"
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
				[1.0] = "pwe_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pwe_objective_dungeon_outdoors_vista1_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_arrive_first_portal = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_arrive_first_portal_01",
				"pwe_objective_portals_arrive_first_portal_02",
				"pwe_objective_portals_arrive_first_portal_03",
				"pwe_objective_portals_arrive_first_portal_04"
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
				"pwe_objective_portals_arrive_first_portal_01",
				"pwe_objective_portals_arrive_first_portal_02",
				"pwe_objective_portals_arrive_first_portal_03",
				"pwe_objective_portals_arrive_first_portal_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_arrive_first_portal = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_portals_arrive_first_portal_01",
				[2.0] = "pwh_objective_portals_arrive_first_portal_03"
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
				[1.0] = "pwh_objective_portals_arrive_first_portal_01",
				[2.0] = "pwh_objective_portals_arrive_first_portal_03"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_jump_challenge = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 3,
			sound_events = {
				"pbw_objective_dungeon_jump_challenge_01",
				"pbw_objective_dungeon_jump_challenge_02",
				"pbw_objective_dungeon_jump_challenge_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_dungeon_jump_challenge_01",
				"pbw_objective_dungeon_jump_challenge_02",
				"pbw_objective_dungeon_jump_challenge_03"
			},
			randomize_indexes = {}
		},
		nik_loading_screen_castle = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_loading_screen_castle_b_01",
				[2.0] = "nik_loading_screen_castle_b_02"
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
				[1.0] = "nik_loading_screen_castle_b_01",
				[2.0] = "nik_loading_screen_castle_b_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_arrive_first_portal = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_arrive_first_portal_01",
				"pdr_objective_portals_arrive_first_portal_02",
				"pdr_objective_portals_arrive_first_portal_03",
				"pdr_objective_portals_arrive_first_portal_04"
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
				"pdr_objective_portals_arrive_first_portal_01",
				"pdr_objective_portals_arrive_first_portal_02",
				"pdr_objective_portals_arrive_first_portal_03",
				"pdr_objective_portals_arrive_first_portal_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_outdoors_vista1 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pdr_objective_dungeon_outdoors_vista1_02"
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
				[1.0] = "pdr_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pdr_objective_dungeon_outdoors_vista1_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_darkness_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_darkness_entry_01",
				"pwe_objective_dungeon_darkness_entry_02",
				"pwe_objective_dungeon_darkness_entry_03",
				"pwe_objective_dungeon_darkness_entry_04"
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
				"pwe_objective_dungeon_darkness_entry_01",
				"pwe_objective_dungeon_darkness_entry_02",
				"pwe_objective_dungeon_darkness_entry_03",
				"pwe_objective_dungeon_darkness_entry_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_outdoors_vista1 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pbw_objective_dungeon_outdoors_vista1_02"
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
				[1.0] = "pbw_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pbw_objective_dungeon_outdoors_vista1_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_arrive_first_portal = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_arrive_first_portal_01",
				"pbw_objective_portals_arrive_first_portal_02",
				"pbw_objective_portals_arrive_first_portal_03",
				"pbw_objective_portals_arrive_first_portal_04"
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
				"pbw_objective_portals_arrive_first_portal_01",
				"pbw_objective_portals_arrive_first_portal_02",
				"pbw_objective_portals_arrive_first_portal_03",
				"pbw_objective_portals_arrive_first_portal_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_balance = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_balance_01",
				"pbw_objective_dungeon_balance_02",
				"pbw_objective_dungeon_balance_03",
				"pbw_objective_dungeon_balance_04"
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
				"pbw_objective_dungeon_balance_01",
				"pbw_objective_dungeon_balance_02",
				"pbw_objective_dungeon_balance_03",
				"pbw_objective_dungeon_balance_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_torch_1 = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_dungeon_torch_1_01",
				"pes_objective_dungeon_torch_1_02",
				"pes_objective_dungeon_torch_1_03"
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
				"pes_objective_dungeon_torch_1_01",
				"pes_objective_dungeon_torch_1_02",
				"pes_objective_dungeon_torch_1_03"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_torch_2 = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_dungeon_torch_2_01",
				"pes_objective_dungeon_torch_2_02",
				"pes_objective_dungeon_torch_2_03"
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
				"pes_objective_dungeon_torch_2_01",
				"pes_objective_dungeon_torch_2_02",
				"pes_objective_dungeon_torch_2_03"
			},
			randomize_indexes = {}
		},
		dlc_scr_pwe_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "default",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_scr_pwe_gameplay_seeing_a_scr_01",
				"dlc_scr_pwe_gameplay_seeing_a_scr_02",
				"dlc_scr_pwe_gameplay_seeing_a_scr_03",
				"dlc_scr_pwe_gameplay_seeing_a_scr_04",
				"dlc_scr_pwe_gameplay_seeing_a_scr_05",
				"dlc_scr_pwe_gameplay_seeing_a_scr_06",
				"dlc_scr_pwe_gameplay_seeing_a_scr_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"dlc_scr_pwe_gameplay_seeing_a_scr_01",
				"dlc_scr_pwe_gameplay_seeing_a_scr_02",
				"dlc_scr_pwe_gameplay_seeing_a_scr_03",
				"dlc_scr_pwe_gameplay_seeing_a_scr_04",
				"dlc_scr_pwe_gameplay_seeing_a_scr_05",
				"dlc_scr_pwe_gameplay_seeing_a_scr_06",
				"dlc_scr_pwe_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_traps = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_traps_01",
				"pbw_objective_castle_traps_02",
				"pbw_objective_castle_traps_03",
				"pbw_objective_castle_traps_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_traps_01",
				"pbw_objective_castle_traps_02",
				"pbw_objective_castle_traps_03",
				"pbw_objective_castle_traps_04"
			},
			randomize_indexes = {}
		},
		pes_portals_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_portals_intro_b_01",
				[2.0] = "pes_portals_intro_b_02"
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
				[1.0] = "pes_portals_intro_b_01",
				[2.0] = "pes_portals_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_castle_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_castle_intro_a_01",
				[2.0] = "pes_castle_intro_a_02"
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
				[1.0] = "pes_castle_intro_a_01",
				[2.0] = "pes_castle_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_chalice_rising = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_chalice_rising_01",
				"pbw_objective_castle_chalice_rising_02",
				"pbw_objective_castle_chalice_rising_03",
				"pbw_objective_castle_chalice_rising_04"
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
				"pbw_objective_castle_chalice_rising_01",
				"pbw_objective_castle_chalice_rising_02",
				"pbw_objective_castle_chalice_rising_03",
				"pbw_objective_castle_chalice_rising_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwh_gameplay_hearing_a_pm_in_combat = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_01",
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_02",
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_03",
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_04"
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
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_01",
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_02",
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_03",
				"dlc_pm_pwh_gameplay_hearing_a_pm_in_combat_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_torch_1 = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pbw_objective_dungeon_torch_1_01",
				"pbw_objective_dungeon_torch_1_02",
				"pbw_objective_dungeon_torch_1_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_dungeon_torch_1_01",
				"pbw_objective_dungeon_torch_1_02",
				"pbw_objective_dungeon_torch_1_03"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_self_tag = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pbw_gameplay_self_tag_01",
				"pbw_gameplay_self_tag_02",
				"pbw_gameplay_self_tag_03",
				"pbw_gameplay_self_tag_04",
				"pbw_gameplay_self_tag_05",
				"pbw_gameplay_self_tag_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_fear",
				"face_exhausted",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_gameplay_self_tag_01",
				"pbw_gameplay_self_tag_02",
				"pbw_gameplay_self_tag_03",
				"pbw_gameplay_self_tag_04",
				"pbw_gameplay_self_tag_05",
				"pbw_gameplay_self_tag_06"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_run = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_run_01",
				"pbw_objective_castle_run_02",
				"pbw_objective_castle_run_03",
				"pbw_objective_castle_run_04"
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
				"pbw_objective_castle_run_01",
				"pbw_objective_castle_run_02",
				"pbw_objective_castle_run_03",
				"pbw_objective_castle_run_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_upward_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_upward_tunnel_01",
				"pdr_objective_dungeon_upward_tunnel_02",
				"pdr_objective_dungeon_upward_tunnel_03",
				"pdr_objective_dungeon_upward_tunnel_04"
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
				"pdr_objective_dungeon_upward_tunnel_01",
				"pdr_objective_dungeon_upward_tunnel_02",
				"pdr_objective_dungeon_upward_tunnel_03",
				"pdr_objective_dungeon_upward_tunnel_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pbw_gameplay_seeing_a_pm = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"dlc_pm_pbw_gameplay_seeing_a_pm_01",
				"dlc_pm_pbw_gameplay_seeing_a_pm_02",
				"dlc_pm_pbw_gameplay_seeing_a_pm_03",
				"dlc_pm_pbw_gameplay_seeing_a_pm_04",
				"dlc_pm_pbw_gameplay_seeing_a_pm_05",
				"dlc_pm_pbw_gameplay_seeing_a_pm_06",
				"dlc_pm_pbw_gameplay_seeing_a_pm_07",
				"dlc_pm_pbw_gameplay_seeing_a_pm_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"dlc_pm_pbw_gameplay_seeing_a_pm_01",
				"dlc_pm_pbw_gameplay_seeing_a_pm_02",
				"dlc_pm_pbw_gameplay_seeing_a_pm_03",
				"dlc_pm_pbw_gameplay_seeing_a_pm_04",
				"dlc_pm_pbw_gameplay_seeing_a_pm_05",
				"dlc_pm_pbw_gameplay_seeing_a_pm_06",
				"dlc_pm_pbw_gameplay_seeing_a_pm_07",
				"dlc_pm_pbw_gameplay_seeing_a_pm_08"
			},
			randomize_indexes = {}
		},
		pes_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pes_gameplay_healing_draught_01",
				"pes_gameplay_healing_draught_02",
				"pes_gameplay_healing_draught_03",
				"pes_gameplay_healing_draught_04",
				"pes_gameplay_healing_draught_05",
				"pes_gameplay_healing_draught_06",
				"pes_gameplay_healing_draught_07",
				"pes_gameplay_healing_draught_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pes_gameplay_healing_draught_01",
				"pes_gameplay_healing_draught_02",
				"pes_gameplay_healing_draught_03",
				"pes_gameplay_healing_draught_04",
				"pes_gameplay_healing_draught_05",
				"pes_gameplay_healing_draught_06",
				"pes_gameplay_healing_draught_07",
				"pes_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_upward_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_upward_tunnel_01",
				"pbw_objective_dungeon_upward_tunnel_02",
				"pbw_objective_dungeon_upward_tunnel_03",
				"pbw_objective_dungeon_upward_tunnel_04"
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
				"pbw_objective_dungeon_upward_tunnel_01",
				"pbw_objective_dungeon_upward_tunnel_02",
				"pbw_objective_dungeon_upward_tunnel_03",
				"pbw_objective_dungeon_upward_tunnel_04"
			},
			randomize_indexes = {}
		},
		pes_objective_spotting_pm_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_spotting_pm_gear_01",
				[2.0] = "pes_objective_spotting_pm_gear_02"
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
				[1.0] = "pes_objective_spotting_pm_gear_01",
				[2.0] = "pes_objective_spotting_pm_gear_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_inner_sanctum = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_inner_sanctum_01",
				"pes_objective_castle_inner_sanctum_02",
				"pes_objective_castle_inner_sanctum_03",
				"pes_objective_castle_inner_sanctum_04"
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
				"pes_objective_castle_inner_sanctum_01",
				"pes_objective_castle_inner_sanctum_02",
				"pes_objective_castle_inner_sanctum_03",
				"pes_objective_castle_inner_sanctum_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_spot_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_spot_artifact_2_01",
				"pwe_objective_dungeon_spot_artifact_2_02",
				"pwe_objective_dungeon_spot_artifact_2_03",
				"pwe_objective_dungeon_spot_artifact_2_04"
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
				"pwe_objective_dungeon_spot_artifact_2_01",
				"pwe_objective_dungeon_spot_artifact_2_02",
				"pwe_objective_dungeon_spot_artifact_2_03",
				"pwe_objective_dungeon_spot_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_inner_sanctum = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_inner_sanctum_01",
				"pbw_objective_castle_inner_sanctum_02",
				"pbw_objective_castle_inner_sanctum_03",
				"pbw_objective_castle_inner_sanctum_04"
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
				"pbw_objective_castle_inner_sanctum_01",
				"pbw_objective_castle_inner_sanctum_02",
				"pbw_objective_castle_inner_sanctum_03",
				"pbw_objective_castle_inner_sanctum_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_inner_sanctum = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_inner_sanctum_01",
				"pdr_objective_castle_inner_sanctum_02",
				"pdr_objective_castle_inner_sanctum_03",
				"pdr_objective_castle_inner_sanctum_04"
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
				"pdr_objective_castle_inner_sanctum_01",
				"pdr_objective_castle_inner_sanctum_02",
				"pdr_objective_castle_inner_sanctum_03",
				"pdr_objective_castle_inner_sanctum_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_chalice_rising = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_chalice_rising_01",
				"pwe_objective_castle_chalice_rising_02",
				"pwe_objective_castle_chalice_rising_03",
				"pwe_objective_castle_chalice_rising_04"
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
				"pwe_objective_castle_chalice_rising_01",
				"pwe_objective_castle_chalice_rising_02",
				"pwe_objective_castle_chalice_rising_03",
				"pwe_objective_castle_chalice_rising_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_spotting_sf_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_spotting_sf_gear_01",
				[2.0] = "pbw_objective_spotting_sf_gear_02"
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
				[1.0] = "pbw_objective_spotting_sf_gear_01",
				[2.0] = "pbw_objective_spotting_sf_gear_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_upward_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_upward_tunnel_01",
				"pwe_objective_dungeon_upward_tunnel_02",
				"pwe_objective_dungeon_upward_tunnel_03",
				"pwe_objective_dungeon_upward_tunnel_04"
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
				"pwe_objective_dungeon_upward_tunnel_01",
				"pwe_objective_dungeon_upward_tunnel_02",
				"pwe_objective_dungeon_upward_tunnel_03",
				"pwe_objective_dungeon_upward_tunnel_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_blood_pool = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_blood_pool_01",
				"pwe_objective_castle_blood_pool_02",
				"pwe_objective_castle_blood_pool_03",
				"pwe_objective_castle_blood_pool_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwe_objective_castle_blood_pool_01",
				"pwe_objective_castle_blood_pool_02",
				"pwe_objective_castle_blood_pool_03",
				"pwe_objective_castle_blood_pool_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_spot_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_spot_artifact_2_01",
				"pwh_objective_dungeon_spot_artifact_2_02",
				"pwh_objective_dungeon_spot_artifact_2_03",
				"pwh_objective_dungeon_spot_artifact_2_04"
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
				"pwh_objective_dungeon_spot_artifact_2_01",
				"pwh_objective_dungeon_spot_artifact_2_02",
				"pwh_objective_dungeon_spot_artifact_2_03",
				"pwh_objective_dungeon_spot_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pes_portals_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_portals_intro_a_01",
				[2.0] = "pes_portals_intro_a_02"
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
				[1.0] = "pes_portals_intro_a_01",
				[2.0] = "pes_portals_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_dungeon_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_dungeon_intro_a_01",
				[2.0] = "pwe_dungeon_intro_a_02"
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
				[1.0] = "pwe_dungeon_intro_a_01",
				[2.0] = "pwe_dungeon_intro_a_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_spot_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_spot_artifact_2_01",
				"pes_objective_dungeon_spot_artifact_2_02",
				"pes_objective_dungeon_spot_artifact_2_03",
				"pes_objective_dungeon_spot_artifact_2_04"
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
				"pes_objective_dungeon_spot_artifact_2_01",
				"pes_objective_dungeon_spot_artifact_2_02",
				"pes_objective_dungeon_spot_artifact_2_03",
				"pes_objective_dungeon_spot_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_wood_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_wood_door_01",
				"pes_objective_castle_wood_door_02",
				"pes_objective_castle_wood_door_03",
				"pes_objective_castle_wood_door_04"
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
				"pes_objective_castle_wood_door_01",
				"pes_objective_castle_wood_door_02",
				"pes_objective_castle_wood_door_03",
				"pes_objective_castle_wood_door_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_chalice_rising = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_chalice_rising_01",
				"pdr_objective_castle_chalice_rising_02",
				"pdr_objective_castle_chalice_rising_03",
				"pdr_objective_castle_chalice_rising_04"
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
				"pdr_objective_castle_chalice_rising_01",
				"pdr_objective_castle_chalice_rising_02",
				"pdr_objective_castle_chalice_rising_03",
				"pdr_objective_castle_chalice_rising_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_chalice_rising = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_chalice_rising_01",
				"pes_objective_castle_chalice_rising_02",
				"pes_objective_castle_chalice_rising_03",
				"pes_objective_castle_chalice_rising_04"
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
				"pes_objective_castle_chalice_rising_01",
				"pes_objective_castle_chalice_rising_02",
				"pes_objective_castle_chalice_rising_03",
				"pes_objective_castle_chalice_rising_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_spot_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_spot_artifact_2_01",
				"pdr_objective_dungeon_spot_artifact_2_02",
				"pdr_objective_dungeon_spot_artifact_2_03",
				"pdr_objective_dungeon_spot_artifact_2_04"
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
				"pdr_objective_dungeon_spot_artifact_2_01",
				"pdr_objective_dungeon_spot_artifact_2_02",
				"pdr_objective_dungeon_spot_artifact_2_03",
				"pdr_objective_dungeon_spot_artifact_2_04"
			},
			randomize_indexes = {}
		},
		nik_map_brief_dungeon = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_map_brief_dungeon_01",
				[2.0] = "nik_map_brief_dungeon_02"
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
				[1.0] = "nik_map_brief_dungeon_01",
				[2.0] = "nik_map_brief_dungeon_02"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pbw_gameplay_healing_draught_01",
				"pbw_gameplay_healing_draught_02",
				"pbw_gameplay_healing_draught_03",
				"pbw_gameplay_healing_draught_04",
				"pbw_gameplay_healing_draught_05",
				"pbw_gameplay_healing_draught_06",
				"pbw_gameplay_healing_draught_07",
				"pbw_gameplay_healing_draught_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_gameplay_healing_draught_01",
				"pbw_gameplay_healing_draught_02",
				"pbw_gameplay_healing_draught_03",
				"pbw_gameplay_healing_draught_04",
				"pbw_gameplay_healing_draught_05",
				"pbw_gameplay_healing_draught_06",
				"pbw_gameplay_healing_draught_07",
				"pbw_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_ballroom = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_ballroom_01",
				"pwh_objective_castle_ballroom_02",
				"pwh_objective_castle_ballroom_03",
				"pwh_objective_castle_ballroom_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_ballroom_01",
				"pwh_objective_castle_ballroom_02",
				"pwh_objective_castle_ballroom_03",
				"pwh_objective_castle_ballroom_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_spot_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_spot_artifact_2_01",
				"pbw_objective_dungeon_spot_artifact_2_02",
				"pbw_objective_dungeon_spot_artifact_2_03",
				"pbw_objective_dungeon_spot_artifact_2_04"
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
				"pbw_objective_dungeon_spot_artifact_2_01",
				"pbw_objective_dungeon_spot_artifact_2_02",
				"pbw_objective_dungeon_spot_artifact_2_03",
				"pbw_objective_dungeon_spot_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_unmarked_grave = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_portals_unmarked_grave_01",
				[2.0] = "pbw_objective_portals_unmarked_grave_02"
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
				[1.0] = "pbw_objective_portals_unmarked_grave_01",
				[2.0] = "pbw_objective_portals_unmarked_grave_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_ballroom = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_ballroom_01",
				"pes_objective_castle_ballroom_02",
				"pes_objective_castle_ballroom_03",
				"pes_objective_castle_ballroom_04"
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
				"pes_objective_castle_ballroom_01",
				"pes_objective_castle_ballroom_02",
				"pes_objective_castle_ballroom_03",
				"pes_objective_castle_ballroom_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_third_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_third_portal_tips_01",
				"pwh_objective_portals_third_portal_tips_02",
				"pwh_objective_portals_third_portal_tips_03",
				"pwh_objective_portals_third_portal_tips_04"
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
				"pwh_objective_portals_third_portal_tips_01",
				"pwh_objective_portals_third_portal_tips_02",
				"pwh_objective_portals_third_portal_tips_03",
				"pwh_objective_portals_third_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_traps_ally_hit = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pbw_objective_dungeon_traps_ally_hit_02"
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
				[1.0] = "pbw_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pbw_objective_dungeon_traps_ally_hit_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_traps_ally_hit = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pes_objective_dungeon_traps_ally_hit_02"
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
				[1.0] = "pes_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pes_objective_dungeon_traps_ally_hit_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_traps_ally_hit = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pdr_objective_dungeon_traps_ally_hit_02"
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
				[1.0] = "pdr_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pdr_objective_dungeon_traps_ally_hit_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_acquire_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_acquire_artifact_2_01",
				"pdr_objective_dungeon_acquire_artifact_2_02",
				"pdr_objective_dungeon_acquire_artifact_2_03",
				"pdr_objective_dungeon_acquire_artifact_2_04"
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
				"pdr_objective_dungeon_acquire_artifact_2_01",
				"pdr_objective_dungeon_acquire_artifact_2_02",
				"pdr_objective_dungeon_acquire_artifact_2_03",
				"pdr_objective_dungeon_acquire_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_acquire_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_acquire_artifact_2_01",
				"pes_objective_dungeon_acquire_artifact_2_02",
				"pes_objective_dungeon_acquire_artifact_2_03",
				"pes_objective_dungeon_acquire_artifact_2_04"
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
				"pes_objective_dungeon_acquire_artifact_2_01",
				"pes_objective_dungeon_acquire_artifact_2_02",
				"pes_objective_dungeon_acquire_artifact_2_03",
				"pes_objective_dungeon_acquire_artifact_2_04"
			},
			randomize_indexes = {}
		},
		nik_loading_screen_map = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_loading_screen_map_01",
				[2.0] = "nik_loading_screen_map_02"
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
				[1.0] = "nik_loading_screen_map_01",
				[2.0] = "nik_loading_screen_map_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_escaped = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_escaped_01",
				"pdr_objective_castle_escaped_02",
				"pdr_objective_castle_escaped_03",
				"pdr_objective_castle_escaped_04"
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
				"pdr_objective_castle_escaped_01",
				"pdr_objective_castle_escaped_02",
				"pdr_objective_castle_escaped_03",
				"pdr_objective_castle_escaped_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_self_tag = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwh_gameplay_self_tag_01",
				"pwh_gameplay_self_tag_02",
				"pwh_gameplay_self_tag_03",
				"pwh_gameplay_self_tag_04",
				"pwh_gameplay_self_tag_05",
				"pwh_gameplay_self_tag_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pwh_gameplay_self_tag_01",
				"pwh_gameplay_self_tag_02",
				"pwh_gameplay_self_tag_03",
				"pwh_gameplay_self_tag_04",
				"pwh_gameplay_self_tag_05",
				"pwh_gameplay_self_tag_06"
			},
			randomize_indexes = {}
		},
		pbw_objective_skaven_exit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_skaven_exit_01",
				"pbw_objective_skaven_exit_02",
				"pbw_objective_skaven_exit_03",
				"pbw_objective_skaven_exit_04"
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
				"pbw_objective_skaven_exit_01",
				"pbw_objective_skaven_exit_02",
				"pbw_objective_skaven_exit_03",
				"pbw_objective_skaven_exit_04"
			},
			randomize_indexes = {}
		},
		pes_dungeon_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_dungeon_intro_c_02",
				[2.0] = "pes_dungeon_intro_c_02"
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
				[1.0] = "pes_dungeon_intro_c_02",
				[2.0] = "pes_dungeon_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_acquire_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_acquire_artifact_2_01",
				"pbw_objective_dungeon_acquire_artifact_2_02",
				"pbw_objective_dungeon_acquire_artifact_2_03",
				"pbw_objective_dungeon_acquire_artifact_2_04"
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
				"pbw_objective_dungeon_acquire_artifact_2_01",
				"pbw_objective_dungeon_acquire_artifact_2_02",
				"pbw_objective_dungeon_acquire_artifact_2_03",
				"pbw_objective_dungeon_acquire_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_first_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_first_portal_instruction_01",
				"pes_objective_portals_first_portal_instruction_02",
				"pes_objective_portals_first_portal_instruction_03",
				"pes_objective_portals_first_portal_instruction_04"
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
				"pes_objective_portals_first_portal_instruction_01",
				"pes_objective_portals_first_portal_instruction_02",
				"pes_objective_portals_first_portal_instruction_03",
				"pes_objective_portals_first_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_first_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_first_portal_instruction_01",
				"pdr_objective_portals_first_portal_instruction_02",
				"pdr_objective_portals_first_portal_instruction_03",
				"pdr_objective_portals_first_portal_instruction_04"
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
				"pdr_objective_portals_first_portal_instruction_01",
				"pdr_objective_portals_first_portal_instruction_02",
				"pdr_objective_portals_first_portal_instruction_03",
				"pdr_objective_portals_first_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_mission_successful_01",
				"pdr_objective_portals_mission_successful_02",
				"pdr_objective_portals_mission_successful_03",
				"pdr_objective_portals_mission_successful_04"
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
				"pdr_objective_portals_mission_successful_01",
				"pdr_objective_portals_mission_successful_02",
				"pdr_objective_portals_mission_successful_03",
				"pdr_objective_portals_mission_successful_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_first_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_first_portal_instruction_01",
				"pbw_objective_portals_first_portal_instruction_02",
				"pbw_objective_portals_first_portal_instruction_03",
				"pbw_objective_portals_first_portal_instruction_04"
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
				"pbw_objective_portals_first_portal_instruction_01",
				"pbw_objective_portals_first_portal_instruction_02",
				"pbw_objective_portals_first_portal_instruction_03",
				"pbw_objective_portals_first_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_mission_successful_01",
				"pbw_objective_portals_mission_successful_02",
				"pbw_objective_portals_mission_successful_03",
				"pbw_objective_portals_mission_successful_04"
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
				"pbw_objective_portals_mission_successful_01",
				"pbw_objective_portals_mission_successful_02",
				"pbw_objective_portals_mission_successful_03",
				"pbw_objective_portals_mission_successful_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_torch_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_torch_1_01",
				"pdr_objective_dungeon_torch_1_02",
				"pdr_objective_dungeon_torch_1_03",
				"pdr_objective_dungeon_torch_1_04"
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
				"pdr_objective_dungeon_torch_1_01",
				"pdr_objective_dungeon_torch_1_02",
				"pdr_objective_dungeon_torch_1_03",
				"pdr_objective_dungeon_torch_1_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_torch_2 = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_dungeon_torch_2_01",
				"pwh_objective_dungeon_torch_2_02",
				"pwh_objective_dungeon_torch_2_03"
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
				"pwh_objective_dungeon_torch_2_01",
				"pwh_objective_dungeon_torch_2_02",
				"pwh_objective_dungeon_torch_2_03"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_mission_successful_01",
				"pwe_objective_portals_mission_successful_02",
				"pwe_objective_portals_mission_successful_03",
				"pwe_objective_portals_mission_successful_04"
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
				"pwe_objective_portals_mission_successful_01",
				"pwe_objective_portals_mission_successful_02",
				"pwe_objective_portals_mission_successful_03",
				"pwe_objective_portals_mission_successful_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_skaven_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_skaven_entry_01",
				"pdr_objective_castle_skaven_entry_02",
				"pdr_objective_castle_skaven_entry_03",
				"pdr_objective_castle_skaven_entry_04"
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
				"pdr_objective_castle_skaven_entry_01",
				"pdr_objective_castle_skaven_entry_02",
				"pdr_objective_castle_skaven_entry_03",
				"pdr_objective_castle_skaven_entry_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_lever_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_lever_2_01",
				"pwh_objective_castle_lever_2_02",
				"pwh_objective_castle_lever_2_03",
				"pwh_objective_castle_lever_2_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_lever_2_01",
				"pwh_objective_castle_lever_2_02",
				"pwh_objective_castle_lever_2_03",
				"pwh_objective_castle_lever_2_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_skaven_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_skaven_entry_01",
				"pbw_objective_castle_skaven_entry_02",
				"pbw_objective_castle_skaven_entry_03",
				"pbw_objective_castle_skaven_entry_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_skaven_entry_01",
				"pbw_objective_castle_skaven_entry_02",
				"pbw_objective_castle_skaven_entry_03",
				"pbw_objective_castle_skaven_entry_04"
			},
			randomize_indexes = {}
		},
		pbw_castle_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_castle_intro_a_01",
				[2.0] = "pbw_castle_intro_a_02"
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
				[1.0] = "pbw_castle_intro_a_01",
				[2.0] = "pbw_castle_intro_a_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_skaven_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_skaven_entry_01",
				"pes_objective_castle_skaven_entry_02",
				"pes_objective_castle_skaven_entry_03",
				"pes_objective_castle_skaven_entry_04"
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
				"pes_objective_castle_skaven_entry_01",
				"pes_objective_castle_skaven_entry_02",
				"pes_objective_castle_skaven_entry_03",
				"pes_objective_castle_skaven_entry_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_portal_overheat_near = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_portal_overheat_near_01",
				"pes_objective_portals_portal_overheat_near_02",
				"pes_objective_portals_portal_overheat_near_03",
				"pes_objective_portals_portal_overheat_near_04"
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
				"pes_objective_portals_portal_overheat_near_01",
				"pes_objective_portals_portal_overheat_near_02",
				"pes_objective_portals_portal_overheat_near_03",
				"pes_objective_portals_portal_overheat_near_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_third_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_third_portal_tips_01",
				"pbw_objective_portals_third_portal_tips_02",
				"pbw_objective_portals_third_portal_tips_03",
				"pbw_objective_portals_third_portal_tips_04"
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
				"pbw_objective_portals_third_portal_tips_01",
				"pbw_objective_portals_third_portal_tips_02",
				"pbw_objective_portals_third_portal_tips_03",
				"pbw_objective_portals_third_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_traps_ally_hit = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pwe_objective_dungeon_traps_ally_hit_02"
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
				[1.0] = "pwe_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pwe_objective_dungeon_traps_ally_hit_02"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_third_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_third_portal_tips_01",
				"pes_objective_portals_third_portal_tips_02",
				"pes_objective_portals_third_portal_tips_03",
				"pes_objective_portals_third_portal_tips_04"
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
				"pes_objective_portals_third_portal_tips_01",
				"pes_objective_portals_third_portal_tips_02",
				"pes_objective_portals_third_portal_tips_03",
				"pes_objective_portals_third_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_third_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_third_portal_tips_01",
				"pdr_objective_portals_third_portal_tips_02",
				"pdr_objective_portals_third_portal_tips_03",
				"pdr_objective_portals_third_portal_tips_04"
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
				"pdr_objective_portals_third_portal_tips_01",
				"pdr_objective_portals_third_portal_tips_02",
				"pdr_objective_portals_third_portal_tips_03",
				"pdr_objective_portals_third_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_skaven_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_skaven_entry_01",
				"pwh_objective_castle_skaven_entry_02",
				"pwh_objective_castle_skaven_entry_03",
				"pwh_objective_castle_skaven_entry_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_skaven_entry_01",
				"pwh_objective_castle_skaven_entry_02",
				"pwh_objective_castle_skaven_entry_03",
				"pwh_objective_castle_skaven_entry_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pes_gameplay_seeing_a_pm = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"dlc_pm_pes_gameplay_seeing_a_pm_01",
				"dlc_pm_pes_gameplay_seeing_a_pm_02",
				"dlc_pm_pes_gameplay_seeing_a_pm_03",
				"dlc_pm_pes_gameplay_seeing_a_pm_04",
				"dlc_pm_pes_gameplay_seeing_a_pm_05",
				"dlc_pm_pes_gameplay_seeing_a_pm_06",
				"dlc_pm_pes_gameplay_seeing_a_pm_07",
				"dlc_pm_pes_gameplay_seeing_a_pm_08"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"dlc_pm_pes_gameplay_seeing_a_pm_01",
				"dlc_pm_pes_gameplay_seeing_a_pm_02",
				"dlc_pm_pes_gameplay_seeing_a_pm_03",
				"dlc_pm_pes_gameplay_seeing_a_pm_04",
				"dlc_pm_pes_gameplay_seeing_a_pm_05",
				"dlc_pm_pes_gameplay_seeing_a_pm_06",
				"dlc_pm_pes_gameplay_seeing_a_pm_07",
				"dlc_pm_pes_gameplay_seeing_a_pm_08"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_portal_overheat_near = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_portal_overheat_near_01",
				"pwe_objective_portals_portal_overheat_near_02",
				"pwe_objective_portals_portal_overheat_near_03",
				"pwe_objective_portals_portal_overheat_near_04"
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
				"pwe_objective_portals_portal_overheat_near_01",
				"pwe_objective_portals_portal_overheat_near_02",
				"pwe_objective_portals_portal_overheat_near_03",
				"pwe_objective_portals_portal_overheat_near_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_traps_warning = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_traps_warning_01",
				"pwh_objective_dungeon_traps_warning_02",
				"pwh_objective_dungeon_traps_warning_03",
				"pwh_objective_dungeon_traps_warning_04"
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
				"pwh_objective_dungeon_traps_warning_01",
				"pwh_objective_dungeon_traps_warning_02",
				"pwh_objective_dungeon_traps_warning_03",
				"pwh_objective_dungeon_traps_warning_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_darkness_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_darkness_entry_01",
				"pes_objective_dungeon_darkness_entry_02",
				"pes_objective_dungeon_darkness_entry_03",
				"pes_objective_dungeon_darkness_entry_04"
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
				"pes_objective_dungeon_darkness_entry_01",
				"pes_objective_dungeon_darkness_entry_02",
				"pes_objective_dungeon_darkness_entry_03",
				"pes_objective_dungeon_darkness_entry_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_darkness_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_darkness_entry_01",
				"pdr_objective_dungeon_darkness_entry_02",
				"pdr_objective_dungeon_darkness_entry_03",
				"pdr_objective_dungeon_darkness_entry_04"
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
				"pdr_objective_dungeon_darkness_entry_01",
				"pdr_objective_dungeon_darkness_entry_02",
				"pdr_objective_dungeon_darkness_entry_03",
				"pdr_objective_dungeon_darkness_entry_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_traps_warning = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_traps_warning_01",
				"pwe_objective_dungeon_traps_warning_02",
				"pwe_objective_dungeon_traps_warning_03",
				"pwe_objective_dungeon_traps_warning_04"
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
				"pwe_objective_dungeon_traps_warning_01",
				"pwe_objective_dungeon_traps_warning_02",
				"pwe_objective_dungeon_traps_warning_03",
				"pwe_objective_dungeon_traps_warning_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_ballroom = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_ballroom_01",
				"pbw_objective_castle_ballroom_02",
				"pbw_objective_castle_ballroom_03",
				"pbw_objective_castle_ballroom_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_ballroom_01",
				"pbw_objective_castle_ballroom_02",
				"pbw_objective_castle_ballroom_03",
				"pbw_objective_castle_ballroom_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_olesya = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_dungeon_olesya_01",
				[2.0] = "pbw_objective_dungeon_olesya_02"
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
				[1.0] = "pbw_objective_dungeon_olesya_01",
				[2.0] = "pbw_objective_dungeon_olesya_02"
			},
			randomize_indexes = {}
		},
		dlc_pm_pbw_gameplay_tips_pm = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"dlc_pm_pbw_gameplay_tips_pm_01",
				"dlc_pm_pbw_gameplay_tips_pm_02",
				"dlc_pm_pbw_gameplay_tips_pm_03",
				"dlc_pm_pbw_gameplay_tips_pm_04",
				"dlc_pm_pbw_gameplay_tips_pm_05",
				"dlc_pm_pbw_gameplay_tips_pm_06"
			},
			dialogue_animations = {
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
				"face_neutral"
			},
			localization_strings = {
				"dlc_pm_pbw_gameplay_tips_pm_01",
				"dlc_pm_pbw_gameplay_tips_pm_02",
				"dlc_pm_pbw_gameplay_tips_pm_03",
				"dlc_pm_pbw_gameplay_tips_pm_04",
				"dlc_pm_pbw_gameplay_tips_pm_05",
				"dlc_pm_pbw_gameplay_tips_pm_06"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_portal_overheat_near = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_portal_overheat_near_01",
				"pbw_objective_portals_portal_overheat_near_02",
				"pbw_objective_portals_portal_overheat_near_03",
				"pbw_objective_portals_portal_overheat_near_04"
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
				"pbw_objective_portals_portal_overheat_near_01",
				"pbw_objective_portals_portal_overheat_near_02",
				"pbw_objective_portals_portal_overheat_near_03",
				"pbw_objective_portals_portal_overheat_near_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_statue = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_statue_01",
				"pbw_objective_castle_statue_02",
				"pbw_objective_castle_statue_03",
				"pbw_objective_castle_statue_04"
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
				"pbw_objective_castle_statue_01",
				"pbw_objective_castle_statue_02",
				"pbw_objective_castle_statue_03",
				"pbw_objective_castle_statue_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_torch_2 = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_objective_dungeon_torch_2_01",
				"pdr_objective_dungeon_torch_2_02",
				"pdr_objective_dungeon_torch_2_03"
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
				"pdr_objective_dungeon_torch_2_01",
				"pdr_objective_dungeon_torch_2_02",
				"pdr_objective_dungeon_torch_2_03"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_balance = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_balance_01",
				"pes_objective_dungeon_balance_02",
				"pes_objective_dungeon_balance_03",
				"pes_objective_dungeon_balance_04"
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
				"pes_objective_dungeon_balance_01",
				"pes_objective_dungeon_balance_02",
				"pes_objective_dungeon_balance_03",
				"pes_objective_dungeon_balance_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_spotting_sf_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_spotting_sf_gear_01",
				[2.0] = "pdr_objective_spotting_sf_gear_02"
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
				[1.0] = "pdr_objective_spotting_sf_gear_01",
				[2.0] = "pdr_objective_spotting_sf_gear_02"
			},
			randomize_indexes = {}
		},
		pwh_castle_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_castle_intro_c_01",
				[2.0] = "pwh_castle_intro_c_02"
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
				[1.0] = "pwh_castle_intro_c_01",
				[2.0] = "pwh_castle_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_darkness_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_darkness_entry_01",
				"pbw_objective_dungeon_darkness_entry_02",
				"pbw_objective_dungeon_darkness_entry_03",
				"pbw_objective_dungeon_darkness_entry_04"
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
				"pbw_objective_dungeon_darkness_entry_01",
				"pbw_objective_dungeon_darkness_entry_02",
				"pbw_objective_dungeon_darkness_entry_03",
				"pbw_objective_dungeon_darkness_entry_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_blood_pool = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_blood_pool_01",
				"pwh_objective_castle_blood_pool_02",
				"pwh_objective_castle_blood_pool_03",
				"pwh_objective_castle_blood_pool_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_blood_pool_01",
				"pwh_objective_castle_blood_pool_02",
				"pwh_objective_castle_blood_pool_03",
				"pwh_objective_castle_blood_pool_04"
			},
			randomize_indexes = {}
		},
		pwe_dungeon_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_dungeon_intro_b_01",
				[2.0] = "pwe_dungeon_intro_b_02"
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
				[1.0] = "pwe_dungeon_intro_b_01",
				[2.0] = "pwe_dungeon_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_portals_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_portals_intro_a_01",
				[2.0] = "pwe_portals_intro_a_02"
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
				[1.0] = "pwe_portals_intro_a_01",
				[2.0] = "pwe_portals_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_acquire_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_acquire_artifact_1_01",
				"pwe_objective_dungeon_acquire_artifact_1_02",
				"pwe_objective_dungeon_acquire_artifact_1_03",
				"pwe_objective_dungeon_acquire_artifact_1_04"
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
				"pwe_objective_dungeon_acquire_artifact_1_01",
				"pwe_objective_dungeon_acquire_artifact_1_02",
				"pwe_objective_dungeon_acquire_artifact_1_03",
				"pwe_objective_dungeon_acquire_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_statue = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_statue_01",
				"pdr_objective_castle_statue_02",
				"pdr_objective_castle_statue_03",
				"pdr_objective_castle_statue_04"
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
				"pdr_objective_castle_statue_01",
				"pdr_objective_castle_statue_02",
				"pdr_objective_castle_statue_03",
				"pdr_objective_castle_statue_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_view = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_view_01",
				"pes_objective_castle_view_02",
				"pes_objective_castle_view_03",
				"pes_objective_castle_view_04"
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
				"pes_objective_castle_view_01",
				"pes_objective_castle_view_02",
				"pes_objective_castle_view_03",
				"pes_objective_castle_view_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_acquire_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_acquire_artifact_2_01",
				"pwe_objective_dungeon_acquire_artifact_2_02",
				"pwe_objective_dungeon_acquire_artifact_2_03",
				"pwe_objective_dungeon_acquire_artifact_2_04"
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
				"pwe_objective_dungeon_acquire_artifact_2_01",
				"pwe_objective_dungeon_acquire_artifact_2_02",
				"pwe_objective_dungeon_acquire_artifact_2_03",
				"pwe_objective_dungeon_acquire_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_acquire_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_acquire_artifact_1_01",
				"pes_objective_dungeon_acquire_artifact_1_02",
				"pes_objective_dungeon_acquire_artifact_1_03",
				"pes_objective_dungeon_acquire_artifact_1_04"
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
				"pes_objective_dungeon_acquire_artifact_1_01",
				"pes_objective_dungeon_acquire_artifact_1_02",
				"pes_objective_dungeon_acquire_artifact_1_03",
				"pes_objective_dungeon_acquire_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_acquire_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_acquire_artifact_1_01",
				"pdr_objective_dungeon_acquire_artifact_1_02",
				"pdr_objective_dungeon_acquire_artifact_1_03",
				"pdr_objective_dungeon_acquire_artifact_1_04"
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
				"pdr_objective_dungeon_acquire_artifact_1_01",
				"pdr_objective_dungeon_acquire_artifact_1_02",
				"pdr_objective_dungeon_acquire_artifact_1_03",
				"pdr_objective_dungeon_acquire_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_second_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_second_portal_tips_01",
				"pbw_objective_portals_second_portal_tips_02",
				"pbw_objective_portals_second_portal_tips_03",
				"pbw_objective_portals_second_portal_tips_04"
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
				"pbw_objective_portals_second_portal_tips_01",
				"pbw_objective_portals_second_portal_tips_02",
				"pbw_objective_portals_second_portal_tips_03",
				"pbw_objective_portals_second_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_acquire_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_acquire_artifact_1_01",
				"pbw_objective_dungeon_acquire_artifact_1_02",
				"pbw_objective_dungeon_acquire_artifact_1_03",
				"pbw_objective_dungeon_acquire_artifact_1_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_dungeon_acquire_artifact_1_01",
				"pbw_objective_dungeon_acquire_artifact_1_02",
				"pbw_objective_dungeon_acquire_artifact_1_03",
				"pbw_objective_dungeon_acquire_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pdr_portals_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_portals_intro_b_01",
				[2.0] = "pdr_portals_intro_b_02"
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
				[1.0] = "pdr_portals_intro_b_01",
				[2.0] = "pdr_portals_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_second_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_second_portal_tips_01",
				"pes_objective_portals_second_portal_tips_02",
				"pes_objective_portals_second_portal_tips_03",
				"pes_objective_portals_second_portal_tips_04"
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
				"pes_objective_portals_second_portal_tips_01",
				"pes_objective_portals_second_portal_tips_02",
				"pes_objective_portals_second_portal_tips_03",
				"pes_objective_portals_second_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pwh_dungeon_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_dungeon_intro_a_01",
				[2.0] = "pwh_dungeon_intro_a_02"
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
				[1.0] = "pwh_dungeon_intro_a_01",
				[2.0] = "pwh_dungeon_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_portals_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_portals_intro_c_01",
				[2.0] = "pdr_portals_intro_c_02"
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
				[1.0] = "pdr_portals_intro_c_01",
				[2.0] = "pdr_portals_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_castle_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_castle_intro_c_01",
				[2.0] = "pdr_castle_intro_c_02"
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
				[1.0] = "pdr_castle_intro_c_01",
				[2.0] = "pdr_castle_intro_c_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_blood_pool = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_blood_pool_01",
				"pes_objective_castle_blood_pool_02",
				"pes_objective_castle_blood_pool_03",
				"pes_objective_castle_blood_pool_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pes_objective_castle_blood_pool_01",
				"pes_objective_castle_blood_pool_02",
				"pes_objective_castle_blood_pool_03",
				"pes_objective_castle_blood_pool_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_first_portal_skaven_cooling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_first_portal_skaven_cooling_01",
				"pwh_objective_portals_first_portal_skaven_cooling_02",
				"pwh_objective_portals_first_portal_skaven_cooling_03",
				"pwh_objective_portals_first_portal_skaven_cooling_04"
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
				"pwh_objective_portals_first_portal_skaven_cooling_01",
				"pwh_objective_portals_first_portal_skaven_cooling_02",
				"pwh_objective_portals_first_portal_skaven_cooling_03",
				"pwh_objective_portals_first_portal_skaven_cooling_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_wood_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_wood_door_01",
				"pwe_objective_castle_wood_door_02",
				"pwe_objective_castle_wood_door_03",
				"pwe_objective_castle_wood_door_04"
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
				"pwe_objective_castle_wood_door_01",
				"pwe_objective_castle_wood_door_02",
				"pwe_objective_castle_wood_door_03",
				"pwe_objective_castle_wood_door_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_escaped = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_escaped_01",
				"pbw_objective_castle_escaped_02",
				"pbw_objective_castle_escaped_03",
				"pbw_objective_castle_escaped_04"
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
				"pbw_objective_castle_escaped_01",
				"pbw_objective_castle_escaped_02",
				"pbw_objective_castle_escaped_03",
				"pbw_objective_castle_escaped_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_first_portal_skaven_cooling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_first_portal_skaven_cooling_01",
				"pwe_objective_portals_first_portal_skaven_cooling_02",
				"pwe_objective_portals_first_portal_skaven_cooling_03",
				"pwe_objective_portals_first_portal_skaven_cooling_04"
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
				"pwe_objective_portals_first_portal_skaven_cooling_01",
				"pwe_objective_portals_first_portal_skaven_cooling_02",
				"pwe_objective_portals_first_portal_skaven_cooling_03",
				"pwe_objective_portals_first_portal_skaven_cooling_04"
			},
			randomize_indexes = {}
		},
		pwh_castle_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_castle_intro_a_01",
				[2.0] = "pwh_castle_intro_a_02"
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
				[1.0] = "pwh_castle_intro_a_01",
				[2.0] = "pwh_castle_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_overheat_failed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_overheat_failed_01",
				"pbw_objective_portals_overheat_failed_02",
				"pbw_objective_portals_overheat_failed_03",
				"pbw_objective_portals_overheat_failed_04"
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
				"pbw_objective_portals_overheat_failed_01",
				"pbw_objective_portals_overheat_failed_02",
				"pbw_objective_portals_overheat_failed_03",
				"pbw_objective_portals_overheat_failed_04"
			},
			randomize_indexes = {}
		},
		pwe_gameplay_self_tag = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pwe_gameplay_self_tag_01",
				"pwe_gameplay_self_tag_02",
				"pwe_gameplay_self_tag_03",
				"pwe_gameplay_self_tag_04",
				"pwe_gameplay_self_tag_05",
				"pwe_gameplay_self_tag_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear",
				"face_fear"
			},
			localization_strings = {
				"pwe_gameplay_self_tag_01",
				"pwe_gameplay_self_tag_02",
				"pwe_gameplay_self_tag_03",
				"pwe_gameplay_self_tag_04",
				"pwe_gameplay_self_tag_05",
				"pwe_gameplay_self_tag_06"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_overheat_failed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_overheat_failed_01",
				"pdr_objective_portals_overheat_failed_02",
				"pdr_objective_portals_overheat_failed_03",
				"pdr_objective_portals_overheat_failed_04"
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
				"pdr_objective_portals_overheat_failed_01",
				"pdr_objective_portals_overheat_failed_02",
				"pdr_objective_portals_overheat_failed_03",
				"pdr_objective_portals_overheat_failed_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_overheat_failed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_overheat_failed_01",
				"pes_objective_portals_overheat_failed_02",
				"pes_objective_portals_overheat_failed_03",
				"pes_objective_portals_overheat_failed_04"
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
				"pes_objective_portals_overheat_failed_01",
				"pes_objective_portals_overheat_failed_02",
				"pes_objective_portals_overheat_failed_03",
				"pes_objective_portals_overheat_failed_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_run = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_run_01",
				"pdr_objective_castle_run_02",
				"pdr_objective_castle_run_03",
				"pdr_objective_castle_run_04"
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
				"pdr_objective_castle_run_01",
				"pdr_objective_castle_run_02",
				"pdr_objective_castle_run_03",
				"pdr_objective_castle_run_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_first_portal_skaven_cooling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_first_portal_skaven_cooling_01",
				"pes_objective_portals_first_portal_skaven_cooling_02",
				"pes_objective_portals_first_portal_skaven_cooling_03",
				"pes_objective_portals_first_portal_skaven_cooling_04"
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
				"pes_objective_portals_first_portal_skaven_cooling_01",
				"pes_objective_portals_first_portal_skaven_cooling_02",
				"pes_objective_portals_first_portal_skaven_cooling_03",
				"pes_objective_portals_first_portal_skaven_cooling_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_first_portal_skaven_cooling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_first_portal_skaven_cooling_01",
				"pdr_objective_portals_first_portal_skaven_cooling_02",
				"pdr_objective_portals_first_portal_skaven_cooling_03",
				"pdr_objective_portals_first_portal_skaven_cooling_04"
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
				"pdr_objective_portals_first_portal_skaven_cooling_01",
				"pdr_objective_portals_first_portal_skaven_cooling_02",
				"pdr_objective_portals_first_portal_skaven_cooling_03",
				"pdr_objective_portals_first_portal_skaven_cooling_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_balance = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_balance_01",
				"pwh_objective_dungeon_balance_02",
				"pwh_objective_dungeon_balance_03",
				"pwh_objective_dungeon_balance_04"
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
				"pwh_objective_dungeon_balance_01",
				"pwh_objective_dungeon_balance_02",
				"pwh_objective_dungeon_balance_03",
				"pwh_objective_dungeon_balance_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_balance = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_balance_01",
				"pwe_objective_dungeon_balance_02",
				"pwe_objective_dungeon_balance_03",
				"pwe_objective_dungeon_balance_04"
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
				"pwe_objective_dungeon_balance_01",
				"pwe_objective_dungeon_balance_02",
				"pwe_objective_dungeon_balance_03",
				"pwe_objective_dungeon_balance_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_blood_pool = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_blood_pool_01",
				"pdr_objective_castle_blood_pool_02",
				"pdr_objective_castle_blood_pool_03",
				"pdr_objective_castle_blood_pool_04"
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
				"pdr_objective_castle_blood_pool_01",
				"pdr_objective_castle_blood_pool_02",
				"pdr_objective_castle_blood_pool_03",
				"pdr_objective_castle_blood_pool_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_statue = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_statue_01",
				"pwh_objective_castle_statue_02",
				"pwh_objective_castle_statue_03",
				"pwh_objective_castle_statue_04"
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
				"pwh_objective_castle_statue_01",
				"pwh_objective_castle_statue_02",
				"pwh_objective_castle_statue_03",
				"pwh_objective_castle_statue_04"
			},
			randomize_indexes = {}
		},
		nik_map_brief_portals = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_map_brief_portals_01",
				[2.0] = "nik_map_brief_portals_02"
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
				[1.0] = "nik_map_brief_portals_01",
				[2.0] = "nik_map_brief_portals_02"
			},
			randomize_indexes = {}
		},
		pwe_castle_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_castle_intro_b_01",
				[2.0] = "pwe_castle_intro_b_02"
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
				[1.0] = "pwe_castle_intro_b_01",
				[2.0] = "pwe_castle_intro_b_02"
			},
			randomize_indexes = {}
		},
		nik_map_brief_castle = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_map_brief_castle_a_01",
				[2.0] = "nik_map_brief_castle_a_02"
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
				[1.0] = "nik_map_brief_castle_a_01",
				[2.0] = "nik_map_brief_castle_a_02"
			},
			randomize_indexes = {}
		},
		pwh_portals_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_portals_intro_b_01",
				[2.0] = "pwh_portals_intro_b_02"
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
				[1.0] = "pwh_portals_intro_b_01",
				[2.0] = "pwh_portals_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_village = {
			sound_events_n = 1,
			face_animations_n = 1,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 1,
			sound_events = {
				[1.0] = "pbw_objective_portals_village_01"
			},
			dialogue_animations = {
				[1.0] = "dialogue_talk"
			},
			face_animations = {
				[1.0] = "face_concerned"
			},
			localization_strings = {
				[1.0] = "pbw_objective_portals_village_01"
			}
		},
		pes_castle_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_castle_intro_b_01",
				[2.0] = "pes_castle_intro_b_02"
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
				[1.0] = "pes_castle_intro_b_01",
				[2.0] = "pes_castle_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_dungeon_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_dungeon_intro_a_01",
				[2.0] = "pes_dungeon_intro_a_02"
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
				[1.0] = "pes_dungeon_intro_a_01",
				[2.0] = "pes_dungeon_intro_a_02"
			},
			randomize_indexes = {}
		},
		pwh_dungeon_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_dungeon_intro_c_02",
				[2.0] = "pwh_dungeon_intro_c_02"
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
				[1.0] = "pwh_dungeon_intro_c_02",
				[2.0] = "pwh_dungeon_intro_c_02"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_self_tag = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pdr_gameplay_self_tag_01",
				"pdr_gameplay_self_tag_02",
				"pdr_gameplay_self_tag_03",
				"pdr_gameplay_self_tag_04",
				"pdr_gameplay_self_tag_05",
				"pdr_gameplay_self_tag_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_fear",
				"face_exhausted",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_self_tag_01",
				"pdr_gameplay_self_tag_02",
				"pdr_gameplay_self_tag_03",
				"pdr_gameplay_self_tag_04",
				"pdr_gameplay_self_tag_05",
				"pdr_gameplay_self_tag_06"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_second_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_second_portal_instruction_01",
				"pes_objective_portals_second_portal_instruction_02",
				"pes_objective_portals_second_portal_instruction_03",
				"pes_objective_portals_second_portal_instruction_04"
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
				"pes_objective_portals_second_portal_instruction_01",
				"pes_objective_portals_second_portal_instruction_02",
				"pes_objective_portals_second_portal_instruction_03",
				"pes_objective_portals_second_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_second_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_second_portal_instruction_01",
				"pdr_objective_portals_second_portal_instruction_02",
				"pdr_objective_portals_second_portal_instruction_03",
				"pdr_objective_portals_second_portal_instruction_04"
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
				"pdr_objective_portals_second_portal_instruction_01",
				"pdr_objective_portals_second_portal_instruction_02",
				"pdr_objective_portals_second_portal_instruction_03",
				"pdr_objective_portals_second_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pbw_dungeon_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_dungeon_intro_b_01",
				[2.0] = "pbw_dungeon_intro_b_02"
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
				[1.0] = "pbw_dungeon_intro_b_01",
				[2.0] = "pbw_dungeon_intro_b_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_chalice_acquired = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_chalice_acquired_01",
				"pbw_objective_castle_chalice_acquired_02",
				"pbw_objective_castle_chalice_acquired_03",
				"pbw_objective_castle_chalice_acquired_04"
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
				"pbw_objective_castle_chalice_acquired_01",
				"pbw_objective_castle_chalice_acquired_02",
				"pbw_objective_castle_chalice_acquired_03",
				"pbw_objective_castle_chalice_acquired_04"
			},
			randomize_indexes = {}
		},
		pwe_portals_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_portals_intro_c_01",
				[2.0] = "pwe_portals_intro_c_02"
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
				[1.0] = "pwe_portals_intro_c_01",
				[2.0] = "pwe_portals_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_second_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_second_portal_instruction_01",
				"pbw_objective_portals_second_portal_instruction_02",
				"pbw_objective_portals_second_portal_instruction_03",
				"pbw_objective_portals_second_portal_instruction_04"
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
				"pbw_objective_portals_second_portal_instruction_01",
				"pbw_objective_portals_second_portal_instruction_02",
				"pbw_objective_portals_second_portal_instruction_03",
				"pbw_objective_portals_second_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_village = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_portals_village_01",
				[2.0] = "pdr_objective_portals_village_02"
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
				[1.0] = "pdr_objective_portals_village_01",
				[2.0] = "pdr_objective_portals_village_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_skaven_exit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_skaven_exit_01",
				"pwh_objective_skaven_exit_02",
				"pwh_objective_skaven_exit_03",
				"pwh_objective_skaven_exit_04"
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
				"pwh_objective_skaven_exit_01",
				"pwh_objective_skaven_exit_02",
				"pwh_objective_skaven_exit_03",
				"pwh_objective_skaven_exit_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_overheat_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_overheat_successful_01",
				"pwe_objective_portals_overheat_successful_02",
				"pwe_objective_portals_overheat_successful_03",
				"pwe_objective_portals_overheat_successful_04"
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
				"pwe_objective_portals_overheat_successful_01",
				"pwe_objective_portals_overheat_successful_02",
				"pwe_objective_portals_overheat_successful_03",
				"pwe_objective_portals_overheat_successful_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwe_gameplay_hearing_a_pm_in_combat = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "default",
			dialogue_animations_n = 4,
			sound_events = {
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_01",
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_02",
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_03",
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_contempt",
				"face_fear",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_01",
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_02",
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_03",
				"dlc_pm_pwe_gameplay_hearing_a_pm_in_combat_04"
			},
			randomize_indexes = {}
		},
		pbw_castle_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_castle_intro_b_01",
				[2.0] = "pbw_castle_intro_b_02"
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
				[1.0] = "pbw_castle_intro_b_01",
				[2.0] = "pbw_castle_intro_b_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_spot_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_spot_artifact_1_01",
				"pdr_objective_dungeon_spot_artifact_1_02",
				"pdr_objective_dungeon_spot_artifact_1_03",
				"pdr_objective_dungeon_spot_artifact_1_04"
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
				"pdr_objective_dungeon_spot_artifact_1_01",
				"pdr_objective_dungeon_spot_artifact_1_02",
				"pdr_objective_dungeon_spot_artifact_1_03",
				"pdr_objective_dungeon_spot_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_skaven_exit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_skaven_exit_01",
				"pwe_objective_skaven_exit_02",
				"pwe_objective_skaven_exit_03",
				"pwe_objective_skaven_exit_04"
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
				"pwe_objective_skaven_exit_01",
				"pwe_objective_skaven_exit_02",
				"pwe_objective_skaven_exit_03",
				"pwe_objective_skaven_exit_04"
			},
			randomize_indexes = {}
		},
		pwe_castle_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_castle_intro_c_01",
				[2.0] = "pwe_castle_intro_c_02"
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
				[1.0] = "pwe_castle_intro_c_01",
				[2.0] = "pwe_castle_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_overheat_successful = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_portals_overheat_successful_02",
				"pwh_objective_portals_overheat_successful_03",
				"pwh_objective_portals_overheat_successful_04"
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
				"pwh_objective_portals_overheat_successful_02",
				"pwh_objective_portals_overheat_successful_03",
				"pwh_objective_portals_overheat_successful_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_spot_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_spot_artifact_1_01",
				"pbw_objective_dungeon_spot_artifact_1_02",
				"pbw_objective_dungeon_spot_artifact_1_03",
				"pbw_objective_dungeon_spot_artifact_1_04"
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
				"pbw_objective_dungeon_spot_artifact_1_01",
				"pbw_objective_dungeon_spot_artifact_1_02",
				"pbw_objective_dungeon_spot_artifact_1_03",
				"pbw_objective_dungeon_spot_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_overheat_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_overheat_successful_01",
				"pes_objective_portals_overheat_successful_02",
				"pes_objective_portals_overheat_successful_03",
				"pes_objective_portals_overheat_successful_04"
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
				"pes_objective_portals_overheat_successful_01",
				"pes_objective_portals_overheat_successful_02",
				"pes_objective_portals_overheat_successful_03",
				"pes_objective_portals_overheat_successful_04"
			},
			randomize_indexes = {}
		},
		pbw_castle_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_castle_intro_c_01",
				[2.0] = "pbw_castle_intro_c_02"
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
				[1.0] = "pbw_castle_intro_c_01",
				[2.0] = "pbw_castle_intro_c_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_placing_statuette = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_placing_statuette_01",
				"pwe_objective_castle_placing_statuette_02",
				"pwe_objective_castle_placing_statuette_03",
				"pwe_objective_castle_placing_statuette_04"
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
				"pwe_objective_castle_placing_statuette_01",
				"pwe_objective_castle_placing_statuette_02",
				"pwe_objective_castle_placing_statuette_03",
				"pwe_objective_castle_placing_statuette_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_broken_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_broken_bridge_01",
				"pbw_objective_castle_broken_bridge_02",
				"pbw_objective_castle_broken_bridge_03",
				"pbw_objective_castle_broken_bridge_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_broken_bridge_01",
				"pbw_objective_castle_broken_bridge_02",
				"pbw_objective_castle_broken_bridge_03",
				"pbw_objective_castle_broken_bridge_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_broken_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_broken_bridge_01",
				"pes_objective_castle_broken_bridge_02",
				"pes_objective_castle_broken_bridge_03",
				"pes_objective_castle_broken_bridge_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pes_objective_castle_broken_bridge_01",
				"pes_objective_castle_broken_bridge_02",
				"pes_objective_castle_broken_bridge_03",
				"pes_objective_castle_broken_bridge_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_broken_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_broken_bridge_01",
				"pdr_objective_castle_broken_bridge_02",
				"pdr_objective_castle_broken_bridge_03",
				"pdr_objective_castle_broken_bridge_04"
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
				"pdr_objective_castle_broken_bridge_01",
				"pdr_objective_castle_broken_bridge_02",
				"pdr_objective_castle_broken_bridge_03",
				"pdr_objective_castle_broken_bridge_04"
			},
			randomize_indexes = {}
		},
		pdr_castle_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_castle_intro_b_01",
				[2.0] = "pdr_castle_intro_b_02"
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
				[1.0] = "pdr_castle_intro_b_01",
				[2.0] = "pdr_castle_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_chalice_acquired = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_chalice_acquired_01",
				"pwe_objective_castle_chalice_acquired_02",
				"pwe_objective_castle_chalice_acquired_03",
				"pwe_objective_castle_chalice_acquired_04"
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
				"pwe_objective_castle_chalice_acquired_01",
				"pwe_objective_castle_chalice_acquired_02",
				"pwe_objective_castle_chalice_acquired_03",
				"pwe_objective_castle_chalice_acquired_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_balance = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_balance_01",
				"pdr_objective_dungeon_balance_02",
				"pdr_objective_dungeon_balance_03",
				"pdr_objective_dungeon_balance_04"
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
				"pdr_objective_dungeon_balance_01",
				"pdr_objective_dungeon_balance_02",
				"pdr_objective_dungeon_balance_03",
				"pdr_objective_dungeon_balance_04"
			},
			randomize_indexes = {}
		},
		pes_gameplay_self_tag = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pes_gameplay_self_tag_01",
				"pes_gameplay_self_tag_02",
				"pes_gameplay_self_tag_03",
				"pes_gameplay_self_tag_04",
				"pes_gameplay_self_tag_05",
				"pes_gameplay_self_tag_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_angry",
				"face_fear",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted",
				"face_exhausted"
			},
			localization_strings = {
				"pes_gameplay_self_tag_01",
				"pes_gameplay_self_tag_02",
				"pes_gameplay_self_tag_03",
				"pes_gameplay_self_tag_04",
				"pes_gameplay_self_tag_05",
				"pes_gameplay_self_tag_06"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_overheat_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_overheat_successful_01",
				"pbw_objective_portals_overheat_successful_02",
				"pbw_objective_portals_overheat_successful_03",
				"pbw_objective_portals_overheat_successful_04"
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
				"pbw_objective_portals_overheat_successful_01",
				"pbw_objective_portals_overheat_successful_02",
				"pbw_objective_portals_overheat_successful_03",
				"pbw_objective_portals_overheat_successful_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_escaped = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_escaped_01",
				"pwh_objective_castle_escaped_02",
				"pwh_objective_castle_escaped_03",
				"pwh_objective_castle_escaped_04"
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
				"pwh_objective_castle_escaped_01",
				"pwh_objective_castle_escaped_02",
				"pwh_objective_castle_escaped_03",
				"pwh_objective_castle_escaped_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_placing_statuette = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_placing_statuette_01",
				"pes_objective_castle_placing_statuette_02",
				"pes_objective_castle_placing_statuette_03",
				"pes_objective_castle_placing_statuette_04"
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
				"pes_objective_castle_placing_statuette_01",
				"pes_objective_castle_placing_statuette_02",
				"pes_objective_castle_placing_statuette_03",
				"pes_objective_castle_placing_statuette_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_placing_statuette = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_placing_statuette_01",
				"pdr_objective_castle_placing_statuette_02",
				"pdr_objective_castle_placing_statuette_03",
				"pdr_objective_castle_placing_statuette_04"
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
				"pdr_objective_castle_placing_statuette_01",
				"pdr_objective_castle_placing_statuette_02",
				"pdr_objective_castle_placing_statuette_03",
				"pdr_objective_castle_placing_statuette_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_run = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_run_01",
				"pes_objective_castle_run_02",
				"pes_objective_castle_run_03",
				"pes_objective_castle_run_04"
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
				"pes_objective_castle_run_01",
				"pes_objective_castle_run_02",
				"pes_objective_castle_run_03",
				"pes_objective_castle_run_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_escaped = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_escaped_01",
				"pwe_objective_castle_escaped_02",
				"pwe_objective_castle_escaped_03",
				"pwe_objective_castle_escaped_04"
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
				"pwe_objective_castle_escaped_01",
				"pwe_objective_castle_escaped_02",
				"pwe_objective_castle_escaped_03",
				"pwe_objective_castle_escaped_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_chalice_acquired = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_chalice_acquired_01",
				"pdr_objective_castle_chalice_acquired_02",
				"pdr_objective_castle_chalice_acquired_03",
				"pdr_objective_castle_chalice_acquired_04"
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
				"pdr_objective_castle_chalice_acquired_01",
				"pdr_objective_castle_chalice_acquired_02",
				"pdr_objective_castle_chalice_acquired_03",
				"pdr_objective_castle_chalice_acquired_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_chalice_acquired = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_chalice_acquired_01",
				"pes_objective_castle_chalice_acquired_02",
				"pes_objective_castle_chalice_acquired_03",
				"pes_objective_castle_chalice_acquired_04"
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
				"pes_objective_castle_chalice_acquired_01",
				"pes_objective_castle_chalice_acquired_02",
				"pes_objective_castle_chalice_acquired_03",
				"pes_objective_castle_chalice_acquired_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_broken_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_broken_bridge_01",
				"pwe_objective_castle_broken_bridge_02",
				"pwe_objective_castle_broken_bridge_03",
				"pwe_objective_castle_broken_bridge_04"
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
				"pwe_objective_castle_broken_bridge_01",
				"pwe_objective_castle_broken_bridge_02",
				"pwe_objective_castle_broken_bridge_03",
				"pwe_objective_castle_broken_bridge_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_chalice_acquired = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_chalice_acquired_01",
				"pwh_objective_castle_chalice_acquired_02",
				"pwh_objective_castle_chalice_acquired_03",
				"pwh_objective_castle_chalice_acquired_04"
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
				"pwh_objective_castle_chalice_acquired_01",
				"pwh_objective_castle_chalice_acquired_02",
				"pwh_objective_castle_chalice_acquired_03",
				"pwh_objective_castle_chalice_acquired_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_skaven_exit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_skaven_exit_01",
				"pdr_objective_skaven_exit_02",
				"pdr_objective_skaven_exit_03",
				"pdr_objective_skaven_exit_04"
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
				"pdr_objective_skaven_exit_01",
				"pdr_objective_skaven_exit_02",
				"pdr_objective_skaven_exit_03",
				"pdr_objective_skaven_exit_04"
			},
			randomize_indexes = {}
		},
		pdr_portals_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_portals_intro_a_01",
				[2.0] = "pdr_portals_intro_a_02"
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
				[1.0] = "pdr_portals_intro_a_01",
				[2.0] = "pdr_portals_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_lever = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pbw_objective_castle_lever_01",
				"pbw_objective_castle_lever_02",
				"pbw_objective_castle_lever_03"
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
				"pbw_objective_castle_lever_01",
				"pbw_objective_castle_lever_02",
				"pbw_objective_castle_lever_03"
			},
			randomize_indexes = {}
		},
		pdr_dungeon_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_dungeon_intro_c_01",
				[2.0] = "pdr_dungeon_intro_c_02"
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
				[1.0] = "pdr_dungeon_intro_c_01",
				[2.0] = "pdr_dungeon_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_dungeon_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_dungeon_intro_a_01",
				[2.0] = "pbw_dungeon_intro_a_02"
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
				[1.0] = "pbw_dungeon_intro_a_01",
				[2.0] = "pbw_dungeon_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_dungeon_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_dungeon_intro_a_01",
				[2.0] = "pdr_dungeon_intro_a_02"
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
				[1.0] = "pdr_dungeon_intro_a_01",
				[2.0] = "pdr_dungeon_intro_a_02"
			},
			randomize_indexes = {}
		},
		pdr_castle_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_castle_intro_a_01",
				[2.0] = "pdr_castle_intro_a_02"
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
				[1.0] = "pdr_castle_intro_a_01",
				[2.0] = "pdr_castle_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_portals_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_portals_intro_c_01",
				[2.0] = "pbw_portals_intro_c_02"
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
				[1.0] = "pbw_portals_intro_c_01",
				[2.0] = "pbw_portals_intro_c_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_statue = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_statue_01",
				"pes_objective_castle_statue_02",
				"pes_objective_castle_statue_03",
				"pes_objective_castle_statue_04"
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
				"pes_objective_castle_statue_01",
				"pes_objective_castle_statue_02",
				"pes_objective_castle_statue_03",
				"pes_objective_castle_statue_04"
			},
			randomize_indexes = {}
		},
		dlc_scr_pwh_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_scr_pwh_gameplay_seeing_a_scr_01",
				"dlc_scr_pwh_gameplay_seeing_a_scr_02",
				"dlc_scr_pwh_gameplay_seeing_a_scr_03",
				"dlc_scr_pwh_gameplay_seeing_a_scr_04",
				"dlc_scr_pwh_gameplay_seeing_a_scr_05",
				"dlc_scr_pwh_gameplay_seeing_a_scr_06",
				"dlc_scr_pwh_gameplay_seeing_a_scr_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"dlc_scr_pwh_gameplay_seeing_a_scr_01",
				"dlc_scr_pwh_gameplay_seeing_a_scr_02",
				"dlc_scr_pwh_gameplay_seeing_a_scr_03",
				"dlc_scr_pwh_gameplay_seeing_a_scr_04",
				"dlc_scr_pwh_gameplay_seeing_a_scr_05",
				"dlc_scr_pwh_gameplay_seeing_a_scr_06",
				"dlc_scr_pwh_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_view = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_view_01",
				"pwe_objective_castle_view_02",
				"pwe_objective_castle_view_03",
				"pwe_objective_castle_view_04"
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
				"pwe_objective_castle_view_01",
				"pwe_objective_castle_view_02",
				"pwe_objective_castle_view_03",
				"pwe_objective_castle_view_04"
			},
			randomize_indexes = {}
		},
		pbw_portals_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_portals_intro_a_01",
				[2.0] = "pbw_portals_intro_a_02"
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
				[1.0] = "pbw_portals_intro_a_01",
				[2.0] = "pbw_portals_intro_a_02"
			},
			randomize_indexes = {}
		},
		pbw_dungeon_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_dungeon_intro_c_02",
				[2.0] = "pbw_dungeon_intro_c_02"
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
				[1.0] = "pbw_dungeon_intro_c_02",
				[2.0] = "pbw_dungeon_intro_c_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_catacombs_arrival = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_catacombs_arrival_01",
				"pes_objective_castle_catacombs_arrival_02",
				"pes_objective_castle_catacombs_arrival_03",
				"pes_objective_castle_catacombs_arrival_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pes_objective_castle_catacombs_arrival_01",
				"pes_objective_castle_catacombs_arrival_02",
				"pes_objective_castle_catacombs_arrival_03",
				"pes_objective_castle_catacombs_arrival_04"
			},
			randomize_indexes = {}
		},
		pdr_dungeon_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_dungeon_intro_b_01",
				[2.0] = "pdr_dungeon_intro_b_02"
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
				[1.0] = "pdr_dungeon_intro_b_01",
				[2.0] = "pdr_dungeon_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_portals_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_portals_intro_b_01",
				[2.0] = "pwe_portals_intro_b_02"
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
				[1.0] = "pwe_portals_intro_b_01",
				[2.0] = "pwe_portals_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_ballroom = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_ballroom_01",
				"pwe_objective_castle_ballroom_02",
				"pwe_objective_castle_ballroom_03",
				"pwe_objective_castle_ballroom_04"
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
				"pwe_objective_castle_ballroom_01",
				"pwe_objective_castle_ballroom_02",
				"pwe_objective_castle_ballroom_03",
				"pwe_objective_castle_ballroom_04"
			},
			randomize_indexes = {}
		},
		pwe_dungeon_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_dungeon_intro_c_02",
				[2.0] = "pwe_dungeon_intro_c_02"
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
				[1.0] = "pwe_dungeon_intro_c_02",
				[2.0] = "pwe_dungeon_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_catacombs_arrival = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_catacombs_arrival_01",
				"pbw_objective_castle_catacombs_arrival_02",
				"pbw_objective_castle_catacombs_arrival_03",
				"pbw_objective_castle_catacombs_arrival_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_catacombs_arrival_01",
				"pbw_objective_castle_catacombs_arrival_02",
				"pbw_objective_castle_catacombs_arrival_03",
				"pbw_objective_castle_catacombs_arrival_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_village = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_portals_village_01",
				"pes_objective_portals_village_02",
				"pes_objective_portals_village_03"
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
				"pes_objective_portals_village_01",
				"pes_objective_portals_village_02",
				"pes_objective_portals_village_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_catacombs_arrival = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_catacombs_arrival_01",
				"pdr_objective_castle_catacombs_arrival_02",
				"pdr_objective_castle_catacombs_arrival_03",
				"pdr_objective_castle_catacombs_arrival_04"
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
				"pdr_objective_castle_catacombs_arrival_01",
				"pdr_objective_castle_catacombs_arrival_02",
				"pdr_objective_castle_catacombs_arrival_03",
				"pdr_objective_castle_catacombs_arrival_04"
			},
			randomize_indexes = {}
		},
		pwe_castle_intro = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_castle_intro_a_01",
				[2.0] = "pwe_castle_intro_a_02"
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
				[1.0] = "pwe_castle_intro_a_01",
				[2.0] = "pwe_castle_intro_a_02"
			},
			randomize_indexes = {}
		},
		dlc_pm_pdr_gameplay_seeing_a_pm = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_pm_pdr_gameplay_seeing_a_pm_01",
				"dlc_pm_pdr_gameplay_seeing_a_pm_02",
				"dlc_pm_pdr_gameplay_seeing_a_pm_03",
				"dlc_pm_pdr_gameplay_seeing_a_pm_04",
				"dlc_pm_pdr_gameplay_seeing_a_pm_05",
				"dlc_pm_pdr_gameplay_seeing_a_pm_06",
				"dlc_pm_pdr_gameplay_seeing_a_pm_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"dlc_pm_pdr_gameplay_seeing_a_pm_01",
				"dlc_pm_pdr_gameplay_seeing_a_pm_02",
				"dlc_pm_pdr_gameplay_seeing_a_pm_03",
				"dlc_pm_pdr_gameplay_seeing_a_pm_04",
				"dlc_pm_pdr_gameplay_seeing_a_pm_05",
				"dlc_pm_pdr_gameplay_seeing_a_pm_06",
				"dlc_pm_pdr_gameplay_seeing_a_pm_07"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pwh_gameplay_healing_draught_01",
				"pwh_gameplay_healing_draught_02",
				"pwh_gameplay_healing_draught_03",
				"pwh_gameplay_healing_draught_04",
				"pwh_gameplay_healing_draught_05",
				"pwh_gameplay_healing_draught_06",
				"pwh_gameplay_healing_draught_07",
				"pwh_gameplay_healing_draught_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pwh_gameplay_healing_draught_01",
				"pwh_gameplay_healing_draught_02",
				"pwh_gameplay_healing_draught_03",
				"pwh_gameplay_healing_draught_04",
				"pwh_gameplay_healing_draught_05",
				"pwh_gameplay_healing_draught_06",
				"pwh_gameplay_healing_draught_07",
				"pwh_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_torch_2 = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pbw_objective_dungeon_torch_2_01",
				"pbw_objective_dungeon_torch_2_02",
				"pbw_objective_dungeon_torch_2_03"
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
				"pbw_objective_dungeon_torch_2_01",
				"pbw_objective_dungeon_torch_2_02",
				"pbw_objective_dungeon_torch_2_03"
			},
			randomize_indexes = {}
		},
		pes_objective_skaven_exit = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_skaven_exit_01",
				"pes_objective_skaven_exit_02",
				"pes_objective_skaven_exit_03",
				"pes_objective_skaven_exit_04"
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
				"pes_objective_skaven_exit_01",
				"pes_objective_skaven_exit_02",
				"pes_objective_skaven_exit_03",
				"pes_objective_skaven_exit_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwh_gameplay_hearing_a_pm = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 4,
			sound_events = {
				"dlc_pm_pwh_gameplay_hearing_a_pm_01",
				"dlc_pm_pwh_gameplay_hearing_a_pm_02",
				"dlc_pm_pwh_gameplay_hearing_a_pm_03",
				"dlc_pm_pwh_gameplay_hearing_a_pm_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"dlc_pm_pwh_gameplay_hearing_a_pm_01",
				"dlc_pm_pwh_gameplay_hearing_a_pm_02",
				"dlc_pm_pwh_gameplay_hearing_a_pm_03",
				"dlc_pm_pwh_gameplay_hearing_a_pm_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_first_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_first_portal_instruction_01",
				"pwe_objective_portals_first_portal_instruction_02",
				"pwe_objective_portals_first_portal_instruction_03",
				"pwe_objective_portals_first_portal_instruction_04"
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
				"pwe_objective_portals_first_portal_instruction_01",
				"pwe_objective_portals_first_portal_instruction_02",
				"pwe_objective_portals_first_portal_instruction_03",
				"pwe_objective_portals_first_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_upward_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_upward_tunnel_01",
				"pes_objective_dungeon_upward_tunnel_02",
				"pes_objective_dungeon_upward_tunnel_03",
				"pes_objective_dungeon_upward_tunnel_04"
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
				"pes_objective_dungeon_upward_tunnel_01",
				"pes_objective_dungeon_upward_tunnel_02",
				"pes_objective_dungeon_upward_tunnel_03",
				"pes_objective_dungeon_upward_tunnel_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_village = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_portals_village_01",
				"pwh_objective_portals_village_02",
				"pwh_objective_portals_village_03"
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
				"pwh_objective_portals_village_01",
				"pwh_objective_portals_village_02",
				"pwh_objective_portals_village_03"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_mission_successful_01",
				"pwh_objective_portals_mission_successful_02",
				"pwh_objective_portals_mission_successful_03",
				"pwh_objective_portals_mission_successful_04"
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
				"pwh_objective_portals_mission_successful_01",
				"pwh_objective_portals_mission_successful_02",
				"pwh_objective_portals_mission_successful_03",
				"pwh_objective_portals_mission_successful_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_third_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_third_portal_instruction_01",
				"pwe_objective_portals_third_portal_instruction_02",
				"pwe_objective_portals_third_portal_instruction_03",
				"pwe_objective_portals_third_portal_instruction_04"
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
				"pwe_objective_portals_third_portal_instruction_01",
				"pwe_objective_portals_third_portal_instruction_02",
				"pwe_objective_portals_third_portal_instruction_03",
				"pwe_objective_portals_third_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_third_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_third_portal_instruction_01",
				"pwh_objective_portals_third_portal_instruction_02",
				"pwh_objective_portals_third_portal_instruction_03",
				"pwh_objective_portals_third_portal_instruction_04"
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
				"pwh_objective_portals_third_portal_instruction_01",
				"pwh_objective_portals_third_portal_instruction_02",
				"pwh_objective_portals_third_portal_instruction_03",
				"pwh_objective_portals_third_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_second_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_second_portal_tips_01",
				"pwh_objective_portals_second_portal_tips_02",
				"pwh_objective_portals_second_portal_tips_03",
				"pwh_objective_portals_second_portal_tips_04"
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
				"pwh_objective_portals_second_portal_tips_01",
				"pwh_objective_portals_second_portal_tips_02",
				"pwh_objective_portals_second_portal_tips_03",
				"pwh_objective_portals_second_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_second_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_second_portal_instruction_01",
				"pwh_objective_portals_second_portal_instruction_02",
				"pwh_objective_portals_second_portal_instruction_03",
				"pwh_objective_portals_second_portal_instruction_04"
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
				"pwh_objective_portals_second_portal_instruction_01",
				"pwh_objective_portals_second_portal_instruction_02",
				"pwh_objective_portals_second_portal_instruction_03",
				"pwh_objective_portals_second_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_unmarked_grave = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_portals_unmarked_grave_01",
				[2.0] = "pwh_objective_portals_unmarked_grave_02"
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
				[1.0] = "pwh_objective_portals_unmarked_grave_01",
				[2.0] = "pwh_objective_portals_unmarked_grave_02"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwe_gameplay_hearing_a_pm = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "default",
			dialogue_animations_n = 4,
			sound_events = {
				"dlc_pm_pwe_gameplay_hearing_a_pm_01",
				"dlc_pm_pwe_gameplay_hearing_a_pm_02",
				"dlc_pm_pwe_gameplay_hearing_a_pm_03",
				"dlc_pm_pwe_gameplay_hearing_a_pm_04"
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
				"dlc_pm_pwe_gameplay_hearing_a_pm_01",
				"dlc_pm_pwe_gameplay_hearing_a_pm_02",
				"dlc_pm_pwe_gameplay_hearing_a_pm_03",
				"dlc_pm_pwe_gameplay_hearing_a_pm_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_overheat_failed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_overheat_failed_01",
				"pwh_objective_portals_overheat_failed_02",
				"pwh_objective_portals_overheat_failed_03",
				"pwh_objective_portals_overheat_failed_04"
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
				"pwh_objective_portals_overheat_failed_01",
				"pwh_objective_portals_overheat_failed_02",
				"pwh_objective_portals_overheat_failed_03",
				"pwh_objective_portals_overheat_failed_04"
			},
			randomize_indexes = {}
		},
		pes_dungeon_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_dungeon_intro_b_01",
				[2.0] = "pes_dungeon_intro_b_02"
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
				[1.0] = "pes_dungeon_intro_b_01",
				[2.0] = "pes_dungeon_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_portal_overheat_near = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_portal_overheat_near_01",
				"pwh_objective_portals_portal_overheat_near_02",
				"pwh_objective_portals_portal_overheat_near_03",
				"pwh_objective_portals_portal_overheat_near_04"
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
				"pwh_objective_portals_portal_overheat_near_01",
				"pwh_objective_portals_portal_overheat_near_02",
				"pwh_objective_portals_portal_overheat_near_03",
				"pwh_objective_portals_portal_overheat_near_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_portals_first_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_portals_first_portal_instruction_01",
				"pwh_objective_portals_first_portal_instruction_02",
				"pwh_objective_portals_first_portal_instruction_03",
				"pwh_objective_portals_first_portal_instruction_04"
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
				"pwh_objective_portals_first_portal_instruction_01",
				"pwh_objective_portals_first_portal_instruction_02",
				"pwh_objective_portals_first_portal_instruction_03",
				"pwh_objective_portals_first_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_closed_portcullis = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_closed_portcullis_01",
				"pwh_objective_castle_closed_portcullis_02",
				"pwh_objective_castle_closed_portcullis_03",
				"pwh_objective_castle_closed_portcullis_04"
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
				"pwh_objective_castle_closed_portcullis_01",
				"pwh_objective_castle_closed_portcullis_02",
				"pwh_objective_castle_closed_portcullis_03",
				"pwh_objective_castle_closed_portcullis_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_run = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_run_01",
				"pwh_objective_castle_run_02",
				"pwh_objective_castle_run_03",
				"pwh_objective_castle_run_04"
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
				"pwh_objective_castle_run_01",
				"pwh_objective_castle_run_02",
				"pwh_objective_castle_run_03",
				"pwh_objective_castle_run_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_view = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_view_01",
				"pdr_objective_castle_view_02",
				"pdr_objective_castle_view_03",
				"pdr_objective_castle_view_04"
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
				"pdr_objective_castle_view_01",
				"pdr_objective_castle_view_02",
				"pdr_objective_castle_view_03",
				"pdr_objective_castle_view_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_lever = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_castle_lever_01",
				[2.0] = "pwh_objective_castle_lever_02"
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
				[1.0] = "pwh_objective_castle_lever_01",
				[2.0] = "pwh_objective_castle_lever_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_chalice_rising = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_chalice_rising_01",
				"pwh_objective_castle_chalice_rising_02",
				"pwh_objective_castle_chalice_rising_03",
				"pwh_objective_castle_chalice_rising_04"
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
				"pwh_objective_castle_chalice_rising_01",
				"pwh_objective_castle_chalice_rising_02",
				"pwh_objective_castle_chalice_rising_03",
				"pwh_objective_castle_chalice_rising_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pes_gameplay_tips_pm = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 6,
			sound_events = {
				"dlc_pm_pes_gameplay_tips_pm_01",
				"dlc_pm_pes_gameplay_tips_pm_02",
				"dlc_pm_pes_gameplay_tips_pm_03",
				"dlc_pm_pes_gameplay_tips_pm_04",
				"dlc_pm_pes_gameplay_tips_pm_05",
				"dlc_pm_pes_gameplay_tips_pm_06"
			},
			dialogue_animations = {
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
				"face_neutral"
			},
			localization_strings = {
				"dlc_pm_pes_gameplay_tips_pm_01",
				"dlc_pm_pes_gameplay_tips_pm_02",
				"dlc_pm_pes_gameplay_tips_pm_03",
				"dlc_pm_pes_gameplay_tips_pm_04",
				"dlc_pm_pes_gameplay_tips_pm_05",
				"dlc_pm_pes_gameplay_tips_pm_06"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_lever_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_lever_2_01",
				"pwe_objective_castle_lever_2_02",
				"pwe_objective_castle_lever_2_03",
				"pwe_objective_castle_lever_2_04"
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
				"pwe_objective_castle_lever_2_01",
				"pwe_objective_castle_lever_2_02",
				"pwe_objective_castle_lever_2_03",
				"pwe_objective_castle_lever_2_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_olesya = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dungeon_olesya_01",
				[2.0] = "pwh_objective_dungeon_olesya_02"
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
				[1.0] = "pwh_objective_dungeon_olesya_01",
				[2.0] = "pwh_objective_dungeon_olesya_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_olesya = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_dungeon_olesya_01",
				[2.0] = "pwe_objective_dungeon_olesya_02"
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
				[1.0] = "pwe_objective_dungeon_olesya_01",
				[2.0] = "pwe_objective_dungeon_olesya_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_upward_tunnel = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_upward_tunnel_01",
				"pwh_objective_dungeon_upward_tunnel_02",
				"pwh_objective_dungeon_upward_tunnel_03",
				"pwh_objective_dungeon_upward_tunnel_04"
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
				"pwh_objective_dungeon_upward_tunnel_01",
				"pwh_objective_dungeon_upward_tunnel_02",
				"pwh_objective_dungeon_upward_tunnel_03",
				"pwh_objective_dungeon_upward_tunnel_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_acquire_artifact_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_acquire_artifact_2_01",
				"pwh_objective_dungeon_acquire_artifact_2_02",
				"pwh_objective_dungeon_acquire_artifact_2_03",
				"pwh_objective_dungeon_acquire_artifact_2_04"
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
				"pwh_objective_dungeon_acquire_artifact_2_01",
				"pwh_objective_dungeon_acquire_artifact_2_02",
				"pwh_objective_dungeon_acquire_artifact_2_03",
				"pwh_objective_dungeon_acquire_artifact_2_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_torture_racks = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_dungeon_torture_racks_01",
				"pwh_objective_dungeon_torture_racks_02",
				"pwh_objective_dungeon_torture_racks_03"
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
				"pwh_objective_dungeon_torture_racks_01",
				"pwh_objective_dungeon_torture_racks_02",
				"pwh_objective_dungeon_torture_racks_03"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_catacombs_arrival = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_castle_catacombs_arrival_01",
				"pwh_objective_castle_catacombs_arrival_02",
				"pwh_objective_castle_catacombs_arrival_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_catacombs_arrival_01",
				"pwh_objective_castle_catacombs_arrival_02",
				"pwh_objective_castle_catacombs_arrival_03"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_second_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_second_portal_instruction_01",
				"pwe_objective_portals_second_portal_instruction_02",
				"pwe_objective_portals_second_portal_instruction_03",
				"pwe_objective_portals_second_portal_instruction_04"
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
				"pwe_objective_portals_second_portal_instruction_01",
				"pwe_objective_portals_second_portal_instruction_02",
				"pwe_objective_portals_second_portal_instruction_03",
				"pwe_objective_portals_second_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_outdoors_vista1 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pwh_objective_dungeon_outdoors_vista1_02"
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
				[1.0] = "pwh_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pwh_objective_dungeon_outdoors_vista1_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_acquire_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_acquire_artifact_1_01",
				"pwh_objective_dungeon_acquire_artifact_1_02",
				"pwh_objective_dungeon_acquire_artifact_1_03",
				"pwh_objective_dungeon_acquire_artifact_1_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_dungeon_acquire_artifact_1_01",
				"pwh_objective_dungeon_acquire_artifact_1_02",
				"pwh_objective_dungeon_acquire_artifact_1_03",
				"pwh_objective_dungeon_acquire_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_spot_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_spot_artifact_1_01",
				"pwh_objective_dungeon_spot_artifact_1_02",
				"pwh_objective_dungeon_spot_artifact_1_03",
				"pwh_objective_dungeon_spot_artifact_1_04"
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
				"pwh_objective_dungeon_spot_artifact_1_01",
				"pwh_objective_dungeon_spot_artifact_1_02",
				"pwh_objective_dungeon_spot_artifact_1_03",
				"pwh_objective_dungeon_spot_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_wood_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_wood_door_01",
				"pbw_objective_castle_wood_door_02",
				"pbw_objective_castle_wood_door_03",
				"pbw_objective_castle_wood_door_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_wood_door_01",
				"pbw_objective_castle_wood_door_02",
				"pbw_objective_castle_wood_door_03",
				"pbw_objective_castle_wood_door_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_jump_challenge = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_dungeon_jump_challenge_01",
				"pwh_objective_dungeon_jump_challenge_02",
				"pwh_objective_dungeon_jump_challenge_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_dungeon_jump_challenge_01",
				"pwh_objective_dungeon_jump_challenge_02",
				"pwh_objective_dungeon_jump_challenge_03"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_traps_ally_hit = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pwh_objective_dungeon_traps_ally_hit_02"
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
				[1.0] = "pwh_objective_dungeon_traps_ally_hit_01",
				[2.0] = "pwh_objective_dungeon_traps_ally_hit_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_darkness_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_darkness_entry_01",
				"pwh_objective_dungeon_darkness_entry_02",
				"pwh_objective_dungeon_darkness_entry_03",
				"pwh_objective_dungeon_darkness_entry_04"
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
				"pwh_objective_dungeon_darkness_entry_01",
				"pwh_objective_dungeon_darkness_entry_02",
				"pwh_objective_dungeon_darkness_entry_03",
				"pwh_objective_dungeon_darkness_entry_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_jump_challenge = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 3,
			sound_events = {
				"pwe_objective_dungeon_jump_challenge_01",
				"pwe_objective_dungeon_jump_challenge_02",
				"pwe_objective_dungeon_jump_challenge_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_neutral"
			},
			localization_strings = {
				"pwe_objective_dungeon_jump_challenge_01",
				"pwe_objective_dungeon_jump_challenge_02",
				"pwe_objective_dungeon_jump_challenge_03"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_second_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_second_portal_tips_01",
				"pwe_objective_portals_second_portal_tips_02",
				"pwe_objective_portals_second_portal_tips_03",
				"pwe_objective_portals_second_portal_tips_04"
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
				"pwe_objective_portals_second_portal_tips_01",
				"pwe_objective_portals_second_portal_tips_02",
				"pwe_objective_portals_second_portal_tips_03",
				"pwe_objective_portals_second_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pes_castle_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_castle_intro_c_01",
				[2.0] = "pes_castle_intro_c_02"
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
				[1.0] = "pes_castle_intro_c_01",
				[2.0] = "pes_castle_intro_c_02"
			},
			randomize_indexes = {}
		},
		dlc_scr_pdr_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_scr_pdr_gameplay_seeing_a_scr_01",
				"dlc_scr_pdr_gameplay_seeing_a_scr_02",
				"dlc_scr_pdr_gameplay_seeing_a_scr_03",
				"dlc_scr_pdr_gameplay_seeing_a_scr_04",
				"dlc_scr_pdr_gameplay_seeing_a_scr_05",
				"dlc_scr_pdr_gameplay_seeing_a_scr_06",
				"dlc_scr_pdr_gameplay_seeing_a_scr_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"dlc_scr_pdr_gameplay_seeing_a_scr_01",
				"dlc_scr_pdr_gameplay_seeing_a_scr_02",
				"dlc_scr_pdr_gameplay_seeing_a_scr_03",
				"dlc_scr_pdr_gameplay_seeing_a_scr_04",
				"dlc_scr_pdr_gameplay_seeing_a_scr_05",
				"dlc_scr_pdr_gameplay_seeing_a_scr_06",
				"dlc_scr_pdr_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_trap_door_activated = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_trap_door_activated_01",
				"pwh_objective_castle_trap_door_activated_02",
				"pwh_objective_castle_trap_door_activated_03",
				"pwh_objective_castle_trap_door_activated_04"
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
				"pwh_objective_castle_trap_door_activated_01",
				"pwh_objective_castle_trap_door_activated_02",
				"pwh_objective_castle_trap_door_activated_03",
				"pwh_objective_castle_trap_door_activated_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_blood_pool = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_blood_pool_01",
				"pbw_objective_castle_blood_pool_02",
				"pbw_objective_castle_blood_pool_03",
				"pbw_objective_castle_blood_pool_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_blood_pool_01",
				"pbw_objective_castle_blood_pool_02",
				"pbw_objective_castle_blood_pool_03",
				"pbw_objective_castle_blood_pool_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_placing_statuette = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_placing_statuette_01",
				"pwh_objective_castle_placing_statuette_02",
				"pwh_objective_castle_placing_statuette_03",
				"pwh_objective_castle_placing_statuette_04"
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
				"pwh_objective_castle_placing_statuette_01",
				"pwh_objective_castle_placing_statuette_02",
				"pwh_objective_castle_placing_statuette_03",
				"pwh_objective_castle_placing_statuette_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_inner_sanctum = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_inner_sanctum_01",
				"pwh_objective_castle_inner_sanctum_02",
				"pwh_objective_castle_inner_sanctum_03",
				"pwh_objective_castle_inner_sanctum_04"
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
				"pwh_objective_castle_inner_sanctum_01",
				"pwh_objective_castle_inner_sanctum_02",
				"pwh_objective_castle_inner_sanctum_03",
				"pwh_objective_castle_inner_sanctum_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_trap_door_activated = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_trap_door_activated_01",
				"pwe_objective_castle_trap_door_activated_02",
				"pwe_objective_castle_trap_door_activated_03",
				"pwe_objective_castle_trap_door_activated_04"
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
				"pwe_objective_castle_trap_door_activated_01",
				"pwe_objective_castle_trap_door_activated_02",
				"pwe_objective_castle_trap_door_activated_03",
				"pwe_objective_castle_trap_door_activated_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_first_portal_skaven_cooling = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_first_portal_skaven_cooling_01",
				"pbw_objective_portals_first_portal_skaven_cooling_02",
				"pbw_objective_portals_first_portal_skaven_cooling_03",
				"pbw_objective_portals_first_portal_skaven_cooling_04"
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
				"pbw_objective_portals_first_portal_skaven_cooling_01",
				"pbw_objective_portals_first_portal_skaven_cooling_02",
				"pbw_objective_portals_first_portal_skaven_cooling_03",
				"pbw_objective_portals_first_portal_skaven_cooling_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_lever_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_lever_2_01",
				"pbw_objective_castle_lever_2_02",
				"pbw_objective_castle_lever_2_03",
				"pbw_objective_castle_lever_2_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pbw_objective_castle_lever_2_01",
				"pbw_objective_castle_lever_2_02",
				"pbw_objective_castle_lever_2_03",
				"pbw_objective_castle_lever_2_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_run = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 3,
			sound_events = {
				"pwe_objective_castle_run_01",
				"pwe_objective_castle_run_02",
				"pwe_objective_castle_run_03"
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
				"pwe_objective_castle_run_01",
				"pwe_objective_castle_run_02",
				"pwe_objective_castle_run_03"
			},
			randomize_indexes = {}
		},
		nik_loading_screen_dungeon = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "npc_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "nik_loading_screen_dungeon_01",
				[2.0] = "nik_loading_screen_dungeon_02"
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
				[1.0] = "nik_loading_screen_dungeon_01",
				[2.0] = "nik_loading_screen_dungeon_02"
			},
			randomize_indexes = {}
		},
		pwh_objective_dungeon_torch_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_dungeon_torch_1_01",
				"pwh_objective_dungeon_torch_1_02",
				"pwh_objective_dungeon_torch_1_03",
				"pwh_objective_dungeon_torch_1_04"
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
				"pwh_objective_dungeon_torch_1_01",
				"pwh_objective_dungeon_torch_1_02",
				"pwh_objective_dungeon_torch_1_03",
				"pwh_objective_dungeon_torch_1_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_broken_bridge = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwh_objective_castle_broken_bridge_01",
				"pwh_objective_castle_broken_bridge_02",
				"pwh_objective_castle_broken_bridge_03",
				"pwh_objective_castle_broken_bridge_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_broken_bridge_01",
				"pwh_objective_castle_broken_bridge_02",
				"pwh_objective_castle_broken_bridge_03",
				"pwh_objective_castle_broken_bridge_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_view = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_castle_view_01",
				"pwh_objective_castle_view_02",
				"pwh_objective_castle_view_03"
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
				"pwh_objective_castle_view_01",
				"pwh_objective_castle_view_02",
				"pwh_objective_castle_view_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_spotting_pm_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_spotting_pm_gear_01",
				[2.0] = "pdr_objective_spotting_pm_gear_02"
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
				[1.0] = "pdr_objective_spotting_pm_gear_01",
				[2.0] = "pdr_objective_spotting_pm_gear_02"
			},
			randomize_indexes = {}
		},
		pwe_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pwe_gameplay_healing_draught_01",
				"pwe_gameplay_healing_draught_02",
				"pwe_gameplay_healing_draught_03",
				"pwe_gameplay_healing_draught_04",
				"pwe_gameplay_healing_draught_05",
				"pwe_gameplay_healing_draught_06",
				"pwe_gameplay_healing_draught_07",
				"pwe_gameplay_healing_draught_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pwe_gameplay_healing_draught_01",
				"pwe_gameplay_healing_draught_02",
				"pwe_gameplay_healing_draught_03",
				"pwe_gameplay_healing_draught_04",
				"pwe_gameplay_healing_draught_05",
				"pwe_gameplay_healing_draught_06",
				"pwe_gameplay_healing_draught_07",
				"pwe_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_torture_racks = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pwe_objective_dungeon_torture_racks_01",
				"pwe_objective_dungeon_torture_racks_02",
				"pwe_objective_dungeon_torture_racks_03"
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
				"pwe_objective_dungeon_torture_racks_01",
				"pwe_objective_dungeon_torture_racks_02",
				"pwe_objective_dungeon_torture_racks_03"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_lever = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_lever_01",
				"pdr_objective_castle_lever_02",
				"pdr_objective_castle_lever_03",
				"pdr_objective_castle_lever_04"
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
				"pdr_objective_castle_lever_01",
				"pdr_objective_castle_lever_02",
				"pdr_objective_castle_lever_03",
				"pdr_objective_castle_lever_04"
			},
			randomize_indexes = {}
		},
		dlc_pm_pwe_gameplay_tips_pm = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "default",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_pm_pwe_gameplay_tips_pm_01",
				"dlc_pm_pwe_gameplay_tips_pm_02",
				"dlc_pm_pwe_gameplay_tips_pm_03",
				"dlc_pm_pwe_gameplay_tips_pm_04",
				"dlc_pm_pwe_gameplay_tips_pm_05",
				"dlc_pm_pwe_gameplay_tips_pm_06",
				"dlc_pm_pwe_gameplay_tips_pm_07"
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
				"face_contempt",
				"face_fear",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt",
				"face_contempt"
			},
			localization_strings = {
				"dlc_pm_pwe_gameplay_tips_pm_01",
				"dlc_pm_pwe_gameplay_tips_pm_02",
				"dlc_pm_pwe_gameplay_tips_pm_03",
				"dlc_pm_pwe_gameplay_tips_pm_04",
				"dlc_pm_pwe_gameplay_tips_pm_05",
				"dlc_pm_pwe_gameplay_tips_pm_06",
				"dlc_pm_pwe_gameplay_tips_pm_07"
			},
			randomize_indexes = {}
		},
		pwh_objective_castle_wood_door = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 3,
			sound_events = {
				"pwh_objective_castle_wood_door_01",
				"pwh_objective_castle_wood_door_02",
				"pwh_objective_castle_wood_door_03"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_concerned",
				"face_concerned",
				"face_neutral"
			},
			localization_strings = {
				"pwh_objective_castle_wood_door_01",
				"pwh_objective_castle_wood_door_02",
				"pwh_objective_castle_wood_door_03"
			},
			randomize_indexes = {}
		},
		dlc_scr_pes_gameplay_seeing_a_scr = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "drachenfels",
			category = "enemy_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"dlc_scr_pes_gameplay_seeing_a_scr_01",
				"dlc_scr_pes_gameplay_seeing_a_scr_02",
				"dlc_scr_pes_gameplay_seeing_a_scr_03",
				"dlc_scr_pes_gameplay_seeing_a_scr_04",
				"dlc_scr_pes_gameplay_seeing_a_scr_05",
				"dlc_scr_pes_gameplay_seeing_a_scr_06",
				"dlc_scr_pes_gameplay_seeing_a_scr_07"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"dlc_scr_pes_gameplay_seeing_a_scr_01",
				"dlc_scr_pes_gameplay_seeing_a_scr_02",
				"dlc_scr_pes_gameplay_seeing_a_scr_03",
				"dlc_scr_pes_gameplay_seeing_a_scr_04",
				"dlc_scr_pes_gameplay_seeing_a_scr_05",
				"dlc_scr_pes_gameplay_seeing_a_scr_06",
				"dlc_scr_pes_gameplay_seeing_a_scr_07"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_outdoors_vista1 = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pes_objective_dungeon_outdoors_vista1_02"
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
				[1.0] = "pes_objective_dungeon_outdoors_vista1_01",
				[2.0] = "pes_objective_dungeon_outdoors_vista1_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_traps_warning = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_dungeon_traps_warning_01",
				"pbw_objective_dungeon_traps_warning_02",
				"pbw_objective_dungeon_traps_warning_03",
				"pbw_objective_dungeon_traps_warning_04"
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
				"pbw_objective_dungeon_traps_warning_01",
				"pbw_objective_dungeon_traps_warning_02",
				"pbw_objective_dungeon_traps_warning_03",
				"pbw_objective_dungeon_traps_warning_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_olesya = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_olesya_01",
				"pdr_objective_dungeon_olesya_02",
				"pdr_objective_dungeon_olesya_03",
				"pdr_objective_dungeon_olesya_04"
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
				"pdr_objective_dungeon_olesya_01",
				"pdr_objective_dungeon_olesya_02",
				"pdr_objective_dungeon_olesya_03",
				"pdr_objective_dungeon_olesya_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_spotting_sf_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwe_objective_spotting_sf_gear_01",
				[2.0] = "pwe_objective_spotting_sf_gear_02"
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
				[1.0] = "pwe_objective_spotting_sf_gear_01",
				[2.0] = "pwe_objective_spotting_sf_gear_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_trap_door_activated = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_trap_door_activated_01",
				"pdr_objective_castle_trap_door_activated_02",
				"pdr_objective_castle_trap_door_activated_03",
				"pdr_objective_castle_trap_door_activated_04"
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
				"pdr_objective_castle_trap_door_activated_01",
				"pdr_objective_castle_trap_door_activated_02",
				"pdr_objective_castle_trap_door_activated_03",
				"pdr_objective_castle_trap_door_activated_04"
			},
			randomize_indexes = {}
		},
		pwh_castle_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_castle_intro_b_01",
				[2.0] = "pwh_castle_intro_b_02"
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
				[1.0] = "pwh_castle_intro_b_01",
				[2.0] = "pwh_castle_intro_b_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_third_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_third_portal_tips_01",
				"pwe_objective_portals_third_portal_tips_02",
				"pwe_objective_portals_third_portal_tips_03",
				"pwe_objective_portals_third_portal_tips_04"
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
				"pwe_objective_portals_third_portal_tips_01",
				"pwe_objective_portals_third_portal_tips_02",
				"pwe_objective_portals_third_portal_tips_03",
				"pwe_objective_portals_third_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_trap_door_activated = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_trap_door_activated_01",
				"pes_objective_castle_trap_door_activated_02",
				"pes_objective_castle_trap_door_activated_03",
				"pes_objective_castle_trap_door_activated_04"
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
				"pes_objective_castle_trap_door_activated_01",
				"pes_objective_castle_trap_door_activated_02",
				"pes_objective_castle_trap_door_activated_03",
				"pes_objective_castle_trap_door_activated_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_traps = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_traps_01",
				"pdr_objective_castle_traps_02",
				"pdr_objective_castle_traps_03",
				"pdr_objective_castle_traps_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_castle_traps_01",
				"pdr_objective_castle_traps_02",
				"pdr_objective_castle_traps_03",
				"pdr_objective_castle_traps_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_portals_overheat_failed = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_portals_overheat_failed_01",
				"pwe_objective_portals_overheat_failed_02",
				"pwe_objective_portals_overheat_failed_03",
				"pwe_objective_portals_overheat_failed_04"
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
				"pwe_objective_portals_overheat_failed_01",
				"pwe_objective_portals_overheat_failed_02",
				"pwe_objective_portals_overheat_failed_03",
				"pwe_objective_portals_overheat_failed_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_traps_warning = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_traps_warning_01",
				"pes_objective_dungeon_traps_warning_02",
				"pes_objective_dungeon_traps_warning_03",
				"pes_objective_dungeon_traps_warning_04"
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
				"pes_objective_dungeon_traps_warning_01",
				"pes_objective_dungeon_traps_warning_02",
				"pes_objective_dungeon_traps_warning_03",
				"pes_objective_dungeon_traps_warning_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_spotting_pm_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_spotting_pm_gear_01",
				[2.0] = "pwh_objective_spotting_pm_gear_02"
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
				[1.0] = "pwh_objective_spotting_pm_gear_01",
				[2.0] = "pwh_objective_spotting_pm_gear_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_closed_portcullis = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_closed_portcullis_01",
				"pwe_objective_castle_closed_portcullis_02",
				"pwe_objective_castle_closed_portcullis_03",
				"pwe_objective_castle_closed_portcullis_04"
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
				"pwe_objective_castle_closed_portcullis_01",
				"pwe_objective_castle_closed_portcullis_02",
				"pwe_objective_castle_closed_portcullis_03",
				"pwe_objective_castle_closed_portcullis_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_lever = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_lever_01",
				"pwe_objective_castle_lever_02",
				"pwe_objective_castle_lever_03",
				"pwe_objective_castle_lever_04"
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
				"face_neutral"
			},
			localization_strings = {
				"pwe_objective_castle_lever_01",
				"pwe_objective_castle_lever_02",
				"pwe_objective_castle_lever_03",
				"pwe_objective_castle_lever_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_torch_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_torch_1_01",
				"pwe_objective_dungeon_torch_1_02",
				"pwe_objective_dungeon_torch_1_03",
				"pwe_objective_dungeon_torch_1_04"
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
				"pwe_objective_dungeon_torch_1_01",
				"pwe_objective_dungeon_torch_1_02",
				"pwe_objective_dungeon_torch_1_03",
				"pwe_objective_dungeon_torch_1_04"
			},
			randomize_indexes = {}
		},
		pwh_objective_spotting_sf_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_objective_spotting_sf_gear_01",
				[2.0] = "pwh_objective_spotting_sf_gear_02"
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
				[1.0] = "pwh_objective_spotting_sf_gear_01",
				[2.0] = "pwh_objective_spotting_sf_gear_02"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_spot_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_dungeon_spot_artifact_1_01",
				"pes_objective_dungeon_spot_artifact_1_02",
				"pes_objective_dungeon_spot_artifact_1_03",
				"pes_objective_dungeon_spot_artifact_1_04"
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
				"pes_objective_dungeon_spot_artifact_1_01",
				"pes_objective_dungeon_spot_artifact_1_02",
				"pes_objective_dungeon_spot_artifact_1_03",
				"pes_objective_dungeon_spot_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_portals_third_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_portals_third_portal_instruction_01",
				"pbw_objective_portals_third_portal_instruction_02",
				"pbw_objective_portals_third_portal_instruction_03",
				"pbw_objective_portals_third_portal_instruction_04"
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
				"pbw_objective_portals_third_portal_instruction_01",
				"pbw_objective_portals_third_portal_instruction_02",
				"pbw_objective_portals_third_portal_instruction_03",
				"pbw_objective_portals_third_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_torch_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_torch_2_01",
				"pwe_objective_dungeon_torch_2_02",
				"pwe_objective_dungeon_torch_2_03",
				"pwe_objective_dungeon_torch_2_04"
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
				"pwe_objective_dungeon_torch_2_01",
				"pwe_objective_dungeon_torch_2_02",
				"pwe_objective_dungeon_torch_2_03",
				"pwe_objective_dungeon_torch_2_04"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_lever_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_lever_2_01",
				"pes_objective_castle_lever_2_02",
				"pes_objective_castle_lever_2_03",
				"pes_objective_castle_lever_2_04"
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
				"pes_objective_castle_lever_2_01",
				"pes_objective_castle_lever_2_02",
				"pes_objective_castle_lever_2_03",
				"pes_objective_castle_lever_2_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_overheat_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_overheat_successful_01",
				"pdr_objective_portals_overheat_successful_02",
				"pdr_objective_portals_overheat_successful_03",
				"pdr_objective_portals_overheat_successful_04"
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
				"pdr_objective_portals_overheat_successful_01",
				"pdr_objective_portals_overheat_successful_02",
				"pdr_objective_portals_overheat_successful_03",
				"pdr_objective_portals_overheat_successful_04"
			},
			randomize_indexes = {}
		},
		pes_portals_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_portals_intro_c_01",
				[2.0] = "pes_portals_intro_c_02"
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
				[1.0] = "pes_portals_intro_c_01",
				[2.0] = "pes_portals_intro_c_02"
			},
			randomize_indexes = {}
		},
		pes_objective_castle_escaped = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_castle_escaped_01",
				"pes_objective_castle_escaped_02",
				"pes_objective_castle_escaped_03",
				"pes_objective_castle_escaped_04"
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
				"pes_objective_castle_escaped_01",
				"pes_objective_castle_escaped_02",
				"pes_objective_castle_escaped_03",
				"pes_objective_castle_escaped_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_ballroom = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_ballroom_01",
				"pdr_objective_castle_ballroom_02",
				"pdr_objective_castle_ballroom_03",
				"pdr_objective_castle_ballroom_04"
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
				"pdr_objective_castle_ballroom_01",
				"pdr_objective_castle_ballroom_02",
				"pdr_objective_castle_ballroom_03",
				"pdr_objective_castle_ballroom_04"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_olesya = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pes_objective_dungeon_olesya_01",
				[2.0] = "pes_objective_dungeon_olesya_02"
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
				[1.0] = "pes_objective_dungeon_olesya_01",
				[2.0] = "pes_objective_dungeon_olesya_02"
			},
			randomize_indexes = {}
		},
		pwe_objective_dungeon_spot_artifact_1 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_dungeon_spot_artifact_1_01",
				"pwe_objective_dungeon_spot_artifact_1_02",
				"pwe_objective_dungeon_spot_artifact_1_03",
				"pwe_objective_dungeon_spot_artifact_1_04"
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
				"pwe_objective_dungeon_spot_artifact_1_01",
				"pwe_objective_dungeon_spot_artifact_1_02",
				"pwe_objective_dungeon_spot_artifact_1_03",
				"pwe_objective_dungeon_spot_artifact_1_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_trap_door_activated = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_trap_door_activated_01",
				"pbw_objective_castle_trap_door_activated_02",
				"pbw_objective_castle_trap_door_activated_03",
				"pbw_objective_castle_trap_door_activated_04"
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
				"pbw_objective_castle_trap_door_activated_01",
				"pbw_objective_castle_trap_door_activated_02",
				"pbw_objective_castle_trap_door_activated_03",
				"pbw_objective_castle_trap_door_activated_04"
			},
			randomize_indexes = {}
		},
		pbw_portals_intro_b = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_portals_intro_b_01",
				[2.0] = "pbw_portals_intro_b_02"
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
				[1.0] = "pbw_portals_intro_b_01",
				[2.0] = "pbw_portals_intro_b_02"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_third_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_third_portal_instruction_01",
				"pes_objective_portals_third_portal_instruction_02",
				"pes_objective_portals_third_portal_instruction_03",
				"pes_objective_portals_third_portal_instruction_04"
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
				"pes_objective_portals_third_portal_instruction_01",
				"pes_objective_portals_third_portal_instruction_02",
				"pes_objective_portals_third_portal_instruction_03",
				"pes_objective_portals_third_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_traps_warning = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_dungeon_traps_warning_01",
				"pdr_objective_dungeon_traps_warning_02",
				"pdr_objective_dungeon_traps_warning_03",
				"pdr_objective_dungeon_traps_warning_04"
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
				"pdr_objective_dungeon_traps_warning_01",
				"pdr_objective_dungeon_traps_warning_02",
				"pdr_objective_dungeon_traps_warning_03",
				"pdr_objective_dungeon_traps_warning_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_castle_placing_statuette = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pbw_objective_castle_placing_statuette_01",
				"pbw_objective_castle_placing_statuette_02",
				"pbw_objective_castle_placing_statuette_03",
				"pbw_objective_castle_placing_statuette_04"
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
				"pbw_objective_castle_placing_statuette_01",
				"pbw_objective_castle_placing_statuette_02",
				"pbw_objective_castle_placing_statuette_03",
				"pbw_objective_castle_placing_statuette_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_third_portal_instruction = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_third_portal_instruction_01",
				"pdr_objective_portals_third_portal_instruction_02",
				"pdr_objective_portals_third_portal_instruction_03",
				"pdr_objective_portals_third_portal_instruction_04"
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
				"pdr_objective_portals_third_portal_instruction_01",
				"pdr_objective_portals_third_portal_instruction_02",
				"pdr_objective_portals_third_portal_instruction_03",
				"pdr_objective_portals_third_portal_instruction_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_statue = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_statue_01",
				"pwe_objective_castle_statue_02",
				"pwe_objective_castle_statue_03",
				"pwe_objective_castle_statue_04"
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
				"pwe_objective_castle_statue_01",
				"pwe_objective_castle_statue_02",
				"pwe_objective_castle_statue_03",
				"pwe_objective_castle_statue_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_second_portal_tips = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_second_portal_tips_01",
				"pdr_objective_portals_second_portal_tips_02",
				"pdr_objective_portals_second_portal_tips_03",
				"pdr_objective_portals_second_portal_tips_04"
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
				"pdr_objective_portals_second_portal_tips_01",
				"pdr_objective_portals_second_portal_tips_02",
				"pdr_objective_portals_second_portal_tips_03",
				"pdr_objective_portals_second_portal_tips_04"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_skaven_entry = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_skaven_entry_01",
				"pwe_objective_castle_skaven_entry_02",
				"pwe_objective_castle_skaven_entry_03",
				"pwe_objective_castle_skaven_entry_04"
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
				"pwe_objective_castle_skaven_entry_01",
				"pwe_objective_castle_skaven_entry_02",
				"pwe_objective_castle_skaven_entry_03",
				"pwe_objective_castle_skaven_entry_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_healing_draught = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "drachenfels",
			category = "seen_items",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_gameplay_healing_draught_01",
				"pdr_gameplay_healing_draught_02",
				"pdr_gameplay_healing_draught_03",
				"pdr_gameplay_healing_draught_04",
				"pdr_gameplay_healing_draught_05",
				"pdr_gameplay_healing_draught_06",
				"pdr_gameplay_healing_draught_07",
				"pdr_gameplay_healing_draught_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_neutral",
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_gameplay_healing_draught_01",
				"pdr_gameplay_healing_draught_02",
				"pdr_gameplay_healing_draught_03",
				"pdr_gameplay_healing_draught_04",
				"pdr_gameplay_healing_draught_05",
				"pdr_gameplay_healing_draught_06",
				"pdr_gameplay_healing_draught_07",
				"pdr_gameplay_healing_draught_08"
			},
			randomize_indexes = {}
		},
		pdr_objective_dungeon_torture_racks = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pdr_objective_dungeon_torture_racks_01",
				"pdr_objective_dungeon_torture_racks_02",
				"pdr_objective_dungeon_torture_racks_03"
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
				"pdr_objective_dungeon_torture_racks_01",
				"pdr_objective_dungeon_torture_racks_02",
				"pdr_objective_dungeon_torture_racks_03"
			},
			randomize_indexes = {}
		},
		pes_objective_dungeon_torture_racks = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pes_objective_dungeon_torture_racks_01",
				"pes_objective_dungeon_torture_racks_02",
				"pes_objective_dungeon_torture_racks_03"
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
				"pes_objective_dungeon_torture_racks_01",
				"pes_objective_dungeon_torture_racks_02",
				"pes_objective_dungeon_torture_racks_03"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_mission_successful = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_mission_successful_01",
				"pes_objective_portals_mission_successful_02",
				"pes_objective_portals_mission_successful_03",
				"pes_objective_portals_mission_successful_04"
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
				"pes_objective_portals_mission_successful_01",
				"pes_objective_portals_mission_successful_02",
				"pes_objective_portals_mission_successful_03",
				"pes_objective_portals_mission_successful_04"
			},
			randomize_indexes = {}
		},
		pes_objective_portals_arrive_first_portal = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pes_objective_portals_arrive_first_portal_01",
				"pes_objective_portals_arrive_first_portal_02",
				"pes_objective_portals_arrive_first_portal_03",
				"pes_objective_portals_arrive_first_portal_04"
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
				"pes_objective_portals_arrive_first_portal_01",
				"pes_objective_portals_arrive_first_portal_02",
				"pes_objective_portals_arrive_first_portal_03",
				"pes_objective_portals_arrive_first_portal_04"
			},
			randomize_indexes = {}
		},
		pwh_portals_intro_c = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pwh_portals_intro_c_01",
				[2.0] = "pwh_portals_intro_c_02"
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
				[1.0] = "pwh_portals_intro_c_01",
				[2.0] = "pwh_portals_intro_c_02"
			},
			randomize_indexes = {}
		},
		pbw_objective_dungeon_torture_racks = {
			sound_events_n = 3,
			randomize_indexes_n = 0,
			face_animations_n = 3,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 3,
			sound_events = {
				"pbw_objective_dungeon_torture_racks_01",
				"pbw_objective_dungeon_torture_racks_02",
				"pbw_objective_dungeon_torture_racks_03"
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
				"pbw_objective_dungeon_torture_racks_01",
				"pbw_objective_dungeon_torture_racks_02",
				"pbw_objective_dungeon_torture_racks_03"
			},
			randomize_indexes = {}
		},
		pwe_objective_castle_catacombs_arrival = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 4,
			sound_events = {
				"pwe_objective_castle_catacombs_arrival_01",
				"pwe_objective_castle_catacombs_arrival_02",
				"pwe_objective_castle_catacombs_arrival_03",
				"pwe_objective_castle_catacombs_arrival_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pwe_objective_castle_catacombs_arrival_01",
				"pwe_objective_castle_catacombs_arrival_02",
				"pwe_objective_castle_catacombs_arrival_03",
				"pwe_objective_castle_catacombs_arrival_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_unmarked_grave = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pdr_objective_portals_unmarked_grave_01",
				[2.0] = "pdr_objective_portals_unmarked_grave_02"
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
				[1.0] = "pdr_objective_portals_unmarked_grave_01",
				[2.0] = "pdr_objective_portals_unmarked_grave_02"
			},
			randomize_indexes = {}
		},
		pdr_objective_portals_portal_overheat_near = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_portals_portal_overheat_near_01",
				"pdr_objective_portals_portal_overheat_near_02",
				"pdr_objective_portals_portal_overheat_near_03",
				"pdr_objective_portals_portal_overheat_near_04"
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
				"pdr_objective_portals_portal_overheat_near_01",
				"pdr_objective_portals_portal_overheat_near_02",
				"pdr_objective_portals_portal_overheat_near_03",
				"pdr_objective_portals_portal_overheat_near_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_wood_door = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "guidance",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_wood_door_01",
				"pdr_objective_castle_wood_door_02",
				"pdr_objective_castle_wood_door_03",
				"pdr_objective_castle_wood_door_04"
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
				"pdr_objective_castle_wood_door_01",
				"pdr_objective_castle_wood_door_02",
				"pdr_objective_castle_wood_door_03",
				"pdr_objective_castle_wood_door_04"
			},
			randomize_indexes = {}
		},
		pdr_objective_castle_lever_2 = {
			sound_events_n = 4,
			randomize_indexes_n = 0,
			face_animations_n = 4,
			database = "drachenfels",
			category = "player_feedback",
			dialogue_animations_n = 4,
			sound_events = {
				"pdr_objective_castle_lever_2_01",
				"pdr_objective_castle_lever_2_02",
				"pdr_objective_castle_lever_2_03",
				"pdr_objective_castle_lever_2_04"
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
				"face_neutral",
				"face_neutral"
			},
			localization_strings = {
				"pdr_objective_castle_lever_2_01",
				"pdr_objective_castle_lever_2_02",
				"pdr_objective_castle_lever_2_03",
				"pdr_objective_castle_lever_2_04"
			},
			randomize_indexes = {}
		},
		pbw_objective_spotting_pm_gear = {
			sound_events_n = 2,
			randomize_indexes_n = 0,
			face_animations_n = 2,
			database = "drachenfels",
			category = "level_talk",
			dialogue_animations_n = 2,
			sound_events = {
				[1.0] = "pbw_objective_spotting_pm_gear_01",
				[2.0] = "pbw_objective_spotting_pm_gear_02"
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
				[1.0] = "pbw_objective_spotting_pm_gear_01",
				[2.0] = "pbw_objective_spotting_pm_gear_02"
			},
			randomize_indexes = {}
		}
	})

	return 
end
