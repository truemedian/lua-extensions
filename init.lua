--- This initialization module is designed for use in the Luvit environment.
--- It *will* not work elsewhere, however you can still copy the individual
--- extensions from the `libs` directory and they should work.
local ext_math = require('math.lua')
local ext_string = require('string.lua')
local ext_table = require('table.lua')

-- Luvit uses Luajit 2.1, but `table.new` is not included in the stdlib by default
require('table.new')

local extensions = {math = ext_math, string = ext_string, table = ext_table}

setmetatable(extensions, {
	__call = function()
		for _, ext in pairs(extensions) do
			ext()
		end
	end,
})

for name, ext in pairs(extensions) do
	setmetatable(ext, {
		__call = function()
			_G[name] = _G[name] or {}

			for k, v in pairs(extensions) do
				_G[name][k] = v
			end
		end,
	})
end

return extensions
