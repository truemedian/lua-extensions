local isnan = require('libs.math').isnan

describe('ext_math.isnan', function()
	test('(nan)', function()
		assert.truthy(isnan(0 / 0))
	end)

	test('(1)', function()
		assert.falsy(isnan(1))
	end)

	test('(+/- inf)', function()
		assert.falsy(isnan(math.huge))
		assert.falsy(isnan(-math.huge))
	end)
end)
