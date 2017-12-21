require("scripts/entity_system/systems/ai/ai_group_templates/ai_group_templates")
require("scripts/entity_system/systems/ai/ai_group_templates/ai_group_templates_clan_rat")
require("scripts/entity_system/systems/ai/ai_group_templates/ai_group_templates_storm_vermin")

AIGroupSystem = class(AIGroupSystem, ExtensionSystemBase)
local extensions = {
	"AIGroupMember"
}

local function readonlytable(table)
	return setmetatable({}, {
		__metatable = false,
		__index = table,
		__newindex = function (table, key, value)
			error("Coder trying to modify a AI group system read-only empty table. Don't do it!")

			return 
		end
	})
end

local EMPTY_TABLE = readonlytable({})
AIGroupSystem.init = function (self, context, system_name)
	local entity_manager = context.entity_manager

	entity_manager.register_system(entity_manager, self, system_name, extensions)

	self.entity_manager = entity_manager
	self.is_server = context.is_server
	self.world = context.world
	self.unit_storage = context.unit_storage
	self.nav_world = Managers.state.entity:system("ai_system"):nav_world()
	self.groups = {}
	self.groups_to_initialize = {}
	self.groups_to_update = {}
	self.unit_extension_data = {}
	self.dummy_extension = readonlytable({})
	self.group_uid = 0

	return 
end
AIGroupSystem.destroy = function (self)
	return 
end
local dummy_input = readonlytable({})
AIGroupSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local id = extension_init_data.id

	if id == nil then
		ScriptUnit.set_extension(unit, "ai_group_system", self.dummy_extension, dummy_input)

		self.unit_extension_data[unit] = self.dummy_extension

		return self.dummy_extension
	end

	local template = extension_init_data.template
	local extension = {}
	local group = self.groups[id]

	if group == nil then
		group = {
			members_n = 0,
			num_spawned_members = 0,
			id = id,
			members = {},
			size = extension_init_data.size,
			template = template
		}

		assert(group.size, "Created group without size!")
		assert(group.template, "Created group without template!")

		self.groups[id] = group
		self.groups_to_initialize[id] = group

		if script_data.ai_group_debug then
			Unit.set_animation_logging(unit, true)
		end
	end

	group.members[unit] = extension
	group.members_n = group.members_n + 1
	group.num_spawned_members = group.num_spawned_members + 1
	extension.group = group
	extension.template = template
	extension.id = id
	extension.frozen = false

	assert(group.num_spawned_members <= group.size, "An AI group was initialized with size=%d but %d AIs was assigned to it.", group.size, group.num_spawned_members)
	ScriptUnit.set_extension(unit, "ai_group_system", extension, dummy_input)

	self.unit_extension_data[unit] = extension
	local pre_unit_init = AIGroupTemplates[template].pre_unit_init

	if pre_unit_init then
		pre_unit_init(unit, group.template)
	end

	return extension
end
AIGroupSystem.on_remove_extension = function (self, unit, extension_name)
	local extension = self.unit_extension_data[unit]

	if extension == self.dummy_extension then
		fassert(next(extension) == nil, "No extension data for unit %s", unit)
		ScriptUnit.remove_extension(unit, self.NAME)

		return 
	end

	self.on_freeze_extension(self, unit, extension_name)
	ScriptUnit.remove_extension(unit, self.NAME)

	return 
end
AIGroupSystem.on_freeze_extension = function (self, unit, extension_name)
	local extension = self.unit_extension_data[unit]

	if extension == self.dummy_extension or extension == nil or extension.frozen then
		return 
	end

	local id = extension.id
	local group = self.groups[id]

	fassert(group ~= nil, "Trying to remove group extension for unit %s that does not belong to a group.", unit)

	group.members[unit] = nil
	group.members_n = group.members_n - 1

	if group.members_n == 0 and group.num_spawned_members == group.size then
		local world = self.world
		local nav_world = self.nav_world

		if self.groups_to_initialize[id] == nil then
			local template = group.template
			local template_destroy = AIGroupTemplates[template].destroy

			template_destroy(world, nav_world, group, unit)
		end

		self.groups[id] = nil
		self.groups_to_initialize[id] = nil
		self.groups_to_update[id] = nil
	end

	extension.frozen = true

	return 
end
AIGroupSystem.hot_join_sync = function (self, sender, player)
	return 
end
local debug_drawer_info = {
	mode = "retained",
	name = "AIGroupTemplates_retained"
}
AIGroupSystem.update = function (self, context, t)
	if not self.is_server then
		return 
	end

	local world = self.world
	local nav_world = self.nav_world
	local AIGroupTemplates = AIGroupTemplates

	for id, group in pairs(self.groups_to_initialize) do
		if group.num_spawned_members == group.size then
			if 0 < group.members_n then
				local template = group.template
				local template_init = AIGroupTemplates[template].init

				template_init(world, nav_world, group, t)

				self.groups_to_initialize[group.id] = nil
				self.groups_to_update[group.id] = group
			else
				self.groups_to_initialize[group.id] = nil
			end
		end
	end

	for id, group in pairs(self.groups_to_update) do
		local template = group.template
		local template_update = AIGroupTemplates[template].update

		template_update(world, nav_world, group, t, context.dt)
	end

	if not script_data.ai_group_debug then
		local drawer = Managers.state.debug:drawer(debug_drawer_info)

		drawer.reset(drawer)
	end

	return 
end
AIGroupSystem.generate_group_id = function (self)
	self.group_uid = self.group_uid + 1

	return self.group_uid
end
AIGroupSystem.set_allowed_layer = function (self, layer_name, allowed)
	local layer_id = LAYER_ID_MAPPING[layer_name]

	for id, group in pairs(self.groups_to_update) do
		if group.nav_data and group.nav_data.navtag_layer_cost_table then
			if allowed then
				GwNavTagLayerCostTable.allow_layer(group.nav_data.navtag_layer_cost_table, layer_id)
			else
				GwNavTagLayerCostTable.forbid_layer(group.nav_data.navtag_layer_cost_table, layer_id)
			end
		end
	end

	return 
end

return 
