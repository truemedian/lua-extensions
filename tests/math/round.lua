local math = require('libs.math')
local round = math.round

describe('ext_math.round', function()
	test('with simple values', function()
		assert.equal(42.1, round(42.069, 1))
		assert.equal(6, round(5.5))
		assert.equal(3, round(3.49))
	end)

	test('(+/- math.pi)', function()
		assert.equal(3.14, round(math.pi, 2))
		assert.equal(-3.14, round(-math.pi, 2))
	end)

	test('(+/- math.min_normal)', function()
		assert.equal(0, round(math.min_normal))
		assert.equal(0, round(-math.min_normal))
	end)

	test('(+/- math.max_normal)', function()
		assert.equal(math.max_normal, round(math.max_normal))
		assert.equal(-math.max_normal, round(-math.max_normal))
	end)
end)
