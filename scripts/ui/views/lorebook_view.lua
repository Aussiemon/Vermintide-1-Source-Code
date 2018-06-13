require("scripts/ui/views/lorebook_page_layout")
require("scripts/ui/views/lorebook_pages")

local BaseLocalize = Localize
local Localize = LocalizeLorebook
local HOVER_TEXTURE_SPACING = 25
local STATUS_TEXTURE_SPACING = -5
local ELEMENT_SELECTED_ALPHA = 160
local ELEMENT_NON_SELECTED_ALPHA = 100
local NUM_PAGES = 4
local definitions = local_require("scripts/ui/views/lorebook_view_definitions")
local input_description_data = {
	gamepad_support = true,
	name = "lorebook_menu"
}
LorebookView = class(LorebookView)

LorebookView.init = function (self, ingame_ui_context)
	self.ui_renderer = ingame_ui_context.ui_renderer
	self.input_manager = ingame_ui_context.input_manager
	self.ingame_ui = ingame_ui_context.ingame_ui
	self.world = ingame_ui_context.world
	self.statistics_db = ingame_ui_context.statistics_db
	self.wwise_world = ingame_ui_context.dialogue_system.wwise_world
	local input_manager = self.input_manager

	input_manager:create_input_service("lorebook_menu", "IngameMenuKeymaps", "IngameMenuFilters")
	input_manager:map_device_to_service("lorebook_menu", "keyboard")
	input_manager:map_device_to_service("lorebook_menu", "mouse")
	input_manager:map_device_to_service("lorebook_menu", "gamepad")

	self.list_elements = {}
	self.index_list_elements = {}
	self.index_array = {}
	self.page_layout = table.clone(JournalPageLayout)
	self.new_page_paths = self:initialize_new_page_paths()
	self.locked_page_paths = self:initialize_locked_page_paths()

	rawset(_G, "global_lorebook_view", self)

	self.ui_animations = {}

	self:create_ui_elements()

	self.controller_cooldown = 0
	local input_service = self.input_manager:get_service("lorebook_menu")
	local number_of_actvie_descriptions = 6
	local gui_layer = definitions.scenegraph_definition.root.position[3]
	self.menu_input_description = MenuInputDescriptionUI:new(ingame_ui_context, self.ui_renderer, input_service, number_of_actvie_descriptions, gui_layer, definitions.generic_input_actions)

	self.menu_input_description:set_input_description(nil)

	self.paragraph_divider_offsets = {}
	self.page_texts = {}

	for i = 1, NUM_PAGES, 1 do
		self.paragraph_divider_offsets[i] = {
			large = {},
			medium = {},
			small = {}
		}
		self.page_texts[i] = {
			top = {
				width = 0,
				texts = {}
			},
			center = {
				width = 0,
				texts = {}
			},
			bottom = {
				width = 0,
				texts = {}
			}
		}
	end
end

LorebookView.input_service = function (self)
	return self.input_manager:get_service("lorebook_menu")
end

LorebookView.destroy = function (self)
	rawset(_G, "global_lorebook_view", nil)
	self.menu_input_description:destroy()

	self.menu_input_description = nil

	GarbageLeakDetector.register_object(self, "LorebookView")
end

local widget_definitions = definitions.widget_definitions
local create_simple_texture_widget = definitions.create_simple_texture_widget

LorebookView.create_ui_elements = function (self)
	self.ui_scenegraph = UISceneGraph.init_scenegraph(definitions.scenegraph_definition)
	self.background_widgets = {
		create_simple_texture_widget("journal_bg", "background")
	}
	self.title_text = UIWidget.init(widget_definitions.title_text)
	self.front_page_new_icon = UIWidget.init(widget_definitions.front_page_new_icon)
	self.front_page_lock_icon = UIWidget.init(widget_definitions.front_page_lock_icon)
	self.front_page_new_icon_text = UIWidget.init(widget_definitions.front_page_new_icon_text)
	self.front_page_lock_icon_text = UIWidget.init(widget_definitions.front_page_lock_icon_text)
	self.front_page_new_icon_text.style.text.horizontal_alignment = "left"
	self.front_page_lock_icon_text.style.text.horizontal_alignment = "left"
	self.front_page_title_image = UIWidget.init(widget_definitions.front_page_title_image)
	self.front_page_description_text = UIWidget.init(widget_definitions.front_page_description_text)
	self.page_reveal_mask = UIWidget.init(widget_definitions.page_reveal_mask)
	self.lorebook_front_page_collectible_title = UIWidget.init(widget_definitions.lorebook_front_page_collectible_title)
	self.lorebook_front_page_collectible_divider = UIWidget.init(widget_definitions.lorebook_front_page_collectible_divider)
	self.lorebook_front_page_collectible_counter = UIWidget.init(widget_definitions.lorebook_front_page_collectible_counter)
	self.lorebook_front_page_collectible_counter.style.text.localize = false
	self.contents_title_divider = UIWidget.init(widget_definitions.contents_title_divider)
	self.contents_title_divider_top = UIWidget.init(widget_definitions.contents_title_divider_top)
	self.page_back_button = UIWidget.init(widget_definitions.page_back_button)
	self.exit_button = UIWidget.init(widget_definitions.exit_button)
	self.dead_space_filler = UIWidget.init(widget_definitions.dead_space_filler)
	self.contents_title = UIWidget.init(widget_definitions.contents_title)
	self.page_title = UIWidget.init(widget_definitions.page_title)
	self.page_content = UIWidget.init(widget_definitions.page_content)
	self.page_count = UIWidget.init(widget_definitions.page_count)
	self.paragraph_divider_large = UIWidget.init(widget_definitions.paragraph_divider_large)
	self.paragraph_divider_medium = UIWidget.init(widget_definitions.paragraph_divider_medium)
	self.paragraph_divider_small = UIWidget.init(widget_definitions.paragraph_divider_small)
	self.page_image_1 = UIWidget.init(widget_definitions.page_image_1)
	self.page_image_2 = UIWidget.init(widget_definitions.page_image_2)
	self.next_page = UIWidget.init(widget_definitions.next_page_button)
	self.previous_page = UIWidget.init(widget_definitions.previous_page_button)
	self.dead_space_4k_filler = UIWidget.init(UIWidgets.create_4k_filler())
	local contents_list = UIWidget.init(definitions.contents_list_definition)
	local list_content = contents_list.content.list_content
	local list_style = contents_list.style.list_style
	local item_styles = list_style.item_styles
	self.contents_list = contents_list
	local index_list = UIWidget.init(definitions.index_list_definition)
	local index_list_content = index_list.content.list_content
	local index_list_style = index_list.style.list_style
	local index_item_styles = index_list_style.item_styles
	self.index_list = index_list
	self.ui_animator = UIAnimator:new(self.ui_scenegraph, definitions.animations)
end

LorebookView.initialize_locked_page_paths = function (self)
	local lorebook_collectable_pages = LorebookCollectablePages
	local locked_page_paths = {}

	for _, pages in pairs(lorebook_collectable_pages) do
		for index, category_name in ipairs(pages) do
			locked_page_paths[#locked_page_paths + 1] = LorebookPaths[category_name]
		end
	end

	return locked_page_paths
end

LorebookView.initialize_new_page_paths = function (self)
	local new_page_ids = LoreBookHelper.get_new_page_ids()

	if new_page_ids then
		local new_page_paths = {}

		for category_name, new in pairs(new_page_ids) do
			new_page_paths[#new_page_paths + 1] = LorebookPaths[category_name]
		end

		return new_page_paths
	end
end

LorebookView.change_tab_index = function (self, new_index, play_sound)
	if self.index_array[1] and self.index_array[1] == new_index then
		return
	end

	table.clear(self.index_array)

	self.index_array[1] = new_index

	if play_sound then
		self:play_sound("Play_hud_lorebook_button")
	end

	local contents_list = self.contents_list
	local list_content = contents_list.content.list_content
	local num_contents_list_items = #list_content
	local item_styles = contents_list.style.list_style.item_styles
	local tab_category = self.page_layout[new_index]
	local sub_categories = tab_category.sub_categories

	self:populate_list(list_content, item_styles, sub_categories)

	local index_list = self.index_list
	local index_list_content = index_list.content.list_content
	local num_index_list_items = #index_list_content
	local index_item_styles = index_list.style.list_style.item_styles
	local tab_category = self.page_layout[new_index]
	local sub_categories = tab_category.sub_categories

	self:populate_index_list(index_list_content, index_item_styles, sub_categories)

	local category_name = tab_category.category_name

	self:fill_page_content(tab_category.page_text, category_name, tab_category.images, tab_category.image)
	self:set_content_title(category_name)
	self:set_page_title()
end

LorebookView.get_current_categories = function (self)
	local index_array = self.index_array
	local depth = #index_array
	local categories = self.page_layout

	for i = 1, depth, 1 do
		local index = index_array[i]
		local in_sub_category = index_array[i + 1] ~= nil
		categories = (in_sub_category and categories[index].sub_categories) or categories[index]
	end

	return categories
end

LorebookView.get_next_sub_categories_by_index = function (self, index)
	local current_categories = self:get_current_categories()
	local current_sub_categories = current_categories.sub_categories

	if current_sub_categories then
		return current_sub_categories[index].sub_categories, current_sub_categories[index]
	end
end

LorebookView.set_content_title = function (self, title)
	local contents_title = self.contents_title
	local contents_title_content = contents_title.content
	contents_title_content.text_field = Localize(title)
	self.contents_title_divider.content.visible = true
end

LorebookView.set_page_title = function (self, title)
	local page_title = self.page_title
	local page_title_content = page_title.content
	page_title_content.text_field = (title and Localize(title)) or ""
end

LorebookView.fill_page_content = function (self, page_text, category_name, images, image)
	local seed = LorebookCategoryLookup[category_name] * 5208943
	local page_title = self.page_title
	local page_title_content = page_title.content
	local page_widget = self.page_content
	local page_widget_content = page_widget.content
	local localized_page_text = (page_text and Localize(page_text)) or ""
	page_widget_content.text_field = localized_page_text
	page_text = page_text or ""
	local exclusion_zones = page_widget_content.text_exclusion_zones
	exclusion_zones.top.active = false
	exclusion_zones.bottom.active = false
	local page_image_1 = self.page_image_1
	local page_image_1_content = page_image_1.content
	local page_image_2 = self.page_image_2
	local page_image_2_content = page_image_2.content
	page_image_1_content.visible = false
	page_image_2_content.visible = false

	if page_text == "" then
		page_widget_content.visible = false
		self.paragraph_divider_large.content.visible = false
		self.paragraph_divider_medium.content.visible = false
		self.paragraph_divider_small.content.visible = false
	else
		page_widget_content.visible = true
		self.paragraph_divider_large.content.visible = true
		self.paragraph_divider_medium.content.visible = true
		self.paragraph_divider_small.content.visible = true
	end

	if image then
		page_image_1_content.texture_id = image.name
		page_image_1_content.visible = true
		local vertical_alignment = image.vertical_alignment
		local horizontal_alignment = image.horizontal_alignment

		if not vertical_alignment then
			local value = nil
			seed, value = Math.next_random(seed, 2)

			if value == 1 then
				vertical_alignment = "top"
			else
				vertical_alignment = "bottom"
			end
		end

		if not horizontal_alignment then
			local value = nil
			seed, value = Math.next_random(seed, 2)

			if value == 1 then
				horizontal_alignment = "left"
			else
				horizontal_alignment = "right"
			end
		end

		self:setup_page_image_and_exclusion_zone("page_image_1", image.name, vertical_alignment, horizontal_alignment, exclusion_zones)
	elseif page_text ~= "" and images then
		local num_images = nil
		seed, num_images = Math.next_random(seed, 0, 1)
		local vertical_alignment, horizontal_alignment = nil

		if num_images > 0 then
			local value = nil
			seed, value = Math.next_random(seed, 2)

			if value == 1 then
				vertical_alignment = "top"
			else
				vertical_alignment = "bottom"
			end

			seed, value = Math.next_random(seed, 2)

			if value == 1 then
				horizontal_alignment = "left"
			else
				horizontal_alignment = "right"
			end

			seed, value = Math.next_random(seed, #images)
			local image_name = images[value]
			page_image_1_content.texture_id = image_name
			page_image_1_content.visible = true

			self:setup_page_image_and_exclusion_zone("page_image_1", image_name, vertical_alignment, horizontal_alignment, exclusion_zones)

			if num_images == 2 then
				local page_image_1_horizontal_alignment = horizontal_alignment
				local page_image_1_image = image_name
				seed, value = Math.next_random(seed, 2)

				if vertical_alignment == "bottom" then
					vertical_alignment = "top"
				else
					vertical_alignment = "bottom"
				end

				if horizontal_alignment == "left" then
					horizontal_alignment = "right"
				else
					horizontal_alignment = "left"
				end

				local images_2 = table.clone(images)
				seed = table.shuffle(images_2, seed)
				local image_found = false
				local page_content_scenegraph = self.ui_scenegraph.page_content
				local page_text_size = page_content_scenegraph.size

				for i = 1, #images, 1 do
					repeat
						if image_found then
							break
						end

						local image_name = images[i]

						if image_name == page_image_1_content.texture_id then
							break
						end

						local page_image_1_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(page_image_1_image)
						local page_image_2_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(image_name)
						local page_image_1_size = page_image_1_settings.size
						local page_image_2_size = page_image_2_settings.size

						if (page_image_1_horizontal_alignment == horizontal_alignment or page_text_size[1] < page_image_1_size[1] + page_image_2_size[1]) and page_text_size[2] < page_image_1_size[2] + page_image_2_size[2] then
							break
						end

						image_found = true
						page_image_2_content.texture_id = image_name
						page_image_2_content.visible = true

						self:setup_page_image_and_exclusion_zone("page_image_2", image_name, vertical_alignment, horizontal_alignment, exclusion_zones)
					until true
				end
			end
		end
	end

	self:setup_page_texts(page_widget.style, page_widget.content, localized_page_text)

	local page_count = self.page_count
	local content = self.page_count.content
	content.text_field = "1 / " .. self.num_content_pages
end

local image_offsets = {
	top = {
		left = {
			-10,
			5
		},
		right = {
			10,
			5
		},
		center = {
			0,
			0
		}
	},
	bottom = {
		left = {
			-10,
			-5
		},
		right = {
			10,
			-5
		},
		center = {
			0,
			0
		}
	}
}
local image_padding = {
	top = {
		left = {
			5,
			5
		},
		right = {
			5,
			5
		},
		center = {
			0,
			0
		}
	},
	bottom = {
		left = {
			5,
			5
		},
		right = {
			5,
			5
		},
		center = {
			0,
			0
		}
	}
}

LorebookView.setup_page_image_and_exclusion_zone = function (self, scenegraph_id, image_name, vertical_alignment, horizontal_alignment, exclusion_zones)
	local image_settings = UIAtlasHelper.get_atlas_settings_by_texture_name(image_name)
	local size = image_settings.size
	local scenegraph = self.ui_scenegraph[scenegraph_id]
	local scenegraph_size = scenegraph.size
	local scenegraph_local_position = scenegraph.local_position
	scenegraph_size[1] = size[1]
	scenegraph_size[2] = size[2]
	local inv_scale = RESOLUTION_LOOKUP.inv_scale
	local offset = image_offsets[vertical_alignment][horizontal_alignment]
	local x_offset = offset[1]
	local y_offset = offset[2]
	scenegraph_local_position[1] = x_offset
	scenegraph_local_position[2] = y_offset
	scenegraph.vertical_alignment = vertical_alignment
	scenegraph.horizontal_alignment = horizontal_alignment
	local exclusion_zone = exclusion_zones[vertical_alignment]
	exclusion_zone.alignment = horizontal_alignment
	local padding = image_padding[vertical_alignment][horizontal_alignment]
	local x_padding = padding[1] * inv_scale
	local y_padding = padding[2] * inv_scale
	exclusion_zone.width = size[1] + x_padding
	exclusion_zone.height = size[2] + y_padding
	exclusion_zone.active = true
end

LorebookView.on_element_pressed = function (self, index, element_content, play_sound)
	local should_select = false
	local index_array = self.index_array
	local depth = #index_array
	local next_sub_categories, next_parent_category = self:get_next_sub_categories_by_index(index)

	if next_sub_categories then
		index_array[depth + 1] = index
		local contents_list = self.contents_list
		local list_content = contents_list.content.list_content
		local num_contents_list_items = #list_content
		local item_styles = contents_list.style.list_style.item_styles

		self:populate_list(list_content, item_styles, next_sub_categories)

		local index_list = self.index_list
		local index_list_content = index_list.content.list_content
		local num_index_list_items = #index_list_content
		local index_item_styles = index_list.style.list_style.item_styles

		self:populate_index_list(index_list_content, index_item_styles, next_sub_categories)

		local category_name = next_parent_category.category_name

		self:fill_page_content(next_parent_category.page_text, category_name, next_parent_category.images, next_parent_category.image)
		self:set_content_title(category_name)
		self:set_page_title()
	elseif next_parent_category then
		self:set_page_title(next_parent_category.page_title)

		local category_name = next_parent_category.category_name

		self:fill_page_content(next_parent_category.page_text, category_name, next_parent_category.images, next_parent_category.image)

		should_select = true

		self:play_element_select_animation(index)
	end

	local sound_event = "Play_hud_lorebook_topic"

	if should_select then
		if element_content.new then
			sound_event = "Play_hud_lorebook_page_reveal"
		else
			sound_event = "Play_hud_lorebook_hover"
		end
	end

	if play_sound then
		self:play_sound(sound_event)
	end

	return should_select
end

LorebookView.on_index_element_pressed = function (self, index, element_content, play_sound)
	print(index)

	local index_array = self.index_array
	local depth = #index_array
	local previous_category_index = nil

	for i = depth, index + 1, -1 do
		print(i, depth, index)

		previous_category_index = index_array[i]
		index_array[i] = nil
	end

	if play_sound then
		self:play_sound("Play_hud_lorebook_close_topic")
	end

	local current_categories = self:get_current_categories()

	if current_categories then
		local contents_list = self.contents_list
		local list_content = contents_list.content.list_content
		local num_contents_list_items = #list_content
		local item_styles = contents_list.style.list_style.item_styles

		self:populate_list(list_content, item_styles, current_categories.sub_categories or current_categories)

		local index_list = self.index_list
		local index_list_content = index_list.content.list_content
		local num_index_list_items = #index_list_content
		local index_item_styles = index_list.style.list_style.item_styles

		self:populate_index_list(index_list_content, index_item_styles, current_categories.sub_categories or current_categories)

		local category_name = current_categories.category_name

		self:fill_page_content(current_categories.page_text, category_name, current_categories.images, current_categories.image)
		self:set_content_title(category_name)
		self:set_page_title()
	end

	return previous_category_index
end

local hover_params = {}
local hover_widgets = {}

LorebookView.on_element_hover_enter = function (self, index, element_style, play_sound)
	if self.element_hover_anim_id then
		self.ui_animator:stop_animation(self.element_hover_anim_id)

		self.element_hover_anim_id = nil
	end

	local speed = 1

	if element_style then
		local current_hover_alpha = element_style.hover_texture_left.color[1]
		local progress = current_hover_alpha / 255
		speed = 1 + 1 - progress
	end

	hover_widgets[1] = self.contents_list
	hover_params.hover_index = index
	self.element_hover_anim_id = self.ui_animator:start_animation("on_element_hover", hover_widgets, definitions.scenegraph_definition, hover_params, speed)

	if play_sound then
		self:play_sound("Play_hud_hover")
	end
end

local index_hover_params = {}
local index_hover_widgets = {}

LorebookView.on_index_element_hover_enter = function (self, index, element_style, play_sound)
	if self.index_element_hover_anim_id then
		self.ui_animator:stop_animation(self.index_element_hover_anim_id)

		self.index_element_hover_anim_id = nil
	end

	local speed = 1

	if element_style then
		local current_hover_alpha = element_style.hover_texture.color[1]
		local progress = current_hover_alpha / 255
		speed = 1 + 1 - progress
	end

	index_hover_widgets[1] = self.index_list
	index_hover_params.hover_index = index
	self.index_element_hover_anim_id = self.ui_animator:start_animation("on_index_element_hover", index_hover_widgets, definitions.scenegraph_definition, index_hover_params, speed)

	if play_sound then
		self:play_sound("Play_hud_hover")
	end
end

local select_params = {}
local select_widgets = {}

LorebookView.play_element_select_animation = function (self, index)
	if self.element_select_anim_id then
		self.ui_animator:stop_animation(self.element_select_anim_id)

		self.element_select_anim_id = nil
	end

	select_widgets[1] = self.contents_list
	select_params.select_index = index
	self.element_select_anim_id = self.ui_animator:start_animation("on_element_select", select_widgets, definitions.scenegraph_definition, select_params)
end

LorebookView.on_back_pressed = function (self, play_sound)
	local index_array = self.index_array
	local depth = #index_array
	local previous_category_index = nil

	if self.element_select_anim_id then
		self.ui_animator:stop_animation(self.element_select_anim_id)

		self.element_select_anim_id = nil
	end

	if depth > 1 then
		previous_category_index = index_array[depth]
		index_array[depth] = nil
		depth = depth - 1
	elseif depth == 1 then
		return
	end

	if play_sound then
		self:play_sound("Play_hud_lorebook_close_topic")
	end

	local current_categories = self:get_current_categories()

	if current_categories then
		local contents_list = self.contents_list
		local list_content = contents_list.content.list_content
		local num_contents_list_items = #list_content
		local item_styles = contents_list.style.list_style.item_styles

		self:populate_list(list_content, item_styles, current_categories.sub_categories or current_categories)

		local index_list = self.index_list
		local index_list_content = index_list.content.list_content
		local num_index_list_items = #index_list_content
		local index_item_styles = index_list.style.list_style.item_styles

		self:populate_index_list(index_list_content, index_item_styles, current_categories.sub_categories or current_categories)

		local category_name = current_categories.category_name

		self:fill_page_content(current_categories.page_text, category_name, current_categories.images, current_categories.image)
		self:set_content_title(category_name)
		self:set_page_title()
	end

	return previous_category_index
end

LorebookView.mark_page_content_as_read = function (self, content)
	local new_paths = self.new_page_paths
	local page_id = content.name
	content.new = nil

	LoreBookHelper.unmark_page_id_as_new(content.category_name)

	self.new_page_paths = self:initialize_new_page_paths()
end

LorebookView.mark_categories_as_new = function (self, list_content)
	local new_paths = self.new_page_paths

	if new_paths then
		for i = 1, #list_content, 1 do
			local element_content = list_content[i]
			local name = element_content.category_name
			local path = LorebookPaths[name]

			for j = 1, #new_paths, 1 do
				local new_path = new_paths[j]
				local match = true

				for k = 1, #path, 1 do
					local index_1 = path[k]
					local index_2 = new_path[k]

					if index_1 ~= index_2 then
						match = false

						break
					end
				end

				if match then
					element_content.new = true

					break
				end
			end
		end
	end
end

LorebookView.is_category_unlocked = function (self, category)
	local sub_categories = category.sub_categories

	if sub_categories then
		for i = 1, #sub_categories, 1 do
			local unlocked = self:is_category_unlocked(sub_categories[i])

			if unlocked then
				return true
			end
		end
	else
		local category_name = category.category_name
		local unlocked = self:is_page_unlocked(category_name)

		if unlocked then
			return true
		end
	end
end

LorebookView.is_page_unlocked = function (self, category_name)
	local unlocked = nil

	if script_data.unlock_all_lorebook or LorebookDefaultUnlocks[category_name] then
		unlocked = true
	else
		local id = LorebookCategoryLookup[category_name]
		local local_player = Managers.player:local_player()
		local stats_id = local_player:stats_id()
		unlocked = self.statistics_db:get_persistent_lorebook_stat(stats_id, "lorebook_unlocks", id)
	end

	return unlocked
end

LorebookView.populate_list = function (self, list_content, item_styles, categories)
	local num_categories = #categories
	local list_elements = self.list_elements

	table.clear(list_content)
	table.clear(item_styles)

	for i = 1, num_categories, 1 do
		local category = categories[i]
		local use_existing_element = i <= #list_elements

		if not use_existing_element then
			self:create_list_element(category)
		end

		local list_element = (use_existing_element and self:set_element_data(list_elements[i], category)) or list_elements[i]
		list_content[i] = list_element.content
		item_styles[i] = list_element.style
	end

	self:mark_categories_as_new(list_content)

	local contents_list = self.contents_list
	local contents_list_style = contents_list.style.list_style
	contents_list_style.start_index = 1
	contents_list_style.num_draws = num_categories
	self.contents_list.element.pass_data[1].num_list_elements = nil

	for _, element in ipairs(list_content) do
		if not element.has_sub_pages and element.new then
			self:play_sound("Play_hud_lorebook_new_page")

			break
		end
	end
end

LorebookView.populate_index_list = function (self, list_content, item_styles, categories)
	local index_array = self.index_array
	local max_depth = #index_array - 1
	local index_list_elements = self.index_list_elements

	table.clear(list_content)
	table.clear(item_styles)

	local categories_real = self.page_layout
	local total_width = 0

	for i = 1, max_depth, 1 do
		local index = index_array[i]
		local in_sub_category = index_array[i + 1] ~= nil
		local category = categories_real[index]
		local use_existing_element = i <= #index_list_elements

		if not use_existing_element then
			self:create_index_list_element(category)
		end

		local list_element = (use_existing_element and self:set_index_list_element_data(index_list_elements[i], category)) or index_list_elements[i]
		list_content[i] = list_element.content
		item_styles[i] = list_element.style
		categories_real = (in_sub_category and categories_real[index].sub_categories) or categories_real[index]
		total_width = list_content[i].total_width
	end

	local index_list = self.index_list
	local index_list_style = index_list.style.list_style
	index_list_style.start_index = 1
	index_list_style.num_draws = max_depth
	self.index_list.element.pass_data[1].num_list_elements = nil
	index_list_style.total_width = math.max(0, total_width - 20)

	if max_depth > 0 then
		index_list_elements[max_depth].content.last_element = true
	end
end

LorebookView.create_list_element = function (self, category)
	local index = #self.list_elements
	local index_name = category.index_name
	local category_name = category.category_name
	local font_size = 28
	local default_height_offest = 50
	local offset = (index - 1) * default_height_offest
	local list_member_height_offset = -offset
	local page_text = category.page_text
	local is_category_unlocked = self:is_category_unlocked(category)
	local content = {
		selected_texture_left = "journal_marker_left_glow",
		hover_texture_left = "journal_marker_left",
		selected = false,
		hover_texture_right = "journal_marker_right",
		available = true,
		visible = true,
		new_texture = "journal_icon_02",
		locked_texture = "journal_icon_01",
		selected_texture = "journal_entry_select",
		selected_texture_right = "journal_marker_right_glow",
		new = false,
		button_hotspot = {},
		controller_button_hotspot = {},
		category_name = category_name,
		name = Localize(index_name or category_name),
		index = index,
		unlocked = is_category_unlocked,
		has_sub_pages = category.sub_categories ~= nil,
		page_text = page_text
	}
	local style = {
		offset = {
			0,
			0,
			0
		},
		hotspot = {
			offset = {
				0,
				0,
				0
			},
			size = {
				680,
				default_height_offest,
				0
			}
		},
		name = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			localize = false,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("black", ELEMENT_SELECTED_ALPHA),
			font_size = font_size,
			size = {
				680,
				default_height_offest,
				0
			},
			offset = {
				0,
				0,
				1
			}
		},
		hover_texture_left = {
			offset = {
				0,
				20,
				2
			},
			color = {
				0,
				255,
				255,
				255
			},
			size = {
				124,
				13
			}
		},
		hover_texture_right = {
			offset = {
				0,
				20,
				2
			},
			color = {
				0,
				255,
				255,
				255
			},
			size = {
				124,
				13
			}
		},
		selected_texture_left = {
			offset = {
				0,
				6,
				2
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				153,
				40
			}
		},
		selected_texture_right = {
			offset = {
				0,
				6,
				2
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				153,
				40
			}
		},
		new_texture_left = {
			offset = {
				0,
				11,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				30,
				30
			}
		},
		new_texture_right = {
			offset = {
				0,
				11,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				30,
				30
			}
		},
		locked_texture_left = {
			offset = {
				0,
				12,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				30,
				30
			}
		},
		locked_texture_right = {
			offset = {
				0,
				12,
				1
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				30,
				30
			}
		},
		selected_texture = {
			offset = {
				0,
				15,
				0
			},
			size = {
				245,
				23
			},
			color = {
				255,
				255,
				255,
				255
			}
		}
	}
	local name_style = style.name
	local text_width, text_height = self:get_text_size(Localize(content.name), name_style)

	self:align_element_icons_by_text_length(text_width, style)

	self.list_elements[index + 1] = {
		content = content,
		style = style
	}
end

LorebookView.create_index_list_element = function (self, category)
	local index = #self.index_list_elements
	local index_name = category.index_name
	local category_name = category.category_name
	local default_height_offest = 18
	local offset = (index - 1) * default_height_offest
	local list_member_height_offset = -offset
	local content = {
		selected_texture = "index_selection_marker_selected",
		selected = false,
		last_element = false,
		hover_texture = "index_selection_marker",
		visible = true,
		divider = ">",
		button_hotspot = {},
		controller_button_hotspot = {},
		category_name = category_name,
		name = Localize(index_name or category_name),
		index = index
	}
	local style = {
		offset = {
			0,
			0,
			0
		},
		hotspot = {
			offset = {
				0,
				0,
				0
			},
			size = {
				0,
				default_height_offest * 1.35,
				0
			}
		},
		name = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			localize = false,
			font_size = 18,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("black", ELEMENT_SELECTED_ALPHA),
			size = {
				0,
				default_height_offest,
				0
			},
			offset = {
				0,
				0,
				1
			}
		},
		divider = {
			vertical_alignment = "center",
			horizontal_alignment = "center",
			localize = false,
			font_size = 18,
			font_type = "hell_shark",
			text_color = Colors.get_color_table_with_alpha("black", ELEMENT_SELECTED_ALPHA),
			size = {
				18,
				default_height_offest,
				0
			},
			offset = {
				0,
				0,
				1
			}
		},
		hover_texture = {
			offset = {
				0,
				0,
				2
			},
			color = {
				0,
				255,
				255,
				255
			},
			size = {
				32,
				50
			}
		},
		selected_texture = {
			offset = {
				0,
				0,
				2
			},
			color = {
				255,
				255,
				255,
				255
			},
			size = {
				32,
				50
			}
		}
	}
	local text_width, text_height = self:get_text_size(Localize(content.name), style.name)
	style.hotspot.size[1] = text_width
	style.name.size[1] = text_width
	local previous_element_offset = 0
	local divider_offset = 20

	if index > 0 then
		local previous_element = self.index_list_elements[index]
		local previous_element_content = previous_element.content
		previous_element_offset = previous_element_content.total_width
	end

	style.name.offset[1] = previous_element_offset
	style.hotspot.offset[1] = previous_element_offset
	style.divider.offset[1] = text_width + previous_element_offset
	style.hover_texture.offset[1] = (text_width * 0.5 + previous_element_offset) - 16
	style.selected_texture.offset[1] = (text_width * 0.5 + previous_element_offset) - 16
	content.total_width = text_width + divider_offset + previous_element_offset
	self.index_list_elements[index + 1] = {
		content = content,
		style = style
	}
end

LorebookView.set_element_data = function (self, list_element, category)
	local element_content = list_element.content
	local element_style = list_element.style
	local index_name = category.index_name
	local category_name = category.category_name
	local page_text = category.page_text
	local is_category_unlocked = self:is_category_unlocked(category)
	element_content.unlocked = is_category_unlocked
	element_content.category_name = category_name
	element_content.name = Localize(index_name or category_name)
	element_content.page_text = page_text
	element_content.has_sub_pages = category.sub_categories ~= nil
	local name_style = element_style.name
	local text_width, text_height = self:get_text_size(element_content.name, name_style)

	self:align_element_icons_by_text_length(text_width, element_style)

	element_content.new = false
	element_content.selected = false
	element_content.gamepad_hover = false
	element_style.name.text_color[1] = ELEMENT_SELECTED_ALPHA

	table.clear(element_content.button_hotspot)
end

LorebookView.set_index_list_element_data = function (self, list_element, category)
	local content = list_element.content
	local style = list_element.style
	local index_name = category.index_name
	local category_name = category.category_name
	content.category_name = category_name
	content.name = Localize(index_name or category_name)
	local text_width, text_height = self:get_text_size(content.name, style.name)
	style.hotspot.size[1] = text_width
	style.name.size[1] = text_width
	local index = content.index
	local previous_element_offset = 0
	local divider_offset = 20

	if index > 0 then
		local previous_element = self.index_list_elements[index]
		local previous_element_content = previous_element.content
		previous_element_offset = previous_element_content.total_width
	end

	style.name.offset[1] = previous_element_offset
	style.hotspot.offset[1] = previous_element_offset
	style.divider.offset[1] = text_width + previous_element_offset
	style.hover_texture.offset[1] = (text_width * 0.5 + previous_element_offset) - 16
	style.selected_texture.offset[1] = (text_width * 0.5 + previous_element_offset) - 16
	content.total_width = text_width + divider_offset + previous_element_offset
	content.selected = false
	content.gamepad_hover = false
	content.last_element = false

	table.clear(content.button_hotspot)
end

LorebookView.align_element_icons_by_text_length = function (self, text_length, element_style)
	local name_style = element_style.name
	local hotspot_x_offset = name_style.size[1] * 0.5 - text_length * 0.5
	element_style.hotspot.size[1] = text_length
	element_style.hotspot.offset[1] = hotspot_x_offset
	local hover_texture_left_style = element_style.hover_texture_left
	local hover_texture_right_style = element_style.hover_texture_right
	hover_texture_right_style.offset[1] = hotspot_x_offset + text_length + HOVER_TEXTURE_SPACING
	hover_texture_left_style.offset[1] = hotspot_x_offset - (hover_texture_left_style.size[1] + HOVER_TEXTURE_SPACING)
	local new_texture_left_style = element_style.new_texture_left
	local new_texture_right_style = element_style.new_texture_right
	new_texture_right_style.offset[1] = hotspot_x_offset + text_length + STATUS_TEXTURE_SPACING
	new_texture_left_style.offset[1] = hotspot_x_offset - new_texture_left_style.size[1] - STATUS_TEXTURE_SPACING
	local locked_texture_left_style = element_style.locked_texture_left
	local locked_texture_right_style = element_style.locked_texture_right
	locked_texture_right_style.offset[1] = hotspot_x_offset + text_length + STATUS_TEXTURE_SPACING
	locked_texture_left_style.offset[1] = hotspot_x_offset - locked_texture_left_style.size[1] - STATUS_TEXTURE_SPACING
	local selected_texture_left_style = element_style.selected_texture_left
	local selected_texture_right_style = element_style.selected_texture_right
	local selected_texture_size = selected_texture_left_style.size
	selected_texture_right_style.offset[1] = (hotspot_x_offset + text_length + HOVER_TEXTURE_SPACING) - 13
	selected_texture_left_style.offset[1] = hotspot_x_offset - (hover_texture_left_style.size[1] + HOVER_TEXTURE_SPACING) - 13
end

LorebookView.get_text_size = function (self, localized_text, text_style)
	local font, scaled_font_size = UIFontByResolution(text_style)
	local text_width, text_height, min = UIRenderer.text_size(self.ui_renderer, localized_text, font[1], scaled_font_size)

	return text_width, text_height
end

LorebookView._collected_lorebook_page_amount = function (self)
	local player_manager = Managers.player
	local local_player = player_manager:local_player()
	local statistics_db = player_manager:statistics_db()
	local stats_id = local_player:stats_id()
	local collectable_pages = LorebookCollectablePages
	local total_collected = 0

	for _, pages in pairs(collectable_pages) do
		local num_pages = #pages

		for i = 1, num_pages, 1 do
			local category_name = pages[i]
			local id = LorebookCategoryLookup[category_name]
			local unlocked = statistics_db:get_persistent_lorebook_stat(stats_id, "lorebook_unlocks", id)

			if unlocked then
				total_collected = total_collected + 1
			end
		end
	end

	return total_collected
end

LorebookView.on_enter = function (self)
	self.input_manager:block_device_except_service("lorebook_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("lorebook_menu", "mouse", 1)
	self.input_manager:block_device_except_service("lorebook_menu", "gamepad", 1)

	local lorebook_front_page_collectible_counter = self.lorebook_front_page_collectible_counter
	local total_amount_of_collectible_lorebook_pages = LorebookCollectablePagesAmount
	local num_collected_pages = self:_collected_lorebook_page_amount()
	lorebook_front_page_collectible_counter.content.text = tostring(num_collected_pages) .. "/" .. tostring(total_amount_of_collectible_lorebook_pages)

	self:play_sound("Play_hud_lorebook_open")

	self.active = true

	self:change_tab_index(1, false)
	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_on")

	if PLATFORM ~= "win32" and not SaveData.has_shown_lorebook_popup then
		self._popup_id = Managers.popup:queue_popup(BaseLocalize("popup_lorebook_not_localized"), BaseLocalize("popup_info_topic"), "ok", BaseLocalize("menu_ok"))
	end
end

LorebookView.on_exit = function (self)
	self:play_sound("Play_hud_lorebook_close")

	self.exiting = nil
	self.active = nil

	if self._popup_id then
		Managers.popup:cancel_popup(self._popup_id)
	end

	WwiseWorld.trigger_event(self.wwise_world, "hud_in_inventory_state_off")
end

LorebookView.exit = function (self, return_to_game)
	self:on_menu_close()

	self.exiting = true
	local exit_transition = (return_to_game and "exit_menu") or "ingame_menu"

	self.ingame_ui:transition_with_fade(exit_transition)
end

LorebookView.transitioning = function (self)
	if self.exiting then
		return true
	else
		return not self.active
	end
end

LorebookView.suspend = function (self)
	self.suspended = true

	self.input_manager:device_unblock_all_services("keyboard", 1)
	self.input_manager:device_unblock_all_services("mouse", 1)
	self.input_manager:device_unblock_all_services("gamepad", 1)
end

LorebookView.unsuspend = function (self)
	self.input_manager:block_device_except_service("lorebook_menu", "keyboard", 1)
	self.input_manager:block_device_except_service("lorebook_menu", "mouse", 1)
	self.input_manager:block_device_except_service("lorebook_menu", "gamepad", 1)

	self.suspended = nil
end

LorebookView.update_animations = function (self, dt)
	local ui_animator = self.ui_animator

	ui_animator:update(dt)
	self:_handle_popup()

	if self.page_reveal_anim_id and ui_animator:is_animation_completed(self.page_reveal_anim_id) then
		self.page_reveal_anim_id = nil
	end
end

LorebookView._handle_popup = function (self)
	if self._popup_id then
		local result = Managers.popup:query_result(self._popup_id)

		if result then
			if result == "ok" then
				SaveData.has_shown_lorebook_popup = true

				Managers.save:auto_save(SaveFileName, SaveData)
			end

			self._popup_id = nil
		end
	end
end

LorebookView.reveal_page = function (self, instant)
	if self.page_reveal_anim_id then
		self.ui_animator:stop_animation(self.page_reveal_anim_id)

		self.page_reveal_anim_id = nil
	end

	if instant then
		local widget = self.page_reveal_mask
		local widget_style = widget.style
		local num_textures = widget.content.num_textures

		for i = 1, num_textures, 1 do
			local style_id = "texture_" .. i
			local texture_style = widget_style[style_id]
			texture_style.color[1] = 0
		end

		self.page_reveal_mask.style.cover_rect.color[1] = 255
	else
		local widgets = {
			self.page_reveal_mask
		}
		self.page_reveal_anim_id = self.ui_animator:start_animation("page_reveal", widgets, definitions.scenegraph_definition, nil)
	end
end

LorebookView.update = function (self, dt)
	if self.suspended then
		return
	end

	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_manager = self.input_manager
	local input_service = input_manager:get_service("lorebook_menu")
	local gamepad_active = input_manager:is_device_active("gamepad")
	local transitioning = self:transitioning()

	self:update_animations(dt)

	for name, ui_animation in pairs(self.ui_animations) do
		UIAnimation.update(ui_animation, dt)

		if UIAnimation.completed(ui_animation) then
			self.ui_animations[name] = nil
		end
	end

	if self.active then
		self:draw_widgets(dt, gamepad_active)
	end

	if not transitioning then
		if gamepad_active then
			if not self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = true

				self:on_gamepad_activated()
			end

			self:handle_gamepad_input(input_service, dt)
		else
			if self.gamepad_active_last_frame then
				self.gamepad_active_last_frame = false

				self:on_gamepad_deactivated()
			end

			self:handle_input(input_service)
		end
	end

	if gamepad_active then
		self.menu_input_description:draw(ui_renderer, dt)
	end

	local exit_button_hotspot = self.exit_button.content.button_hotspot

	if exit_button_hotspot.on_hover_enter then
		self:play_sound("Play_hud_hover")
	end

	if not transitioning and (input_service:get("toggle_menu") or exit_button_hotspot.on_release) then
		exit_button_hotspot.on_release = nil
		local return_to_game = not self.ingame_ui.menu_active

		self:play_sound("Play_hud_select")
		self:exit(return_to_game)
	end
end

local input_actions = definitions.input_actions

LorebookView.update_input_description = function (self)
	local actions_name_to_use = nil

	if not actions_name_to_use then
		actions_name_to_use = "default"
		local index_array = self.index_array

		if index_array[1] then
			local gamepad_hover_index, hover_content, num_draws = self:get_gamepad_hover_index()

			if hover_content then
				local num_content_pages = self.num_content_pages

				if not hover_content.unlocked then
					if num_content_pages and num_content_pages > 1 then
						actions_name_to_use = "selection_locked_includes_pages"
					else
						actions_name_to_use = "selection_locked"
					end
				elseif num_content_pages and num_content_pages > 1 then
					actions_name_to_use = "selection_includes_pages"
				else
					actions_name_to_use = "selection"
				end
			end
		end
	end

	if not self.gamepad_active_actions_name or self.gamepad_active_actions_name ~= actions_name_to_use then
		self.gamepad_active_actions_name = actions_name_to_use
		input_description_data.actions = input_actions[actions_name_to_use]

		self.menu_input_description:set_input_description(input_description_data)
	end
end

LorebookView.draw_widgets = function (self, dt, gamepad_active)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("lorebook_menu")

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)

	for _, widget in ipairs(self.background_widgets) do
		UIRenderer.draw_widget(ui_renderer, widget)
	end

	UIRenderer.draw_widget(ui_renderer, self.title_text)

	if not gamepad_active then
		UIRenderer.draw_widget(ui_renderer, self.exit_button)
	end

	local index_array = self.index_array
	local tab_index = index_array[2]

	if tab_index then
		if not gamepad_active then
			UIRenderer.draw_widget(ui_renderer, self.page_back_button)
		end

		UIRenderer.draw_widget(ui_renderer, self.contents_list)
		UIRenderer.draw_widget(ui_renderer, self.index_list)
		UIRenderer.draw_widget(ui_renderer, self.contents_title)
		UIRenderer.draw_widget(ui_renderer, self.contents_title_divider)
		UIRenderer.draw_widget(ui_renderer, self.contents_title_divider_top)
		UIRenderer.draw_widget(ui_renderer, self.page_title)
		UIRenderer.draw_widget(ui_renderer, self.page_content)
		UIRenderer.draw_widget(ui_renderer, self.page_reveal_mask)
	else
		UIRenderer.draw_widget(ui_renderer, self.contents_title)
		UIRenderer.draw_widget(ui_renderer, self.contents_title_divider)
		UIRenderer.draw_widget(ui_renderer, self.contents_list)
		UIRenderer.draw_widget(ui_renderer, self.front_page_new_icon)
		UIRenderer.draw_widget(ui_renderer, self.front_page_lock_icon)
		UIRenderer.draw_widget(ui_renderer, self.front_page_new_icon_text)
		UIRenderer.draw_widget(ui_renderer, self.front_page_lock_icon_text)
		UIRenderer.draw_widget(ui_renderer, self.front_page_title_image)
		UIRenderer.draw_widget(ui_renderer, self.front_page_description_text)
		UIRenderer.draw_widget(ui_renderer, self.lorebook_front_page_collectible_title)
		UIRenderer.draw_widget(ui_renderer, self.lorebook_front_page_collectible_counter)
		UIRenderer.draw_widget(ui_renderer, self.lorebook_front_page_collectible_divider)
	end

	UIRenderer.draw_widget(ui_renderer, self.paragraph_divider_large)
	UIRenderer.draw_widget(ui_renderer, self.paragraph_divider_medium)
	UIRenderer.draw_widget(ui_renderer, self.paragraph_divider_small)
	UIRenderer.draw_widget(ui_renderer, self.dead_space_4k_filler)

	if self.current_page == 1 then
		UIRenderer.draw_widget(ui_renderer, self.page_image_1)
		UIRenderer.draw_widget(ui_renderer, self.page_image_2)
	end

	if self.num_content_pages and self.num_content_pages > 1 then
		if self.current_page > 1 then
			UIRenderer.draw_widget(ui_renderer, self.previous_page)
		end

		if self.current_page < self.num_content_pages then
			UIRenderer.draw_widget(ui_renderer, self.next_page)
		end

		UIRenderer.draw_widget(ui_renderer, self.page_count)
	end

	UIRenderer.draw_widget(ui_renderer, self.dead_space_filler)
	UIRenderer.end_pass(ui_renderer)
end

LorebookView.handle_gamepad_input = function (self, input_service, dt)
	self:update_input_description()

	local controller_cooldown = self.controller_cooldown

	if controller_cooldown and controller_cooldown > 0 then
		self.controller_cooldown = controller_cooldown - dt
	else
		local index_array = self.index_array

		if input_service:get("back") then
			if #index_array > 1 then
				local previous_category_index = self:on_back_pressed(true)

				if previous_category_index then
					self:set_gamepad_hover_index(previous_category_index)
				end

				self.controller_cooldown = GamepadSettings.menu_cooldown
			else
				local return_to_game = not self.ingame_ui.menu_active

				self:exit(return_to_game)
			end

			return
		end

		local gamepad_hover_index, hover_content, num_draws = self:get_gamepad_hover_index()

		if num_draws > 0 then
			local new_gamepad_hover_index = nil

			if not gamepad_hover_index then
				new_gamepad_hover_index = 1
			elseif input_service:get("move_up_hold") then
				new_gamepad_hover_index = math.max(gamepad_hover_index - 1, 1)
			elseif input_service:get("move_down_hold") then
				new_gamepad_hover_index = math.min(gamepad_hover_index + 1, num_draws)
			elseif input_service:get("confirm") then
				local selecting_element, element_locked = self:set_gamepad_selection_index(gamepad_hover_index, true)

				if not element_locked then
					if not selecting_element then
						self:set_gamepad_hover_index(1)
					end

					self.controller_cooldown = GamepadSettings.menu_cooldown
				end
			end

			if new_gamepad_hover_index and new_gamepad_hover_index ~= gamepad_hover_index then
				self:set_gamepad_hover_index(new_gamepad_hover_index, true)

				self.controller_cooldown = GamepadSettings.menu_cooldown

				return
			end
		end

		self:handle_page_change_input(input_service)
	end
end

LorebookView.on_gamepad_activated = function (self)
	return
end

LorebookView.on_gamepad_deactivated = function (self)
	self:set_gamepad_hover_index(nil)
end

LorebookView.get_gamepad_hover_index = function (self)
	local contents_list = self.contents_list
	local contents_list_content = contents_list.content.list_content
	local contents_list_style = contents_list.style.list_style
	local item_styles = contents_list_style.item_styles
	local start_index = contents_list_style.start_index
	local num_draws = contents_list_style.num_draws - 1
	local stop_index = math.min(start_index + num_draws, #contents_list_content)

	for i = start_index, stop_index, 1 do
		local content = contents_list_content[i]

		if content.gamepad_hover then
			return i, content, num_draws + 1
		end
	end

	return nil, nil, num_draws + 1
end

LorebookView.set_gamepad_hover_index = function (self, index, play_sound)
	local contents_list = self.contents_list
	local contents_list_content = contents_list.content.list_content
	local contents_list_style = contents_list.style.list_style
	local item_styles = contents_list_style.item_styles
	local start_index = contents_list_style.start_index
	local num_draws = contents_list_style.num_draws - 1
	local stop_index = math.min(start_index + num_draws, #contents_list_content)

	for i = start_index, stop_index, 1 do
		local content = contents_list_content[i]
		content.gamepad_hover = i == index
	end

	local selected_index_style = index and item_styles[index]

	self:on_element_hover_enter(index, selected_index_style, play_sound)
end

LorebookView.set_gamepad_selection_index = function (self, index, play_sound)
	local contents_list = self.contents_list
	local contents_list_content = contents_list.content.list_content
	local content = contents_list_content[index]

	if not content.unlocked then
		return nil, true
	end

	local contents_list_style = contents_list.style.list_style
	local item_styles = contents_list_style.item_styles
	local start_index = contents_list_style.start_index
	local num_draws = contents_list_style.num_draws - 1
	local stop_index = math.min(start_index + num_draws, #contents_list_content)
	local should_select = self:on_element_pressed(index, content, play_sound)
	local instant_page_fade = true

	if should_select then
		if content.new then
			self:mark_page_content_as_read(content)

			instant_page_fade = false
		end

		for k = start_index, stop_index, 1 do
			local is_selected = k == index
			contents_list_content[k].selected = is_selected
		end
	end

	self:reveal_page(instant_page_fade)

	return should_select, true
end

LorebookView.handle_input = function (self, input_service)
	local next_page_hotspot = self.next_page.content.button_hotspot
	local previous_page_hotspot = self.previous_page.content.button_hotspot
	local back_button_button_hotspot = self.page_back_button.content.button_hotspot

	if next_page_hotspot.on_hover_enter or previous_page_hotspot.on_hover_enter or back_button_button_hotspot.on_hover_enter then
		self:play_sound("Play_hud_hover")
	end

	if back_button_button_hotspot.on_release or input_service:get("right_press") then
		if back_button_button_hotspot.on_release then
			back_button_button_hotspot.on_release = nil
		end

		self:on_back_pressed(true)
	end

	local contents_list = self.contents_list
	local contents_list_content = contents_list.content.list_content
	local contents_list_style = contents_list.style.list_style
	local item_styles = contents_list_style.item_styles
	local start_index = contents_list_style.start_index
	local num_draws = contents_list_style.num_draws - 1
	local stop_index = math.min(start_index + num_draws, #contents_list_content)
	start_index = math.max(1, stop_index - num_draws)

	for i = start_index, stop_index, 1 do
		local content = contents_list_content[i]

		if content then
			local button_hotspot = content.button_hotspot

			if button_hotspot.on_hover_enter then
				self:on_element_hover_enter(i, item_styles[i], true)
			end

			if content.unlocked and not content.selected and button_hotspot.on_release then
				button_hotspot.on_release = nil
				local should_select = self:on_element_pressed(i, content, true)
				local instant_page_fade = true

				if should_select then
					if content.new then
						self:mark_page_content_as_read(content)

						instant_page_fade = false
					end

					for k = start_index, stop_index, 1 do
						local is_selected = k == i
						contents_list_content[k].selected = is_selected
					end
				end

				self:reveal_page(instant_page_fade)
			end
		end
	end

	local index_list = self.index_list
	local index_list_content = index_list.content.list_content
	local index_list_style = index_list.style.list_style
	local item_styles = index_list_style.item_styles
	local start_index = index_list_style.start_index
	local num_draws = index_list_style.num_draws - 1
	local stop_index = math.min(start_index + num_draws, #index_list_content)
	start_index = math.max(1, stop_index - num_draws)

	for i = start_index, stop_index, 1 do
		local content = index_list_content[i]

		if content then
			local button_hotspot = content.button_hotspot

			if button_hotspot.on_hover_enter then
				self:on_index_element_hover_enter(i, item_styles[i], true)
			end

			if button_hotspot.on_release then
				self:on_index_element_pressed(i, content, true)
			end
		end
	end

	self:handle_page_change_input(input_service)
end

LorebookView.handle_page_change_input = function (self, input_service)
	local next_page_hotspot = self.next_page.content.button_hotspot
	local previous_page_hotspot = self.previous_page.content.button_hotspot
	local num_content_pages = self.num_content_pages
	local current_page = self.current_page

	if (input_service:get("cycle_next") or next_page_hotspot.on_release) and num_content_pages and current_page < num_content_pages then
		next_page_hotspot.on_release = nil
		self.current_page = self.current_page + 1

		self:_set_content_to_current_page()
		self:play_sound("Play_hud_lorebook_next_page")
	end

	if (input_service:get("cycle_previous") or previous_page_hotspot.on_release) and num_content_pages and current_page > 1 then
		previous_page_hotspot.on_release = nil
		self.current_page = self.current_page - 1

		self:_set_content_to_current_page()
		self:play_sound("Play_hud_lorebook_next_page")
	end
end

LorebookView._set_content_to_current_page = function (self)
	local index = self.current_page
	self.page_content.content.page = self.page_texts[index]
	self.paragraph_divider_large.content.positions = self.paragraph_divider_offsets[index].large
	self.paragraph_divider_medium.content.positions = self.paragraph_divider_offsets[index].medium
	self.paragraph_divider_small.content.positions = self.paragraph_divider_offsets[index].small
	local page_count = self.page_count
	local page_count_content = self.page_count.content
	page_count_content.text_field = index .. " / " .. self.num_content_pages
end

local divider_position_offset = 10
local divider_size_offset = -20

LorebookView._add_eventual_paragraph_divider = function (self, texts, return_indices, line_index, total_potential_lines, text_pos, full_font_height, page_index, top_exclusion_zone, bottom_exclusion_zone, top_height, center_height, bottom_height, top_width, bottom_width, top_offset, bottom_offset)
	local seed = line_index * 40147
	local paragraph_divider_offsets = self.paragraph_divider_offsets[page_index]
	local scenegraph_large = self.ui_scenegraph.paragraph_divider_large
	local scenegraph_large_size = scenegraph_large.size
	local scenegraph_large_position = scenegraph_large.position
	local scenegraph_medium = self.ui_scenegraph.paragraph_divider_medium
	local scenegraph_medium_size = scenegraph_medium.size
	local scenegraph_medium_position = scenegraph_medium.position
	local scenegraph_small = self.ui_scenegraph.paragraph_divider_small
	local scenegraph_small_size = scenegraph_small.size
	local scenegraph_small_position = scenegraph_small.position
	local large_width = scenegraph_large_size[1] + divider_size_offset
	local medium_width = scenegraph_medium_size[1] + divider_size_offset
	local small_width = scenegraph_small_size[1] + divider_size_offset
	local large_divider_position = scenegraph_large_position[1] + divider_position_offset
	local medium_divider_position = scenegraph_medium_position[1] + divider_position_offset
	local small_divider_position = scenegraph_small_position[1] + divider_position_offset

	if table.contains(return_indices, line_index) and table.contains(return_indices, line_index + 1) and table.contains(return_indices, line_index + 2) then
		local has_text_2 = texts[line_index + 1] ~= "\n" and texts[line_index + 1] ~= ""
		local has_text_3 = texts[line_index + 2] ~= "\n" and texts[line_index + 2] ~= ""

		if has_text_2 or has_text_3 then
			return

			local empty_end_of_page = line_index + 2 == total_potential_lines and not has_text_2 and not has_text_3

			if empty_end_of_page then
			end

			local divider_size = "large"
			local y_pos = text_pos[2] - full_font_height * 0.8333333333333334
			local top_zone_active = top_exclusion_zone and top_exclusion_zone.active
			local bottom_zone_active = bottom_exclusion_zone and bottom_exclusion_zone.active

			if top_zone_active and math.abs(y_pos) < top_height and (large_divider_position < top_offset or top_offset + top_width < large_divider_position + large_width) then
				if medium_divider_position < top_offset or top_offset + top_width < medium_divider_position + medium_width then
					if small_divider_position < top_offset or top_offset + top_width < small_divider_position + small_width then
						return
					else
						divider_size = "small"
					end
				else
					divider_size = "medium"
				end
			end
		end

		if bottom_zone_active and math.abs(y_pos) > top_height + center_height and math.abs(y_pos) < top_height + center_height + bottom_height and (large_divider_position < bottom_offset or bottom_offset + bottom_width < large_divider_position + large_width) then
			if medium_divider_position < bottom_offset or bottom_offset + bottom_width < medium_divider_position + medium_width then
				if small_divider_position < bottom_offset or bottom_offset + bottom_width < small_divider_position + small_width then
					return
				else
					divider_size = "small"
				end
			else
				divider_size = "medium"
			end
		end

		if top_zone_active and bottom_zone_active and divider_size == "large" then
			local overlap_y = math.abs(y_pos) < top_exclusion_zone.height and math.abs(y_pos) < top_height + bottom_exclusion_zone.height

			if overlap_y then
				local large_top_x_overlap = large_divider_position < top_offset or top_offset + top_width < large_divider_position + large_width
				local large_bottom_x_overlap = large_divider_position < bottom_offset or bottom_offset + bottom_width < large_divider_position + large_width

				if large_top_x_overlap and large_bottom_x_overlap then
					local medium_top_x_overlap = medium_divider_position < top_offset or top_offset + top_width < medium_divider_position + medium_width
					local medium_bottom_x_overlap = medium_divider_position < bottom_offset or bottom_offset + bottom_width < medium_divider_position + medium_width

					if medium_top_x_overlap and medium_bottom_x_overlap then
						local small_top_x_overlap = small_divider_position < top_offset or top_offset + top_width < small_divider_position + small_width
						local small_bottom_x_overlap = small_divider_position < bottom_offset or bottom_offset + bottom_width < small_divider_position + small_width

						if small_top_x_overlap and small_bottom_x_overlap then
							return
						else
							divider_size = "small"
						end
					else
						divider_size = "medium"
					end
				end
			end
		end

		local index = #paragraph_divider_offsets[divider_size] + 1
		paragraph_divider_offsets[divider_size][index] = y_pos
		local value = nil
		seed, value = Math.next_random(seed, 2, 4)
		self["paragraph_divider_" .. divider_size].content.texture_ids[index] = "journal_page_divider_0" .. tostring(value) .. "_" .. divider_size
	end
end

LorebookView.setup_page_texts = function (self, style, content, text)
	local text_style = style.text
	local ui_renderer = self.ui_renderer
	local font_material, font_size, font_name = nil

	if text_style.font_type then
		local font, size_of_font = UIFontByResolution(text_style)
		font_name = font[3]
		font_size = font[2]
		font_material = font[1]
		font_size = size_of_font
	else
		local font = text_style.font
		font_name = font[3]
		font_size = font[2]
		font_material = font[1]

		if not text_style.font_size then
		end
	end

	if text_style.localize then
		text = Localize(text)
	end

	local font_height, font_min, font_max = UIGetFontHeight(ui_renderer.gui, font_name, font_size)
	local inv_scale = RESOLUTION_LOOKUP.inv_scale
	local full_font_height = (font_max + math.abs(font_min)) * inv_scale
	local text_offset = Vector3(0, -full_font_height, 0)
	local text_exclusion_zones = content.text_exclusion_zones
	local top_exclusion_zone = text_exclusion_zones and text_exclusion_zones.top.active and text_exclusion_zones.top
	local bottom_exclusion_zone = text_exclusion_zones and text_exclusion_zones.bottom.active and text_exclusion_zones.bottom
	local area_size = self.ui_scenegraph.page_content.size
	local area_width = area_size[1]
	local area_height = area_size[2]
	local top_width = (top_exclusion_zone and area_width - top_exclusion_zone.width) or area_width
	local center_width = area_width
	local bottom_width = (bottom_exclusion_zone and area_width - bottom_exclusion_zone.width) or area_width
	local top_height = area_height
	local center_height = 0
	local bottom_height = 0
	local top_offset = 0
	local center_offset = 0
	local bottom_offset = 0
	local string_length = string.len(text)
	local string_offset = 0
	local page_index = 1
	local page_texts = self.page_texts

	for i = 1, NUM_PAGES, 1 do
		self.page_texts[i].top.width = 0
		self.page_texts[i].center.width = 0
		self.page_texts[i].bottom.width = 0

		table.clear(self.page_texts[i].top.texts)
		table.clear(self.page_texts[i].center.texts)
		table.clear(self.page_texts[i].bottom.texts)
		table.clear(self.paragraph_divider_offsets[i].large)
		table.clear(self.paragraph_divider_offsets[i].medium)
		table.clear(self.paragraph_divider_offsets[i].small)
	end

	while string_offset < string_length do
		if page_index > 1 then
			top_exclusion_zone, bottom_exclusion_zone = nil
			top_width = area_width
			center_width = 0
			bottom_width = 0
			top_height = area_height
			center_height = 0
			bottom_height = 0
			top_offset = 0
			center_offset = 0
			bottom_offset = 0
		end

		local top_exclusion_alignment, top_exclusion_width, top_exclusion_height = nil

		if top_exclusion_zone then
			top_exclusion_alignment = top_exclusion_zone.alignment
			local inv_scale = RESOLUTION_LOOKUP.inv_scale
			local x_padding = image_padding.top[top_exclusion_alignment][1]
			local y_padding = image_padding.top[top_exclusion_alignment][2]
			top_exclusion_width = top_exclusion_zone.width + x_padding * inv_scale
			top_exclusion_height = top_exclusion_zone.height + y_padding * inv_scale
		end

		local bottom_exclusion_alignment, bottom_exclusion_width, bottom_exclusion_height = nil

		if bottom_exclusion_zone then
			bottom_exclusion_alignment = bottom_exclusion_zone.alignment
			local inv_scale = RESOLUTION_LOOKUP.inv_scale
			local x_padding = image_padding.bottom[bottom_exclusion_alignment][1]
			local y_padding = image_padding.bottom[bottom_exclusion_alignment][2]
			bottom_exclusion_width = bottom_exclusion_zone.width + x_padding * inv_scale
			bottom_exclusion_height = bottom_exclusion_zone.height + y_padding * inv_scale
		end

		if top_exclusion_zone and not bottom_exclusion_zone then
			if area_height <= top_exclusion_height then
				top_height = area_height
			else
				top_height = top_exclusion_height
			end

			top_width = area_width - top_exclusion_width
			top_offset = (top_exclusion_alignment == "left" and top_exclusion_width) or 0
			bottom_height = area_height - top_height
			bottom_width = area_width
			bottom_offset = 0
		elseif not top_exclusion_zone and bottom_exclusion_zone then
			if area_height <= bottom_exclusion_height then
				bottom_height = area_height
			else
				bottom_height = bottom_exclusion_height
			end

			bottom_width = area_width - bottom_exclusion_width
			bottom_offset = (bottom_exclusion_alignment == "left" and bottom_exclusion_width) or 0
			top_height = area_height - bottom_height
			top_width = area_width
			top_offset = 0
		elseif top_exclusion_zone and bottom_exclusion_zone then
			if area_height >= top_exclusion_height + bottom_exclusion_height then
				top_height = top_exclusion_height
				top_width = area_width - top_exclusion_width
				bottom_height = bottom_exclusion_height
				bottom_width = area_width - bottom_exclusion_width
				center_height = area_height - (top_exclusion_height + bottom_exclusion_height)
				center_width = area_width
				top_offset = (top_exclusion_alignment == "left" and top_exclusion_width) or 0
				bottom_offset = (bottom_exclusion_alignment == "left" and bottom_exclusion_width) or 0
				center_offset = 0
			elseif top_exclusion_height < area_height and bottom_exclusion_height < area_height then
				top_height = area_height - bottom_exclusion_height
				top_width = area_width - top_exclusion_width
				bottom_height = area_height - top_exclusion_height
				bottom_width = area_width - bottom_exclusion_width
				center_height = area_height - (top_height + bottom_height)
				center_width = area_width - (top_exclusion_width + bottom_exclusion_width)
				top_offset = (top_exclusion_alignment == "left" and top_exclusion_width) or 0
				bottom_offset = (bottom_exclusion_alignment == "left" and bottom_exclusion_width) or 0
				center_offset = (top_exclusion_alignment == "left" and top_offset) or bottom_offset
			elseif top_exclusion_alignment == "left" and area_height <= top_exclusion_height then
				top_height = area_height - bottom_exclusion_height
				top_width = area_width - top_exclusion_width
				bottom_height = area_height - top_height
				bottom_width = area_width - top_exclusion_width - bottom_exclusion_width
				center_height = 0
				center_width = 0
				top_offset = top_exclusion_width
				bottom_offset = top_exclusion_width
				center_offset = 0
			elseif top_exclusion_alignment == "right" and area_height <= top_exclusion_height then
				top_height = area_height - bottom_exclusion_height
				top_width = area_width - top_exclusion_width
				bottom_height = area_height - top_height
				bottom_width = area_width - top_exclusion_width - bottom_exclusion_width
				center_height = 0
				center_width = 0
				top_offset = 0
				bottom_offset = bottom_exclusion_width
				center_offset = 0
			elseif bottom_exclusion_alignment == "right" and area_height <= bottom_exclusion_height then
				bottom_height = area_height - top_exclusion_height
				bottom_width = area_width - bottom_exclusion_width
				top_height = area_height - bottom_height
				top_width = area_width - top_exclusion_width - bottom_exclusion_width
				center_height = 0
				center_width = 0
				top_offset = top_exclusion_width
				bottom_offset = 0
				center_offset = 0
			elseif bottom_exclusion_alignment == "left" and area_height <= bottom_exclusion_height then
				bottom_height = area_height - top_exclusion_height
				bottom_width = area_width - bottom_exclusion_width
				top_height = area_height - bottom_height
				top_width = area_width - top_exclusion_width - bottom_exclusion_width
				center_height = 0
				center_width = 0
				top_offset = bottom_exclusion_width
				bottom_offset = bottom_exclusion_width
				center_offset = 0
			end
		end

		local minimum_text_width = area_width * 0.2
		local top_text_amount, center_text_amount, bottom_text_amount = nil
		local total_potential_lines = math.floor(area_height / full_font_height) + 1

		if not top_exclusion_zone and not bottom_exclusion_zone then
			top_text_amount = total_potential_lines
		elseif top_exclusion_zone and not bottom_exclusion_zone then
			top_text_amount = math.ceil(top_height / full_font_height)
			bottom_text_amount = total_potential_lines - top_text_amount
		elseif bottom_exclusion_zone and not top_exclusion_zone then
			top_text_amount = math.ceil(top_height / full_font_height)
			bottom_text_amount = total_potential_lines - top_text_amount
		elseif area_height <= top_exclusion_height + bottom_exclusion_height then
			top_text_amount = math.ceil(top_height / full_font_height)
			bottom_text_amount = math.floor(bottom_height / full_font_height)
			local total = 0

			if top_text_amount > 0 and bottom_text_amount < 0 then
				total = top_text_amount
			elseif top_text_amount > 0 and bottom_text_amount > 0 then
				total = bottom_text_amount + top_text_amount
			else
				total = bottom_text_amount
			end

			if total < total_potential_lines then
				center_text_amount = total_potential_lines - total
			else
				center_text_amount = false

				if false then
					center_text_amount = true
				end
			end
		else
			top_text_amount = math.ceil(top_height / full_font_height)
			bottom_text_amount = math.ceil(bottom_height / full_font_height)
			local total = top_text_amount + bottom_text_amount
			center_text_amount = total_potential_lines > total and total_potential_lines - total
		end

		local page = page_texts[page_index]
		local initial_position = Vector3(0, 0, 0)
		local position = initial_position
		local n_linebreaks_at_end_of_block = 0
		page.top.width = top_width
		position = Vector3(initial_position.x + top_offset, position.y, position.z)

		if minimum_text_width < top_width and top_text_amount then
			local initial_string_offset = string_offset
			local top_text = string.sub(text, string_offset)
			local texts, return_indices = UIRenderer.word_wrap(ui_renderer, top_text, font_material, font_size, top_width, "return_linebreak_indices")
			local num_texts = math.min(#texts, top_text_amount)
			local page_texts = page.top.texts
			local j = 1
			local n_linebreaks_at_beginning_of_block = 0

			while texts[j] == "" or texts[j] == "\n" do
				j = j + 1
				n_linebreaks_at_beginning_of_block = n_linebreaks_at_beginning_of_block + 1
			end

			if texts[1] == "" or texts[1] == "\n" then
				if n_linebreaks_at_beginning_of_block > 0 then
					string_offset = string_offset + n_linebreaks_at_beginning_of_block
				end

				top_text_amount = top_text_amount + n_linebreaks_at_beginning_of_block
				center_text_amount = center_text_amount and center_text_amount - n_linebreaks_at_beginning_of_block
				bottom_text_amount = bottom_text_amount and bottom_text_amount - n_linebreaks_at_beginning_of_block
				top_text = string.sub(text, string_offset)
				texts, return_indices = UIRenderer.word_wrap(ui_renderer, top_text, font_material, font_size, top_width, "return_linebreak_indices")
				num_texts = math.min(#texts, top_text_amount)
				page_texts = page.top.texts
			end

			for i = 1, num_texts, 1 do
				local line_text = texts[i]
				local justified = not table.contains(return_indices, i)

				self:_add_eventual_paragraph_divider(texts, return_indices, i, total_potential_lines, position, full_font_height, page_index, top_exclusion_zone, bottom_exclusion_zone, top_height, center_height, bottom_height, top_width, bottom_width, top_offset, bottom_offset)

				if i == 1 and string.sub(line_text, 1, 1) == " " then
					line_text = string.sub(line_text, 2)
					string_offset = string_offset + 1
				end

				page_texts[i * 3 - 2] = line_text
				page_texts[i * 3 - 1] = justified
				page_texts[i * 3] = Vector3Box(position)

				if not justified or i == num_texts then
					string_offset = string_offset + 1
				end

				position = position + text_offset
				string_offset = string_offset + string.len(line_text)

				if string_length <= string_offset then
					page_texts[i * 3 - 1] = false
				end
			end

			if table.contains(return_indices, num_texts) then
				n_linebreaks_at_end_of_block = n_linebreaks_at_end_of_block + 1
			end

			if table.contains(return_indices, num_texts - 1) then
				n_linebreaks_at_end_of_block = n_linebreaks_at_end_of_block + 1
			end

			if table.contains(return_indices, num_texts - 2) then
				n_linebreaks_at_end_of_block = n_linebreaks_at_end_of_block + 1
			end
		else
			position = position + text_offset * (top_text_amount or 0)
		end

		page.center.width = center_width
		position = Vector3(initial_position.x + center_offset, position.y, position.z)

		if center_text_amount and minimum_text_width < center_width then
			local initial_string_offset = string_offset
			local center_text = string.sub(text, string_offset)
			local texts, return_indices = UIRenderer.word_wrap(ui_renderer, center_text, font_material, font_size, center_width, "return_linebreak_indices")
			local num_texts = math.min(#texts, center_text_amount)
			local page_texts = page.center.texts
			local j = 1
			local n_linebreaks_at_beginning_of_block = 0

			while texts[j] == "" or texts[j] == "\n" do
				j = j + 1
				n_linebreaks_at_beginning_of_block = n_linebreaks_at_beginning_of_block + 1
			end

			if texts[1] == "" or texts[1] == "\n" then
				if n_linebreaks_at_end_of_block > 1 or n_linebreaks_at_beginning_of_block == 3 then
					string_offset = string_offset + 1
					center_text_amount = center_text_amount + 1
					bottom_text_amount = bottom_text_amount and bottom_text_amount - 1
				end

				center_text = string.sub(text, string_offset)
				texts, return_indices = UIRenderer.word_wrap(ui_renderer, center_text, font_material, font_size, center_width, "return_linebreak_indices")
				num_texts = math.min(#texts, center_text_amount)
				page_texts = page.center.texts
				n_linebreaks_at_end_of_block = 0
			end

			for i = 1, num_texts, 1 do
				local line_text = texts[i]
				local justified = not table.contains(return_indices, i)

				self:_add_eventual_paragraph_divider(texts, return_indices, i, total_potential_lines, position, full_font_height, page_index, top_exclusion_zone, bottom_exclusion_zone, top_height, center_height, bottom_height, top_width, bottom_width, top_offset, bottom_offset)

				if i == 1 and string.sub(line_text, 1, 1) == " " then
					line_text = string.sub(line_text, 2)
					string_offset = string_offset + 1
				end

				page_texts[i * 3 - 2] = line_text
				page_texts[i * 3 - 1] = justified
				page_texts[i * 3] = Vector3Box(position)

				if not justified then
					string_offset = string_offset + 1
				end

				position = position + text_offset
				string_offset = string_offset + string.len(line_text)

				if string_length <= string_offset then
					page_texts[i * 3 - 1] = false
				end
			end

			if table.contains(return_indices, num_texts) then
				n_linebreaks_at_end_of_block = n_linebreaks_at_end_of_block + 1
			end

			if table.contains(return_indices, num_texts - 1) then
				n_linebreaks_at_end_of_block = n_linebreaks_at_end_of_block + 1
			end

			if table.contains(return_indices, num_texts - 2) then
				n_linebreaks_at_end_of_block = n_linebreaks_at_end_of_block + 1
			end
		else
			position = position + text_offset * (center_text_amount or 0)
		end

		page.bottom.width = bottom_width
		position = Vector3(initial_position.x + bottom_offset, position.y, position.z)

		if bottom_text_amount and minimum_text_width < bottom_width then
			local initial_string_offset = string_offset
			local bottom_text = string.sub(text, string_offset)
			local texts, return_indices = UIRenderer.word_wrap(ui_renderer, bottom_text, font_material, font_size, bottom_width, "return_linebreak_indices")
			local num_texts = math.min(#texts, bottom_text_amount)
			local page_texts = page.bottom.texts
			local j = 1
			local n_linebreaks_at_beginning_of_block = 0

			while texts[j] == "" or texts[j] == "\n" do
				j = j + 1
				n_linebreaks_at_beginning_of_block = n_linebreaks_at_beginning_of_block + 1
			end

			if texts[1] == "" or texts[1] == "\n" then
				if n_linebreaks_at_end_of_block > 1 or n_linebreaks_at_beginning_of_block == 3 then
					string_offset = string_offset + 1
				end

				bottom_text = string.sub(text, string_offset)
				texts, return_indices = UIRenderer.word_wrap(ui_renderer, bottom_text, font_material, font_size, bottom_width, "return_linebreak_indices")
				num_texts = math.min(#texts, bottom_text_amount)
				page_texts = page.bottom.texts
				n_linebreaks_at_end_of_block = 0
			end

			for i = 1, num_texts, 1 do
				local line_text = texts[i]
				local justified = not table.contains(return_indices, i)

				if i ~= num_texts and i ~= num_texts - 1 and i ~= num_texts - 2 then
					self:_add_eventual_paragraph_divider(texts, return_indices, i, total_potential_lines, position, full_font_height, page_index, top_exclusion_zone, bottom_exclusion_zone, top_height, center_height, bottom_height, top_width, bottom_width, top_offset, bottom_offset)
				end

				if i == 1 and string.sub(line_text, 1, 1) == " " then
					line_text = string.sub(line_text, 2)
					string_offset = string_offset + 1
				end

				page_texts[i * 3 - 2] = line_text
				page_texts[i * 3 - 1] = justified
				page_texts[i * 3] = Vector3Box(position)

				if not justified then
					string_offset = string_offset + 1
				end

				position = position + text_offset
				string_offset = string_offset + string.len(line_text)

				if string_length <= string_offset then
					page_texts[i * 3 - 1] = false
				end
			end
		end

		page_index = page_index + 1
	end

	content.page = self.page_texts[1]
	self.paragraph_divider_large.content.positions = self.paragraph_divider_offsets[1].large
	self.paragraph_divider_medium.content.positions = self.paragraph_divider_offsets[1].medium
	self.paragraph_divider_small.content.positions = self.paragraph_divider_offsets[1].small
	self.num_content_pages = page_index - 1
	self.current_page = 1

	self:_set_content_to_current_page()
end

LorebookView.expand_sub_categories = function (self, list_content, item_styles, category_indicies, expand)
	local num_categories = #category_indicies

	for i = 1, num_categories, 1 do
		local index = category_indicies[i]
		local category_content = list_content[index]
		local category_style = item_styles[index]
		category_content.selected = expand
		category_content.visible = category_content.unlocked and expand
		category_style.list_member_offset = (category_content.unlocked and expand and category_style.offset) or {
			0,
			0,
			0
		}

		if (expand and category_content.expanded) or not expand then
			local sub_category_indicies = category_content.sub_category_indicies

			self:expand_sub_categories(list_content, item_styles, sub_category_indicies, expand)
		end
	end
end

LorebookView.make_categories_available = function (self, list_content, category_indicies)
	local num_categories = #category_indicies
	local has_expanded_category = false

	for i = 1, num_categories, 1 do
		local index = category_indicies[i]
		local category_content = list_content[index]

		if category_content.expanded then
			local sub_category_indicies = category_content.sub_category_indicies
			has_expanded_category = true

			self:make_categories_available(list_content, sub_category_indicies)
		end
	end

	for i = 1, num_categories, 1 do
		local index = category_indicies[i]
		local category_content = list_content[index]

		if not category_content.expanded then
			category_content.available = not has_expanded_category
		end
	end
end

LorebookView.calculate_num_draws = function (self, list_content, max_draws)
	local num_list_content = #list_content
	local current_draws = 0
	local last_index = 1

	for i = 1, num_list_content, 1 do
		local content = list_content[i]

		if content.visible then
			current_draws = current_draws + 1
		end

		last_index = i

		if current_draws == max_draws then
			break
		end
	end

	return last_index
end

LorebookView.play_sound = function (self, event)
	WwiseWorld.trigger_event(self.wwise_world, event)
end

LorebookView.on_reset = function (self)
	return
end

LorebookView.on_apply = function (self)
	return
end

LorebookView.on_menu_close = function (self)
	return
end

if rawget(_G, "global_lorebook_view") then
	global_lorebook_view:create_ui_elements()
end

return
