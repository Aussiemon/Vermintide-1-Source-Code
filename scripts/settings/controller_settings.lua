local unbind_button = "left button **"

if Application.platform() == "win32" then
	PlayerControllerKeymaps = {
		toggle_input_helper = {
			input_mappings = {
				{
					"keyboard",
					"f1",
					"pressed"
				}
			}
		},
		action_one = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"pressed"
				},
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_one_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"held"
				},
				{
					"mouse",
					"left",
					"held"
				}
			}
		},
		action_one_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"released"
				},
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		action_two = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"pressed"
				},
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		action_two_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"held"
				},
				{
					"mouse",
					"right",
					"held"
				}
			}
		},
		action_two_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"released"
				},
				{
					"mouse",
					"right",
					"released"
				}
			}
		},
		action_three = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"pressed"
				},
				{
					"mouse",
					"extra_1",
					"pressed"
				}
			}
		},
		action_three_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"held"
				},
				{
					"mouse",
					"extra_1",
					"held"
				}
			}
		},
		action_three_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"released"
				},
				{
					"mouse",
					"extra_1",
					"released"
				}
			}
		},
		action_inspect = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"pressed"
				},
				{
					"keyboard",
					"z",
					"pressed"
				}
			}
		},
		action_inspect_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"held"
				},
				{
					"keyboard",
					"z",
					"held"
				}
			}
		},
		action_inspect_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"released"
				},
				{
					"keyboard",
					"z",
					"released"
				}
			}
		},
		action_one_softbutton_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"soft_button"
				}
			}
		},
		action_one_mouse = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_instant_grenade_throw = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"right_shoulder",
					"pressed"
				}
			}
		},
		action_instant_grenade_throw_released = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"right_shoulder",
					"released"
				}
			}
		},
		action_instant_grenade_throw_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"right_shoulder",
					"held"
				}
			}
		},
		action_instant_heal_self = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		action_instant_heal_self_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"held"
				},
				{
					"gamepad",
					"d_down",
					"held"
				}
			}
		},
		action_instant_drink_potion = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		action_instant_equip_grimoire = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		action_instant_equip_tome = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		action_instant_equip_grenade = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_left",
					"pressed"
				}
			}
		},
		action_instant_equip_healing_draught = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		action_instant_heal_other = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"pressed"
				}
			}
		},
		action_instant_heal_other_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"held"
				}
			}
		},
		weapon_reload = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"r",
					"pressed"
				},
				{
					"gamepad",
					"x",
					"pressed"
				}
			}
		},
		weapon_reload_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"r",
					"held"
				},
				{
					"gamepad",
					"x",
					"held"
				}
			}
		},
		character_inspecting = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"x",
					"held"
				},
				{
					"gamepad",
					"right_thumb",
					"held"
				}
			}
		},
		wield_1 = {
			input_mappings = {
				{
					"keyboard",
					"1",
					"pressed"
				}
			}
		},
		wield_2 = {
			input_mappings = {
				{
					"keyboard",
					"2",
					"pressed"
				}
			}
		},
		wield_3 = {
			input_mappings = {
				{
					"keyboard",
					"3",
					"pressed"
				}
			}
		},
		wield_4 = {
			input_mappings = {
				{
					"keyboard",
					"4",
					"pressed"
				}
			}
		},
		wield_5 = {
			input_mappings = {
				{
					"keyboard",
					"5",
					"pressed"
				}
			}
		},
		wield_6 = {
			input_mappings = {
				{
					"keyboard",
					"6",
					"pressed"
				}
			}
		},
		wield_7 = {
			input_mappings = {
				{
					"keyboard",
					"7",
					"pressed"
				}
			}
		},
		wield_8 = {
			input_mappings = {
				{
					"keyboard",
					"8",
					"pressed"
				}
			}
		},
		wield_9 = {
			input_mappings = {
				{
					"keyboard",
					"9",
					"pressed"
				}
			}
		},
		wield_0 = {
			input_mappings = {
				{
					"keyboard",
					"0",
					"pressed"
				}
			}
		},
		wield_switch = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"q",
					"pressed"
				},
				{
					"gamepad",
					"y",
					"pressed"
				}
			}
		},
		wield_scroll = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		wield_next = {
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		wield_prev = {
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		walk = {
			input_mappings = {
				{
					"keyboard",
					"left alt",
					"held"
				}
			}
		},
		dodge_left = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"a",
					"held"
				}
			}
		},
		dodge_right = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"d",
					"held"
				}
			}
		},
		dodge_back = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"s",
					"held"
				}
			}
		},
		dodge_hold = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"held"
				}
			}
		},
		dodge = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				},
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		interact = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"x",
					"pressed"
				},
				{
					"keyboard",
					"e",
					"pressed"
				}
			}
		},
		interacting = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"x",
					"held"
				},
				{
					"keyboard",
					"e",
					"held"
				}
			}
		},
		jump = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				}
			}
		},
		crouch = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"pressed"
				}
			}
		},
		crouching = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"held"
				}
			}
		},
		crouch_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"pressed"
				}
			}
		},
		crouching_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"held"
				}
			}
		},
		look_raw = {
			input_mappings = {
				{
					"mouse",
					"mouse",
					"axis"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		move_controller = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		ping = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"t",
					"pressed"
				},
				{
					"gamepad",
					"left_shoulder",
					"pressed"
				}
			}
		},
		voip_push_to_talk = {
			input_mappings = {
				{
					"keyboard",
					"g",
					"held"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"soft_button"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"soft_button"
				}
			}
		},
		move_forward = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"soft_button"
				}
			}
		},
		move_back = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"soft_button"
				}
			}
		},
		move_left_pressed = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"pressed"
				}
			}
		},
		move_right_pressed = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"pressed"
				}
			}
		},
		move_forward_pressed = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"pressed"
				}
			}
		},
		move_back_pressed = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"pressed"
				}
			}
		},
		ingame_vote_yes = {
			input_mappings = {
				{
					"keyboard",
					"f5",
					"pressed"
				}
			}
		},
		ingame_vote_no = {
			input_mappings = {
				{
					"keyboard",
					"f6",
					"pressed"
				}
			}
		},
		cursor = {
			combination_type = "add",
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				},
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		next_observer_target = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		}
	}
	PlayerControllerFilters = {
		move = {
			filter_type = "virtual_axis",
			input_mappings = {
				right = "move_right",
				back = "move_back",
				left = "move_left",
				forward = "move_forward"
			}
		},
		look = {
			filter_type = "scale_vector3_invert_y",
			multiplier = 0.0006,
			input_mapping = "look_raw"
		},
		look_controller = {
			multiplier_y = 1.5,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.6,
			multiplier_x = 6
		},
		look_controller_zoom = {
			multiplier_y = 0.5,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.6,
			multiplier_x = 3
		},
		look_controller_3p = {
			filter_type = "scale_vector3",
			multiplier = 0.004,
			input_mapping = "look_raw_controller"
		}
	}
	ChatControllerSettings = {
		activate_chat_input = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"y",
					"pressed"
				},
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"numpad enter",
					"pressed"
				}
			}
		},
		execute_chat_input = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"numpad enter",
					"pressed"
				}
			}
		},
		deactivate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		unallowed_activate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"left alt",
					"held"
				}
			}
		},
		chat_scroll_up = {
			input_mappings = {
				{
					"keyboard",
					"page up",
					"held"
				}
			}
		},
		chat_scroll_down = {
			input_mappings = {
				{
					"keyboard",
					"page down",
					"held"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		left_release = {
			input_mappings = {
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		left_press = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		left_hold = {
			input_mappings = {
				{
					"mouse",
					"left",
					"held"
				}
			}
		}
	}
	FreeFlightKeymaps = {
		quit_game = {
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		projection_mode = {
			input_mappings = {
				{
					"keyboard",
					"f7",
					"pressed"
				}
			}
		},
		free_flight_toggle = {
			input_mappings = {
				{
					"keyboard",
					"f8",
					"pressed"
				}
			}
		},
		frustum_freeze_toggle = {
			input_mappings = {
				{
					"keyboard",
					"left shift",
					"held",
					"keyboard",
					"f8",
					"pressed"
				}
			}
		},
		set_drop_position = {
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				}
			}
		},
		increase_fov = {
			input_mappings = {
				{
					"keyboard",
					"numpad +",
					"pressed"
				}
			}
		},
		decrease_fov = {
			input_mappings = {
				{
					"keyboard",
					"num -",
					"pressed"
				}
			}
		},
		toggle_debug_info = {
			input_mappings = {
				{
					"keyboard",
					"f12",
					"pressed"
				}
			}
		},
		move_forward = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"soft_button"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"soft_button"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"soft_button"
				}
			}
		},
		move_back = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"soft_button"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"keyboard",
					"q",
					"soft_button"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"keyboard",
					"e",
					"soft_button"
				}
			}
		},
		mark = {
			input_mappings = {
				{
					"keyboard",
					"c",
					"pressed"
				}
			}
		},
		toggle_control_points = {
			input_mappings = {
				{
					"keyboard",
					"t",
					"pressed"
				}
			}
		},
		step_frame = {
			input_mappings = {
				{
					"keyboard",
					"up",
					"pressed"
				}
			}
		},
		play_pause = {
			input_mappings = {
				{
					"keyboard",
					"down",
					"pressed"
				}
			}
		},
		increase_frame_step = {
			input_mappings = {
				{
					"keyboard",
					"right",
					"pressed"
				}
			}
		},
		decrease_frame_step = {
			input_mappings = {
				{
					"keyboard",
					"left",
					"pressed"
				}
			}
		},
		look = {
			input_mappings = {
				{
					"mouse",
					"mouse",
					"axis"
				}
			}
		},
		speed_change = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		ray = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		toggle_mouse_focus = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		action_one = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_two = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		k = {
			input_mappings = {
				{
					"keyboard",
					"k",
					"pressed"
				}
			}
		},
		l = {
			input_mappings = {
				{
					"keyboard",
					"l",
					"pressed"
				}
			}
		},
		x = {
			input_mappings = {
				{
					"keyboard",
					"x",
					"pressed"
				}
			}
		},
		m = {
			input_mappings = {
				{
					"keyboard",
					"m",
					"pressed"
				}
			}
		},
		comma = {
			input_mappings = {
				{
					"keyboard",
					"oem_comma (< ,)",
					"pressed"
				}
			}
		},
		period = {
			input_mappings = {
				{
					"keyboard",
					"oem_period (> .)",
					"pressed"
				}
			}
		},
		left_ctrl = {
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"pressed"
				}
			}
		}
	}
	FreeFlightFilters = {
		move = {
			filter_type = "virtual_axis",
			input_mappings = {
				down = "move_down",
				up = "move_up",
				forward = "move_forward",
				back = "move_back",
				left = "move_left",
				right = "move_right"
			}
		}
	}
	SplashScreenKeymaps = {
		skip_splash = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		}
	}
	TitleLoadingKeyMaps = {
		cancel_video = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		left_release = {
			input_mappings = {
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		left_press = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		left_hold = {
			input_mappings = {
				{
					"mouse",
					"left",
					"held"
				}
			}
		},
		confirm = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"released"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"pressed"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		move_left_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"held"
				}
			}
		},
		move_right_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"held"
				}
			}
		}
	}
	TitleScreenKeyMaps = {
		start = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		}
	}
	IngamePlayerListKeymaps = {
		toggle_menu = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"start",
					"pressed"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		left_release = {
			input_mappings = {
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		left_hold = {
			input_mappings = {
				{
					"mouse",
					"left",
					"held"
				}
			}
		},
		left_press = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		right_press = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		ingame_player_list_pressed = {
			input_mappings = {
				{
					"keyboard",
					"tab",
					"pressed"
				}
			}
		},
		ingame_player_list_held = {
			input_mappings = {
				{
					"keyboard",
					"tab",
					"held"
				}
			}
		},
		ingame_player_list_toggle = {
			input_mappings = {
				{
					"gamepad",
					"back",
					"pressed"
				}
			}
		},
		ingame_player_list_exit = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"tab",
					"pressed"
				},
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		close_ingame_player_list = {
			input_mappings = {
				{
					"keyboard",
					"tab",
					"released"
				}
			}
		},
		activate_ingame_player_list = {
			combination_type = "or",
			input_mappings = {
				{
					"mouse",
					"right",
					"released"
				},
				{
					"keyboard",
					"enter",
					"pressed"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"pressed"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		mute_voice = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"released"
				}
			}
		},
		mute_chat = {
			input_mappings = {
				{
					"gamepad",
					"x",
					"released"
				}
			}
		},
		kick_player = {
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"pressed"
				}
			}
		},
		back = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"released"
				}
			}
		},
		show_profile = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		}
	}
	IngameMenuKeymaps = {
		ui_reload_debug = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"f5",
					"pressed"
				},
				{
					"gamepad",
					"y",
					"held"
				}
			}
		},
		ui_debug = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"f6",
					"pressed"
				},
				{
					"gamepad",
					"y",
					"held"
				}
			}
		},
		cancel_matchmaking = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"f10",
					"pressed"
				},
				{
					"gamepad",
					"b",
					"held"
				}
			}
		},
		matchmaking_ready = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"f2",
					"pressed"
				},
				{
					"gamepad",
					"x",
					"held"
				}
			}
		},
		matchmaking_start = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"f3",
					"pressed"
				},
				{
					"gamepad",
					"y",
					"held"
				}
			}
		},
		toggle_menu = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"start",
					"pressed"
				}
			}
		},
		back_menu = {
			combination_type = "or",
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				},
				{
					"gamepad",
					"b",
					"pressed"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"pressed"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"pressed"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		move_up_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"held"
				}
			}
		},
		move_down_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"held"
				}
			}
		},
		move_left_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"held"
				}
			}
		},
		move_right_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"held"
				}
			}
		},
		skip = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"held"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		left_release = {
			input_mappings = {
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		left_hold = {
			input_mappings = {
				{
					"mouse",
					"left",
					"held"
				}
			}
		},
		left_press = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		right_press = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		confirm = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"released"
				}
			}
		},
		confirm_hold = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"held"
				}
			}
		},
		confirm_press = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		back = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"released"
				}
			}
		},
		refresh = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"released"
				}
			}
		},
		special_1 = {
			input_mappings = {
				{
					"gamepad",
					"x",
					"released"
				}
			}
		},
		left_stick_press = {
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"pressed"
				}
			}
		},
		right_stick_press = {
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"pressed"
				}
			}
		},
		cycle_next = {
			input_mappings = {
				{
					"gamepad",
					"right_shoulder",
					"pressed"
				}
			}
		},
		cycle_next_hold = {
			input_mappings = {
				{
					"gamepad",
					"right_shoulder",
					"held"
				}
			}
		},
		cycle_previous = {
			input_mappings = {
				{
					"gamepad",
					"left_shoulder",
					"pressed"
				}
			}
		},
		cycle_previous_hold = {
			input_mappings = {
				{
					"gamepad",
					"left_shoulder",
					"held"
				}
			}
		},
		trigger_left_soft = {
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"soft_button"
				}
			}
		},
		trigger_right_soft = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"soft_button"
				}
			}
		},
		trigger_cycle_next = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"pressed"
				}
			}
		},
		trigger_cycle_next_hold = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"held"
				}
			}
		},
		trigger_cycle_previous = {
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"pressed"
				}
			}
		},
		trigger_cycle_previous_hold = {
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"held"
				}
			}
		},
		gamepad_left_axis = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		gamepad_right_axis = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		hotkey_map = {
			input_mappings = {
				{
					"keyboard",
					"m",
					"pressed"
				}
			}
		},
		hotkey_inventory = {
			input_mappings = {
				{
					"keyboard",
					"i",
					"pressed"
				}
			}
		},
		hotkey_journal = {
			input_mappings = {
				{
					"keyboard",
					"j",
					"pressed"
				}
			}
		},
		hotkey_forge = {
			input_mappings = {
				{
					"keyboard",
					"f",
					"pressed"
				}
			}
		},
		hotkey_altar = {
			input_mappings = {
				{
					"keyboard",
					"h",
					"pressed"
				}
			}
		},
		hotkey_lobby_browser = {
			input_mappings = {
				{
					"keyboard",
					"l",
					"pressed"
				}
			}
		},
		hotkey_quests = {
			input_mappings = {
				{
					"keyboard",
					"u",
					"pressed"
				}
			}
		},
		scroll_axis = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		debug_pixeldistance = {
			combination_type = "and",
			input_mappings = {
				{
					"keyboard",
					"left shift",
					"held"
				},
				{
					"mouse",
					"right",
					"held"
				}
			}
		}
	}
	CutsceneKeymaps = {
		skip_cutscene = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		gdc_skip = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		gdc_debug_skip = {
			combination_type = "and",
			input_mappings = {
				{
					"keyboard",
					"left shift",
					"held"
				},
				{
					"keyboard",
					"space",
					"pressed"
				}
			}
		}
	}
elseif Application.platform() == "ps4" then
	PlayerControllerKeymaps = {
		toggle_input_helper = {
			input_mappings = {
				{
					"keyboard",
					"f1",
					"pressed"
				}
			}
		},
		action_one = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"pressed"
				}
			}
		},
		action_one_hold = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"held"
				}
			}
		},
		action_one_release = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"released"
				}
			}
		},
		action_two = {
			input_mappings = {
				{
					"gamepad",
					"l2",
					"pressed"
				}
			}
		},
		action_two_hold = {
			input_mappings = {
				{
					"gamepad",
					"l2",
					"held"
				}
			}
		},
		action_two_release = {
			input_mappings = {
				{
					"gamepad",
					"l2",
					"released"
				}
			}
		},
		action_three = {
			input_mappings = {
				{
					"gamepad",
					"r3",
					"pressed"
				}
			}
		},
		action_three_hold = {
			input_mappings = {
				{
					"gamepad",
					"r3",
					"held"
				}
			}
		},
		action_three_release = {
			input_mappings = {
				{
					"gamepad",
					"r3",
					"released"
				}
			}
		},
		action_inspect = {
			input_mappings = {
				{
					"gamepad",
					"l3",
					"pressed"
				}
			}
		},
		action_inspect_hold = {
			input_mappings = {
				{
					"gamepad",
					"l3",
					"held"
				}
			}
		},
		action_inspect_release = {
			input_mappings = {
				{
					"gamepad",
					"l3",
					"released"
				}
			}
		},
		action_one_softbutton_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"soft_button"
				}
			}
		},
		action_one_mouse = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_instant_grenade_throw = {
			input_mappings = {
				{
					"gamepad",
					"r1",
					"pressed"
				}
			}
		},
		action_instant_grenade_throw_released = {
			input_mappings = {
				{
					"gamepad",
					"r1",
					"released"
				}
			}
		},
		action_instant_grenade_throw_hold = {
			input_mappings = {
				{
					"gamepad",
					"r1",
					"held"
				}
			}
		},
		action_instant_heal_self = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"pressed"
				}
			}
		},
		action_instant_heal_self_hold = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"held"
				}
			}
		},
		action_instant_drink_potion = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"pressed"
				}
			}
		},
		action_instant_equip_grimoire = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"pressed"
				}
			}
		},
		action_instant_equip_tome = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"pressed"
				}
			}
		},
		action_instant_equip_grenade = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"pressed"
				}
			}
		},
		action_instant_equip_healing_draught = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"pressed"
				}
			}
		},
		action_instant_heal_other = {
			input_mappings = {
				{
					"gamepad",
					"up",
					"pressed"
				}
			}
		},
		action_instant_heal_other_hold = {
			input_mappings = {
				{
					"gamepad",
					"up",
					"held"
				}
			}
		},
		weapon_reload = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"pressed"
				}
			}
		},
		weapon_reload_hold = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"held"
				}
			}
		},
		character_inspecting = {
			input_mappings = {
				{
					"gamepad",
					"r3",
					"held"
				}
			}
		},
		wield_1 = {
			input_mappings = {
				{
					"keyboard",
					"1",
					"pressed"
				}
			}
		},
		wield_2 = {
			input_mappings = {
				{
					"keyboard",
					"2",
					"pressed"
				}
			}
		},
		wield_3 = {
			input_mappings = {
				{
					"keyboard",
					"3",
					"pressed"
				}
			}
		},
		wield_4 = {
			input_mappings = {
				{
					"keyboard",
					"4",
					"pressed"
				}
			}
		},
		wield_5 = {
			input_mappings = {
				{
					"keyboard",
					"5",
					"pressed"
				}
			}
		},
		wield_6 = {
			input_mappings = {
				{
					"keyboard",
					"6",
					"pressed"
				}
			}
		},
		wield_7 = {
			input_mappings = {
				{
					"keyboard",
					"7",
					"pressed"
				}
			}
		},
		wield_8 = {
			input_mappings = {
				{
					"keyboard",
					"8",
					"pressed"
				}
			}
		},
		wield_9 = {
			input_mappings = {
				{
					"keyboard",
					"9",
					"pressed"
				}
			}
		},
		wield_0 = {
			input_mappings = {
				{
					"keyboard",
					"0",
					"pressed"
				}
			}
		},
		wield_switch = {
			input_mappings = {
				{
					"gamepad",
					"triangle",
					"pressed"
				}
			}
		},
		wield_scroll = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		wield_next = {
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		wield_prev = {
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		walk = {
			input_mappings = {
				{
					"keyboard",
					"left alt",
					"held"
				}
			}
		},
		dodge_left = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"a",
					"held"
				}
			}
		},
		dodge_right = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"d",
					"held"
				}
			}
		},
		dodge_back = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"s",
					"held"
				}
			}
		},
		dodge_hold = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"held"
				}
			}
		},
		dodge = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		},
		interact = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"pressed"
				}
			}
		},
		interacting = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"held"
				}
			}
		},
		jump = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		},
		crouch = {
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"pressed"
				}
			}
		},
		crouching = {
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"held"
				}
			}
		},
		crouch_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"circle",
					"pressed"
				}
			}
		},
		crouching_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"circle",
					"held"
				}
			}
		},
		look_raw = {
			input_mappings = {
				{
					"mouse",
					"mouse",
					"axis"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		move_controller = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		ping = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"t",
					"pressed"
				},
				{
					"gamepad",
					"l1",
					"pressed"
				}
			}
		},
		voip_push_to_talk = {
			input_mappings = {
				{
					"keyboard",
					"g",
					"held"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"soft_button"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"soft_button"
				}
			}
		},
		move_forward = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"soft_button"
				}
			}
		},
		move_back = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"soft_button"
				}
			}
		},
		move_left_pressed = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"pressed"
				}
			}
		},
		move_right_pressed = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"pressed"
				}
			}
		},
		move_forward_pressed = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"pressed"
				}
			}
		},
		move_back_pressed = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"pressed"
				}
			}
		},
		ingame_vote_yes = {
			input_mappings = {
				{
					"keyboard",
					"f5",
					"pressed"
				}
			}
		},
		ingame_vote_no = {
			input_mappings = {
				{
					"keyboard",
					"f6",
					"pressed"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		next_observer_target = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		}
	}
	PlayerControllerFilters = {
		look_controller = {
			multiplier_y = 1.25,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.7,
			multiplier_x = 4.5,
			input_threshold = 0.05
		},
		look_controller_zoom = {
			multiplier_y = 0.5,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.6,
			multiplier_x = 3,
			input_threshold = 0.05
		},
		look_controller_3p = {
			filter_type = "scale_vector3",
			multiplier = 0.004,
			input_threshold = 0.05,
			input_mapping = "look_raw_controller"
		}
	}
	ChatControllerSettings = {
		activate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"y",
					"pressed"
				}
			}
		},
		execute_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				}
			}
		},
		deactivate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		unallowed_activate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"left alt",
					"held"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		left_release = {
			input_mappings = {
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		left_press = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		left_hold = {
			input_mappings = {
				{
					"mouse",
					"left",
					"held"
				}
			}
		}
	}
	FreeFlightKeymaps = {
		quit_game = {
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		projection_mode = {
			input_mappings = {
				{
					"keyboard",
					"f7",
					"pressed"
				}
			}
		},
		free_flight_toggle = {
			combination_type = "and",
			input_mappings = {
				{
					"gamepad",
					"l3",
					"held"
				},
				{
					"gamepad",
					"r3",
					"held"
				},
				{
					"gamepad",
					"l1",
					"held"
				},
				{
					"gamepad",
					"r2",
					"pressed"
				}
			}
		},
		frustum_freeze_toggle = {
			combination_type = "and",
			input_mappings = {
				{
					"keyboard",
					"left shift",
					"held",
					"keyboard",
					"f8",
					"pressed"
				}
			}
		},
		set_drop_position = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		},
		increase_fov = {
			input_mappings = {
				{
					"keyboard",
					"numpad +",
					"pressed"
				}
			}
		},
		decrease_fov = {
			input_mappings = {
				{
					"keyboard",
					"num -",
					"pressed"
				}
			}
		},
		toggle_debug_info = {
			input_mappings = {
				{
					"keyboard",
					"f12",
					"pressed"
				}
			}
		},
		move_forward = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"soft_button"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"soft_button"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"soft_button"
				}
			}
		},
		move_back = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"soft_button"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"keyboard",
					"q",
					"soft_button"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"keyboard",
					"e",
					"soft_button"
				}
			}
		},
		move = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		mark = {
			input_mappings = {
				{
					"keyboard",
					"c",
					"pressed"
				}
			}
		},
		toggle_control_points = {
			input_mappings = {
				{
					"keyboard",
					"t",
					"pressed"
				}
			}
		},
		step_frame = {
			input_mappings = {
				{
					"keyboard",
					"up",
					"pressed"
				}
			}
		},
		play_pause = {
			input_mappings = {
				{
					"keyboard",
					"down",
					"pressed"
				}
			}
		},
		increase_frame_step = {
			input_mappings = {
				{
					"keyboard",
					"right",
					"pressed"
				}
			}
		},
		decrease_frame_step = {
			input_mappings = {
				{
					"keyboard",
					"left",
					"pressed"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		speed_change = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		ray = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		toggle_mouse_focus = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		action_one = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_two = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		k = {
			input_mappings = {
				{
					"keyboard",
					"k",
					"pressed"
				}
			}
		},
		l = {
			input_mappings = {
				{
					"keyboard",
					"l",
					"pressed"
				}
			}
		},
		x = {
			input_mappings = {
				{
					"keyboard",
					"x",
					"pressed"
				}
			}
		},
		m = {
			input_mappings = {
				{
					"keyboard",
					"m",
					"pressed"
				}
			}
		},
		comma = {
			input_mappings = {
				{
					"keyboard",
					"oem_comma (< ,)",
					"pressed"
				}
			}
		},
		period = {
			input_mappings = {
				{
					"keyboard",
					"oem_period (> .)",
					"pressed"
				}
			}
		},
		left_ctrl = {
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"pressed"
				}
			}
		}
	}
	FreeFlightFilters = {
		look = {
			multiplier_y = -400.5,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.1,
			multiplier_x = 600
		},
		move = {
			filter_type = "virtual_axis",
			input_mappings = {
				down = "move_down",
				up = "move_up",
				forward = "move_forward",
				back = "move_back",
				left = "move_left",
				right = "move_right"
			}
		}
	}
	TitleScreenKeyMaps = {
		left = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"released"
				}
			}
		},
		right = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"released"
				}
			}
		},
		up = {
			input_mappings = {
				{
					"gamepad",
					"up",
					"released"
				}
			}
		},
		down = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"released"
				}
			}
		},
		start = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		}
	}
	TitleLoadingKeyMaps = {
		cancel_video = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"held"
				}
			}
		},
		confirm = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"released"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"pressed"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"pressed"
				}
			}
		},
		move_left_hold = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"held"
				}
			}
		},
		move_right_hold = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"held"
				}
			}
		}
	}
	SplashScreenKeymaps = {
		skip_splash = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		}
	}
	IngamePlayerListKeymaps = {
		toggle_menu = {
			input_mappings = {
				{
					"gamepad",
					"options",
					"pressed"
				}
			}
		},
		ingame_player_list_toggle = {
			input_mappings = {
				{
					"gamepad",
					unbind_button,
					"pressed"
				}
			}
		},
		mute_voice = {
			input_mappings = {
				{
					"gamepad",
					"triangle",
					"released"
				}
			}
		},
		mute_chat = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"released"
				}
			}
		},
		kick_player = {
			input_mappings = {
				{
					"gamepad",
					"r3",
					"pressed"
				}
			}
		},
		back = {
			input_mappings = {
				{
					"gamepad",
					"circle",
					"released"
				}
			}
		},
		show_profile = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"gamepad",
					"up",
					"pressed"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"pressed"
				}
			}
		}
	}
	IngameMenuKeymaps = {
		ui_reload_debug = {
			input_mappings = {
				{
					"gamepad",
					"triangle",
					"held"
				}
			}
		},
		ui_debug = {
			input_mappings = {
				{
					"gamepad",
					"triangle",
					"held"
				}
			}
		},
		cancel_matchmaking = {
			input_mappings = {
				{
					"gamepad",
					"circle",
					"held"
				}
			}
		},
		matchmaking_ready = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"held"
				}
			}
		},
		matchmaking_start = {
			input_mappings = {
				{
					"gamepad",
					"triangle",
					"held"
				}
			}
		},
		toggle_menu = {
			input_mappings = {
				{
					"gamepad",
					"options",
					"pressed"
				}
			}
		},
		back_menu = {
			input_mappings = {
				{
					"gamepad",
					"circle",
					"pressed"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"gamepad",
					"up",
					"pressed"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"pressed"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"pressed"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"pressed"
				}
			}
		},
		move_up_hold = {
			input_mappings = {
				{
					"gamepad",
					"up",
					"held"
				}
			}
		},
		move_down_hold = {
			input_mappings = {
				{
					"gamepad",
					"down",
					"held"
				}
			}
		},
		move_left_hold = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"held"
				}
			}
		},
		move_right_hold = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"held"
				}
			}
		},
		confirm = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"released"
				}
			}
		},
		confirm_hold = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"held"
				}
			}
		},
		confirm_press = {
			input_mappings = {
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		},
		back = {
			input_mappings = {
				{
					"gamepad",
					"circle",
					"released"
				}
			}
		},
		refresh = {
			input_mappings = {
				{
					"gamepad",
					"triangle",
					"released"
				}
			}
		},
		special_1 = {
			input_mappings = {
				{
					"gamepad",
					"square",
					"released"
				}
			}
		},
		left_stick_press = {
			input_mappings = {
				{
					"gamepad",
					"l3",
					"pressed"
				}
			}
		},
		right_stick_press = {
			input_mappings = {
				{
					"gamepad",
					"r3",
					"pressed"
				}
			}
		},
		cycle_next = {
			input_mappings = {
				{
					"gamepad",
					"r1",
					"pressed"
				}
			}
		},
		cycle_next_hold = {
			input_mappings = {
				{
					"gamepad",
					"r1",
					"held"
				}
			}
		},
		cycle_previous = {
			input_mappings = {
				{
					"gamepad",
					"l1",
					"pressed"
				}
			}
		},
		cycle_previous_hold = {
			input_mappings = {
				{
					"gamepad",
					"l1",
					"held"
				}
			}
		},
		trigger_left_soft = {
			input_mappings = {
				{
					"gamepad",
					"l2",
					"soft_button"
				}
			}
		},
		trigger_right_soft = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"soft_button"
				}
			}
		},
		trigger_cycle_next = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"pressed"
				}
			}
		},
		trigger_cycle_next_hold = {
			input_mappings = {
				{
					"gamepad",
					"r2",
					"held"
				}
			}
		},
		trigger_cycle_previous = {
			input_mappings = {
				{
					"gamepad",
					"l2",
					"pressed"
				}
			}
		},
		trigger_cycle_previous_hold = {
			input_mappings = {
				{
					"gamepad",
					"l2",
					"held"
				}
			}
		},
		gamepad_left_axis = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		gamepad_right_axis = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		}
	}
	CutsceneKeymaps = {
		skip_cutscene = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		},
		gdc_skip = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"gamepad",
					"cross",
					"pressed"
				}
			}
		}
	}
elseif Application.platform() == "xb1" then
	PlayerControllerKeymaps = {
		toggle_input_helper = {
			input_mappings = {
				{
					"keyboard",
					"f1",
					"pressed"
				}
			}
		},
		action_one = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"pressed"
				},
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_one_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"held"
				},
				{
					"mouse",
					"left",
					"held"
				}
			}
		},
		action_one_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"released"
				},
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		action_two = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"pressed"
				},
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		action_two_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"held"
				},
				{
					"mouse",
					"right",
					"held"
				}
			}
		},
		action_two_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"released"
				},
				{
					"mouse",
					"right",
					"released"
				}
			}
		},
		action_three = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"pressed"
				},
				{
					"mouse",
					"extra_1",
					"pressed"
				}
			}
		},
		action_three_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"held"
				},
				{
					"mouse",
					"extra_1",
					"held"
				}
			}
		},
		action_three_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"released"
				},
				{
					"mouse",
					"extra_1",
					"released"
				}
			}
		},
		action_inspect = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"pressed"
				},
				{
					"keyboard",
					"z",
					"pressed"
				}
			}
		},
		action_inspect_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"held"
				},
				{
					"keyboard",
					"z",
					"held"
				}
			}
		},
		action_inspect_release = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"released"
				},
				{
					"keyboard",
					"z",
					"released"
				}
			}
		},
		action_one_softbutton_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"soft_button"
				}
			}
		},
		action_one_mouse = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_instant_grenade_throw = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"right_shoulder",
					"pressed"
				}
			}
		},
		action_instant_grenade_throw_released = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"right_shoulder",
					"released"
				}
			}
		},
		action_instant_grenade_throw_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"right_shoulder",
					"held"
				}
			}
		},
		action_instant_heal_self = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		action_instant_heal_self_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"held"
				},
				{
					"gamepad",
					"d_down",
					"held"
				}
			}
		},
		action_instant_drink_potion = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		action_instant_equip_grimoire = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		action_instant_equip_tome = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		action_instant_equip_grenade = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_left",
					"pressed"
				}
			}
		},
		action_instant_equip_healing_draught = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				},
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		action_instant_heal_other = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"pressed"
				}
			}
		},
		action_instant_heal_other_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"held"
				}
			}
		},
		weapon_reload = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"r",
					"pressed"
				},
				{
					"gamepad",
					"x",
					"pressed"
				}
			}
		},
		weapon_reload_hold = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"r",
					"held"
				},
				{
					"gamepad",
					"x",
					"held"
				}
			}
		},
		character_inspecting = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"x",
					"held"
				},
				{
					"gamepad",
					"right_thumb",
					"held"
				}
			}
		},
		wield_1 = {
			input_mappings = {
				{
					"keyboard",
					"1",
					"pressed"
				}
			}
		},
		wield_2 = {
			input_mappings = {
				{
					"keyboard",
					"2",
					"pressed"
				}
			}
		},
		wield_3 = {
			input_mappings = {
				{
					"keyboard",
					"3",
					"pressed"
				}
			}
		},
		wield_4 = {
			input_mappings = {
				{
					"keyboard",
					"4",
					"pressed"
				}
			}
		},
		wield_5 = {
			input_mappings = {
				{
					"keyboard",
					"5",
					"pressed"
				}
			}
		},
		wield_6 = {
			input_mappings = {
				{
					"keyboard",
					"6",
					"pressed"
				}
			}
		},
		wield_7 = {
			input_mappings = {
				{
					"keyboard",
					"7",
					"pressed"
				}
			}
		},
		wield_8 = {
			input_mappings = {
				{
					"keyboard",
					"8",
					"pressed"
				}
			}
		},
		wield_9 = {
			input_mappings = {
				{
					"keyboard",
					"9",
					"pressed"
				}
			}
		},
		wield_0 = {
			input_mappings = {
				{
					"keyboard",
					"0",
					"pressed"
				}
			}
		},
		wield_switch = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"q",
					"pressed"
				},
				{
					"gamepad",
					"y",
					"pressed"
				}
			}
		},
		wield_scroll = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		wield_next = {
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		wield_prev = {
			input_mappings = {
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		walk = {
			input_mappings = {
				{
					"keyboard",
					"left alt",
					"held"
				}
			}
		},
		dodge_left = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"a",
					"held"
				}
			}
		},
		dodge_right = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"d",
					"held"
				}
			}
		},
		dodge_back = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed",
					"keyboard",
					"s",
					"held"
				}
			}
		},
		dodge_hold = {
			input_mappings = {
				{
					"keyboard",
					"space",
					"held"
				}
			}
		},
		dodge = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				},
				{
					"keyboard",
					unbind_button,
					"pressed"
				}
			}
		},
		interact = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"x",
					"pressed"
				},
				{
					"keyboard",
					"e",
					"pressed"
				}
			}
		},
		interacting = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"x",
					"held"
				},
				{
					"keyboard",
					"e",
					"held"
				}
			}
		},
		jump = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				}
			}
		},
		crouch = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"pressed"
				}
			}
		},
		crouching = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"held"
				}
			}
		},
		crouch_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"pressed"
				}
			}
		},
		crouching_gamepad = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"held"
				}
			}
		},
		look_raw = {
			input_mappings = {
				{
					"mouse",
					"mouse",
					"axis"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		move_controller = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		ping = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"t",
					"pressed"
				},
				{
					"gamepad",
					"left_shoulder",
					"pressed"
				}
			}
		},
		voip_push_to_talk = {
			input_mappings = {
				{
					"keyboard",
					"g",
					"held"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"soft_button"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"soft_button"
				}
			}
		},
		move_forward = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"soft_button"
				}
			}
		},
		move_back = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"soft_button"
				}
			}
		},
		move_left_pressed = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"pressed"
				}
			}
		},
		move_right_pressed = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"pressed"
				}
			}
		},
		move_forward_pressed = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"pressed"
				}
			}
		},
		move_back_pressed = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"pressed"
				}
			}
		},
		ingame_vote_yes = {
			input_mappings = {
				{
					"keyboard",
					"f5",
					"pressed"
				}
			}
		},
		ingame_vote_no = {
			input_mappings = {
				{
					"keyboard",
					"f6",
					"pressed"
				}
			}
		},
		cursor = {
			combination_type = "add",
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				},
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		next_observer_target = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		}
	}
	PlayerControllerFilters = {
		look_controller = {
			multiplier_y = 1.25,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.7,
			multiplier_x = 4.5
		},
		look_controller_zoom = {
			multiplier_y = 0.5,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.6,
			multiplier_x = 3
		},
		look_controller_3p = {
			filter_type = "scale_vector3",
			multiplier = 0.004,
			input_mapping = "look_raw_controller"
		}
	}
	ChatControllerSettings = {
		activate_chat_input = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"y",
					"pressed"
				},
				{
					"keyboard",
					"enter",
					"pressed"
				}
			}
		},
		execute_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				}
			}
		},
		deactivate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		unallowed_activate_chat_input = {
			input_mappings = {
				{
					"keyboard",
					"left alt",
					"held"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		left_release = {
			input_mappings = {
				{
					"mouse",
					"left",
					"released"
				}
			}
		},
		left_press = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		left_hold = {
			input_mappings = {
				{
					"mouse",
					"left",
					"held"
				}
			}
		}
	}
	FreeFlightKeymaps = {
		quit_game = {
			input_mappings = {
				{
					"keyboard",
					"esc",
					"pressed"
				}
			}
		},
		projection_mode = {
			input_mappings = {
				{
					"keyboard",
					"f7",
					"pressed"
				}
			}
		},
		free_flight_toggle = {
			combination_type = "and",
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"held"
				},
				{
					"gamepad",
					"right_thumb",
					"held"
				},
				{
					"gamepad",
					"left_shoulder",
					"held"
				},
				{
					"gamepad",
					"right_shoulder",
					"pressed"
				}
			}
		},
		frustum_freeze_toggle = {
			combination_type = "and",
			input_mappings = {
				{
					"keyboard",
					"left shift",
					"held",
					"keyboard",
					"f8",
					"pressed"
				}
			}
		},
		set_drop_position = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		increase_fov = {
			input_mappings = {
				{
					"keyboard",
					"numpad +",
					"pressed"
				}
			}
		},
		decrease_fov = {
			input_mappings = {
				{
					"keyboard",
					"num -",
					"pressed"
				}
			}
		},
		toggle_debug_info = {
			input_mappings = {
				{
					"keyboard",
					"f12",
					"pressed"
				}
			}
		},
		move_forward = {
			input_mappings = {
				{
					"keyboard",
					"w",
					"soft_button"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"keyboard",
					"d",
					"soft_button"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"keyboard",
					"a",
					"soft_button"
				}
			}
		},
		move_back = {
			input_mappings = {
				{
					"keyboard",
					"s",
					"soft_button"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"keyboard",
					"q",
					"soft_button"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"keyboard",
					"e",
					"soft_button"
				}
			}
		},
		move = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		mark = {
			input_mappings = {
				{
					"keyboard",
					"c",
					"pressed"
				}
			}
		},
		toggle_control_points = {
			input_mappings = {
				{
					"keyboard",
					"t",
					"pressed"
				}
			}
		},
		step_frame = {
			input_mappings = {
				{
					"keyboard",
					"up",
					"pressed"
				}
			}
		},
		play_pause = {
			input_mappings = {
				{
					"keyboard",
					"down",
					"pressed"
				}
			}
		},
		increase_frame_step = {
			input_mappings = {
				{
					"keyboard",
					"right",
					"pressed"
				}
			}
		},
		decrease_frame_step = {
			input_mappings = {
				{
					"keyboard",
					"left",
					"pressed"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		speed_change = {
			input_mappings = {
				{
					"mouse",
					"wheel",
					"axis"
				}
			}
		},
		ray = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		toggle_mouse_focus = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		cursor = {
			input_mappings = {
				{
					"mouse",
					"cursor",
					"axis"
				}
			}
		},
		action_one = {
			input_mappings = {
				{
					"mouse",
					"left",
					"pressed"
				}
			}
		},
		action_two = {
			input_mappings = {
				{
					"mouse",
					"right",
					"pressed"
				}
			}
		},
		k = {
			input_mappings = {
				{
					"keyboard",
					"k",
					"pressed"
				}
			}
		},
		l = {
			input_mappings = {
				{
					"keyboard",
					"l",
					"pressed"
				}
			}
		},
		x = {
			input_mappings = {
				{
					"keyboard",
					"x",
					"pressed"
				}
			}
		},
		m = {
			input_mappings = {
				{
					"keyboard",
					"m",
					"pressed"
				}
			}
		},
		comma = {
			input_mappings = {
				{
					"keyboard",
					"oem_comma (< ,)",
					"pressed"
				}
			}
		},
		period = {
			input_mappings = {
				{
					"keyboard",
					"oem_period (> .)",
					"pressed"
				}
			}
		},
		left_ctrl = {
			input_mappings = {
				{
					"keyboard",
					"left ctrl",
					"pressed"
				}
			}
		}
	}
	FreeFlightFilters = {
		look = {
			multiplier_y = -400.5,
			power_of = 2,
			filter_type = "scale_vector3_xy_accelerated_x",
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.1,
			multiplier_x = 600
		}
	}
	TitleScreenKeyMaps = {
		left = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"released"
				}
			}
		},
		right = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"released"
				}
			}
		},
		up = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"released"
				}
			}
		},
		down = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"released"
				}
			}
		},
		start = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		delete_save = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"back",
					"pressed"
				}
			}
		}
	}
	ControllerDisconnectKeymaps = {
		accept_held = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"held"
				},
				{
					"gamepad",
					"start",
					"held"
				}
			}
		},
		cancel_held = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"b",
					"held"
				},
				{
					"gamepad",
					"back",
					"held"
				}
			}
		},
		accept = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"released"
				},
				{
					"gamepad",
					"start",
					"released"
				}
			}
		},
		cancel = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"b",
					"released"
				},
				{
					"gamepad",
					"back",
					"released"
				}
			}
		}
	}
	TitleLoadingKeyMaps = {
		cancel_video = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"held"
				}
			}
		},
		confirm = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"released"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"pressed"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		move_left_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"held"
				}
			}
		},
		move_right_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"held"
				}
			}
		}
	}
	SplashScreenKeymaps = {
		skip_splash = {
			combination_type = "or",
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		}
	}
	IngamePlayerListKeymaps = {
		toggle_menu = {
			input_mappings = {
				{
					"gamepad",
					"start",
					"pressed"
				}
			}
		},
		ingame_player_list_toggle = {
			input_mappings = {
				{
					"gamepad",
					"back",
					"pressed"
				}
			}
		},
		mute_voice = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"released"
				}
			}
		},
		mute_chat = {
			input_mappings = {
				{
					"gamepad",
					"x",
					"released"
				}
			}
		},
		kick_player = {
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"pressed"
				}
			}
		},
		back = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"released"
				}
			}
		},
		show_profile = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"pressed"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		}
	}
	IngameMenuKeymaps = {
		ui_reload_debug = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"held"
				}
			}
		},
		ui_debug = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"held"
				}
			}
		},
		cancel_matchmaking = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"held"
				}
			}
		},
		matchmaking_ready = {
			input_mappings = {
				{
					"gamepad",
					"x",
					"held"
				}
			}
		},
		matchmaking_start = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"held"
				}
			}
		},
		toggle_menu = {
			input_mappings = {
				{
					"gamepad",
					"start",
					"pressed"
				}
			}
		},
		back_menu = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"pressed"
				}
			}
		},
		move_up = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"pressed"
				}
			}
		},
		move_down = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"pressed"
				}
			}
		},
		move_left = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"pressed"
				}
			}
		},
		move_right = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"pressed"
				}
			}
		},
		move_up_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_up",
					"held"
				}
			}
		},
		move_down_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_down",
					"held"
				}
			}
		},
		move_left_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_left",
					"held"
				}
			}
		},
		move_right_hold = {
			input_mappings = {
				{
					"gamepad",
					"d_right",
					"held"
				}
			}
		},
		confirm = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"released"
				}
			}
		},
		confirm_hold = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"held"
				}
			}
		},
		confirm_press = {
			input_mappings = {
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		back = {
			input_mappings = {
				{
					"gamepad",
					"b",
					"released"
				}
			}
		},
		refresh = {
			input_mappings = {
				{
					"gamepad",
					"y",
					"released"
				}
			}
		},
		special_1 = {
			input_mappings = {
				{
					"gamepad",
					"x",
					"released"
				}
			}
		},
		left_stick_press = {
			input_mappings = {
				{
					"gamepad",
					"left_thumb",
					"pressed"
				}
			}
		},
		right_stick_press = {
			input_mappings = {
				{
					"gamepad",
					"right_thumb",
					"pressed"
				}
			}
		},
		cycle_next = {
			input_mappings = {
				{
					"gamepad",
					"right_shoulder",
					"pressed"
				}
			}
		},
		cycle_next_hold = {
			input_mappings = {
				{
					"gamepad",
					"right_shoulder",
					"held"
				}
			}
		},
		cycle_previous = {
			input_mappings = {
				{
					"gamepad",
					"left_shoulder",
					"pressed"
				}
			}
		},
		cycle_previous_hold = {
			input_mappings = {
				{
					"gamepad",
					"left_shoulder",
					"held"
				}
			}
		},
		trigger_left_soft = {
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"soft_button"
				}
			}
		},
		trigger_right_soft = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"soft_button"
				}
			}
		},
		trigger_cycle_next = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"pressed"
				}
			}
		},
		trigger_cycle_next_hold = {
			input_mappings = {
				{
					"gamepad",
					"right_trigger",
					"held"
				}
			}
		},
		trigger_cycle_previous = {
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"pressed"
				}
			}
		},
		trigger_cycle_previous_hold = {
			input_mappings = {
				{
					"gamepad",
					"left_trigger",
					"held"
				}
			}
		},
		gamepad_left_axis = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		},
		gamepad_right_axis = {
			input_mappings = {
				{
					"gamepad",
					"right",
					"axis"
				}
			}
		},
		look_raw_controller = {
			input_mappings = {
				{
					"gamepad",
					"left",
					"axis"
				}
			}
		}
	}
	CutsceneKeymaps = {
		skip_cutscene = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"enter",
					"pressed"
				},
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"keyboard",
					"esc",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		},
		gdc_skip = {
			combination_type = "or",
			input_mappings = {
				{
					"keyboard",
					"space",
					"pressed"
				},
				{
					"gamepad",
					"a",
					"pressed"
				}
			}
		}
	}
end

GamepadSettings = {
	menu_cooldown = 0.1
}

return 
