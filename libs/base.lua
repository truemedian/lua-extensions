---Extensions to the Lua standard base library.
---@module extensions.base
---@alias ext_base

local ext_base = {}

---Format a message and then print it.
---@param message any
---@param ... any
function ext_base.printf(message, ...)
    print(string.format(message, ...))
end

---Format a message and then throw an error.
---@param message any
---@param ... any
function ext_base.errorf(message, ...)
    return error(string.format(message, ...))
end

---Assert a condition, throws an error with a formatted message if it is false.
---@param cond any
---@param message any
---@param ... any
function ext_base.assertf(cond, message, ...)
    if not cond then
        return error(string.format(message, ...))
    else
        return cond, message, ...
    end
end

return ext_base
