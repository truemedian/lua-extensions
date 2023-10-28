local join = require('libs.table').join

describe('ext_table.join', function()
	it('returns expected value when a and b are empty', function()
		local a, b = {}, {}
		local rtn = join(a, b)
		assert.same({}, rtn)
		assert.equal(rtn, a) -- return is really a?
	end)

	test('if b is unchanged', function()
		local b, b_org = {1, 2, 3}, {1, 2, 3}
		join({}, b)
		assert.same(b, b_org)
	end)

	test('when a is empty', function()
		local a, b = {}, {1, 2, math.pi, 'a', 'b', false, true}
		assert.same(b, join(a, b))
	end)

	test('returns expected value when b is empty', function()
		local a, b = {1, 2, 3}, {}
		local expected = {1, 2, 3}
		assert.same(expected, join(a, b))
	end)

	test('returns expected value when a and b are not empty', function()
		local a, b = {false, 1, math.pi, 'foo'}, {1, 2, math.pi, 'a', 'b', false, true}
		local expected = {}
		do
			for _, v in ipairs(a) do
				table.insert(expected, v)
			end
			for _, v in ipairs(b) do
				table.insert(expected, v)
			end
		end
		assert.same(expected, join(a, b))
	end)

	it('does ignore non-array portion', function()
		local a, b = {}, {a = 1, [false] = true, 1, 2, 3, 4, 5}
		assert.same({1, 2, 3, 4, 5}, join(a, b))
	end)
end)
