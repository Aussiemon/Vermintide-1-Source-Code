DefaultPlayerData = {
	new_item_data_version = 1,
	controls_version = 9,
	skins_activated_version = 1,
	new_lorebook_data_version = 1,
	additional_content_version = 2,
	new_item_ids = {},
	controls = {},
	new_lorebook_ids = {},
	additional_content_data = {},
	skins_activated_data = {
		witch_hunter = "witch_hunter_arrogance_lost",
		empire_soldier = "empire_soldier_arrogance_lost",
		dwarf_ranger = "dwarf_ranger_arrogance_lost",
		wood_elf = "wood_elf_arrogance_lost",
		bright_wizard = "bright_wizard_arrogance_lost"
	}
}
PlayerData = PlayerData or table.clone(DefaultPlayerData)

function populate_player_data_from_save(save_data, id, version_match)
	if not save_data.player_data then
		save_data.player_data = {}
	end

	if not save_data.player_data[id] then
		local new_player_data = table.clone(DefaultPlayerData)

		if save_data.controls then
			new_player_data.controls = save_data.controls
			save_data.controls = nil
		end

		if save_data.new_item_ids then
			new_player_data.new_item_ids = save_data.new_item_ids
			save_data.new_item_ids = nil
		end

		if save_data.new_lorebook_ids then
			new_player_data.new_lorebook_ids = save_data.new_lorebook_ids
			save_data.new_lorebook_ids = nil
		end

		save_data.player_data[id] = new_player_data
	end

	local player_save_data = save_data.player_data[id]

	if version_match then
		if PlayerData.controls_version ~= player_save_data.controls_version then
			player_save_data.controls = {}

			print("Wrong controls_version for save file, saved: ", player_save_data.controls_version, " current: ", PlayerData.controls_version)

			player_save_data.controls_version = PlayerData.controls_version
		end

		if PlayerData.new_item_data_version ~= player_save_data.new_item_data_version then
			print("Wrong new_item_data_version for save file, saved: ", player_save_data.new_item_data_version, " current: ", PlayerData.new_item_data_version)

			player_save_data.new_item_ids = {}
			player_save_data.new_item_data_version = PlayerData.new_item_data_version
		end

		if PlayerData.new_lorebook_data_version ~= player_save_data.new_lorebook_data_version then
			print("Wrong new_lorebook_data_version for save file, saved: ", player_save_data.new_lorebook_data_version, " current: ", PlayerData.new_lorebook_data_version)

			player_save_data.new_lorebook_ids = {}
			player_save_data.new_lorebook_data_version = PlayerData.new_lorebook_data_version
		end

		if PlayerData.additional_content_version ~= player_save_data.additional_content_version then
			print("Wrong additional_content_version for save file, saved: ", player_save_data.additional_content_version, " current: ", PlayerData.additional_content_version)

			player_save_data.additional_content_data = {}
			player_save_data.additional_content_version = PlayerData.additional_content_version
		end

		if PlayerData.skins_activated_version ~= player_save_data.skins_activated_version then
			print("Wrong skins_activated_version for save file, saved: ", player_save_data.skins_activated_version, " current: ", PlayerData.skins_activated_version)

			player_save_data.skins_activated_data = table.clone(PlayerData.skins_activated_data)
			player_save_data.skins_activated_version = PlayerData.skins_activated_version
		end
	end

	PlayerData = player_save_data
	local input_manager = Managers.input

	if input_manager then
		input_manager.apply_saved_keymaps(input_manager)
	end

	return 
end

return 
