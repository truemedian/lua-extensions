local reverse = require('libs.table').reverse

describe('ext_table.reverse', function()
	local template = {false, true, -1, 0, 'a', 'b', {}}
	local tbl, exp_tbl = nil, {{}, 'b', 'a', 0, -1, true, false}

	before_each(function()
		tbl = {}
		for i, v in ipairs(template) do
			tbl[i] = v
		end
	end)

	it('reverses the table in-place when dest is not provided', function()
		local rtn = reverse(tbl)
		assert.same(exp_tbl, rtn)
		assert.equal(rtn, tbl)
	end)
	it('reverses the table into dest when provided', function()
		local dest = {}
		local rtn = reverse(tbl, dest)
		assert.same(exp_tbl, rtn)
		assert.equal(rtn, dest)
		assert.are_not_equal(tbl, rtn)
	end)
	it('ignores dest if it is equal to the table', function()
		-- in this case, it should be treated
		-- as if no dest was passed
		local rtn = reverse(tbl, tbl)
		assert.same(exp_tbl, rtn)
	end)
end)
