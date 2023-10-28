local endswith = require('libs.string').endswith

describe('ext_string.endswith', function()
	test('with plain false', function()
		assert.truthy(endswith('test123', '%d'))
		assert.falsy(endswith('test', '%d', false))

		assert.truthy(endswith('test test@123', '[a-z]+%p%d+$'))
		assert.falsy(endswith('test 123@test', '[a-z]+%p%d+'))
	end)

	test('with plain true', function()
		assert.truthy(endswith('   %d', '%d', true))
		assert.falsy(endswith('   123', '%d', true))
	end)
end)
