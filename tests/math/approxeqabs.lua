local math = require('libs.math')
local min_value, eps = math.min_normal, math.epsilon
local approxeqabs = math.approxeqabs

describe('ext_math.approxeqabs', function()
	test('(0, 0)', function()
		assert.truthy(approxeqabs(0, 0))
	end)

	test('(-1, -1)', function()
		assert.truthy(approxeqabs(-1, -1))
	end)

	test('(3 * math.epsilon, 1)', function()
		assert.falsy(approxeqabs(3 * eps, 1))
	end)

	test('(1 + math.epsilon, 1)', function()
		assert.truthy(approxeqabs(1 + eps, 1))
	end)

	test('(+/-min_value, 0, math.epsilon * 2)', function()
		assert.truthy(approxeqabs(min_value, 0, eps * 2))
		assert.truthy(approxeqabs(-min_value, 0, eps * 2))
	end)
end)
