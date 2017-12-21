table.table_as_sorted_string_arrays = function (source, key_dest, value_dest)
	local count = 0

	for key, value in pairs(source) do
		count = count + 1
		key_dest[count] = tostring(key)
	end

	table.sort(key_dest)

	for i = 1, count, 1 do
		local key = key_dest[i]
		value_dest[i] = source[key]
	end

	return count
end

return 
