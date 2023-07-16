local patternescape = require('libs.string').patternescape

describe('ext_string.patternescape', function()
	it('fully escapes a pattern', function()
		local patt = '^$()%.[]*+-?'
		local expected_rtn = '%^%$%(%)%%%.%[%]%*%+%-%?'
		assert.equal(expected_rtn, patternescape(patt))
	end)
end)
