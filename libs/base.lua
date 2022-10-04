---Extensions to the Lua standard base library.
---@module extensions.base
---@alias ext_base

local ext_base = {}

local function increaseLevel(level)
    if level == 0 then
        return 0
    else
        return (level or 1) + 1
    end
end

---Format a message and then print it.
---@param message any
---@param ... any
function ext_base.printf(message, ...)
    print(string.format(message, ...))
end

---Format a message and then throw an error.
---@param message any
---@param level integer?
---@param ... any
function ext_base.errorf(message, level, ...)
    return error(string.format(message, ...), increaseLevel(level))
end

---Assert a condition, throws an error with a formatted message if it is false.
---@param cond any
---@param message any
---@param level integer?
---@param ... any
function ext_base.assertf(cond, message, level, ...)
    if not cond then
        return error(string.format(message, ...), increaseLevel(level))
    else
        return cond, message, level, ...
    end
end

return ext_base
