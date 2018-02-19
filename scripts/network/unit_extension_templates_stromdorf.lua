return {
	ai_unit_storm_vermin_champion = {
		base_template = "ai_unit_base",
		go_type = "ai_unit_with_inventory",
		self_owned_extensions = {
			"AIMeleeLineOfSightExtension",
			"AIInventoryExtension",
			"PingTargetExtension"
		},
		husk_extensions = {
			"AIInventoryExtension",
			"PingTargetExtension"
		},
		remove_when_killed = {
			self_owned_extensions = {
				"AIMeleeLineOfSightExtension"
			},
			husk_extensions = {}
		}
	}
}
