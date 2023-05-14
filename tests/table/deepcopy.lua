local deepcopy = require('libs.table').deepcopy

describe('ext_table.deepcopy', function ()
	local tbl = {layer = {}}
	local exp_tbl = {
		[-6] = 'nine',
		[-1] = coroutine.create(deepcopy),
		[0] = 0,
		1,
		2,
		[math.pi] = 'pi',
		foo = 'bar',
		[false] = true,
		[coroutine.create(deepcopy)] = deepcopy,
		[tbl] = tbl,
	}

	test('', function ()
		assert.same(exp_tbl, deepcopy(exp_tbl))
		assert.same({}, deepcopy({}))
		-- make sure it is a deep copy
		-- the copied tables should not equal the ones in original table
		assert.does_not.equal(tbl, deepcopy(exp_tbl)[tbl])
		assert.does_not.equal(tbl.layer, deepcopy(exp_tbl)[tbl].layer)
	end)
end)
