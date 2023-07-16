local search = require('libs.table').search

describe('ext_table.search', function ()
	local foo = {}
	local tbl = {
		str = 'str',
		[2] = 2,
		[foo] = foo,
		[true] = false,
	}

	test('for a string value', function ()
		assert.equal('str', search(tbl, 'str'))
	end)
	test('for a numerical value', function ()
		assert.equal(2, search(tbl, 2))
	end)
	test('for a table value', function ()
		assert.equal(foo, search(tbl, foo))
	end)
	test('for a boolean value', function ()
		assert.equal(true, search(tbl, false))
	end)
	test('returns nil for non-existent values', function ()
		assert.equal(nil, search(tbl, math.pi))
		assert.equal(nil, search(tbl, nil))
	end)
end)
