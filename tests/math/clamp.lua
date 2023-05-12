local math = require('libs.math')
local clamp = math.clamp

describe('ext_math.clamp', function()
	test('in range [1, 5]', function()
		assert.equal(1, clamp(0, 1, 5))
		assert.equal(3, clamp(3, 1, 5))
		assert.equal(5, clamp(6, 1, 5))
	end)

	test('in negative range [-5, -1]', function()
		assert.equal(-5, clamp(-6, -5, -1))
		assert.equal(-3, clamp(-3, -5, -1))
		assert.equal(-1, clamp(0, -5, -1))
	end)

	test('(+/- inf) in range [1, 2]', function()
		assert.equal(1, clamp(-math.huge, 1, 2))
		assert.equal(2, clamp(math.huge, 1, 2))
	end)
end)
