local levenshtein = require('libs.string').levenshtein

describe('ext_string.levenshtein', function()
	local str = 'foo bar'

	test('for insertion, deletion and substitution', function()
		assert.equal(3, levenshtein(str, 'faf bor'))
		assert.equal(5, levenshtein(str, 'foo over bar'))
		assert.equal(3, levenshtein(str, 'o ar'))
		assert.equal(4, levenshtein(str, 'boo r '))
		assert.equal(0, levenshtein(str, str))
		assert.equal(0, levenshtein('', ''))
		assert.equal(#str, levenshtein(str, ''))
	end)
end)
