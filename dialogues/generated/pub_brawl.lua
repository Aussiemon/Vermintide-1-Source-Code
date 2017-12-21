return function ()
	define_rule({
		name = "pwh_gameplay_pub_brawl_hit_empire_soldier",
		response = "pwh_gameplay_pub_brawl_hit_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_pub_brawl_hit_bright_wizard",
		response = "pwh_gameplay_pub_brawl_hit_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_pub_brawl_hit_dwarf_ranger",
		response = "pwh_gameplay_pub_brawl_hit_dwarf_ranger",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_gameplay_pub_brawl_hit_wood_elf",
		response = "pwh_gameplay_pub_brawl_hit_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"witch_hunter"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_gameplay_pub_brawl_hit_witch_hunter",
		response = "pes_gameplay_pub_brawl_hit_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_gameplay_pub_brawl_hit_bright_wizard",
		response = "pes_gameplay_pub_brawl_hit_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_gameplay_pub_brawl_hit_wood_elf",
		response = "pes_gameplay_pub_brawl_hit_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pes_gameplay_pub_brawl_hit_dwarf_ranger",
		response = "pes_gameplay_pub_brawl_hit_dwarf_ranger",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"empire_soldier"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_pub_brawl_hit_witch_hunter",
		response = "pdr_gameplay_pub_brawl_hit_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_pub_brawl_hit_bright_wizard",
		response = "pdr_gameplay_pub_brawl_hit_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_pub_brawl_hit_wood_elf",
		response = "pdr_gameplay_pub_brawl_hit_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pdr_gameplay_pub_brawl_hit_empire_soldier",
		response = "pdr_gameplay_pub_brawl_hit_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_gameplay_pub_brawl_hit_witch_hunter",
		response = "pwe_gameplay_pub_brawl_hit_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_gameplay_pub_brawl_hit_dwarf_ranger",
		response = "pwe_gameplay_pub_brawl_hit_dwarf_ranger",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_gameplay_pub_brawl_hit_bright_wizard",
		response = "pwe_gameplay_pub_brawl_hit_bright_wizard",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwe_gameplay_pub_brawl_hit_empire_soldier",
		response = "pwe_gameplay_pub_brawl_hit_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"wood_elf"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_pub_brawl_hit_witch_hunter",
		response = "pbw_gameplay_pub_brawl_hit_witch_hunter",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"witch_hunter"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_pub_brawl_hit_dwarf_ranger",
		response = "pbw_gameplay_pub_brawl_hit_dwarf_ranger",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"dwarf_ranger"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_pub_brawl_hit_wood_elf",
		response = "pbw_gameplay_pub_brawl_hit_wood_elf",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"wood_elf"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pbw_gameplay_pub_brawl_hit_empire_soldier",
		response = "pbw_gameplay_pub_brawl_hit_empire_soldier",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"friendly_fire"
			},
			{
				"query_context",
				"target",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"source_name",
				OP.EQ,
				"bright_wizard"
			},
			{
				"query_context",
				"player_profile",
				OP.EQ,
				"empire_soldier"
			},
			{
				"user_context",
				"player_profile",
				OP.EQ,
				"bright_wizard"
			},
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_pub_brawl_hit",
				OP.TIMESET
			}
		}
	})
	define_rule({
		name = "pwh_bar_brawl_challenge",
		response = "pwh_bar_brawl_challenge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_challenge"
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
				"user_memory",
				"last_challange_witch_hunter",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_challange_witch_hunter",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pwh_bar_brawl_drink",
		name = "pwh_bar_brawl_drink",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_drink"
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
		name = "pbw_bar_brawl_challenge",
		response = "pbw_bar_brawl_challenge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_challenge"
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
				"user_memory",
				"last_challange_bright_wizard",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_challange_bright_wizard",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pbw_bar_brawl_drink",
		name = "pbw_bar_brawl_drink",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_drink"
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
		name = "pdr_bar_brawl_challenge",
		response = "pdr_bar_brawl_challenge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_challenge"
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
				"user_memory",
				"last_challange_dwarf_ranger",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_challange_dwarf_ranger",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pdr_bar_brawl_drink",
		name = "pdr_bar_brawl_drink",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_drink"
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
		name = "pes_bar_brawl_challenge",
		response = "pes_bar_brawl_challenge",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_challenge"
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
				"user_memory",
				"last_challange_empire_soldier",
				OP.TIMEDIFF,
				OP.GT,
				5
			}
		},
		on_done = {
			{
				"user_memory",
				"last_challange_empire_soldier",
				OP.TIMESET
			}
		}
	})
	define_rule({
		response = "pes_bar_brawl_drink",
		name = "pes_bar_brawl_drink",
		criterias = {
			{
				"query_context",
				"concept",
				OP.EQ,
				"seen_item"
			},
			{
				"query_context",
				"item_tag",
				OP.EQ,
				"bar_brawl_drink"
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
	add_dialogues({
		pdr_bar_brawl_drink = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pdr_bar_brawl_drink_01",
				"pdr_bar_brawl_drink_02",
				"pdr_bar_brawl_drink_03",
				"pdr_bar_brawl_drink_04",
				"pdr_bar_brawl_drink_04",
				"pdr_bar_brawl_drink_05",
				"pdr_bar_brawl_drink_05"
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
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pdr_bar_brawl_drink_01",
				"pdr_bar_brawl_drink_02",
				"pdr_bar_brawl_drink_03",
				"pdr_bar_brawl_drink_04",
				"pdr_bar_brawl_drink_04",
				"pdr_bar_brawl_drink_05",
				"pdr_bar_brawl_drink_05"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_pub_brawl_hit_empire_soldier = {
			sound_events_n = 19,
			randomize_indexes_n = 0,
			face_animations_n = 19,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 19,
			sound_events = {
				"pwh_gameplay_friendly_fire_empire_soldier_01",
				"pwh_gameplay_friendly_fire_empire_soldier_03",
				"pwh_gameplay_friendly_fire_empire_soldier_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_02",
				"pwh_curse_03"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwh_gameplay_friendly_fire_empire_soldier_01",
				"pwh_gameplay_friendly_fire_empire_soldier_03",
				"pwh_gameplay_friendly_fire_empire_soldier_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_02",
				"pwh_curse_03"
			},
			randomize_indexes = {}
		},
		pbw_bar_brawl_drink = {
			sound_events_n = 6,
			randomize_indexes_n = 0,
			face_animations_n = 6,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 6,
			sound_events = {
				"pbw_bar_brawl_drink_01",
				"pbw_bar_brawl_drink_02",
				"pbw_bar_brawl_drink_03",
				"pbw_bar_brawl_drink_04",
				"pbw_bar_brawl_challenge_03",
				"pdr_bar_brawl_challenge_01"
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_bar_brawl_drink_01",
				"pbw_bar_brawl_drink_02",
				"pbw_bar_brawl_drink_03",
				"pbw_bar_brawl_drink_04",
				"pbw_bar_brawl_challenge_03",
				"pdr_bar_brawl_challenge_01"
			},
			randomize_indexes = {}
		},
		pes_bar_brawl_challenge = {
			sound_events_n = 14,
			randomize_indexes_n = 0,
			face_animations_n = 14,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 14,
			sound_events = {
				"pes_bar_brawl_challenge_01",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pbw_bar_brawl_challenge_02",
				"pes_bar_brawl_challenge_03",
				"pes_bar_brawl_taunt_01",
				"pes_bar_brawl_taunt_02",
				"pes_bar_brawl_taunt_03",
				"pes_bar_brawl_taunt_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_neutral",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pes_bar_brawl_challenge_01",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pbw_bar_brawl_challenge_02",
				"pes_bar_brawl_challenge_03",
				"pes_bar_brawl_taunt_01",
				"pes_bar_brawl_taunt_02",
				"pes_bar_brawl_taunt_03",
				"pes_bar_brawl_taunt_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_pub_brawl_hit_empire_soldier = {
			sound_events_n = 15,
			randomize_indexes_n = 0,
			face_animations_n = 15,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 15,
			sound_events = {
				"pdr_gameplay_friendly_fire_empire_soldier_03",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pdr_gameplay_friendly_fire_empire_soldier_03",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pwe_gameplay_pub_brawl_hit_dwarf_ranger = {
			sound_events_n = 13,
			randomize_indexes_n = 0,
			face_animations_n = 13,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 13,
			sound_events = {
				"pwe_gameplay_friendly_fire_dwarf_ranger_01",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_gameplay_friendly_fire_dwarf_ranger_01",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_pub_brawl_hit_wood_elf = {
			sound_events_n = 19,
			randomize_indexes_n = 0,
			face_animations_n = 19,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 19,
			sound_events = {
				"pwh_gameplay_friendly_fire_wood_elf_01",
				"pwh_gameplay_friendly_fire_wood_elf_02",
				"pwh_gameplay_friendly_fire_wood_elf_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_10",
				"pwh_curse_11"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwh_gameplay_friendly_fire_wood_elf_01",
				"pwh_gameplay_friendly_fire_wood_elf_02",
				"pwh_gameplay_friendly_fire_wood_elf_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_10",
				"pwh_curse_11"
			},
			randomize_indexes = {}
		},
		pes_bar_brawl_drink = {
			sound_events_n = 5,
			randomize_indexes_n = 0,
			face_animations_n = 5,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 5,
			sound_events = {
				"pes_bar_brawl_drink_01",
				"pes_bar_brawl_drink_02",
				"pes_bar_brawl_drink_03",
				"pes_bar_brawl_drink_04",
				"pes_bar_brawl_drink_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy",
				"face_happy"
			},
			localization_strings = {
				"pes_bar_brawl_drink_01",
				"pes_bar_brawl_drink_02",
				"pes_bar_brawl_drink_03",
				"pes_bar_brawl_drink_04",
				"pes_bar_brawl_drink_04"
			},
			randomize_indexes = {}
		},
		pes_gameplay_pub_brawl_hit_bright_wizard = {
			sound_events_n = 16,
			randomize_indexes_n = 0,
			face_animations_n = 16,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 16,
			sound_events = {
				"pes_gameplay_friendly_fire_bright_wizard_02",
				"pes_gameplay_friendly_fire_bright_wizard_04",
				"pes_curse_05",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_11",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pes_gameplay_friendly_fire_bright_wizard_02",
				"pes_gameplay_friendly_fire_bright_wizard_04",
				"pes_curse_05",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_11",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_pub_brawl_hit_empire_soldier = {
			sound_events_n = 16,
			randomize_indexes_n = 0,
			face_animations_n = 16,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 16,
			sound_events = {
				"pbw_gameplay_friendly_fire_empire_soldier_01",
				"pbw_gameplay_friendly_fire_empire_soldier_02",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_gameplay_friendly_fire_empire_soldier_01",
				"pbw_gameplay_friendly_fire_empire_soldier_02",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			randomize_indexes = {}
		},
		pdr_bar_brawl_challenge = {
			sound_events_n = 8,
			randomize_indexes_n = 0,
			face_animations_n = 8,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 8,
			sound_events = {
				"pdr_bar_brawl_challenge_01",
				"pdr_bar_brawl_challenge_06",
				"pbw_bar_brawl_challenge_02",
				"pdr_bar_brawl_challenge_03",
				"pdr_bar_brawl_taunt_01",
				"pdr_bar_brawl_taunt_02",
				"pdr_bar_brawl_taunt_03",
				"pdr_bar_brawl_taunt_04"
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
				"pdr_bar_brawl_challenge_01",
				"pdr_bar_brawl_challenge_06",
				"pbw_bar_brawl_challenge_02",
				"pdr_bar_brawl_challenge_03",
				"pdr_bar_brawl_taunt_01",
				"pdr_bar_brawl_taunt_02",
				"pdr_bar_brawl_taunt_03",
				"pdr_bar_brawl_taunt_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_pub_brawl_hit_witch_hunter = {
			sound_events_n = 18,
			randomize_indexes_n = 0,
			face_animations_n = 18,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 18,
			sound_events = {
				"pbw_gameplay_friendly_fire_witch_hunter_01",
				"pbw_gameplay_friendly_fire_witch_hunter_02",
				"pbw_gameplay_friendly_fire_witch_hunter_03",
				"pbw_gameplay_friendly_fire_witch_hunter_04",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_gameplay_friendly_fire_witch_hunter_01",
				"pbw_gameplay_friendly_fire_witch_hunter_02",
				"pbw_gameplay_friendly_fire_witch_hunter_03",
				"pbw_gameplay_friendly_fire_witch_hunter_04",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_pub_brawl_hit_wood_elf = {
			sound_events_n = 17,
			randomize_indexes_n = 0,
			face_animations_n = 17,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 17,
			sound_events = {
				"pdr_gameplay_friendly_fire_wood_elf_01",
				"pdr_gameplay_friendly_fire_wood_elf_03",
				"pdr_gameplay_friendly_fire_wood_elf_04",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pdr_gameplay_friendly_fire_wood_elf_01",
				"pdr_gameplay_friendly_fire_wood_elf_03",
				"pdr_gameplay_friendly_fire_wood_elf_04",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pbw_bar_brawl_challenge = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pbw_bar_brawl_challenge_01",
				"pbw_bar_brawl_challenge_04",
				"pbw_bar_brawl_challenge_06",
				"pbw_bar_brawl_taunt_01",
				"pbw_bar_brawl_taunt_02",
				"pbw_bar_brawl_taunt_03",
				"pbw_bar_brawl_taunt_04"
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
				"pbw_bar_brawl_challenge_01",
				"pbw_bar_brawl_challenge_04",
				"pbw_bar_brawl_challenge_06",
				"pbw_bar_brawl_taunt_01",
				"pbw_bar_brawl_taunt_02",
				"pbw_bar_brawl_taunt_03",
				"pbw_bar_brawl_taunt_04"
			},
			randomize_indexes = {}
		},
		pes_gameplay_pub_brawl_hit_witch_hunter = {
			sound_events_n = 17,
			randomize_indexes_n = 0,
			face_animations_n = 17,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 17,
			sound_events = {
				"pes_gameplay_friendly_fire_witch_hunter_03",
				"pes_gameplay_friendly_fire_witch_hunter_04",
				"pes_curse_04",
				"pes_curse_05",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_11",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pes_gameplay_friendly_fire_witch_hunter_03",
				"pes_gameplay_friendly_fire_witch_hunter_04",
				"pes_curse_04",
				"pes_curse_05",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_11",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_pub_brawl_hit_bright_wizard = {
			sound_events_n = 16,
			randomize_indexes_n = 0,
			face_animations_n = 16,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 16,
			sound_events = {
				"pdr_gameplay_friendly_fire_bright_wizard_02",
				"pdr_gameplay_friendly_fire_bright_wizard_04",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pdr_gameplay_friendly_fire_bright_wizard_02",
				"pdr_gameplay_friendly_fire_bright_wizard_04",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_pub_brawl_hit_wood_elf = {
			sound_events_n = 16,
			randomize_indexes_n = 0,
			face_animations_n = 16,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 16,
			sound_events = {
				"pbw_gameplay_friendly_fire_wood_elf_01",
				"pbw_gameplay_friendly_fire_wood_elf_04",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_gameplay_friendly_fire_wood_elf_01",
				"pbw_gameplay_friendly_fire_wood_elf_04",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			randomize_indexes = {}
		},
		pwh_bar_brawl_challenge = {
			sound_events_n = 11,
			randomize_indexes_n = 0,
			face_animations_n = 11,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 11,
			sound_events = {
				"pwh_bar_brawl_challenge_01",
				"pwh_bar_brawl_challenge_02",
				"pwh_bar_brawl_challenge_03",
				"pwh_bar_brawl_challenge_04",
				"pwh_bar_brawl_challenge_05",
				"pwh_bar_brawl_challenge_03_alt1",
				"pwh_bar_brawl_challenge_04_alt1",
				"pwh_bar_brawl_taunt_01",
				"pwh_bar_brawl_taunt_02",
				"pwh_bar_brawl_taunt_03",
				"pwh_bar_brawl_taunt_04"
			},
			dialogue_animations = {
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_concerned",
				"face_concerned",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pwh_bar_brawl_challenge_01",
				"pwh_bar_brawl_challenge_02",
				"pwh_bar_brawl_challenge_03",
				"pwh_bar_brawl_challenge_04",
				"pwh_bar_brawl_challenge_05",
				"pwh_bar_brawl_challenge_03_alt1",
				"pwh_bar_brawl_challenge_04_alt1",
				"pwh_bar_brawl_taunt_01",
				"pwh_bar_brawl_taunt_02",
				"pwh_bar_brawl_taunt_03",
				"pwh_bar_brawl_taunt_04"
			},
			randomize_indexes = {}
		},
		pbw_gameplay_pub_brawl_hit_dwarf_ranger = {
			sound_events_n = 17,
			randomize_indexes_n = 0,
			face_animations_n = 17,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 17,
			sound_events = {
				"pbw_gameplay_friendly_fire_dwarf_ranger_01",
				"pbw_gameplay_friendly_fire_dwarf_ranger_03",
				"pbw_gameplay_friendly_fire_dwarf_ranger_04",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_concerned",
				"face_concerned"
			},
			localization_strings = {
				"pbw_gameplay_friendly_fire_dwarf_ranger_01",
				"pbw_gameplay_friendly_fire_dwarf_ranger_03",
				"pbw_gameplay_friendly_fire_dwarf_ranger_04",
				"pbw_curse_01",
				"pbw_curse_02",
				"pbw_curse_03",
				"pbw_curse_04",
				"pbw_curse_05",
				"pbw_curse_06",
				"pbw_curse_07",
				"pbw_curse_08",
				"pbw_curse_09",
				"pbw_curse_10",
				"pbw_curse_11",
				"pbw_curse_12",
				"pbw_bar_brawl_challenge_05",
				"pbw_bar_brawl_challenge_06"
			},
			randomize_indexes = {}
		},
		pdr_gameplay_pub_brawl_hit_witch_hunter = {
			sound_events_n = 15,
			randomize_indexes_n = 0,
			face_animations_n = 15,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 15,
			sound_events = {
				"pdr_gameplay_friendly_fire_witch_hunter_02",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pdr_gameplay_friendly_fire_witch_hunter_02",
				"pdr_curse_02",
				"pdr_curse_03",
				"pdr_curse_04",
				"pdr_curse_05",
				"pdr_curse_11",
				"pdr_curse_12",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_05",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_06",
				"pdr_bar_brawl_challenge_04",
				"pdr_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pwe_gameplay_pub_brawl_hit_empire_soldier = {
			sound_events_n = 13,
			randomize_indexes_n = 0,
			face_animations_n = 13,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 13,
			sound_events = {
				"pwe_gameplay_friendly_fire_empire_soldier_02",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_gameplay_friendly_fire_empire_soldier_02",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			randomize_indexes = {}
		},
		pwh_bar_brawl_drink = {
			sound_events_n = 7,
			randomize_indexes_n = 0,
			face_animations_n = 7,
			database = "pub_brawl",
			category = "player_alerts",
			dialogue_animations_n = 7,
			sound_events = {
				"pwh_bar_brawl_drink_01",
				"pwh_bar_brawl_drink_02",
				"pwh_bar_brawl_drink_03",
				"pwh_bar_brawl_drink_04",
				"pwh_bar_brawl_drink_01_alt1",
				"pwh_bar_brawl_drink_02_alt1",
				"pwh_bar_brawl_drink_04_alt1"
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
				"pwh_bar_brawl_drink_01",
				"pwh_bar_brawl_drink_02",
				"pwh_bar_brawl_drink_03",
				"pwh_bar_brawl_drink_04",
				"pwh_bar_brawl_drink_01_alt1",
				"pwh_bar_brawl_drink_02_alt1",
				"pwh_bar_brawl_drink_04_alt1"
			},
			randomize_indexes = {}
		},
		pwe_gameplay_pub_brawl_hit_bright_wizard = {
			sound_events_n = 13,
			randomize_indexes_n = 0,
			face_animations_n = 13,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 13,
			sound_events = {
				"pwe_gameplay_friendly_fire_bright_wizard_04",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_gameplay_friendly_fire_bright_wizard_04",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			randomize_indexes = {}
		},
		pes_gameplay_pub_brawl_hit_dwarf_ranger = {
			sound_events_n = 17,
			randomize_indexes_n = 0,
			face_animations_n = 17,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 17,
			sound_events = {
				"pes_gameplay_friendly_fire_dwarf_ranger_01",
				"pes_gameplay_friendly_fire_dwarf_ranger_02",
				"pes_gameplay_friendly_fire_dwarf_ranger_03",
				"pes_curse_05",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pes_gameplay_friendly_fire_dwarf_ranger_01",
				"pes_gameplay_friendly_fire_dwarf_ranger_02",
				"pes_gameplay_friendly_fire_dwarf_ranger_03",
				"pes_curse_05",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_pub_brawl_hit_dwarf_ranger = {
			sound_events_n = 19,
			randomize_indexes_n = 0,
			face_animations_n = 19,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 19,
			sound_events = {
				"pwh_gameplay_friendly_fire_dwarf_ranger_01",
				"pwh_gameplay_friendly_fire_dwarf_ranger_02",
				"pwh_gameplay_friendly_fire_dwarf_ranger_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_07",
				"pwh_curse_08"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwh_gameplay_friendly_fire_dwarf_ranger_01",
				"pwh_gameplay_friendly_fire_dwarf_ranger_02",
				"pwh_gameplay_friendly_fire_dwarf_ranger_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_07",
				"pwh_curse_08"
			},
			randomize_indexes = {}
		},
		pwe_gameplay_pub_brawl_hit_witch_hunter = {
			sound_events_n = 15,
			randomize_indexes_n = 0,
			face_animations_n = 15,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 15,
			sound_events = {
				"pwe_gameplay_friendly_fire_witch_hunter_01",
				"pwe_gameplay_friendly_fire_witch_hunter_02",
				"pwe_gameplay_friendly_fire_witch_hunter_04",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwe_gameplay_friendly_fire_witch_hunter_01",
				"pwe_gameplay_friendly_fire_witch_hunter_02",
				"pwe_gameplay_friendly_fire_witch_hunter_04",
				"pwe_curse_01",
				"pwe_curse_02",
				"pwe_curse_03",
				"pwe_curse_04",
				"pwe_curse_05",
				"pwe_curse_06",
				"pwe_curse_07",
				"pwe_curse_08",
				"pwe_curse_09",
				"pwe_curse_10",
				"pwe_curse_11",
				"pwe_curse_12"
			},
			randomize_indexes = {}
		},
		pwh_gameplay_pub_brawl_hit_bright_wizard = {
			sound_events_n = 19,
			randomize_indexes_n = 0,
			face_animations_n = 19,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 19,
			sound_events = {
				"pwh_gameplay_friendly_fire_bright_wizard_02",
				"pwh_gameplay_friendly_fire_bright_wizard_03",
				"pwh_gameplay_friendly_fire_bright_wizard_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_05",
				"pwh_curse_06"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk"
			},
			face_animations = {
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pwh_gameplay_friendly_fire_bright_wizard_02",
				"pwh_gameplay_friendly_fire_bright_wizard_03",
				"pwh_gameplay_friendly_fire_bright_wizard_04",
				"pwh_gameplay_pub_brawl_hit_01",
				"pwh_gameplay_pub_brawl_hit_02",
				"pwh_gameplay_pub_brawl_hit_03",
				"pwh_gameplay_pub_brawl_hit_04",
				"pwh_gameplay_pub_brawl_hit_05",
				"pwh_gameplay_pub_brawl_hit_06",
				"pwh_gameplay_pub_brawl_hit_07",
				"pwh_gameplay_pub_brawl_hit_08",
				"pwh_gameplay_pub_brawl_hit_09",
				"pwh_gameplay_pub_brawl_hit_10",
				"pwh_gameplay_pub_brawl_hit_11",
				"pwh_gameplay_pub_brawl_hit_12",
				"pwh_gameplay_pub_brawl_hit_13",
				"pwh_gameplay_pub_brawl_hit_14",
				"pwh_curse_05",
				"pwh_curse_06"
			},
			randomize_indexes = {}
		},
		pes_gameplay_pub_brawl_hit_wood_elf = {
			sound_events_n = 14,
			randomize_indexes_n = 0,
			face_animations_n = 14,
			database = "pub_brawl",
			category = "player_feedback",
			dialogue_animations_n = 14,
			sound_events = {
				"pes_gameplay_friendly_fire_wood_elf_03",
				"pes_gameplay_friendly_fire_wood_elf_04",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_11",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			dialogue_animations = {
				"dialogue_shout",
				"dialogue_shout",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
				"dialogue_talk",
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
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry",
				"face_angry"
			},
			localization_strings = {
				"pes_gameplay_friendly_fire_wood_elf_03",
				"pes_gameplay_friendly_fire_wood_elf_04",
				"pes_curse_06",
				"pes_curse_07",
				"pes_curse_10",
				"pes_curse_11",
				"pes_curse_12",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_06",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_05",
				"pes_bar_brawl_challenge_04",
				"pes_bar_brawl_challenge_04"
			},
			randomize_indexes = {}
		}
	})

	return 
end
