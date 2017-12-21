return function (self)
	return {
		start_entry = "board_quest_1",
		grid = {
			board_quest_1 = {
				scenegraph_id = "board_quest_slot_1",
				widget_table = self._board_quest_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_quest_selection,
				actions = {
					move_right = "board_quest_2",
					move_left = "log_quest_1",
					move_up = "board_contract_5",
					move_down = "board_contract_1"
				}
			},
			board_quest_2 = {
				scenegraph_id = "board_quest_slot_2",
				widget_table = self._board_quest_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_quest_selection,
				actions = {
					move_right = "board_quest_3",
					move_left = "board_quest_1",
					move_up = "board_contract_6",
					move_down = "board_contract_2"
				}
			},
			board_quest_3 = {
				scenegraph_id = "board_quest_slot_3",
				widget_table = self._board_quest_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_quest_selection,
				actions = {
					move_right = "log_quest_1",
					move_left = "board_quest_2",
					move_up = "board_contract_8",
					move_down = "board_contract_4"
				}
			},
			log_quest_1 = {
				widget_index = 1,
				scenegraph_id = "log_quest",
				widget_table = self._log_quest_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_quest_selection,
				actions = {
					move_right = "board_quest_1",
					move_left = "board_quest_3",
					move_up = "log_contract_3",
					move_down = "log_contract_1"
				}
			},
			board_contract_1 = {
				scenegraph_id = "board_contract_slot_1",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "board_contract_2",
					move_left = "log_contract_1",
					move_up = "board_quest_1",
					move_down = "board_contract_5"
				}
			},
			board_contract_2 = {
				scenegraph_id = "board_contract_slot_2",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "board_contract_3",
					move_left = "board_contract_1",
					move_up = "board_quest_2",
					move_down = "board_contract_6"
				}
			},
			board_contract_3 = {
				scenegraph_id = "board_contract_slot_3",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "board_contract_4",
					move_left = "board_contract_2",
					move_up = "board_quest_2",
					move_down = "board_contract_7"
				}
			},
			board_contract_4 = {
				scenegraph_id = "board_contract_slot_4",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "log_contract_1",
					move_left = "board_contract_3",
					move_up = "board_quest_3",
					move_down = "board_contract_8"
				}
			},
			board_contract_5 = {
				scenegraph_id = "board_contract_slot_5",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "board_contract_6",
					move_left = "log_contract_3",
					move_up = "board_contract_1",
					move_down = "board_quest_1"
				}
			},
			board_contract_6 = {
				scenegraph_id = "board_contract_slot_6",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "board_contract_7",
					move_left = "board_contract_5",
					move_up = "board_contract_2",
					move_down = "board_quest_2"
				}
			},
			board_contract_7 = {
				scenegraph_id = "board_contract_slot_7",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "board_contract_8",
					move_left = "board_contract_6",
					move_up = "board_contract_3",
					move_down = "board_quest_2"
				}
			},
			board_contract_8 = {
				scenegraph_id = "board_contract_slot_8",
				widget_table = self._board_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_board_contract_selection,
				actions = {
					move_right = "log_contract_3",
					move_left = "board_contract_7",
					move_up = "board_contract_4",
					move_down = "board_quest_3"
				}
			},
			log_contract_1 = {
				widget_index = 1,
				scenegraph_id = "log_contract_1",
				widget_table = self._log_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_log_contract_selection,
				actions = {
					move_right = "board_contract_1",
					move_left = "board_contract_4",
					move_up = "log_quest_1",
					move_down = "log_contract_2"
				}
			},
			log_contract_2 = {
				widget_index = 2,
				scenegraph_id = "log_contract_2",
				widget_table = self._log_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_log_contract_selection,
				actions = {
					move_right = "board_contract_5",
					move_left = "board_contract_8",
					move_up = "log_contract_1",
					move_down = "log_contract_3"
				}
			},
			log_contract_3 = {
				widget_index = 3,
				scenegraph_id = "log_contract_3",
				widget_table = self._log_contract_widgets,
				selection_widget = self.gamepad_selection_widgets.gamepad_log_contract_selection,
				actions = {
					move_right = "board_contract_5",
					move_left = "board_contract_8",
					move_up = "log_contract_2",
					move_down = "log_quest_1"
				}
			}
		}
	}
end
