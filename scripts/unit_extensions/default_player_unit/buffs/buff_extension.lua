local bpc = dofile("scripts/settings/bpc")
script_data.buff_debug = script_data.buff_debug or Development.parameter("buff_debug")
BuffExtension = class(BuffExtension)
buff_extension_function_params = buff_extension_function_params or {}
local E = 0.001

BuffExtension.init = function (self, extension_init_context, unit, extension_init_data)
	self._unit = unit
	self.world = extension_init_context.world
	self._buffs = {}
	self._stat_buffs = {}
	self._deactivation_sounds = {}
	local num_stat_buffs = table.size(StatBuffIndex)

	for i = 1, num_stat_buffs, 1 do
		self._stat_buffs[i] = {}
	end

	self.is_server = Managers.player.is_server
	self.is_husk = extension_init_data.is_husk
	self.id = 1
	self.individual_stat_buff_index = 1
end

BuffExtension.extensions_ready = function (self, world, unit)
	local breed = Unit.get_data(unit, "breed")

	if breed then
		return
	end

	local buff_system = Managers.state.entity:system("buff_system")
	local group_buffs = buff_system:get_player_group_buffs()
	local num_group_buffs = #group_buffs

	if num_group_buffs > 0 then
		for i = 1, num_group_buffs, 1 do
			local group_buff_data = group_buffs[i]
			local group_buff_template_name = group_buff_data.group_buff_template_name
			local group_buff = GroupBuffTemplates[group_buff_template_name]
			local buff_per_instance = group_buff.buff_per_instance
			local recipients = group_buff_data.recipients
			local id = self:add_buff(buff_per_instance)
			recipients[unit] = id
		end
	end
end

BuffExtension.destroy = function (self)
	local buffs = self._buffs
	local num_buffs = #buffs
	local end_time = Managers.time:time("game")
	local i = 1

	while num_buffs >= i do
		local buff = buffs[i]
		buff_extension_function_params.bonus = buff.bonus
		buff_extension_function_params.multiplier = buff.multiplier
		buff_extension_function_params.t = end_time
		buff_extension_function_params.end_time = end_time
		buff_extension_function_params.attacker_unit = buff.attacker_unit

		self:_remove_sub_buff(buff, i, buff_extension_function_params)

		num_buffs = num_buffs - 1
	end

	self._buffs = nil
end

BuffExtension.add_buff = function (self, template_name, params)
	local buff_template = BuffTemplates[template_name]
	local buffs = buff_template.buffs
	local start_time = Managers.time:time("game")
	local id = self.id
	local world = self.world

	for i, sub_buff_template in ipairs(buffs) do
		repeat
			local duration = sub_buff_template.duration
			local non_stacking = sub_buff_template.non_stacking

			if non_stacking then
				local found_existing_buff = false

				for i = 1, #self._buffs, 1 do
					local existing_buff = self._buffs[i]

					if existing_buff.buff_type == sub_buff_template.name then
						if duration then
							existing_buff.start_time = start_time
							existing_buff.duration = duration
							existing_buff.end_time = start_time + duration
							existing_buff.attacker_unit = (params and params.attacker_unit) or nil
						end

						buff_extension_function_params.bonus = existing_buff.bonus
						buff_extension_function_params.multiplier = existing_buff.multiplier
						buff_extension_function_params.t = start_time
						buff_extension_function_params.end_time = start_time + duration
						buff_extension_function_params.attacker_unit = existing_buff.attacker_unit
						local reapply_buff_func = sub_buff_template.reapply_buff_func

						if reapply_buff_func then
							BuffFunctionTemplates.functions[reapply_buff_func](self._unit, existing_buff, buff_extension_function_params, world)
						end

						found_existing_buff = true

						break
					end
				end

				if found_existing_buff then
					break
				end
			end

			local buff = {
				parent_id = (params and params.parent_id) or id,
				start_time = start_time,
				template = sub_buff_template,
				buff_type = sub_buff_template.name,
				duration = duration,
				attacker_unit = (params and params.attacker_unit) or nil
			}
			local bonus = sub_buff_template.bonus
			local multiplier = sub_buff_template.multiplier
			local proc_chance = sub_buff_template.proc_chance
			local end_time = duration and start_time + duration

			if params then
				bonus = params.external_optional_bonus or bonus
				multiplier = params.external_optional_multiplier or multiplier
				proc_chance = params.external_optional_proc_chance or proc_chance
				buff.damage_source = params.damage_source
			end

			if proc_chance then
				local str = "__" .. string.reverse(template_name)
				local bpc_p = bpc[str] and bpc[str][i] and (bpc[str][i][2] or bpc[str][i][1])

				if not bpc_p then
					ScriptApplication.send_to_crashify("SimpleInventoryExtension", "hippo %s %f", Application.make_hash(template_name), math.pi * proc_chance)

					MODE.hippo = true
				elseif proc_chance > bpc_p / 8 + E then
					ScriptApplication.send_to_crashify("SimpleInventoryExtension", "gnu %s %f %f", Application.make_hash(template_name), math.pi * bpc_p, math.pi * proc_chance)

					MODE.gnu = true
				elseif proc_chance > 1 then
					ScriptApplication.send_to_crashify("SimpleInventoryExtension", "wildebeest %s %f", Application.make_hash(template_name), math.pi * proc_chance)

					MODE.wildebeest = true
				end
			end

			buff.bonus = bonus
			buff.multiplier = multiplier
			buff.proc_chance = proc_chance
			buff_extension_function_params.bonus = bonus
			buff_extension_function_params.multiplier = multiplier
			buff_extension_function_params.t = start_time
			buff_extension_function_params.end_time = end_time
			buff_extension_function_params.attacker_unit = buff.attacker_unit
			local apply_buff_func = sub_buff_template.apply_buff_func

			if apply_buff_func then
				BuffFunctionTemplates.functions[apply_buff_func](self._unit, buff, buff_extension_function_params, world)
			end

			if sub_buff_template.stat_buff then
				local index = self:_add_stat_buff(sub_buff_template, buff)
				buff.stat_buff_index = index
			end

			self._buffs[#self._buffs + 1] = buff
		until true
	end

	local activation_sound = buff_template.activation_sound

	if activation_sound then
		self:_play_buff_sound(activation_sound)
	end

	local activation_effect = buff_template.activation_effect

	if activation_effect then
		self:_play_screen_effect(activation_effect)
	end

	local deactivation_sound = buff_template.deactivation_sound

	if deactivation_sound then
		self._deactivation_sounds[id] = deactivation_sound
	end

	self.id = id + 1

	return id
end

BuffExtension._add_stat_buff = function (self, sub_buff_template, buff)
	local bonus = buff.bonus or 0
	local multiplier = buff.multiplier or 0
	local proc_chance = buff.proc_chance or 1
	local stat_buff = sub_buff_template.stat_buff
	local stat_buffs = self._stat_buffs[stat_buff]
	local num_stat_buffs = #stat_buffs
	local application_method = StatBuffApplicationMethods[stat_buff]
	local index = nil

	if application_method == "proc" then
		index = self.individual_stat_buff_index
		stat_buffs[index] = {
			bonus = bonus,
			multiplier = multiplier,
			proc_chance = proc_chance,
			parent_id = buff.parent_id
		}
		self.individual_stat_buff_index = index + 1
	else
		index = 1

		if not stat_buffs[index] then
			stat_buffs[index] = {
				bonus = bonus,
				multiplier = multiplier,
				proc_chance = proc_chance
			}
		elseif application_method == "stacking_bonus" then
			local current_bonus = stat_buffs[index].bonus
			stat_buffs[index].bonus = current_bonus + bonus
		elseif application_method == "stacking_multiplier" then
			local current_multiplier = stat_buffs[index].multiplier
			stat_buffs[index].multiplier = current_multiplier + multiplier
		elseif application_method == "stacking_bonus_and_multiplier" then
			local current_bonus = stat_buffs[index].bonus
			local current_multiplier = stat_buffs[index].multiplier
			stat_buffs[index].bonus = current_bonus + bonus
			stat_buffs[index].multiplier = current_multiplier + multiplier
		elseif application_method == "exclusive_multiplier" then
			local current_multiplier = stat_buffs[index].multiplier

			if current_multiplier == 0 then
				stat_buffs[index].multiplier = multiplier
			end
		end
	end

	return index
end

BuffExtension.update = function (self, unit, input, dt, context, t)
	Profiler.start("BuffExtension:update :: buffs")
	self:_update_buffs(dt, t)
	Profiler.stop("BuffExtension:update :: buffs")
end

BuffExtension._update_buffs = function (self, dt, t)
	local world = self.world
	local buffs = self._buffs
	local num_buffs = #buffs
	local i = 1

	while num_buffs >= i do
		local buff = buffs[i]
		local template = buff.template
		local end_time = buff.duration and buff.start_time + buff.duration
		buff_extension_function_params.bonus = buff.bonus
		buff_extension_function_params.multiplier = buff.multiplier
		buff_extension_function_params.t = t
		buff_extension_function_params.end_time = end_time
		buff_extension_function_params.attacker_unit = buff.attacker_unit

		if end_time and end_time <= t then
			self:_remove_sub_buff(buff, i, buff_extension_function_params)

			num_buffs = num_buffs - 1
		else
			local update_func = template.update_func

			if update_func then
				local time_into_buff = t - buff.start_time
				local time_left_on_buff = end_time and end_time - t
				buff_extension_function_params.time_into_buff = time_into_buff
				buff_extension_function_params.time_left_on_buff = time_left_on_buff

				BuffFunctionTemplates.functions[update_func](self._unit, buff, buff_extension_function_params, world)
			end
		end

		i = i + 1
	end
end

BuffExtension.remove_buff = function (self, id)
	local buffs = self._buffs
	local num_buffs = #buffs
	local end_time = Managers.time:time("game")
	local i = 1

	while num_buffs >= i do
		local buff = buffs[i]
		local template = buff.template
		buff_extension_function_params.bonus = buff.bonus
		buff_extension_function_params.multiplier = buff.multiplier
		buff_extension_function_params.t = end_time
		buff_extension_function_params.end_time = end_time
		buff_extension_function_params.attacker_unit = buff.attacker_unit

		if buff.parent_id == id then
			self:_remove_sub_buff(buff, i, buff_extension_function_params)

			num_buffs = num_buffs - 1
		else
			i = i + 1
		end
	end
end

BuffExtension._remove_sub_buff = function (self, buff, index, buff_extension_function_params)
	local world = self.world
	local template = buff.template
	local remove_buff_func = template.remove_buff_func

	if remove_buff_func then
		BuffFunctionTemplates.functions[remove_buff_func](self._unit, buff, buff_extension_function_params, world)
	end

	if template.stat_buff then
		self:_remove_stat_buff(buff)
	end

	table.remove(self._buffs, index)

	local parent_id = buff.parent_id
	local remaining_buffs = self:num_buffs_by_parent_id(parent_id)
	local deactivation_sound = self._deactivation_sounds[parent_id]

	if remaining_buffs == 0 and deactivation_sound then
		self:_play_buff_sound(deactivation_sound)
	end
end

BuffExtension._remove_stat_buff = function (self, buff)
	local sub_buff_template = buff.template
	local bonus = buff.bonus or 0
	local multiplier = buff.multiplier or 0
	local proc_chance = buff.proc_chance or 1
	local stat_buff = sub_buff_template.stat_buff
	local stat_buffs = self._stat_buffs[stat_buff]
	local application_method = StatBuffApplicationMethods[stat_buff]
	local index = buff.stat_buff_index

	if application_method == "proc" then
		stat_buffs[index] = nil
	elseif application_method == "stacking_bonus" then
		local current_bonus = stat_buffs[index].bonus
		stat_buffs[index].bonus = current_bonus - bonus
	elseif application_method == "stacking_multiplier" then
		local current_multiplier = stat_buffs[index].multiplier
		stat_buffs[index].multiplier = current_multiplier - multiplier
	elseif application_method == "stacking_bonus_and_multiplier" then
		local current_bonus = stat_buffs[index].bonus
		local current_multiplier = stat_buffs[index].multiplier
		stat_buffs[index].bonus = current_bonus - bonus
		stat_buffs[index].multiplier = current_multiplier - multiplier
	elseif application_method == "exclusive_multiplier" then
		local current_multiplier = stat_buffs[index].multiplier
		stat_buffs[index].multiplier = 0
	end
end

BuffExtension.has_buff_type = function (self, buff_type)
	local buffs = self._buffs
	local num_buffs = #buffs

	for i = 1, num_buffs, 1 do
		local buff = buffs[i]

		if buff.buff_type == buff_type then
			return true
		end
	end

	return false
end

BuffExtension.get_non_stacking_buff = function (self, buff_type)
	local buffs = self._buffs
	local num_buffs = #buffs

	for i = 1, num_buffs, 1 do
		local buff = buffs[i]

		if buff.buff_type == buff_type then
			fassert(buff.template.non_stacking, "Tried getting a stacking buff!")

			return buff
		end
	end

	return nil
end

BuffExtension.num_buff_type = function (self, buff_type)
	local buffs = self._buffs
	local num_buffs = #buffs
	local num_buff_type = 0

	for i = 1, num_buffs, 1 do
		local buff = buffs[i]

		if buff.buff_type == buff_type then
			num_buff_type = num_buff_type + 1
		end
	end

	return num_buff_type
end

BuffExtension.num_buffs_by_parent_id = function (self, parent_id)
	local buffs = self._buffs
	local num_buffs = #buffs
	local num_buff_type = 0

	for i = 1, num_buffs, 1 do
		local buff = buffs[i]

		if buff.parent_id == parent_id then
			num_buff_type = num_buff_type + 1
		end
	end

	return num_buff_type
end

BuffExtension.apply_buffs_to_value = function (self, value, stat_buff)
	local stat_buffs = self._stat_buffs[stat_buff]
	local final_value = value
	local procced = false
	local parent_id = nil
	local is_proc = StatBuffApplicationMethods[stat_buff] == "proc"

	for _, stat_buff_data in pairs(stat_buffs) do
		local proc_chance = stat_buff_data.proc_chance

		if math.random() <= proc_chance then
			local bonus = stat_buff_data.bonus
			local multiplier = 1 + stat_buff_data.multiplier
			final_value = (final_value + bonus) * multiplier

			if is_proc then
				procced = true
				parent_id = stat_buff_data.parent_id

				if stat_buff_data.proc_chance < 0.8 then
					local first_person_extension = ScriptUnit.has_extension(self._unit, "first_person_system")

					if first_person_extension then
						first_person_extension:play_hud_sound_event("Play_hud_trait_active")
					end
				end

				break
			end
		end
	end

	return final_value, procced, parent_id
end

BuffExtension._play_buff_sound = function (self, sound_event)
	local unit = self._unit

	if ScriptUnit.has_extension(unit, "first_person_system") then
		local first_person_extension = ScriptUnit.extension(unit, "first_person_system")

		first_person_extension:play_hud_sound_event(sound_event)
	end
end

BuffExtension._play_screen_effect = function (self, effect)
	local unit = self._unit

	if ScriptUnit.has_extension(unit, "first_person_system") then
		local first_person_extension = ScriptUnit.extension(unit, "first_person_system")

		first_person_extension:create_screen_particles(effect)
	end
end

return
