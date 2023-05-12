local math = require('libs.math')
local nan, inf = 0 / 0, 1 / 0
local min_value = math.min_normal
local approxeqrel = math.approxeqrel

describe('ext_math.approxeqrel', function()
	test('((64 ^ (1 / 3), 4)', function()
		assert.truthy(approxeqrel((64 ^ (1 / 3)), 4))
	end)

	test('(1, 1)', function()
		assert.truthy(approxeqrel(1, 1))
	end)

	test('(1, 0)', function()
		assert.falsy(approxeqrel(1, 0))
	end)

	test('(1, nan)', function()
		assert.falsy(approxeqrel(1, nan))
	end)

	test('(nan, nan)', function()
		assert.falsy(approxeqrel(nan, nan))
	end)

	test('(inf, inf)', function()
		assert.truthy(approxeqrel(inf, inf))
	end)

	test('(+/-math.min_normal, +/-math.min_normal)', function()
		assert.truthy(min_value, min_value)
		assert.truthy(-min_value, -min_value)
	end)
end)
