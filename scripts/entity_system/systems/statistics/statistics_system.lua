require("scripts/entity_system/systems/statistics/statistics_templates")

StatisticsSystem = class(StatisticsSystem, ExtensionSystemBase)
local extensions = {
	"StatisticsExtension"
}
StatisticsSystem.init = function (self, context, name)
	StatisticsSystem.super.init(self, context, name, extensions)

	self.unit_extension_data = {}

	return 
end
StatisticsSystem.destroy = function (self)
	return 
end
local dummy_input = {}
StatisticsSystem.on_add_extension = function (self, world, unit, extension_name, extension_init_data)
	local template_category_name = extension_init_data.template
	local statistics_id = extension_init_data.statistics_id

	assert(template_category_name, "No statistic template set for statistics extension on unit %s", tostring(unit))
	assert(statistics_id, "No statistic id set for statistics extension on unit %s", tostring(unit))

	local extension = {
		template_category_name = template_category_name,
		statistics_id = statistics_id
	}
	local templates = StatisticsTemplateCategories[template_category_name]

	for i = 1, #templates, 1 do
		local template_name = templates[i]
		local template = StatisticsTemplates[template_name]
		extension[template_name] = template.init()
	end

	ScriptUnit.set_extension(unit, self.name, extension, dummy_input)

	self.unit_extension_data[unit] = extension

	return extension
end
StatisticsSystem.on_remove_extension = function (self, unit, extension_name)
	self.unit_extension_data[unit] = nil

	ScriptUnit.remove_extension(unit, self.NAME)

	return 
end
StatisticsSystem.update = function (self, context, t)
	local statistics_db = context.statistics_db
	local StatisticsTemplateCategories = StatisticsTemplateCategories
	local StatisticsTemplates = StatisticsTemplates

	for unit, extension in pairs(self.unit_extension_data) do
		if statistics_db.is_registered(statistics_db, extension.statistics_id) then
			local template_category_name = extension.template_category_name
			local templates = StatisticsTemplateCategories[template_category_name]

			for i = 1, #templates, 1 do
				local template_name = templates[i]
				local template = StatisticsTemplates[template_name]

				template.update(unit, extension, context, t)
			end
		end
	end

	return 
end

return 
