local type = type
local t_insert = table.insert
local t_concat = table.concat
local t_remove = table.remove
local t_sort = table.sort
local s_char = string.char
local tostring = tostring
local tonumber = tonumber
local pairs = pairs
local ipairs = ipairs
local next = next
local error = error
local newproxy = newproxy
local getmetatable = getmetatable
local setmetatable = setmetatable
local print = print
local has_array = false
local array = nil
local array_mt = (has_array and getmetatable(array())) or {}
local json = {}
local null = (newproxy and newproxy(true)) or {}

if getmetatable and getmetatable(null) then
	getmetatable(null).__tostring = function ()
		return "null"
	end
end

json.null = null
local escapes = {
	[""] = "\\f",
	[""] = "\\b",
	["\n"] = "\\n",
	["\t"] = "\\t",
	["\\"] = "\\\\",
	["\r"] = "\\r",
	["\""] = "\\\""
}
local unescapes = {
	b = "",
	f = "",
	t = "\t",
	r = "\r",
	n = "\n",
	["\\"] = "\\",
	["/"] = "/",
	["\""] = "\""
}

for i = 0, 31, 1 do
	local ch = s_char(i)

	if not escapes[ch] then
		escapes[ch] = "\\u%.4X":format(i)
	end
end

local function codepoint_to_utf8(code)
	if code < 128 then
		return s_char(code)
	end

	local bits0_6 = code % 64

	if code < 2048 then
		local bits6_5 = (code - bits0_6) / 64

		return s_char(192 + bits6_5, 128 + bits0_6)
	end

	local bits0_12 = code % 4096
	local bits6_6 = (bits0_12 - bits0_6) / 64
	local bits12_4 = (code - bits0_12) / 4096

	return s_char(224 + bits12_4, 128 + bits6_6, 128 + bits0_6)
end

local valid_types = {
	table = true,
	string = true,
	userdata = true,
	boolean = true,
	number = true
}
local special_keys = {
	__array = true,
	__hash = true
}
local simplesave, tablesave, arraysave, stringsave = nil

function stringsave(o, buffer)
	t_insert(buffer, "\"" .. o.gsub(o, ".", escapes) .. "\"")

	return 
end

function arraysave(o, buffer)
	t_insert(buffer, "[")

	if next(o) then
		for i, v in ipairs(o) do
			simplesave(v, buffer)
			t_insert(buffer, ",")
		end

		t_remove(buffer)
	end

	t_insert(buffer, "]")

	return 
end

function tablesave(o, buffer)
	local __array = {}
	local __hash = {}
	local hash = {}

	for i, v in ipairs(o) do
		__array[i] = v
	end

	for k, v in pairs(o) do
		local ktype = type(k)
		local vtype = type(v)

		if valid_types[vtype] or v == null then
			if ktype == "string" and not special_keys[k] then
				hash[k] = v
			elseif (valid_types[ktype] or k == null) and __array[k] == nil then
				__hash[k] = v
			end
		end
	end

	if next(__hash) ~= nil or next(hash) ~= nil or next(__array) == nil then
		t_insert(buffer, "{")

		local mark = #buffer

		if buffer.ordered then
			local keys = {}

			for k in pairs(hash) do
				t_insert(keys, k)
			end

			t_sort(keys)

			for _, k in ipairs(keys) do
				stringsave(k, buffer)
				t_insert(buffer, ":")
				simplesave(hash[k], buffer)
				t_insert(buffer, ",")
			end
		else
			for k, v in pairs(hash) do
				stringsave(k, buffer)
				t_insert(buffer, ":")
				simplesave(v, buffer)
				t_insert(buffer, ",")
			end
		end

		if next(__hash) ~= nil then
			t_insert(buffer, "\"__hash\":[")

			for k, v in pairs(__hash) do
				simplesave(k, buffer)
				t_insert(buffer, ",")
				simplesave(v, buffer)
				t_insert(buffer, ",")
			end

			t_remove(buffer)
			t_insert(buffer, "]")
			t_insert(buffer, ",")
		end

		if next(__array) then
			t_insert(buffer, "\"__array\":")
			arraysave(__array, buffer)
			t_insert(buffer, ",")
		end

		if mark ~= #buffer then
			t_remove(buffer)
		end

		t_insert(buffer, "}")
	else
		arraysave(__array, buffer)
	end

	return 
end

function userdatasave(o, buffer)
	stringsave(tostring(o), buffer)

	return 
end

function simplesave(o, buffer)
	local t = type(o)

	if t == "number" then
		t_insert(buffer, tostring(o))
	elseif t == "string" then
		stringsave(o, buffer)
	elseif t == "table" then
		local mt = getmetatable(o)

		if mt == array_mt then
			arraysave(o, buffer)
		else
			tablesave(o, buffer)
		end
	elseif t == "boolean" then
		t_insert(buffer, (o and "true") or "false")
	elseif t == "userdata" then
		userdatasave(o, buffer)
	else
		t_insert(buffer, "null")
	end

	return 
end

json.encode = function (obj)
	local t = {}

	simplesave(obj, t)

	return t_concat(t)
end
json.encode_ordered = function (obj)
	local t = {
		ordered = true
	}

	simplesave(obj, t)

	return t_concat(t)
end
json.encode_array = function (obj)
	local t = {}

	arraysave(obj, t)

	return t_concat(t)
end

local function _skip_whitespace(json, index)
	return json.find(json, "[^ \t\r\n]", index) or index
end

local function _fixobject(obj)
	local __array = obj.__array

	if __array then
		obj.__array = nil

		for i, v in ipairs(__array) do
			t_insert(obj, v)
		end
	end

	local __hash = obj.__hash

	if __hash then
		obj.__hash = nil
		local k = nil

		for i, v in ipairs(__hash) do
			if k ~= nil then
				obj[k] = v
				k = nil
			else
				k = v
			end
		end
	end

	return obj
end

local _readvalue, _readstring = nil

local function _readobject(json, index)
	local o = {}

	while true do
		local key, val = nil
		index = _skip_whitespace(json, index + 1)

		if json.byte(json, index) ~= 34 then
			if json.byte(json, index) == 125 then
				return o, index + 1
			end

			return nil, "key expected"
		end

		key, index = _readstring(json, index)

		if key == nil then
			return nil, index
		end

		index = _skip_whitespace(json, index)

		if json.byte(json, index) ~= 58 then
			return nil, "colon expected"
		end

		val, index = _readvalue(json, index + 1)

		if val == nil then
			return nil, index
		end

		o[key] = val
		index = _skip_whitespace(json, index)
		local b = json.byte(json, index)

		if b == 125 then
			return _fixobject(o), index + 1
		end

		if b ~= 44 then
			return nil, "object eof"
		end
	end

	return 
end

local function _readarray(json, index)
	local a = {}
	local oindex = index
	local oindex_byte = json.byte(json, oindex)

	while true do
		local val = nil
		index = _skip_whitespace(json, index + 1)

		if json.byte(json, index) == 93 then
			return setmetatable(a, array_mt), index + 1
		end

		val, index = _readvalue(json, index)

		if val == nil then
			return val, index
		end

		t_insert(a, val)

		index = _skip_whitespace(json, index)
		local b = json.byte(json, index)

		if b == 93 then
			return setmetatable(a, array_mt), index + 1
		end

		if b ~= 44 then
			return nil, "array eof"
		end
	end

	return 
end

local _unescape_error = nil

local function _unescape_surrogate_func(x)
	local lead = tonumber(x.sub(x, 3, 6), 16)
	local trail = tonumber(x.sub(x, 9, 12), 16)
	local codepoint = (lead * 1024 + trail) - 56613888
	local a = codepoint % 64
	codepoint = (codepoint - a) / 64
	local b = codepoint % 64
	codepoint = (codepoint - b) / 64
	local c = codepoint % 64
	codepoint = (codepoint - c) / 64

	return s_char(240 + codepoint, 128 + c, 128 + b, 128 + a)
end

local function _unescape_func(x)
	x = x.match(x, "%x%x%x%x", 3)

	if x then
		return codepoint_to_utf8(tonumber(x, 16))
	end

	_unescape_error = true

	return 
end

function _readstring(json, index)
	index = index + 1
	local endindex = json.find(json, "\"", index, true)

	if endindex then
		local s = json.sub(json, index, endindex - 1)
		_unescape_error = nil
		s = s.gsub(s, "\\u.?.?.?.?", _unescape_func)

		if _unescape_error then
			return nil, "invalid escape"
		end

		return s, endindex + 1
	end

	return nil, "string eof"
end

local function _readnumber(json, index)
	local m = json.match(json, "[0-9%.%-eE%+]+", index)

	return tonumber(m), index + #m
end

local function _readnull(json, index)
	local a, b, c = json.byte(json, index + 1, index + 3)

	if a == 117 and b == 108 and c == 108 then
		return null, index + 4
	end

	return nil, "null parse failed"
end

local function _readtrue(json, index)
	local a, b, c = json.byte(json, index + 1, index + 3)

	if a == 114 and b == 117 and c == 101 then
		return true, index + 4
	end

	return nil, "true parse failed"
end

local function _readfalse(json, index)
	local a, b, c, d = json.byte(json, index + 1, index + 4)

	if a == 97 and b == 108 and c == 115 and d == 101 then
		return false, index + 5
	end

	return nil, "false parse failed"
end

function _readvalue(json, index)
	index = _skip_whitespace(json, index)
	local b = json.byte(json, index)

	if b == 123 then
		return _readobject(json, index)
	elseif b == 91 then
		return _readarray(json, index)
	elseif b == 34 then
		return _readstring(json, index)
	elseif (b ~= nil and 48 <= b and b <= 57) or b == 45 then
		return _readnumber(json, index)
	elseif b == 110 then
		return _readnull(json, index)
	elseif b == 116 then
		return _readtrue(json, index)
	elseif b == 102 then
		return _readfalse(json, index)
	else
		return nil, "value expected"
	end

	return 
end

local first_escape = {
	["\\b"] = "\\u0008",
	["\\u"] = "\\u",
	["\\f"] = "\\u000C",
	["\\/"] = "\\u002f",
	["\\\\"] = "\\u005c",
	["\\n"] = "\\u000A",
	["\\t"] = "\\u0009",
	["\\r"] = "\\u000D",
	["\\\""] = "\\u0022"
}
json.decode = function (json)
	json = json.gsub(json, "\\.", first_escape)
	local val, index = _readvalue(json, 1)

	if val == nil then
		return val, index
	end

	if json.find(json, "[^ \t\r\n]", index) then
		return nil, "garbage at eof"
	end

	return val
end
json.test = function (object)
	local encoded = json.encode(object)
	local decoded = json.decode(encoded)
	local recoded = json.encode(decoded)

	if encoded ~= recoded then
		print("FAILED")
		print("encoded:", encoded)
		print("recoded:", recoded)
	else
		print(encoded)
	end

	return encoded == recoded
end

return json
