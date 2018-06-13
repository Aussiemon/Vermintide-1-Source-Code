function get_item_with_traits()
	local items = ScriptBackendItem.get_all_backend_items()
	local count = 0

	for backend_id, item_data in pairs(items) do
		local traits = ScriptBackendItem.get_traits(backend_id)

		if next(traits) then
			return backend_id, traits
		end

		count = count + 1
	end

	print("no item with traits found, searched ", count, " items.")
end

function reroll_trait(backend_id, trait_name)
	local logic = ForgeLogic:new()
	local value = logic:reroll_trait_variable(backend_id, trait_name, "proc_chance", "bronze_tokens", 2)

	print("randomed value", value)
end

TraitReroller = class(TraitReroller)

TraitReroller.init = function (self)
	self._logic = ForgeLogic:new()
end

TraitReroller.request = function (self, backend_id)
	self._logic:reroll_traits(backend_id)

	local new_item_key = self._logic:poll_reroll_traits()

	return new_item_key
end

TraitReroller.select = function (self, accept_new)
	self._logic:select_rerolled_traits(accept_new)

	local got_result, item_key = self._logic:poll_select_rerolled_traits()

	print((got_result and "got result") or "didn't get result", got_result and item_key)
end

return
