local shift = require('libs.table').shift

local function cp(tbl)
	local new_tbl = {}
	for k, v in pairs(tbl) do
		new_tbl[k] = v
	end
	return new_tbl
end

local function init(j)
	local tbl = {}
	for i = 1, j do
		tbl[i] = i
	end
	return tbl
end

local function expect(tbl, i, count)
	local exp_tbl = {}
	for ii = 1, #tbl do
		if ii >= i then
			exp_tbl[ii + count] = ii
		else
			exp_tbl[ii] = ii
		end
	end
	return exp_tbl
end

describe('ext_table.shift', function ()
	test('with count 0', function ()
		local tbl = init(3)
		local exp_tbl = cp(tbl)
		assert.same(exp_tbl, shift(tbl, 1, 0))
		assert.same(exp_tbl, shift(tbl, 0, 0))
		assert.same(exp_tbl, shift(tbl, -3, 0))
	end)

	test('with empty table', function ()
		local tbl = {}
		local exp_tbl = {}
		assert.same(exp_tbl, shift(tbl, 1, 3))
		assert.same(exp_tbl, shift(tbl, 7, 2))
		assert.same(exp_tbl, shift(tbl, 0, 0))
		assert.same(exp_tbl, shift(tbl, -3, 0))
		assert.same(exp_tbl, shift(tbl, -3, -2))
	end)

	-- in case of an index that is outside the array's size
	-- nothing should happen
	test('with out of range index', function ()
		local tbl = init(16)
		assert.same(tbl, shift(cp(tbl), 17, 3))
		assert.same(tbl, shift(cp(tbl), 2^52, 3))
		assert.same(tbl, shift(cp(tbl), 2^52, 2^52))
	end)

	test('with {1, 2, ..., 16} for last element', function ()
		local tbl = init(16)
		assert.same(expect(tbl, 16, 3), shift(cp(tbl), 16, 3))
		assert.same(expect(tbl, 16, 1), shift(cp(tbl), 16, 1))
	end)

	test('with {1, 2, ..., 32}', function ()
		local tbl = init(32)
		assert.same(expect(tbl, 1, 16), shift(cp(tbl), 1, 16))
		assert.same(expect(tbl, 12, 1), shift(cp(tbl), 12, 1))
		assert.same(expect(tbl, 16, 32), shift(cp(tbl), 16, 32))
		assert.same(expect(tbl, 32, 32), shift(cp(tbl), 32, 32))
	end)

	test('with {1}', function ()
		local tbl = init(1)
		assert.same(expect(tbl, 1, 16), shift(cp(tbl), 1, 16))
		assert.same(expect(tbl, 0, 3), shift(cp(tbl), 0, 3))
		assert.same(cp(tbl), shift(cp(tbl), 2, 10))
	end)

	-- TODO: may want to make tests for negative count
	-- TODO: define the behavior of index = 0
	-- TODO: define what happens with integer inputs
end)
