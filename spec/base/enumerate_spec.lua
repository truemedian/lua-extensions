local base = require('libs.base')
local enumerate = base.enumerate

local function iterateValues(values)
	local i = 0
	return function()
		i = i + 1
		return values[i]
	end
end

describe('ext_base.enumerate', function()
	test('with a simple enumeration', function()
		local tbl = {
			-1,
			1,
			2,
			true,
			false,
			function()
			end,
		}
		local rtn = enumerate(iterateValues(tbl))
		assert.same(tbl, rtn)
	end)
end)
