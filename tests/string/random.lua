local random = require('libs.string').random

describe('ext_string.random', function ()
    test('returns the correct string size', function ()
		assert.equal(10, #random(10))
		assert.equal(10, #random(10, 1))
		assert.equal(10, #random(10, nil, 100))
		assert.equal(10, #random(10, 1, 100))
	end)
end)
