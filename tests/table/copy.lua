local copy = require('libs.table').copy

describe('ext_table.copy', function ()
	local tbl = {layer = {}}
	local exp_tbl = {
		[-6] = 'nine',
		[-1] = coroutine.create(copy),
		[0] = 0,
		1,
		2,
		[math.pi] = 'pi',
		foo = 'bar',
		[false] = true,
		[coroutine.create(copy)] = copy,
		[tbl] = tbl,
	}

	test('', function ()
		assert.same(exp_tbl, copy(exp_tbl))
		assert.same({}, copy({}))
		-- make sure it is not a deep copy
		assert.equal(tbl, copy(exp_tbl)[tbl])
		assert.equal(tbl.layer, copy(exp_tbl)[tbl].layer)
	end)
end)
