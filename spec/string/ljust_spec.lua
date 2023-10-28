local ljust = require('libs.string').ljust

describe('ext_string.ljust', function()
	local str = 'test'
	local str_len = #str

	test('with spaces', function()
		assert.equal(str .. string.rep(' ', str_len), ljust(str, str_len * 2))
		assert.equal(str, ljust(str, str_len))
		assert.equal(str, ljust(str, str_len / 2))
	end)

	test('with pattern', function()
		local patt = '123'
		assert.equal(str .. patt, ljust(str, str_len + #patt, patt))
		assert.equal(str .. patt:rep(3), ljust(str, str_len + #patt * 3, patt))

		assert.equal(str, ljust(str, str_len, patt))
		assert.equal(str, ljust(str, str_len / 2, patt))
		assert.equal(str, ljust(str, str_len + #patt / 2, patt))
	end)
end)
