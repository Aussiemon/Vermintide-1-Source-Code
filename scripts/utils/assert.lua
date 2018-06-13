function assert(condition, ...)
	if not condition then
		local n_args = select("#", ...)

		if n_args > 0 then
			local s, r = pcall(function (...)
				return string.format(...)
			end, ...)

			if s then
				error("assertion failed: " .. r, 2)
			else
				error("assertion failed and invalid debug print: " .. tostring(r), 2)
			end
		end

		error("assertion failed", 2)
	end

	return condition
end

return
