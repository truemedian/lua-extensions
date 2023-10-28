local math = require('libs.math')
local proot, isnan = math.proot, math.isnan
local tolerance = math.sqrt(math.epsilon)

describe('ext_math.proot', function()
	spec('of (16, 2), (64, 3), (0, 2)', function()
		assert.equal(4, proot(16, 2))
		assert.near(4, proot(64, 3), tolerance)
		assert.equal(0, proot(0, 2))
	end)
	spec('of (12.7342, 0), (-4, 2), (-16, -2) should be NaN', function()
		assert.truthy(isnan(proot(12.7342, 0)))
		assert.truthy(isnan(proot(-4, 2)))
		assert.truthy(isnan(proot(-4, 2)))
	end)
end)
