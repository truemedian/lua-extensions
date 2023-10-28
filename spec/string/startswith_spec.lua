local startswith = require('libs.string').startswith

describe('ext_string.startswith', function()
	test('with plain false', function()
		assert.truthy(startswith('123test', '%d', false))
		assert.falsy(startswith('test', '%d', false))

		assert.truthy(startswith('123@test test', '^%d+%p[a-z]+', false))
		assert.falsy(startswith('test@123 test', '%d+%p[a-z]+', false))
	end)

	test('with plain true', function()
		assert.truthy(startswith('%d', '%d', true))
		assert.falsy(startswith('123', '%d', true))
	end)
end)
