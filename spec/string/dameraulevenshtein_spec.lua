local dameraulevenshtein = require('libs.string').dameraulevenshtein

describe('ext_string.levenshtein', function ()
	local str = 'foo bar'

	test('for insertion, deletion and substitution', function ()
		assert.equal(3, dameraulevenshtein(str, 'faf bor'))
		assert.equal(5, dameraulevenshtein(str, 'foo over bar'))
		assert.equal(3, dameraulevenshtein(str, 'o ar'))
		assert.equal(4, dameraulevenshtein(str, 'boo r '))
		assert.equal(0, dameraulevenshtein(str, str))
		assert.equal(0, dameraulevenshtein('', ''))
		assert.equal(#str, dameraulevenshtein(str, ''))
	end)

	test('for transposition', function ()
		assert.equal(1, dameraulevenshtein(str, 'foo bra'))
		assert.equal(2, dameraulevenshtein(str, 'ofo abr'))
		assert.equal(4, dameraulevenshtein(str, 'ofoc ab'))
	end)
end)
