local reduce = require('libs.table').reduce

local function addition(prev, val)
	return prev + val
end

describe('ext_table.reduce', function ()
	test('iterates all entries in correct order', function ()
		local tbl = {1, 'a', 'a', 'b', 2, false, {{}}}
		-- note: reduce should not execute the callback for the first entry
		-- when `initial` is not provided
		local iterated = {1, }
		reduce(tbl, function (_, v)
			iterated[#iterated+1] = v
		end)
		assert.same(tbl, iterated)
	end)

	test('iterates all entries in correct order with initial value', function ()
		local tbl = {1, 'a', 'a', 'b', 2, false, {{}}}
		local iterated = {}
		reduce(tbl, function (_, v)
			iterated[#iterated+1] = v
		end, 0)
		assert.same(tbl, iterated)
	end)

	test('with an empty table', function ()
		assert.equal(nil, reduce({}, function() return true end))
		assert.equal(true, reduce({}, function() return false end, true))
	end)

	test('with a single element', function ()
		local tbl = {'foo'}
		assert.equal('foo', reduce(tbl, function() return true end))
		assert.equal('bar', reduce(tbl, function() return 'bar' end, false))
	end)

	test('add up numbers', function ()
		local tbl = {1, 2, 3, 5, 8, 13, 21}
		assert.equal(53, reduce(tbl, addition))
	end)
end)
