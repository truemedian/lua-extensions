local insert = table.insert
local random = math.random

local ext_table = {}

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

---Returns the number of keys in the table by recursively looking into tables.
---@param tbl table
---@return number
function ext_table.deepcount(tbl)
    local n = 0

    for _, v in pairs(tbl) do
        n = type(v) == 'table' and n + ext_table.deepcount(v) or n + 1
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

---Reverses the contents of the array.
---@param tbl table
function ext_table.reverse(tbl)
    local i, n = 1, #tbl

    while i < n do
        tbl[i], tbl[n] = tbl[n], tbl[i]
        i, n = i + 1, n - 1
    end
end

---Returns a new array with the reversed contents of the original.
---@param tbl table
---@return table
function ext_table.reversed(tbl)
    local new = {}

    for i = 1, #tbl do
        new[i] = tbl[#tbl - i + 1]
    end

    return new
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
---@param start? number
---@param stop? number
---@param step? number
---@return table
function ext_table.slice(tbl, start, stop, step)
    local new = {}

    for i = start or 1, stop or #tbl, step or 1 do
        insert(new, tbl[i])
    end

    return new
end

---Works identically to `memcpy` in C. copies all of src into dest starting at index.
---@param dest table
---@param src table
---@param index number
function ext_table.memcpy(dest, src, index)
    index = index - 1

    for i = 1, #src do
        dest[index + i] = src[i]
    end
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
    return not next(tbl)
end

---Returns a random key, value index from an array.
---@param tbl table
---@return any, any
function ext_table.randomipair(tbl)
    local i = random(#tbl)
    return i, tbl[i]
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

return ext_table
