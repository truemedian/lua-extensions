---A combination of extensions to the Lua standard libraries and other useful utilities for libraries I use.
---@module extensions

-- This initialization module is designed for use in the Luvit environment.
-- It *will* not work elsewhere, however you can still copy the individual
-- extensions from the `libs` directory and they should work.
-- Luvit uses Luajit 2.1, but `table.new` is not included in the stdlib by default
require('table.new')

local extensions = {}
extensions.meta = {}
extensions.math = require('math.lua')
extensions.string = require('string.lua')
extensions.table = require('table.lua')
extensions.coroutine = require('coroutine.lua')

local autoload = {
    math = extensions.math,
    string = extensions.string,
    table = extensions.table,
    coroutine = extensions.coroutine,
}

---Loads the standard library extensions into the global environment. This will **not** overwrite any user-defined functions.
---@usage local extensions = require 'extensions' ()
function extensions.load()
    for name, ext in pairs(autoload) do
        for k, v in pairs(ext) do
            if _G[name][k] == nil then
                _G[name][k] = v
            end
        end
    end
end

function extensions.meta:__call()
    self.load()
    return self
end

setmetatable(extensions, extensions.meta)

return extensions
