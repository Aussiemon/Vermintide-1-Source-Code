require("scripts/ui/views/lorebook_page_layout")

LorebookCategoryNames = {}
LorebookCollectablePages = {}
LorebookCollectablePagesAmount = 0
LorebookDefaultUnlocks = {}
LorebookPaths = {}

for level_name, _ in pairs(LevelSettings) do
	LorebookCollectablePages[level_name] = {}
end

LorebookCollectablePages.any = {}
local fill_page_names = nil

function fill_page_names(categories, parent_path)
	local num_categories = #categories

	for i = 1, num_categories, 1 do
		local path = table.clone(parent_path)
		local category = categories[i]
		local category_name = category.category_name
		path[#path + 1] = i
		LorebookCategoryNames[#LorebookCategoryNames + 1] = category_name
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

local path = {}

fill_page_names(JournalPageLayout, path)

LorebookCategoryLookup = table.mirror_array_inplace(LorebookCategoryNames)

return 
