local random = require('libs.string').random

local function verify(str, mn, mx)
	local bytes = {string.byte(str, 1, #str)}
	for _, v in ipairs(bytes) do
		if v < mn or v > mx then
			return false
		end
	end
	return true
end

describe('ext_string.random', function ()
    it('returns the correct string size', function ()
		assert.equal(10, #random(10))
		assert.equal(10, #random(10, 1))
		assert.equal(10, #random(10, nil, 100))
		assert.equal(10, #random(10, 1, 100))
	end)
	it('returns characters in the correct range', function ()
		assert.is_true(verify((random(1000)), 0, 255))
		assert.is_true(verify((random(1000, 0, 1)), 0, 1))
		assert.is_true(verify((random(1000, 1, 1)), 1, 1))
		assert.is_true(verify((random(1000, 0, 64)), 0, 64))
	end)
end)
