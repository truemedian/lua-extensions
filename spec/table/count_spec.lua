local count = require('libs.table').count

describe('ext_table.count', function ()
	local tbl = {layer = {}}
	local exp_tbl = {
		[-6] = 'nine',
		[-1] = coroutine.create(count),
		[0] = 0,
		1,
		2,
		[math.pi] = 'pi',
		foo = 'bar',
		[false] = true,
		[coroutine.create(count)] = count,
		[tbl] = tbl,
	}
	exp_tbl.exp_tbl = exp_tbl

	test('counting a sequence', function ()
		assert.equal(5, count({1, 2, "a", "b", false}))
	end)
	test('counting a sequence that contains holes', function ()
		assert.equal(3, count({1, nil, nil, false, nil, nil, nil, nil, 'foo'}))
	end)
	test('counting a map', function ()
		assert.equal(11, count(exp_tbl))
	end)
	test('counting an empty table', function ()
		assert.equal(0, count({}))
	end)
end)
