AreaSettings = AreaSettings or {}
AreaSettings.world = {
	sorting = 1
}
AreaSettings.ubersreik = {
	area_icon_background_texture = "ubersreik_location_icon",
	display_name = "dlc1_4_area_ubersreik",
	sorting = 2,
	map_icon = "level_location_any_icon",
	area_icon_hover_texture = "ubersreik_location_icon_glow",
	level_image = "level_image_location_ubersreik",
	map_texture = "map_ubersreik",
	map_position = {
		150,
		170
	},
	console_map_textures = {
		selected = "area_image_ubersreik_01",
		normal = "area_image_ubersreik_02"
	}
}
AreaSettings.drachenfels = {
	sorting = 3,
	display_name = "dlc1_4_area_drachenfels",
	map_icon = "level_location_any_icon",
	dlc_name = "drachenfels",
	dlc_url = "http://store.steampowered.com/app/453280",
	level_image = "level_image_dlc_location_drachenfels",
	map_texture = "map_drachenfels",
	map_position = {
		-412,
		265
	},
	console_map_textures = {
		selected = "area_image_drachenfels_01",
		normal = "area_image_drachenfels_02"
	}
}
AreaSettings.dwarfs = {
	area_icon_background_texture = "ubersreik_location_icon",
	display_name = "dlc1_5_area_dwarf",
	sorting = 4,
	map_icon = "level_location_any_icon",
	area_icon_hover_texture = "ubersreik_location_icon_glow",
	dlc_name = "dwarfs",
	dlc_url = "http://store.steampowered.com/app/463791",
	level_image = "level_image_location_karak_azgaraz",
	map_texture = "map_karak_azgaraz",
	map_position = {
		390,
		-180
	},
	console_map_textures = {
		selected = "area_image_karak_azgaraz_01",
		normal = "area_image_karak_azgaraz_02"
	}
}

for _, dlc in pairs(DLCSettings) do
	local area_settings = dlc.area_settings

	if area_settings then
		for key, value in pairs(area_settings) do
			AreaSettings[key] = value
		end
	end
end

return
