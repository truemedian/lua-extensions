local reverse = require('libs.table').reverse

describe('ext_table.reverse', function ()
	local template = {false, true, -1, 0, 'a', 'b', {}}
	local tbl, exp_tbl = nil, {{}, 'b', 'a', 0, -1, true, false}

	before_each(function ()
		tbl = {}
		for i, v in ipairs(template) do
			tbl[i] = v
		end
	end)

	test('with no dest', function ()
		local rtn = reverse(tbl)
		assert.same(exp_tbl, rtn)
		assert.equal(rtn, tbl)
	end)

	test('with dest', function ()
		local dest = {}
		local rtn = reverse(tbl, dest)
		assert.same(exp_tbl, rtn)
		assert.equal(rtn, dest)
		assert.are_not_equal(tbl, rtn)
	end)

	-- TODO: what should the behavior of passing tbl to dest be?
	-- test('with dest as the table', function ()
	-- 	local rtn = reverse(tbl, tbl)
	-- 	assert.same(exp_tbl, rtn)
	-- end)
end)
