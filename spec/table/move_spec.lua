local move = require('libs.table').move

describe('ext_table.move', function()
	local exp = {1, 2, 3, 4, 5}

	test('basic move to copy 2 elements', function()
		local a = {1, 2, 3, 4, 5}
		local result = move(a, 2, 3, 6)
		assert.same({1, 2, 3, 4, 5, 2, 3}, result)
		assert.equal(a, result)
	end)
	test('basic a to b move', function()
		local a = {1, 2, 3, 4, 5}
		local b = {9, 8, 7}
		local result = move(a, 1, 5, 1, b)
		assert.same(exp, result)
		assert.equal(b, result)
	end)
	test('overriding left-end of b', function()
		local a = {1, 2, 3}
		local b = {9, 8, 7, 4, 5}
		assert.same(exp, move(a, 1, 3, 1, b))
	end)
	test('overriding right-end of b', function()
		local a = {3, 4, 5}
		local b = {1, 2, 7, 8, 9}
		assert.same(exp, move(a, 1, 3, 3, b))
	end)
end)
