local base = require('libs.base')
local enumerateall = base.enumerateall

local function iterateValues(values)
	local i = 0
	return function()
		i = i + 1
		if values[i] then
			return unpack(values[i])
		end
	end
end

describe('ext_base.enumerate', function()
	_G.unpack = table.unpack -- enumerateall expects an unpack global

	test('with a simple pair enumerator', function()
		local tbl = {
			{-1, 1},
			{2, true},
			{
				false,
				function()
				end,
			},
		}
		assert.same(tbl, enumerateall(iterateValues(tbl)))
	end)
end)
