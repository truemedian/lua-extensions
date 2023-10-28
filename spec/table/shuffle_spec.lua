local shuffle = require('libs.table').shuffle

describe('ext_table.shuffle', function()
	local tbl = {}
	local org_tbl = {}
	for i = 1, 1000 do
		tbl[i], org_tbl[i] = i, i
	end
	local rtn = shuffle(tbl)

	it('returns the passed table', function()
		assert.equal(tbl, rtn)
	end)
	it('shuffles the table (the table does not equal itself before shuffling)', function()
		assert.are_not_same(tbl, org_tbl)
	end)
	test('if the size of the shuffled table hasn\'t changed', function()
		assert.equal(#org_tbl, #tbl)
	end)
end)
