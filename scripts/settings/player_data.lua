PlayerData = PlayerData or {
	new_item_data_version = 1,
	controls_version = 7,
	new_item_ids = {},
	controls = {}
}

function populate_player_data_from_save(save_data, id, version_match)
	if not save_data.player_data then
		save_data.player_data = {}
	end

	if not save_data.player_data[id] then
		local new_player_data = table.clone(PlayerData)

		if save_data.controls then
			new_player_data.controls = save_data.controls
			save_data.controls = nil
		end

		if save_data.new_item_ids then
			new_player_data.new_item_ids = save_data.new_item_ids
			save_data.new_item_ids = nil
		end

		save_data.player_data[id] = new_player_data
	end

	local player_save_data = save_data.player_data[id]

	if version_match then
		if PlayerData.controls_version ~= player_save_data.controls_version then
			player_save_data.controls = nil

			print("Wrong controls_version for save file, saved: ", player_save_data.controls_version, " current: ", PlayerData.controls_version)

			player_save_data.controls_version = PlayerData.controls_version
		end

		if PlayerData.new_item_data_version ~= player_save_data.new_item_data_version then
			print("Wrong new_item_data_version for save file, saved: ", player_save_data.new_item_data_version, " current: ", PlayerData.new_item_data_version)

			player_save_data.new_item_ids = {}
			player_save_data.new_item_data_version = PlayerData.new_item_data_version
		end
	end

	PlayerData = player_save_data

	return 
end

return 
