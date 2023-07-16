local math = require('libs.math')
local root, isnan = math.root, math.isnan
local inf, epsilon = math.huge, math.epsilon

describe('ext_math.root', function()
	local tolerance = math.sqrt(epsilon)
	test('with whole squared and cubic roots', function()
		assert.equal(4, root(16, 2))
		assert.near(4, root(64, 3), tolerance)
		assert.equal(0, root(0, 2))
	end)

	test('with negative inputs/outputs', function()
		assert.near(-4, root(-64, 3), tolerance)
		assert.equal(.5, root(16, -4))
	end)

	test('with NaN outputs', function()
		assert.truthy(isnan(root(9, 0)))
		assert.truthy(isnan(root(0, 0)))
		assert.equal(inf, root(0, -3))
		assert.truthy(isnan(root(-16, 2)))
		assert.truthy(isnan(root(-math.max_normal, -4)))
		assert.truthy(isnan(root(-math.min_subnormal, -4)))
	end)

	test('with +/- inf', function()
		assert.equal(inf, root(inf, 2))
		assert.equal(0, root(inf, -2))
		assert.equal(inf, root(inf, 3))
		assert.equal(0, root(inf, -3))

		assert.equal(inf, root(inf, math.max_normal))
		assert.equal(0, root(inf, -math.max_normal))
		assert.equal(inf, root(inf, math.min_subnormal))
		assert.equal(0, root(inf, -math.min_subnormal))
	end)

	test('cubic with floating points', function()
		tolerance = 0.000001
		assert.near(0.584804, root(0.2, 3), tolerance)
		assert.near(0.962728, root(0.8923, 3), tolerance)
		assert.near(1.144714, root(1.5, 3), tolerance)
		assert.near(3.345676, root(37.45, 3), tolerance)
		assert.near(49.748501, root(123123.234375, 3), tolerance)
	end)
end)
