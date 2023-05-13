local patternescape = require('libs.string').patternescape

describe('ext_string.patternescape', function()
	test('', function()
		local patt = '^$()%.[]*+-?'
		local expected_rtn = '%^%$%(%)%%%.%[%]%*%+%-%?'
		assert.equal(expected_rtn, patternescape(patt))
	end)
end)
