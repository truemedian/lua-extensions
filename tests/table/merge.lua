local merge = require('libs.table').merge

local function init_ab()
	local a, b = {
		a = 'foobar',
		c = true,
		[true] = false,
	}, {
		a = 'abcdef',
		[true] = true,
		[math.pi] = 3,
	}
	local expected = {}
	for k, v in pairs(a) do
		expected[k] = v
	end
	for k, v in pairs(b) do
		expected[k] = v
	end
	return a, b, expected
end

describe('ext_table.merge', function ()
	test('', function ()
		local a, b, expected = init_ab()
		local _, b_org = init_ab()
		local rtn = merge(a, b)
		assert.same(expected, rtn)
		assert.same(b, b_org)
		assert.equal(rtn, a)
	end)
end)
