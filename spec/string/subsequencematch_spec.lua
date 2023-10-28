local subsequencematch = require('libs.string').subsequencematch

describe('ext_string.subsequencematch', function()
	local str = 'foo bar'

	it('returns expected value', function()
		assert.truthy(subsequencematch('foo', str))
		assert.truthy(subsequencematch('bar', str))
		assert.truthy(subsequencematch(str, str))
		assert.truthy(subsequencematch(str, 'foo over bar'))
		assert.truthy(subsequencematch('foobar', str))
		assert.truthy(subsequencematch('o', str))
		assert.truthy(subsequencematch('', str))

		assert.falsy(subsequencematch('.', str))
		assert.falsy(subsequencematch(str:reverse(), str))
		assert.falsy(subsequencematch('bar foo', str))
	end)
end)
