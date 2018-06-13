InterestPointUnits = {
	{
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_1pack",
		spawn_weight = 1
	},
	{
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_2pack",
		spawn_weight = 2
	},
	{
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_3pack",
		spawn_weight = 4
	},
	{
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_4pack",
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_4pack_02",
		spawn_weight = 7
	},
	[7.0] = false,
	[5.0] = false,
	[6] = {
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_6pack_01",
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_6pack_02",
		spawn_weight = 5
	},
	[8] = {
		"units/hub_elements/interest_points/pack_spawning/ai_interest_point_8pack",
		spawn_weight = 2
	}
}
InterestPointSettings = {
	max_rats_currently_moving_to_ip = 5,
	interest_point_spawn_chance = 0.5
}
BreedPacks = {
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 3.5,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_storm_vermin_commander
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 3.5,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_storm_vermin_commander
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 3.5,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_storm_vermin_commander
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 3,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_storm_vermin_commander
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 2.5,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_storm_vermin_commander
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 10,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat
		}
	},
	{
		pack_type = "basic",
		spawn_weight = 2,
		members = {
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_clan_rat,
			Breeds.skaven_storm_vermin_commander
		}
	}
}
BackupBreedPack = {
	pack_type = "backup",
	spawn_weight = 0,
	members = {
		{
			breed = Breeds.skaven_clan_rat,
			animation = {
				"idle",
				"idle_passive_sit"
			}
		}
	}
}
BreedPacks_n = #BreedPacks

for i = 1, BreedPacks_n, 1 do
	local pack = BreedPacks[i]
	pack.members_n = #pack.members
end

BreedPacksBySize = {}
local by_size = {}

for i = 1, BreedPacks_n, 1 do
	local pack = BreedPacks[i]
	local size = pack.members_n

	if not by_size[size] then
		by_size[size] = {
			packs = {},
			weights = {}
		}
	end

	local slot = by_size[size]
	local packs = slot.packs
	packs[#packs + 1] = pack
	slot.weights[#slot.weights + 1] = pack.spawn_weight
end

for size, slot in pairs(by_size) do
	local prob, alias = LoadedDice.create(slot.weights, false)
	BreedPacksBySize[size] = {
		packs = slot.packs,
		prob = prob,
		alias = alias
	}
end

InterestPointUnitsLookup = InterestPointUnitsLookup or false
InterestPointPickListIndexLookup = InterestPointPickListIndexLookup or {}
InterestPointPickList = InterestPointPickList or false

if #InterestPointPickListIndexLookup == 0 then
	local weight_lookup = InterestPointPickList or {}
	local items = 0

	for i, data in ipairs(InterestPointUnits) do
		if data then
			for j = 1, data.spawn_weight, 1 do
				items = items + 1
				weight_lookup[items] = i
			end

			InterestPointPickListIndexLookup[i] = items
		else
			InterestPointPickListIndexLookup[i] = InterestPointPickListIndexLookup[#InterestPointPickListIndexLookup]
		end
	end

	InterestPointPickList = weight_lookup
end

return
