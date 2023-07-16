local slice = require('libs.table').slice

local function gen(start, finish, step)
	local tbl = {}
	for i = start, finish, step or 1 do
		tbl[i] = i
	end
	return tbl
end

local function expect(start, finish, step)
	local tbl = {}
	for i = 1, finish - start + 1, step or 1 do
		tbl[#tbl + 1] = start + i - 1
	end
	return tbl
end

describe('ext_table.move', function ()
	test('without step', function ()
		assert.same(expect(4, 8), slice(gen(1, 10), 4, 8))
		assert.same(expect(-10, -5), slice(gen(-10, 10), -10, -5))
		assert.same(expect(1, 5), slice(gen(1, 5), 1, 10))
		assert.same(expect(1, 5), slice(gen(1, 5), -10, 10))
		assert.same(expect(1, 10), slice(gen(1, 10), 1, 10))
	end)
	test('with step', function ()
		assert.same(expect(4, 8, 2), slice(gen(1, 10), 4, 8, 2))
		assert.same(expect(-10, -5, 5), slice(gen(-10, 10), -10, -5, 5))
		assert.same(expect(1, 5), slice(gen(1, 5), 1, 10, 1))
		assert.same(expect(10, 1), slice(gen(10, 1), 10, 1, -1))
	end)
	test('with range [end, start]', function ()
		local tbl = {-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5}
		local exp = {5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5}
		assert.same(exp, slice(tbl, 11, 1, -1))
	end)
	-- TODO: decide if this should be undefined behavior
	-- or define it as the following
	-- test('with holes', function ()
	-- 	local tbl = gen(1, 10)
	-- 	tbl[3], tbl[4] = nil, nil
	-- 	assert.same({1, 2, nil, nil, 5}, slice(tbl, 1, 5))
	-- end)
end)
