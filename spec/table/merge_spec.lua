local merge = require('libs.table').merge

describe('ext_table.merge', function()
	local a = {a = 'foobar', c = true, [true] = false}
	local b = {a = 'abcdef', [true] = true, [math.pi] = 3}
	local expected, b_copy = {}, {}
	for k, v in pairs(a) do
		expected[k] = v
	end
	for k, v in pairs(b) do
		expected[k] = v
		b_copy[k] = v
	end

	local rtn = merge(a, b)

	it('returns expected value', function()
		assert.same(expected, rtn)
	end)
	it('does not change the b argument', function()
		assert.same(b, b_copy)
	end)
	it('returns the a argument', function()
		assert.equal(rtn, a)
	end)
end)
