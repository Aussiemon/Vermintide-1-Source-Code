require("scripts/utils/input_helper")

local unbind_button = "left button **"
PlayerControllerKeymaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		toggle_input_helper = {
			"keyboard",
			"f1",
			"pressed"
		},
		action_one = {
			"mouse",
			"left",
			"pressed"
		},
		action_one_hold = {
			"mouse",
			"left",
			"held"
		},
		action_one_release = {
			"mouse",
			"left",
			"released"
		},
		action_two = {
			"mouse",
			"right",
			"pressed"
		},
		action_two_hold = {
			"mouse",
			"right",
			"held"
		},
		action_two_release = {
			"mouse",
			"right",
			"released"
		},
		action_three = {
			"mouse",
			"extra_1",
			"pressed"
		},
		action_three_hold = {
			"mouse",
			"extra_1",
			"held"
		},
		action_three_release = {
			"mouse",
			"extra_1",
			"released"
		},
		action_inspect = {
			"keyboard",
			"z",
			"pressed"
		},
		action_inspect_hold = {
			"keyboard",
			"z",
			"held"
		},
		action_inspect_release = {
			"keyboard",
			"z",
			"released"
		},
		action_one_softbutton_gamepad = {},
		action_one_mouse = {
			"mouse",
			"left",
			"pressed"
		},
		weapon_reload = {
			"keyboard",
			"r",
			"pressed"
		},
		weapon_reload_hold = {
			"keyboard",
			"r",
			"held"
		},
		character_inspecting = {
			"keyboard",
			"x",
			"held"
		},
		wield_1 = {
			"keyboard",
			"1",
			"pressed"
		},
		wield_2 = {
			"keyboard",
			"2",
			"pressed"
		},
		wield_3 = {
			"keyboard",
			"3",
			"pressed"
		},
		wield_4 = {
			"keyboard",
			"4",
			"pressed"
		},
		wield_5 = {
			"keyboard",
			"5",
			"pressed"
		},
		wield_6 = {
			"keyboard",
			"6",
			"pressed"
		},
		wield_7 = {
			"keyboard",
			"7",
			"pressed"
		},
		wield_8 = {
			"keyboard",
			"8",
			"pressed"
		},
		wield_9 = {
			"keyboard",
			"9",
			"pressed"
		},
		wield_0 = {
			"keyboard",
			"0",
			"pressed"
		},
		wield_switch_1 = {
			"keyboard",
			"q",
			"pressed"
		},
		wield_switch_2 = {},
		wield_scroll = {
			"mouse",
			"wheel",
			"axis"
		},
		wield_next = {
			"mouse",
			"wheel_down",
			"pressed"
		},
		wield_prev = {
			"mouse",
			"wheel_up",
			"pressed"
		},
		walk = {
			"keyboard",
			"left alt",
			"held"
		},
		interact = {
			"keyboard",
			"e",
			"pressed"
		},
		interacting = {
			"keyboard",
			"e",
			"held"
		},
		jump_1 = {
			"keyboard",
			"space",
			"pressed"
		},
		jump_2 = {},
		dodge_hold = {
			"keyboard",
			"space",
			"held"
		},
		dodge = {
			"keyboard",
			unbind_button,
			"pressed"
		},
		crouch = {
			"keyboard",
			"left ctrl",
			"pressed"
		},
		crouching = {
			"keyboard",
			"left ctrl",
			"held"
		},
		look_raw = {
			"mouse",
			"mouse",
			"axis"
		},
		look_raw_controller = {
			"gamepad",
			"right",
			"axis"
		},
		move_controller = {
			"gamepad",
			"left",
			"axis"
		},
		ping = {
			"keyboard",
			"t",
			"pressed"
		},
		voip_push_to_talk = {
			"keyboard",
			"g",
			"held"
		},
		move_left = {
			"keyboard",
			"a",
			"soft_button"
		},
		move_right = {
			"keyboard",
			"d",
			"soft_button"
		},
		move_forward = {
			"keyboard",
			"w",
			"soft_button"
		},
		move_back = {
			"keyboard",
			"s",
			"soft_button"
		},
		move_left_pressed = {
			"keyboard",
			"a",
			"pressed"
		},
		move_right_pressed = {
			"keyboard",
			"d",
			"pressed"
		},
		move_forward_pressed = {
			"keyboard",
			"w",
			"pressed"
		},
		move_back_pressed = {
			"keyboard",
			"s",
			"pressed"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		next_observer_target = {
			"mouse",
			"left",
			"pressed"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		toggle_input_helper = {},
		action_one = {
			"gamepad",
			"right_trigger",
			"pressed"
		},
		action_one_hold = {
			"gamepad",
			"right_trigger",
			"held"
		},
		action_one_release = {
			"gamepad",
			"right_trigger",
			"released"
		},
		action_two = {
			"gamepad",
			"left_trigger",
			"pressed"
		},
		action_two_hold = {
			"gamepad",
			"left_trigger",
			"held"
		},
		action_two_release = {
			"gamepad",
			"left_trigger",
			"released"
		},
		action_three = {
			"gamepad",
			"right_thumb",
			"pressed"
		},
		action_three_hold = {
			"gamepad",
			"right_thumb",
			"held"
		},
		action_three_release = {
			"gamepad",
			"right_thumb",
			"released"
		},
		action_inspect = {
			"gamepad",
			"right_thumb",
			"pressed"
		},
		action_inspect_hold = {
			"gamepad",
			"right_thumb",
			"held"
		},
		action_inspect_release = {
			"gamepad",
			"right_thumb",
			"released"
		},
		action_one_softbutton_gamepad = {
			"gamepad",
			"right_trigger",
			"soft_button"
		},
		action_one_mouse = {
			"mouse",
			"left",
			"pressed"
		},
		weapon_reload = {
			"gamepad",
			"left_shoulder",
			"pressed"
		},
		weapon_reload_hold = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		character_inspecting = {
			"gamepad",
			"left_thumb",
			"held"
		},
		wield_1 = {},
		wield_2 = {},
		wield_3 = {
			"gamepad",
			"d_left",
			"pressed"
		},
		wield_4 = {
			"gamepad",
			"d_right",
			"pressed"
		},
		wield_5 = {
			"gamepad",
			"d_up",
			"pressed"
		},
		wield_6 = {},
		wield_7 = {},
		wield_8 = {},
		wield_9 = {},
		wield_0 = {},
		wield_switch_1 = {
			"gamepad",
			"y",
			"pressed"
		},
		wield_switch_2 = {
			"gamepad",
			"d_down",
			"pressed"
		},
		wield_scroll = {},
		wield_next = {},
		wield_prev = {},
		walk = {},
		interact = {
			"gamepad",
			"x",
			"pressed"
		},
		interacting = {
			"gamepad",
			"x",
			"held"
		},
		jump_1 = {
			"gamepad",
			"a",
			"pressed"
		},
		jump_2 = {},
		dodge_hold_1 = {
			"gamepad",
			"a",
			"held"
		},
		dodge_hold_2 = {},
		crouch = {
			"gamepad",
			"b",
			"pressed"
		},
		crouching = {
			"gamepad",
			"b",
			"held"
		},
		look_raw = {
			"mouse",
			"mouse",
			"axis"
		},
		look_raw_controller = {
			"gamepad",
			"right",
			"axis"
		},
		move_controller = {
			"gamepad",
			"left",
			"axis"
		},
		cursor = {
			"gamepad",
			"left",
			"axis"
		},
		ping = {
			"gamepad",
			"right_shoulder",
			"pressed"
		},
		voip_push_to_talk = {},
		move_left = {},
		move_right = {},
		move_forward = {},
		move_back = {},
		move_left_pressed = {},
		move_right_pressed = {},
		move_forward_pressed = {},
		move_back_pressed = {},
		cursor = {
			"gamepad",
			"left",
			"axis"
		},
		next_observer_target = {
			"gamepad",
			"a",
			"pressed"
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		toggle_input_helper = {
			"keyboard",
			"f1",
			"pressed"
		},
		action_one = {
			"gamepad",
			"r2",
			"pressed"
		},
		action_one_hold = {
			"gamepad",
			"r2",
			"held"
		},
		action_one_release = {
			"gamepad",
			"r2",
			"released"
		},
		action_two = {
			"gamepad",
			"l2",
			"pressed"
		},
		action_two_hold = {
			"gamepad",
			"l2",
			"held"
		},
		action_two_release = {
			"gamepad",
			"l2",
			"released"
		},
		action_three = {
			"gamepad",
			"r3",
			"pressed"
		},
		action_three_hold = {
			"gamepad",
			"r3",
			"held"
		},
		action_three_release = {
			"gamepad",
			"r3",
			"released"
		},
		action_inspect = {
			"gamepad",
			"r3",
			"pressed"
		},
		action_inspect_hold = {
			"gamepad",
			"r3",
			"held"
		},
		action_inspect_release = {
			"gamepad",
			"r3",
			"released"
		},
		action_one_softbutton_gamepad = {
			"gamepad",
			"r2",
			"soft_button"
		},
		action_one_mouse = {
			"mouse",
			"left",
			"pressed"
		},
		weapon_reload = {
			"gamepad",
			"l1",
			"pressed"
		},
		weapon_reload_hold = {
			"gamepad",
			"l1",
			"held"
		},
		character_inspecting = {
			"gamepad",
			"l3",
			"held"
		},
		wield_1 = {},
		wield_2 = {},
		wield_3 = {
			"gamepad",
			"left",
			"pressed"
		},
		wield_4 = {
			"gamepad",
			"right",
			"pressed"
		},
		wield_5 = {
			"gamepad",
			"up",
			"pressed"
		},
		wield_6 = {},
		wield_7 = {},
		wield_8 = {},
		wield_9 = {},
		wield_0 = {},
		wield_switch_1 = {
			"gamepad",
			"triangle",
			"pressed"
		},
		wield_switch_2 = {
			"gamepad",
			"down",
			"pressed"
		},
		wield_scroll = {},
		wield_next = {},
		wield_prev = {},
		walk = {},
		interact = {
			"gamepad",
			"square",
			"pressed"
		},
		interacting = {
			"gamepad",
			"square",
			"held"
		},
		jump_1 = {
			"gamepad",
			"cross",
			"pressed"
		},
		jump_2 = {},
		dodge_hold_1 = {
			"gamepad",
			"cross",
			"held"
		},
		dodge_hold_2 = {},
		dodge_1 = {},
		dodge_2 = {},
		crouch = {
			"gamepad",
			"circle",
			"pressed"
		},
		crouching = {
			"gamepad",
			"circle",
			"held"
		},
		look_raw = {
			"mouse",
			"mouse",
			"axis"
		},
		look_raw_controller = {
			"gamepad",
			"right",
			"axis"
		},
		move_controller = {
			"gamepad",
			"left",
			"axis"
		},
		cursor = {
			"gamepad",
			"left",
			"axis"
		},
		ping = {
			"gamepad",
			"r1",
			"pressed"
		},
		voip_push_to_talk = {},
		move_left = {},
		move_right = {},
		move_forward = {},
		move_back = {},
		move_left_pressed = {},
		move_right_pressed = {},
		move_forward_pressed = {},
		move_back_pressed = {},
		cursor = {
			"gamepad",
			"left",
			"axis"
		},
		next_observer_target = {
			"gamepad",
			"cross",
			"pressed"
		}
	}
}
PlayerControllerFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
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
		jump = {
			filter_type = "or",
			input_mappings = {
				button_1 = "jump_1",
				button_2 = "jump_2"
			}
		},
		wield_switch = {
			filter_type = "or",
			input_mappings = {
				button_1 = "wield_switch_1",
				button_2 = "wield_switch_2"
			}
		},
		look_controller = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 1.5,
			acceleration_delay = 0.2,
			accelerate_time_ref = 0.5,
			threshold = 0.925,
			inverted_y = false,
			multiplier_y = 0.75,
			input_mapping = "look_raw_controller",
			power_of = 1.75,
			multiplier_x = 4
		},
		look_controller_ranged = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 1.25,
			acceleration_delay = 0.2,
			accelerate_time_ref = 0.6,
			threshold = 0.925,
			inverted_y = false,
			multiplier_y = 0.75,
			input_mapping = "look_raw_controller",
			power_of = 2,
			multiplier_x = 4
		},
		look_controller_melee = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 2.5,
			acceleration_delay = 0.2,
			turnaround_time_ref = 0.75,
			threshold = 0.65,
			accelerate_time_ref = 0.15,
			turnaround_delay = 0.2,
			turnaround_multiplier_x = 3,
			multiplier_y = 1,
			inverted_y = false,
			multiplier_x = 2,
			input_mapping = "look_raw_controller",
			power_of = 1.5,
			turnaround_threshold = 0.925,
			turnaround_power_of = 2
		},
		look_controller_zoom = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 0.5,
			acceleration_delay = 0,
			accelerate_time_ref = 0.3,
			threshold = 0.95,
			inverted_y = false,
			multiplier_y = 0.5,
			input_mapping = "look_raw_controller",
			power_of = 1.1,
			multiplier_x = 1
		},
		look_controller_3p = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 0.5,
			acceleration_delay = 0,
			threshold = 0.95,
			accelerate_time_ref = 0.3,
			multiplier_y = 0.5,
			input_mapping = "look_raw_controller",
			power_of = 1.5,
			multiplier_x = 1.5
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		look_controller = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 1.5,
			acceleration_delay = 0.2,
			accelerate_time_ref = 0.5,
			threshold = 0.925,
			inverted_y = false,
			multiplier_y = 0.75,
			input_mapping = "look_raw_controller",
			power_of = 1.75,
			multiplier_x = 4
		},
		look_controller_ranged = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 1.25,
			acceleration_delay = 0.2,
			accelerate_time_ref = 0.6,
			threshold = 0.925,
			inverted_y = false,
			multiplier_y = 0.75,
			input_mapping = "look_raw_controller",
			power_of = 2,
			multiplier_x = 4
		},
		look_controller_melee = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 2.5,
			acceleration_delay = 0.2,
			turnaround_time_ref = 0.75,
			threshold = 0.65,
			accelerate_time_ref = 0.15,
			turnaround_delay = 0.2,
			turnaround_multiplier_x = 3,
			multiplier_y = 1,
			inverted_y = false,
			multiplier_x = 2,
			input_mapping = "look_raw_controller",
			power_of = 1.5,
			turnaround_threshold = 0.925,
			turnaround_power_of = 2
		},
		look_controller_zoom = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 0.5,
			acceleration_delay = 0,
			accelerate_time_ref = 0.3,
			threshold = 0.95,
			inverted_y = false,
			multiplier_y = 0.5,
			input_mapping = "look_raw_controller",
			power_of = 1.1,
			multiplier_x = 1
		},
		look_controller_3p = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 0.5,
			acceleration_delay = 0,
			threshold = 0.95,
			accelerate_time_ref = 0.3,
			multiplier_y = 0.5,
			input_mapping = "look_raw_controller",
			power_of = 1.5,
			multiplier_x = 1.5
		},
		wield_switch = {
			filter_type = "or",
			input_mappings = {
				button_1 = "wield_switch_1",
				button_2 = "wield_switch_2"
			}
		},
		jump = {
			filter_type = "or",
			input_mappings = {
				button_1 = "jump_1",
				button_2 = "jump_2"
			}
		},
		dodge = {
			filter_type = "or",
			input_mappings = {
				button_1 = "dodge_hold_1",
				button_2 = "dodge_hold_2"
			}
		},
		dodge_hold = {
			filter_type = "or",
			input_mappings = {
				button_1 = "dodge_hold_1",
				button_2 = "dodge_hold_2"
			}
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		look_controller = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 1.5,
			acceleration_delay = 0.2,
			accelerate_time_ref = 0.5,
			threshold = 0.925,
			inverted_y = false,
			multiplier_y = 0.75,
			input_mapping = "look_raw_controller",
			power_of = 1.75,
			multiplier_x = 4
		},
		look_controller_ranged = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 1.25,
			acceleration_delay = 0.2,
			accelerate_time_ref = 0.6,
			threshold = 0.925,
			inverted_y = false,
			multiplier_y = 0.75,
			input_mapping = "look_raw_controller",
			power_of = 2,
			multiplier_x = 4
		},
		look_controller_melee = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 2.5,
			acceleration_delay = 0.2,
			turnaround_time_ref = 0.75,
			threshold = 0.65,
			accelerate_time_ref = 0.15,
			turnaround_delay = 0.2,
			turnaround_multiplier_x = 3,
			multiplier_y = 1,
			inverted_y = false,
			multiplier_x = 2,
			input_mapping = "look_raw_controller",
			power_of = 1.5,
			turnaround_threshold = 0.925,
			turnaround_power_of = 2
		},
		look_controller_zoom = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 0.5,
			acceleration_delay = 0,
			accelerate_time_ref = 0.3,
			threshold = 0.95,
			inverted_y = false,
			multiplier_y = 0.5,
			input_mapping = "look_raw_controller",
			power_of = 1.1,
			multiplier_x = 1
		},
		look_controller_3p = {
			filter_type = "scale_vector3_xy_accelerated_x",
			multiplier_min_x = 0.5,
			acceleration_delay = 0,
			threshold = 0.95,
			accelerate_time_ref = 0.3,
			multiplier_y = 0.5,
			input_mapping = "look_raw_controller",
			power_of = 1.5,
			multiplier_x = 1.5
		},
		wield_switch = {
			filter_type = "or",
			input_mappings = {
				button_1 = "wield_switch_1",
				button_2 = "wield_switch_2"
			}
		},
		jump = {
			filter_type = "or",
			input_mappings = {
				button_1 = "jump_1",
				button_2 = "jump_2"
			}
		},
		dodge = {
			filter_type = "or",
			input_mappings = {
				button_1 = "dodge_hold_1",
				button_2 = "dodge_hold_2"
			}
		},
		dodge_hold = {
			filter_type = "or",
			input_mappings = {
				button_1 = "dodge_hold_1",
				button_2 = "dodge_hold_2"
			}
		}
	}
}
ChatControllerSettings = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		activate_chat_input = {
			"keyboard",
			"y",
			"pressed"
		},
		execute_chat_input_1 = {
			"keyboard",
			"enter",
			"pressed"
		},
		execute_chat_input_2 = {
			"keyboard",
			"numpad enter",
			"pressed"
		},
		deactivate_chat_input = {
			"keyboard",
			"esc",
			"pressed"
		},
		unallowed_activate_chat_input = {
			"keyboard",
			"left alt",
			"held"
		},
		chat_scroll_up = {
			"keyboard",
			"page up",
			"held"
		},
		chat_scroll_down = {
			"keyboard",
			"page down",
			"held"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		left_release = {
			"mouse",
			"left",
			"released"
		},
		left_press = {
			"mouse",
			"left",
			"pressed"
		},
		left_hold = {
			"mouse",
			"left",
			"held"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		activate_chat_input = {
			"keyboard",
			"y",
			"pressed"
		},
		execute_chat_input = {
			"keyboard",
			"enter",
			"pressed"
		},
		deactivate_chat_input = {
			"keyboard",
			"esc",
			"pressed"
		},
		unallowed_activate_chat_input = {
			"keyboard",
			"left alt",
			"held"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		left_release = {
			"mouse",
			"left",
			"released"
		},
		left_press = {
			"mouse",
			"left",
			"pressed"
		},
		left_hold = {
			"mouse",
			"left",
			"held"
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		activate_chat_input = {
			"keyboard",
			"triangle",
			"pressed"
		},
		execute_chat_input = {
			"keyboard",
			"enter",
			"pressed"
		},
		deactivate_chat_input = {
			"keyboard",
			"esc",
			"pressed"
		},
		unallowed_activate_chat_input = {
			"keyboard",
			"left alt",
			"held"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		left_release = {
			"mouse",
			"left",
			"released"
		},
		left_press = {
			"mouse",
			"left",
			"pressed"
		},
		left_hold = {
			"mouse",
			"left",
			"held"
		}
	}
}
ChatControllerFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		execute_chat_input = {
			filter_type = "or",
			input_mappings = {
				button_1 = "execute_chat_input_1",
				button_2 = "execute_chat_input_2"
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		execute_chat_input = {
			filter_type = "or",
			input_mappings = {
				button_1 = "execute_chat_input_1",
				button_2 = "execute_chat_input_2"
			}
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		execute_chat_input = {
			filter_type = "or",
			input_mappings = {
				button_1 = "execute_chat_input_1",
				button_2 = "execute_chat_input_2"
			}
		}
	}
}
FreeFlightKeymaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		quit_game = {
			"keyboard",
			"esc",
			"pressed"
		},
		projection_mode = {
			"keyboard",
			"f7",
			"pressed"
		},
		free_flight_toggle = {
			"keyboard",
			"f8",
			"pressed"
		},
		frustum_freeze_toggle = {
			"keyboard",
			"left shift",
			"held",
			"keyboard",
			"f8",
			"pressed"
		},
		set_drop_position = {
			"keyboard",
			"enter",
			"pressed"
		},
		increase_fov = {
			"keyboard",
			"numpad +",
			"pressed"
		},
		decrease_fov = {
			"keyboard",
			"num -",
			"pressed"
		},
		toggle_debug_info = {
			"keyboard",
			"f12",
			"pressed"
		},
		move_forward = {
			"keyboard",
			"w",
			"soft_button"
		},
		move_right = {
			"keyboard",
			"d",
			"soft_button"
		},
		move_left = {
			"keyboard",
			"a",
			"soft_button"
		},
		move_back = {
			"keyboard",
			"s",
			"soft_button"
		},
		move_down = {
			"keyboard",
			"q",
			"soft_button"
		},
		move_up = {
			"keyboard",
			"e",
			"soft_button"
		},
		mark = {
			"keyboard",
			"c",
			"pressed"
		},
		toggle_control_points = {
			"keyboard",
			"t",
			"pressed"
		},
		step_frame = {
			"keyboard",
			"up",
			"pressed"
		},
		play_pause = {
			"keyboard",
			"down",
			"pressed"
		},
		increase_frame_step = {
			"keyboard",
			"right",
			"pressed"
		},
		decrease_frame_step = {
			"keyboard",
			"left",
			"pressed"
		},
		look = {
			"mouse",
			"mouse",
			"axis"
		},
		speed_change = {
			"mouse",
			"wheel",
			"axis"
		},
		ray = {
			"mouse",
			"left",
			"pressed"
		},
		toggle_mouse_focus = {
			"mouse",
			"right",
			"pressed"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		action_one = {
			"mouse",
			"left",
			"pressed"
		},
		action_two = {
			"mouse",
			"right",
			"pressed"
		},
		k = {
			"keyboard",
			"k",
			"pressed"
		},
		l = {
			"keyboard",
			"l",
			"pressed"
		},
		x = {
			"keyboard",
			"x",
			"pressed"
		},
		m = {
			"keyboard",
			"m",
			"pressed"
		},
		comma = {
			"keyboard",
			"oem_comma (< ,)",
			"pressed"
		},
		period = {
			"keyboard",
			"oem_period (> .)",
			"pressed"
		},
		left_ctrl = {
			"keyboard",
			"left ctrl",
			"pressed"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		quit_game = {
			"keyboard",
			"esc",
			"pressed"
		},
		projection_mode = {
			"keyboard",
			"f7",
			"pressed"
		},
		frustum_freeze_toggle = {},
		set_drop_position = {
			"gamepad",
			"a",
			"pressed"
		},
		increase_fov = {
			"keyboard",
			"numpad +",
			"pressed"
		},
		decrease_fov = {
			"keyboard",
			"num -",
			"pressed"
		},
		toggle_debug_info = {
			"keyboard",
			"f12",
			"pressed"
		},
		move_forward = {
			"keyboard",
			"w",
			"soft_button"
		},
		move_right = {
			"keyboard",
			"d",
			"soft_button"
		},
		move_left = {
			"keyboard",
			"a",
			"soft_button"
		},
		move_back = {
			"keyboard",
			"s",
			"soft_button"
		},
		move_down = {
			"keyboard",
			"q",
			"soft_button"
		},
		move_up = {
			"keyboard",
			"e",
			"soft_button"
		},
		move = {
			"gamepad",
			"left",
			"axis"
		},
		mark = {
			"keyboard",
			"c",
			"pressed"
		},
		toggle_control_points = {
			"keyboard",
			"t",
			"pressed"
		},
		step_frame = {
			"keyboard",
			"up",
			"pressed"
		},
		play_pause = {
			"keyboard",
			"down",
			"pressed"
		},
		increase_frame_step = {
			"keyboard",
			"right",
			"pressed"
		},
		decrease_frame_step = {
			"keyboard",
			"left",
			"pressed"
		},
		left_shoulder_held = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		right_shoulder = {
			"gamepad",
			"right_shoulder",
			"pressed"
		},
		right_thumb_held = {
			"gamepad",
			"right_thumb",
			"held"
		},
		left_thumb_held = {
			"gamepad",
			"left_thumb",
			"held"
		},
		look_raw_controller = {
			"gamepad",
			"right",
			"axis"
		},
		speed_change = {
			"mouse",
			"wheel",
			"axis"
		},
		ray = {
			"mouse",
			"left",
			"pressed"
		},
		toggle_mouse_focus = {
			"mouse",
			"right",
			"pressed"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		action_one = {
			"mouse",
			"left",
			"pressed"
		},
		action_two = {
			"mouse",
			"right",
			"pressed"
		},
		k = {
			"keyboard",
			"k",
			"pressed"
		},
		l = {
			"keyboard",
			"l",
			"pressed"
		},
		x = {
			"keyboard",
			"x",
			"pressed"
		},
		m = {
			"keyboard",
			"m",
			"pressed"
		},
		comma = {
			"keyboard",
			"oem_comma (< ,)",
			"pressed"
		},
		period = {
			"keyboard",
			"oem_period (> .)",
			"pressed"
		},
		left_ctrl = {
			"keyboard",
			"left ctrl",
			"pressed"
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		quit_game = {
			"keyboard",
			"esc",
			"pressed"
		},
		projection_mode = {
			"keyboard",
			"f7",
			"pressed"
		},
		frustum_freeze_toggle = {
			"keyboard",
			"left shift",
			"held"
		},
		set_drop_position = {
			"gamepad",
			"cross",
			"pressed"
		},
		increase_fov = {
			"keyboard",
			"numpad +",
			"pressed"
		},
		decrease_fov = {
			"keyboard",
			"num -",
			"pressed"
		},
		toggle_debug_info = {
			"keyboard",
			"f12",
			"pressed"
		},
		move_forward = {
			"keyboard",
			"w",
			"soft_button"
		},
		move_right = {
			"keyboard",
			"d",
			"soft_button"
		},
		move_left = {
			"keyboard",
			"a",
			"soft_button"
		},
		move_back = {
			"keyboard",
			"s",
			"soft_button"
		},
		move_down = {
			"keyboard",
			"q",
			"soft_button"
		},
		move_up = {
			"keyboard",
			"e",
			"soft_button"
		},
		move = {
			"gamepad",
			"left",
			"axis"
		},
		mark = {
			"keyboard",
			"c",
			"pressed"
		},
		toggle_control_points = {
			"keyboard",
			"t",
			"pressed"
		},
		step_frame = {
			"keyboard",
			"up",
			"pressed"
		},
		play_pause = {
			"keyboard",
			"down",
			"pressed"
		},
		increase_frame_step = {
			"keyboard",
			"right",
			"pressed"
		},
		decrease_frame_step = {
			"keyboard",
			"left",
			"pressed"
		},
		left_shoulder_held = {
			"gamepad",
			"l1",
			"held"
		},
		right_shoulder = {
			"gamepad",
			"r1",
			"pressed"
		},
		right_thumb_held = {
			"gamepad",
			"r3",
			"held"
		},
		left_thumb_held = {
			"gamepad",
			"l3",
			"held"
		},
		look_raw_controller = {
			"gamepad",
			"right",
			"axis"
		},
		speed_change = {
			"mouse",
			"wheel",
			"axis"
		},
		ray = {
			"mouse",
			"left",
			"pressed"
		},
		toggle_mouse_focus = {
			"mouse",
			"right",
			"pressed"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		action_one = {
			"mouse",
			"left",
			"pressed"
		},
		action_two = {
			"mouse",
			"right",
			"pressed"
		},
		k = {
			"keyboard",
			"k",
			"pressed"
		},
		l = {
			"keyboard",
			"l",
			"pressed"
		},
		x = {
			"keyboard",
			"x",
			"pressed"
		},
		m = {
			"keyboard",
			"m",
			"pressed"
		},
		comma = {
			"keyboard",
			"oem_comma (< ,)",
			"pressed"
		},
		period = {
			"keyboard",
			"oem_period (> .)",
			"pressed"
		},
		left_ctrl = {
			"keyboard",
			"left ctrl",
			"pressed"
		}
	}
}
FreeFlightFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
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
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		look = {
			multiplier_y = -400.5,
			power_of = 2,
			acceleration_delay = 0,
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.1,
			multiplier_x = 600,
			filter_type = "scale_vector3_xy_accelerated_x"
		},
		free_flight_toggle = {
			filter_type = "and",
			input_mappings = {
				button_2 = "left_thumb_held",
				button_3 = "left_shoulder_held",
				button_1 = "right_thumb_held",
				button_4 = "right_shoulder"
			}
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		look = {
			multiplier_y = -400.5,
			power_of = 2,
			acceleration_delay = 0,
			input_mapping = "look_raw_controller",
			threshold = 0.925,
			accelerate_time_ref = 0.1,
			multiplier_x = 600,
			filter_type = "scale_vector3_xy_accelerated_x"
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
		},
		free_flight_toggle = {
			filter_type = "and",
			input_mappings = {
				button_2 = "left_thumb_held",
				button_3 = "left_shoulder_held",
				button_1 = "right_thumb_held",
				button_4 = "right_shoulder"
			}
		}
	}
}
SplashScreenKeymaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		skip_splash_1 = {
			"keyboard",
			"enter",
			"pressed"
		},
		skip_splash_2 = {
			"keyboard",
			"space",
			"pressed"
		},
		skip_splash_3 = {
			"keyboard",
			"esc",
			"pressed"
		},
		skip_splash_4 = {
			"gamepad",
			"a",
			"pressed"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		skip_splash = {
			"gamepad",
			"a",
			"pressed"
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		skip_splash = {
			"gamepad",
			"cross",
			"pressed"
		}
	}
}
SplashScreenFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		skip_splash = {
			filter_type = "or",
			input_mappings = {
				button_2 = "skip_splash_2",
				button_3 = "skip_splash_3",
				button_1 = "skip_splash_1",
				button_4 = "skip_splash_4"
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {}
}
TitleLoadingKeyMaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		cancel_video_1 = {
			"keyboard",
			"space",
			"pressed"
		},
		cancel_video_2 = {
			"keyboard",
			"esc",
			"pressed"
		},
		cancel_video_3 = {
			"gamepad",
			"a",
			"pressed"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		left_release = {
			"mouse",
			"left",
			"released"
		},
		left_press = {
			"mouse",
			"left",
			"pressed"
		},
		left_hold = {
			"mouse",
			"left",
			"held"
		},
		confirm = {
			"gamepad",
			"a",
			"released"
		},
		move_left = {
			"gamepad",
			"d_left",
			"pressed"
		},
		move_right = {
			"gamepad",
			"d_right",
			"pressed"
		},
		move_left_hold = {
			"gamepad",
			"d_left",
			"held"
		},
		move_right_hold = {
			"gamepad",
			"d_right",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		cancel_video_1 = {
			"gamepad",
			"a",
			"pressed"
		},
		confirm = {
			"gamepad",
			"a",
			"released"
		},
		move_left = {
			"gamepad",
			"d_left",
			"pressed"
		},
		move_right = {
			"gamepad",
			"d_right",
			"pressed"
		},
		move_left_hold = {
			"gamepad",
			"d_left",
			"held"
		},
		move_right_hold = {
			"gamepad",
			"d_right",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		cancel_video_1 = {
			"gamepad",
			"cross",
			"pressed"
		},
		confirm = {
			"gamepad",
			"cross",
			"released"
		},
		move_left = {
			"gamepad",
			"left",
			"pressed"
		},
		move_right = {
			"gamepad",
			"right",
			"pressed"
		},
		move_left_hold = {
			"gamepad",
			"left",
			"held"
		},
		move_right_hold = {
			"gamepad",
			"right",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		}
	}
}
TitleLoadingFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		cancel_video = {
			filter_type = "or",
			input_mappings = {
				button_2 = "cancel_video_2",
				button_3 = "cancel_video_3",
				button_1 = "cancel_video_1"
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		cancel_video = {
			filter_type = "or",
			input_mappings = {
				button_1 = "cancel_video_1"
			}
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		cancel_video = {
			filter_type = "or",
			input_mappings = {
				button_1 = "cancel_video_1"
			}
		}
	}
}
TitleScreenKeyMaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		move_left_raw = {
			"gamepad",
			"d_left",
			"pressed"
		},
		move_right_raw = {
			"gamepad",
			"d_right",
			"pressed"
		},
		move_up_raw = {
			"gamepad",
			"d_up",
			"pressed"
		},
		move_down_raw = {
			"gamepad",
			"d_down",
			"pressed"
		},
		move_left_hold_raw = {
			"gamepad",
			"d_left",
			"held"
		},
		move_right_hold_raw = {
			"gamepad",
			"d_right",
			"held"
		},
		move_up_hold_raw = {
			"gamepad",
			"d_up",
			"held"
		},
		move_down_hold_raw = {
			"gamepad",
			"d_down",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		},
		start_1 = {
			"keyboard",
			"enter",
			"released"
		},
		start_2 = {
			"keyboard",
			"space",
			"released"
		},
		show_support_info_1 = {
			"keyboard",
			"left shift",
			"held"
		},
		show_support_info_2 = {
			"keyboard",
			"f12",
			"held"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		move_left_raw = {
			"gamepad",
			"d_left",
			"pressed"
		},
		move_right_raw = {
			"gamepad",
			"d_right",
			"pressed"
		},
		move_up_raw = {
			"gamepad",
			"d_up",
			"pressed"
		},
		move_down_raw = {
			"gamepad",
			"d_down",
			"pressed"
		},
		move_left_hold_raw = {
			"gamepad",
			"d_left",
			"held"
		},
		move_right_hold_raw = {
			"gamepad",
			"d_right",
			"held"
		},
		move_up_hold_raw = {
			"gamepad",
			"d_up",
			"held"
		},
		move_down_hold_raw = {
			"gamepad",
			"d_down",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		},
		change_profile = {
			"gamepad",
			"x",
			"released"
		},
		start = {
			"gamepad",
			"a",
			"released"
		},
		back = {
			"gamepad",
			"b",
			"pressed"
		},
		delete_save = {
			"gamepad",
			"back",
			"pressed"
		},
		show_support_info_1 = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		show_support_info_2 = {
			"gamepad",
			"right_shoulder",
			"held"
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		move_left_raw = {
			"gamepad",
			"left",
			"pressed"
		},
		move_right_raw = {
			"gamepad",
			"right",
			"pressed"
		},
		move_up_raw = {
			"gamepad",
			"up",
			"pressed"
		},
		move_down_raw = {
			"gamepad",
			"down",
			"pressed"
		},
		move_left_hold_raw = {
			"gamepad",
			"left",
			"held"
		},
		move_right_hold_raw = {
			"gamepad",
			"right",
			"held"
		},
		move_up_hold_raw = {
			"gamepad",
			"up",
			"held"
		},
		move_down_hold_raw = {
			"gamepad",
			"down",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		},
		start = {
			"gamepad",
			"cross",
			"released"
		},
		back = {
			"gamepad",
			"circle",
			"pressed"
		},
		show_support_info_1 = {
			"gamepad",
			"l1",
			"held"
		},
		show_support_info_2 = {
			"gamepad",
			"r1",
			"held"
		}
	}
}
TitleScreenFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		move_down = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_down_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_up_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_left_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_right_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		move_down_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_down_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_up_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_left_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_right_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		show_support_info = {
			filter_type = "and",
			input_mappings = {
				button_1 = "show_support_info_1",
				button_2 = "show_support_info_2"
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		move_down = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_down_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_up_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_left_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_right_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		move_down_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_down_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_up_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_left_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_right_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		show_support_info = {
			filter_type = "and",
			input_mappings = {
				button_1 = "show_support_info_1",
				button_2 = "show_support_info_2"
			}
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		move_down = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_down_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_up_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_left_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_right_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		move_down_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_down_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_up_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_left_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_right_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		show_support_info = {
			filter_type = "and",
			input_mappings = {
				button_1 = "show_support_info_1",
				button_2 = "show_support_info_2"
			}
		}
	}
}
IngamePlayerListKeymaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		toggle_menu = {
			"keyboard",
			"esc",
			"pressed"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		left_release = {
			"mouse",
			"left",
			"released"
		},
		left_hold = {
			"mouse",
			"left",
			"held"
		},
		left_press = {
			"mouse",
			"left",
			"pressed"
		},
		right_press = {
			"mouse",
			"right",
			"pressed"
		},
		ingame_player_list_pressed = {
			"keyboard",
			"tab",
			"pressed"
		},
		ingame_player_list_held = {
			"keyboard",
			"tab",
			"held"
		},
		ingame_player_list_toggle = {},
		ingame_player_list_exit_1 = {
			"keyboard",
			"tab",
			"pressed"
		},
		ingame_player_list_exit_2 = {
			"keyboard",
			"esc",
			"pressed"
		},
		close_ingame_player_list = {
			"keyboard",
			"tab",
			"released"
		},
		activate_ingame_player_list_1 = {
			"mouse",
			"right",
			"released"
		},
		activate_ingame_player_list_2 = {
			"keyboard",
			"enter",
			"pressed"
		},
		move_up = {},
		move_down = {},
		mute_voice = {},
		mute_chat = {},
		kick_player = {},
		toggle_private = {},
		back = {},
		show_profile = {}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		toggle_menu = {
			"gamepad",
			"start",
			"pressed"
		},
		ingame_player_list_toggle = {
			"gamepad",
			"back",
			"pressed"
		},
		mute_voice = {
			"gamepad",
			"y",
			"released"
		},
		mute_chat = {
			"gamepad",
			"x",
			"released"
		},
		kick_player = {
			"gamepad",
			"right_thumb",
			"pressed"
		},
		toggle_private = {
			"gamepad",
			"left_thumb",
			"pressed"
		},
		back = {
			"gamepad",
			"b",
			"released"
		},
		show_profile = {
			"gamepad",
			"a",
			"pressed"
		},
		move_up = {
			"gamepad",
			"d_up",
			"pressed"
		},
		move_down = {
			"gamepad",
			"d_down",
			"pressed"
		},
		ingame_player_list_exit = {},
		activate_ingame_player_list = {}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		toggle_menu = {
			"gamepad",
			"options",
			"pressed"
		},
		ingame_player_list_toggle = {
			"gamepad",
			"touch",
			"pressed"
		},
		mute_voice = {
			"gamepad",
			"triangle",
			"released"
		},
		mute_chat = {
			"gamepad",
			"square",
			"released"
		},
		kick_player = {
			"gamepad",
			"r3",
			"pressed"
		},
		toggle_private = {
			"gamepad",
			"l3",
			"pressed"
		},
		back = {
			"gamepad",
			"circle",
			"released"
		},
		show_profile = {
			"gamepad",
			"cross",
			"pressed"
		},
		move_up = {
			"gamepad",
			"up",
			"pressed"
		},
		move_down = {
			"gamepad",
			"down",
			"pressed"
		},
		ingame_player_list_exit = {},
		activate_ingame_player_list = {}
	}
}
IngamePlayerListFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		ingame_player_list_exit = {
			filter_type = "or",
			input_mappings = {
				button_1 = "ingame_player_list_exit_1",
				button_2 = "ingame_player_list_exit_2"
			}
		},
		activate_ingame_player_list = {
			filter_type = "or",
			input_mappings = {
				button_1 = "activate_ingame_player_list_1",
				button_2 = "activate_ingame_player_list_2"
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {}
}
IngameMenuKeymaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		ingame_vote_yes = {
			"keyboard",
			"f5",
			"pressed"
		},
		ingame_vote_no = {
			"keyboard",
			"f6",
			"pressed"
		},
		ui_reload_debug = {
			"keyboard",
			"f5",
			"pressed"
		},
		ui_debug = {
			"keyboard",
			"f6",
			"pressed"
		},
		cancel_matchmaking = {
			"keyboard",
			"f10",
			"pressed"
		},
		matchmaking_ready_instigate = {
			"keyboard",
			"f2",
			"pressed"
		},
		matchmaking_ready = {
			"keyboard",
			"f2",
			"pressed"
		},
		matchmaking_start = {
			"keyboard",
			"f3",
			"pressed"
		},
		toggle_menu = {
			"keyboard",
			"esc",
			"pressed"
		},
		back_menu = {
			"mouse",
			"right",
			"pressed"
		},
		move_up_raw = {},
		move_down_raw = {},
		move_left_raw = {},
		move_right_raw = {},
		move_up_hold_raw = {},
		move_down_hold_raw = {},
		move_left_hold_raw = {},
		move_right_hold_raw = {},
		analog_input = {},
		skip = {
			"keyboard",
			"space",
			"held"
		},
		cursor = {
			"mouse",
			"cursor",
			"axis"
		},
		left_release = {
			"mouse",
			"left",
			"released"
		},
		left_hold = {
			"mouse",
			"left",
			"held"
		},
		left_press = {
			"mouse",
			"left",
			"pressed"
		},
		right_press = {
			"mouse",
			"right",
			"pressed"
		},
		confirm = {},
		confirm_hold = {},
		confirm_press = {},
		back = {},
		refresh = {},
		refresh_hold = {},
		refresh_press = {},
		special_1 = {},
		left_stick_press = {},
		right_stick_press = {},
		cycle_next = {},
		cycle_next_hold = {},
		cycle_previous = {},
		cycle_previous_hold = {},
		trigger_left_soft = {},
		trigger_right_soft = {},
		trigger_cycle_next = {},
		trigger_cycle_next_hold = {},
		trigger_cycle_previous = {},
		trigger_cycle_previous_hold = {},
		gamepad_left_axis = {},
		gamepad_right_axis = {},
		look_raw_controller = {},
		hotkey_map = {
			"keyboard",
			"m",
			"pressed"
		},
		hotkey_inventory = {
			"keyboard",
			"i",
			"pressed"
		},
		hotkey_journal = {
			"keyboard",
			"o",
			"pressed"
		},
		hotkey_forge = {
			"keyboard",
			"f",
			"pressed"
		},
		hotkey_altar = {
			"keyboard",
			"h",
			"pressed"
		},
		hotkey_lobby_browser = {
			"keyboard",
			"l",
			"pressed"
		},
		hotkey_quests = {
			"keyboard",
			"u",
			"pressed"
		},
		scroll_axis = {
			"mouse",
			"wheel",
			"axis"
		},
		debug_pixeldistance_1 = {
			"keyboard",
			"left shift",
			"held"
		},
		debug_pixeldistance_2 = {
			"mouse",
			"right",
			"held"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		ingame_vote_yes = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		ingame_vote_no = {
			"gamepad",
			"right_shoulder",
			"held"
		},
		ui_reload_debug = {
			"gamepad",
			"y",
			"held"
		},
		ui_debug = {
			"gamepad",
			"y",
			"held"
		},
		cancel_matchmaking = {
			"gamepad",
			"right_shoulder",
			"held"
		},
		matchmaking_ready_instigate = {
			"gamepad",
			"left_shoulder",
			"pressed"
		},
		matchmaking_ready = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		matchmaking_start = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		toggle_menu = {
			"gamepad",
			"start",
			"pressed"
		},
		back_menu = {
			"gamepad",
			"b",
			"pressed"
		},
		move_up_raw = {
			"gamepad",
			"d_up",
			"pressed"
		},
		move_down_raw = {
			"gamepad",
			"d_down",
			"pressed"
		},
		move_left_raw = {
			"gamepad",
			"d_left",
			"pressed"
		},
		move_right_raw = {
			"gamepad",
			"d_right",
			"pressed"
		},
		move_up_hold_raw = {
			"gamepad",
			"d_up",
			"held"
		},
		move_down_hold_raw = {
			"gamepad",
			"d_down",
			"held"
		},
		move_left_hold_raw = {
			"gamepad",
			"d_left",
			"held"
		},
		move_right_hold_raw = {
			"gamepad",
			"d_right",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		},
		confirm = {
			"gamepad",
			"a",
			"released"
		},
		confirm_hold = {
			"gamepad",
			"a",
			"held"
		},
		confirm_press = {
			"gamepad",
			"a",
			"pressed"
		},
		back = {
			"gamepad",
			"b",
			"released"
		},
		refresh = {
			"gamepad",
			"y",
			"released"
		},
		refresh_hold = {
			"gamepad",
			"y",
			"held"
		},
		refresh_press = {
			"gamepad",
			"y",
			"pressed"
		},
		special_1 = {
			"gamepad",
			"x",
			"released"
		},
		left_stick_press = {
			"gamepad",
			"left_thumb",
			"pressed"
		},
		right_stick_press = {
			"gamepad",
			"right_thumb",
			"pressed"
		},
		cycle_next = {
			"gamepad",
			"right_shoulder",
			"pressed"
		},
		cycle_next_hold = {
			"gamepad",
			"right_shoulder",
			"held"
		},
		cycle_previous = {
			"gamepad",
			"left_shoulder",
			"pressed"
		},
		cycle_previous_hold = {
			"gamepad",
			"left_shoulder",
			"held"
		},
		trigger_left_soft = {
			"gamepad",
			"left_trigger",
			"soft_button"
		},
		trigger_right_soft = {
			"gamepad",
			"right_trigger",
			"soft_button"
		},
		trigger_cycle_next = {
			"gamepad",
			"right_trigger",
			"pressed"
		},
		trigger_cycle_next_hold = {
			"gamepad",
			"right_trigger",
			"held"
		},
		trigger_cycle_previous = {
			"gamepad",
			"left_trigger",
			"pressed"
		},
		trigger_cycle_previous_hold = {
			"gamepad",
			"left_trigger",
			"held"
		},
		gamepad_left_axis = {
			"gamepad",
			"left",
			"axis"
		},
		gamepad_right_axis = {
			"gamepad",
			"right",
			"axis"
		},
		look_raw_controller = {
			"gamepad",
			"left",
			"axis"
		},
		show_gamercard = {
			"gamepad",
			"back",
			"pressed"
		},
		debug_pixeldistance = {}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		ingame_vote_yes = {
			"gamepad",
			"l1",
			"held"
		},
		ingame_vote_no = {
			"gamepad",
			"r1",
			"held"
		},
		ui_reload_debug = {
			"gamepad",
			"triangle",
			"held"
		},
		ui_debug = {
			"gamepad",
			"triangle",
			"held"
		},
		cancel_matchmaking = {
			"gamepad",
			"r1",
			"held"
		},
		matchmaking_ready_instigate = {
			"gamepad",
			"l1",
			"pressed"
		},
		matchmaking_ready = {
			"gamepad",
			"l1",
			"held"
		},
		matchmaking_start = {
			"gamepad",
			"l1",
			"held"
		},
		toggle_menu = {
			"gamepad",
			"options",
			"pressed"
		},
		back_menu = {
			"gamepad",
			"circle",
			"pressed"
		},
		move_up_raw = {
			"gamepad",
			"up",
			"pressed"
		},
		move_down_raw = {
			"gamepad",
			"down",
			"pressed"
		},
		move_left_raw = {
			"gamepad",
			"left",
			"pressed"
		},
		move_right_raw = {
			"gamepad",
			"right",
			"pressed"
		},
		move_up_hold_raw = {
			"gamepad",
			"up",
			"held"
		},
		move_down_hold_raw = {
			"gamepad",
			"down",
			"held"
		},
		move_left_hold_raw = {
			"gamepad",
			"left",
			"held"
		},
		move_right_hold_raw = {
			"gamepad",
			"right",
			"held"
		},
		analog_input = {
			"gamepad",
			"left",
			"axis"
		},
		confirm = {
			"gamepad",
			"cross",
			"released"
		},
		confirm_hold = {
			"gamepad",
			"cross",
			"held"
		},
		confirm_press = {
			"gamepad",
			"cross",
			"pressed"
		},
		back = {
			"gamepad",
			"circle",
			"released"
		},
		refresh = {
			"gamepad",
			"triangle",
			"released"
		},
		refresh_hold = {
			"gamepad",
			"triangle",
			"held"
		},
		refresh_press = {
			"gamepad",
			"triangle",
			"pressed"
		},
		special_1 = {
			"gamepad",
			"square",
			"released"
		},
		left_stick_press = {
			"gamepad",
			"l3",
			"pressed"
		},
		right_stick_press = {
			"gamepad",
			"r3",
			"pressed"
		},
		cycle_next = {
			"gamepad",
			"r1",
			"pressed"
		},
		cycle_next_hold = {
			"gamepad",
			"r1",
			"held"
		},
		cycle_previous = {
			"gamepad",
			"l1",
			"pressed"
		},
		cycle_previous_hold = {
			"gamepad",
			"l1",
			"held"
		},
		trigger_left_soft = {
			"gamepad",
			"l2",
			"soft_button"
		},
		trigger_right_soft = {
			"gamepad",
			"r2",
			"soft_button"
		},
		trigger_cycle_next = {
			"gamepad",
			"r2",
			"pressed"
		},
		trigger_cycle_next_hold = {
			"gamepad",
			"r2",
			"held"
		},
		trigger_cycle_previous = {
			"gamepad",
			"l2",
			"pressed"
		},
		trigger_cycle_previous_hold = {
			"gamepad",
			"l2",
			"held"
		},
		gamepad_left_axis = {
			"gamepad",
			"left",
			"axis"
		},
		gamepad_right_axis = {
			"gamepad",
			"right",
			"axis"
		},
		look_raw_controller = {
			"gamepad",
			"left",
			"axis"
		},
		debug_pixeldistance = {}
	}
}
IngameMenuFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		debug_pixeldistance = {
			filter_type = "and",
			input_mappings = {
				button_1 = "debug_pixeldistance_1",
				button_2 = "debug_pixeldistance_2"
			}
		},
		show_support_info = {
			filter_type = "and",
			input_mappings = {
				button_1 = "show_support_info_1",
				button_2 = "show_support_info_2"
			}
		},
		start = {
			filter_type = "or",
			input_mappings = {
				button_1 = "start_1",
				button_2 = "start_2"
			}
		},
		move_down = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_down_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_up_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_left_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_right_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		move_down_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_down_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_up_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_left_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_right_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		show_support_info = {
			filter_type = "and",
			input_mappings = {
				button_1 = "show_support_info_1",
				button_2 = "show_support_info_2"
			}
		},
		move_down = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_down_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_up_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_left_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_right_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		move_down_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_down_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_up_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_left_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_right_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		show_support_info = {
			filter_type = "and",
			input_mappings = {
				button_1 = "show_support_info_1",
				button_2 = "show_support_info_2"
			}
		},
		move_down = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_down_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_up_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_left_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right = {
			filter_type = "move_filter",
			threshold = 0.7,
			input_mappings = {
				"move_right_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		},
		move_down_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_down_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				-1,
				0
			}
		},
		move_up_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_up_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				0,
				1,
				0
			}
		},
		move_left_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_left_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				-1,
				0,
				0
			}
		},
		move_right_hold = {
			filter_type = "move_filter",
			hold = true,
			threshold = 0.7,
			input_mappings = {
				"move_right_hold_raw"
			},
			axis_mappings = {
				"analog_input"
			},
			axis = {
				1,
				0,
				0
			}
		}
	}
}
CutsceneKeymaps = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		skip_cutscene_1 = {
			"keyboard",
			"enter",
			"pressed"
		},
		skip_cutscene_2 = {
			"keyboard",
			"space",
			"pressed"
		},
		skip_cutscene_3 = {
			"keyboard",
			"esc",
			"pressed"
		},
		gdc_skip = {
			"keyboard",
			"space",
			"pressed"
		},
		gdc_debug_skip_1 = {
			"keyboard",
			"left shift",
			"held"
		},
		gdc_debug_skip_2 = {
			"keyboard",
			"space",
			"pressed"
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		skip_cutscene = {
			"gamepad",
			"a",
			"pressed"
		},
		gdc_skip = {
			"gamepad",
			"a",
			"pressed"
		},
		gdc_debug_skip = {}
	},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {
		skip_cutscene = {
			"gamepad",
			"cross",
			"pressed"
		},
		gdc_skip = {
			"gamepad",
			"cross",
			"pressed"
		},
		gdc_debug_skip = {}
	}
}
CutsceneFilters = {
	win32 = InputUtils.keymaps_key_approved("win32") and {
		skip_cutscene = {
			filter_type = "or",
			input_mappings = {
				button_2 = "skip_cutscene_2",
				button_3 = "skip_cutscene_3",
				button_1 = "skip_cutscene_1"
			}
		},
		gdc_debug_skip = {
			filter_type = "and",
			input_mappings = {
				button_1 = "gdc_debug_skip_1",
				button_2 = "gdc_debug_skip_2"
			}
		}
	},
	xb1 = InputUtils.keymaps_key_approved("xb1") and {},
	ps4 = InputUtils.keymaps_key_approved("ps4") and {}
}
ControllerDisconnectKeymaps = {
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		accept_held_1 = {
			"gamepad",
			"a",
			"held"
		},
		accept_held_2 = {
			"gamepad",
			"start",
			"held"
		},
		cancel_held_1 = {
			"gamepad",
			"b",
			"held"
		},
		cancel_held_2 = {
			"gamepad",
			"back",
			"held"
		},
		accept_1 = {
			"gamepad",
			"a",
			"released"
		},
		accept_2 = {
			"gamepad",
			"start",
			"released"
		},
		cancel_1 = {
			"gamepad",
			"b",
			"released"
		},
		cancel_2 = {
			"gamepad",
			"back",
			"released"
		}
	}
}
ControllerDisconnectFilters = {
	xb1 = InputUtils.keymaps_key_approved("xb1") and {
		accept_held = {
			filter_type = "or",
			input_mappings = {
				button_1 = "accept_held_1",
				button_2 = "accept_held_2"
			}
		},
		cancel_held = {
			filter_type = "or",
			input_mappings = {
				button_1 = "cancel_held_1",
				button_2 = "cancel_held_2"
			}
		},
		accept = {
			filter_type = "or",
			input_mappings = {
				button_1 = "accept_1",
				button_2 = "accept_2"
			}
		},
		cancel = {
			filter_type = "or",
			input_mappings = {
				button_1 = "cancel_1",
				button_2 = "cancel_2"
			}
		}
	}
}
GamepadSettings = {
	menu_analog_deadzone = 0.5,
	menu_speed_multiplier_frame_decrease = 0.025,
	menu_cooldown = 0.2,
	menu_min_speed_multiplier = 0.2,
	quest_menu_navigation_cooldown = 0.15
}

require("scripts/helpers/gamepad_alternate_layout_helper")

return 
