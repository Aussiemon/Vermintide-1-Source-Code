require("scripts/settings/forge_settings")
require("scripts/settings/economy")
require("scripts/settings/altar_settings")

VaultForgeUnlockKeyTable = {}
VaultForgeMeltKeyTable = {}
VaultForgeMergeKeyTable = {}

local function init_forge_vault()
	for key, val in pairs(ForgeSettings.trait_unlock_cost) do
		local key_table = VaultForgeUnlockKeyTable
		local cost_table = {}

		for i, cost in ipairs(val.cost) do
			cost_table[i] = "trait_unlock." .. key .. cost

			Vault.deposit_single(cost_table[i], cost)
		end

		key_table[key] = cost_table
	end

	for key, val in pairs(ForgeSettings.melt_reward) do
		local min_max = {
			min = "melt_reward." .. key .. ".min",
			max = "melt_reward." .. key .. ".max"
		}
		VaultForgeMeltKeyTable[key] = min_max

		Vault.deposit_single(min_max.min, val.min)
		Vault.deposit_single(min_max.max, val.max)
	end

	for key, val in pairs(ForgeSettings.merge_cost) do
		local key_table = VaultForgeMergeKeyTable
		local cost_table = {}

		for i, cost in ipairs(val.cost) do
			cost_table[i] = "merge_cost." .. key .. cost

			Vault.deposit_single(cost_table[i], cost)
		end

		key_table[key] = cost_table
	end
end

init_forge_vault()

VaultAltarCostKeyTable = {}
VaultAltarRerollTraitsCostKeyTable = {}
VaultAltarRerollTraitProcCostKeyTable = {}

local function init_altar_vault()
	for key, val in pairs(AltarSettings.pray_for_loot_cost) do
		local t = {
			random = "pray." .. key .. ".random",
			specific = "pray." .. key .. ".specific"
		}
		VaultAltarCostKeyTable[key] = t

		Vault.deposit_single(t.random, val.random)
		Vault.deposit_single(t.specific, val.specific)
	end

	for key, val in pairs(AltarSettings.reroll_traits) do
		local t = {
			cost = "reroll_traits." .. key .. ".cost"
		}
		VaultAltarRerollTraitsCostKeyTable[key] = t

		Vault.deposit_single(t.cost, val.cost)
	end

	for key, val in pairs(AltarSettings.proc_reroll_trait) do
		local t = {
			cost = "proc_reroll_trait." .. key .. ".cost"
		}
		VaultAltarRerollTraitProcCostKeyTable[key] = t

		Vault.deposit_single(t.cost, val.cost)
	end
end

init_altar_vault()

VaultEconomyLevelFailedKeyTable = {}

local function init_economy_vault()
	for difficulty, settings in pairs(DifficultySettings) do
		local t = {
			amount = "failed." .. difficulty .. ".amount"
		}
		VaultEconomyLevelFailedKeyTable[difficulty] = t
		local level_failed_reward = settings.level_failed_reward

		Vault.deposit_single(t.amount, level_failed_reward.token_amount)
	end
end

init_economy_vault()

return
