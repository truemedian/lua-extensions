local isnan = require('libs.math').isnan

describe('ext_math.isnan', function()
	spec('(nan)', function()
		assert.truthy(isnan(0 / 0))
	end)
	spec('(1)', function()
		assert.falsy(isnan(1))
	end)
	spec('(+/- inf)', function()
		assert.falsy(isnan(math.huge))
		assert.falsy(isnan(-math.huge))
	end)
end)
