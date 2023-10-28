local rjust = require('libs.string').rjust

describe('ext_string.rjust', function()
	local str = 'test'
	local str_len = #str

	test('with spaces', function()
		assert.equal(string.rep(' ', str_len) .. str, rjust(str, str_len * 2))
		assert.equal(str, rjust(str, str_len))
		assert.equal(str, rjust(str, str_len / 2))
	end)

	test('with pattern', function()
		local patt = '123'
		assert.equal(patt .. str, rjust(str, str_len + #patt, patt))
		assert.equal(patt:rep(3) .. str, rjust(str, str_len + #patt * 3, patt))

		assert.equal(str, rjust(str, str_len, patt))
		assert.equal(str, rjust(str, str_len / 2, patt))
		assert.equal(str, rjust(str, str_len + #patt / 2, patt))
	end)
end)
