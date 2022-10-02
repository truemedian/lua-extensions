---Extensions to the Lua standard table library.
---@module extensions.table
---@alias ext_table
local insert, sort = table.insert, table.sort
local random = math.random

local ext_table = {}

for k, v in pairs(table) do
	ext_table[k] = v
end

---Returns a new table with a single layer of keys-values copied.
---@param tbl table
---@return table
function ext_table.copy(tbl)
	local new = {}

	for k, v in pairs(tbl) do
		new[k] = v
	end

	return new
end

---Returns a new table with a all layers of keys-values copied. Tables are copied recursively.
---@param tbl table
---@return table
function ext_table.deepcopy(tbl)
	local new = {}

	for k, v in pairs(tbl) do
		new[k] = type(v) == 'table' and ext_table.deepcopy(v) or v
	end

	return new
end

---Returns the number of keys in the table.
---@param tbl table
---@return number
function ext_table.count(tbl)
	local n = 0

	for _ in pairs(tbl) do
		n = n + 1
	end

	return n
end

---Returns a new table with new key-value pairs sourced from the map function.
---The map function has a signature of: `fn(value, key) new_value, new_key?`
---If `new_key` is omitted, the key will remain the same.
---@param tbl table
---@param fn function
---@return table
function ext_table.map(tbl, fn)
	local new = {}

	for k, v in pairs(tbl) do
		local new_v, new_k = fn(v, k)

		if new_k == nil then
			new[k] = new_v
		else
			new[new_k] = new_v
		end
	end

	return new
end

---Returns a new table with only key-value pairs that cause `fn` to return true.
---The filter function has a signature of: `fn(value, key) boolean`
---@param tbl table
---@param fn function
---@return table
function ext_table.filter(tbl, fn)
	local new = {}

	for k, v in pairs(tbl) do
		if fn(v, k) then
			new[k] = v
		end
	end

	return new
end

---Iterates over the array portion of a table in order, calling `fn` on each value, passing in the return value from the previous element.
---If `initial` is not provided, the first element of the array is used, and the iteration starts at the second element.
---The reduce function has a signature of: `fn(previous, value, index?) boolean`
---@param tbl table
---@param fn fun(previous: any, value: any, index?: integer): boolean
---@param initial any
---@return any
function ext_table.reduce(tbl, fn, initial)
	local reduced = initial

	for i, v in ipairs(tbl) do
		if i == 1 and reduced == nil then
			reduced = v
		else
			reduced = fn(reduced, v, i)
		end
	end

	return reduced
end

---Reverses the contents of the array.
---If `dest` is provided, the source array will not be modified
---@param tbl table
---@param dest? table
---@return table
function ext_table.reverse(tbl, dest)
	if dest then
		for i = 1, #tbl do
			dest[i] = tbl[#tbl - i + 1]
		end

		return dest
	else
		local i, n = 1, #tbl

		while i < n do
			tbl[i], tbl[n] = tbl[n], tbl[i]
			i, n = i + 1, n - 1
		end

		return tbl
	end
end

---Shifts every index after `index` in the table to the right by `count`.
---@param tbl table
---@param index number
---@param count number
function ext_table.shift(tbl, index, count)
	local i = #tbl

	while i >= index do
		tbl[i + count] = tbl[i]

		if i < index + count then
			tbl[i] = nil
		end

		i = i - 1
	end
end

---Returns a slice of the table, works similarly to `string.sub` except on a table.
---@param tbl table
---@param[opt] start number
---@param[opt] stop number
---@param[opt] step number
---@return table
function ext_table.slice(tbl, start, stop, step)
	local new = {}

	for i = start or 1, stop or #tbl, step or 1 do
		insert(new, tbl[i])
	end

	return new
end

---Appends all elements of `b` into `a`. Does not consider non-array elements.
---@param a table
---@param b table
---@return table
function ext_table.join(a, b)
	for _, v in ipairs(b) do
		insert(a, v)
	end

	return a
end

---Merges all key-value pairs of `b` into `a`. Will overwrite any existing keys.
---@param a table
---@param b table
---@return table
function ext_table.merge(a, b)
	for k, v in pairs(b) do
		a[k] = v
	end

	return a
end

---This works exactly like [`table.move`](https://www.lua.org/manual/5.3/manual.html#pdf-table.move) introduced in Lua 5.3.
---@param src table
---@param first integer
---@param stop integer
---@param src_offset integer
---@param dest table
function ext_table.move(src, first, stop, src_offset, dest)
	dest = dest or src

	for i = 0, stop - first do
		dest[src_offset + i] = src[first + i]
	end

	return dest
end

---Removes the value at the index from an array and replaces it with the item at the end of the array.
---@param tbl table
---@param i number
---@return any
function ext_table.swapremove(tbl, i)
	local value = tbl[i]

	tbl[i] = tbl[#tbl]

	return value
end

---Looks for a specific value in a table and returns the key it was first found at.
---@param tbl table
---@param value any
---@return any|nil
function ext_table.search(tbl, value)
	for k, v in pairs(tbl) do
		if v == value then
			return k
		end
	end

	return nil
end

---Returns an array of keys available in the table.
---@param tbl table
---@return table
function ext_table.keys(tbl)
	local new = {}

	for k in pairs(tbl) do
		insert(new, k)
	end

	return new
end

---Returns an array of values available in the table.
---@param tbl table
---@return table
function ext_table.values(tbl)
	local new = {}

	for _, v in pairs(tbl) do
		insert(new, v)
	end

	return new
end

---Returns whether or not the table is empty.
---@param tbl table
---@return boolean
function ext_table.isempty(tbl)
	return (next(tbl)) == nil
end

---Shuffles a table in place.
---@param tbl table
---@return table
function ext_table.shuffle(tbl)
	for i = #tbl, 1, -1 do
		local j = random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end

	return tbl
end

---This works exactly like the standard `table.sort`, but it also returns the sorted table.
---@param tbl table
---@param comp fun(a: any, b: any): boolean
---@return table
function ext_table.sort(tbl, comp)
	sort(tbl, comp)
	return tbl
end

---Returns a random key, value index from an array.
---@param tbl table
---@return any, any
function ext_table.randomipair(tbl)
	local i = random(#tbl)
	return i, tbl[i]
end

---Returns a random key, value index from an array.
---@param tbl table
---@return any, any
function ext_table.randomvalue(tbl)
	local values = ext_table.values(tbl)
	return values[random(#values)]
end

---Returns a random key, value index from a table.
---@param tbl table
---@return any, any
function ext_table.randompair(tbl)
	local rand = random(ext_table.count(tbl))
	local n = 0
	for k, v in pairs(tbl) do
		n = n + 1
		if n == rand then
			return k, v
		end
	end
end

---Fills a table from 1 to `len` with `value`.
---@param tbl table
---@param value any
---@param len? integer
---@param start? integer
---@return table
function ext_table.fill(tbl, value, len, start)
	len = len or #tbl
	start = start or 1

	for i = 1, len do
		tbl[i] = value
	end

	return tbl
end

return ext_table
