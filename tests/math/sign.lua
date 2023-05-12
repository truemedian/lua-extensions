local math = require('libs.math')
local sign = math.sign

describe('ext_math.sign', function()
	test('with [-1, 0, 1] as inputs', function()
		assert.equal(-1, sign(-1))
		assert.equal(0, sign(0))
		assert.equal(1, sign(1))
	end)

	test('of +/- inf', function()
		assert.equal(1, sign(math.huge))
		assert.equal(-1, sign(-math.huge))
	end)

	test('of +/- math.min_subnormal', function()
		assert.equal(1, sign(math.min_subnormal))
		assert.equal(-1, sign(-math.min_subnormal))
	end)

	test('of +/- math.max_normal', function()
		assert.equal(1, sign(math.max_normal))
		assert.equal(-1, sign(-math.max_normal))
	end)

	-- TODO: See what should be the behavior when passing nan
end)
