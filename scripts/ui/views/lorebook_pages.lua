require("scripts/ui/views/lorebook_page_layout")

LorebookCategoryNames = {}
LorebookCollectablePages = {}
LorebookCollectablePagesAmount = 0
LorebookDefaultUnlocks = {}
LorebookPaths = {}
LorebookDLCPages = {}

for _, dlc in pairs(DLCSettings) do
	local lorebook_pages = dlc.lorebook_pages

	if lorebook_pages then
		for index, value in ipairs(lorebook_pages) do
			LorebookDLCPages[value] = true
		end
	end
end

local setup, find_pages_to_strip, strip_layout, strip_pages, fill_page_names, add_dlc_pages = nil

function setup()
	LorebookCategoryNames = {}
	LorebookCollectablePages = {}
	LorebookCollectablePagesAmount = 0
	LorebookDefaultUnlocks = {}
	LorebookPaths = {}

	for level_name, _ in pairs(LevelSettings) do
		LorebookCollectablePages[level_name] = {}
	end

	LorebookCollectablePages.any = {}

	return 
end

local categories_to_remove = {}

function find_pages_to_strip(categories, parent_path)
	local num_categories = #categories

	for i = 1, num_categories, 1 do
		local path = table.clone(parent_path)
		local category = categories[i]
		local category_name = category.category_name
		path[#path + 1] = i

		if not DefaultLorebookPages[category_name] and not LorebookDLCPages[category_name] then
			categories_to_remove[#categories_to_remove + 1] = category_name
		end

		local sub_categories = category.sub_categories

		if sub_categories then
			find_pages_to_strip(sub_categories, path)
		end
	end

	return 
end

function strip_layout(category_name_to_strip, categories)
	local num_categories = #categories

	for i = num_categories, 1, -1 do
		local category = categories[i]
		local category_name = category.category_name

		if category_name == category_name_to_strip then
			table.remove(categories, i)
		else
			local sub_categories = category.sub_categories

			if sub_categories then
				local num_sub_categories = #sub_categories

				if num_sub_categories == 0 then
					categories.sub_categories = nil
				elseif 0 < num_sub_categories then
					strip_layout(category_name_to_strip, sub_categories)
				end
			end
		end
	end

	return 
end

function strip_pages()
	local num_pages_to_strip = #categories_to_remove

	if 0 < num_pages_to_strip then
		for i = num_pages_to_strip, 1, -1 do
			local category_name = categories_to_remove[i]

			for index, stored_category_name in ipairs(LorebookCategoryNames) do
				if stored_category_name == category_name then
					LorebookCategoryNames[index] = nil
				end
			end

			LorebookCategoryNames[category_name] = nil
			LorebookPaths[category_name] = nil
			JournalPageLayout[category_name] = nil

			strip_layout(category_name, JournalPageLayout)
		end
	end

	return 
end

local dlc_pages = {}

function fill_page_names(categories, parent_path)
	local num_categories = #categories

	for i = 1, num_categories, 1 do
		local path = table.clone(parent_path)
		local category = categories[i]
		local category_name = category.category_name
		path[#path + 1] = i
		local is_dlc = LorebookDLCPages[category_name] or false

		if is_dlc then
			dlc_pages[#dlc_pages + 1] = category_name
		else
			LorebookCategoryNames[#LorebookCategoryNames + 1] = category_name
		end

		LorebookPaths[category_name] = path
		local unlock_level = category.unlock_level

		if unlock_level then
			local collectable_pages_per_level = LorebookCollectablePages[unlock_level]
			collectable_pages_per_level[#collectable_pages_per_level + 1] = category_name
			LorebookCollectablePagesAmount = LorebookCollectablePagesAmount + 1
		else
			LorebookDefaultUnlocks[category_name] = true
		end

		local sub_categories = category.sub_categories

		if sub_categories then
			fill_page_names(sub_categories, path)
		end
	end

	return 
end

function add_dlc_pages()
	for index, category_name in ipairs(dlc_pages) do
		LorebookCategoryNames[#LorebookCategoryNames + 1] = category_name
	end

	return 
end

setup()

local path = {}

find_pages_to_strip(JournalPageLayout, path)

local path = {}

fill_page_names(JournalPageLayout, path)
add_dlc_pages()
strip_pages()
setup()

local path = {}

fill_page_names(JournalPageLayout, path)
add_dlc_pages()

LorebookCategoryLookup = table.mirror_array_inplace(LorebookCategoryNames)

return 
