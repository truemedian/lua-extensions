local map = require('libs.table').map

local function maketbl()
	return {
		[-6] = 'nine',
		[-1] = coroutine.create(map),
		[0] = 0,
		1,
		2,
		[math.pi] = 'pi',
		foo = 'bar',
		[false] = true,
		[coroutine.create(map)] = map,
		[{}] = {layer = {}},
	}
end

describe('ext_table.map', function ()
	it('iterates all entries', function ()
		local tbl = maketbl()
		tbl.tbl = tbl
		assert.same(tbl, map(tbl, function (v, k)
			return v, k
		end))
	end)

	test('new keys, keep values', function ()
		local tbl = {
			[-1]	= 'a',
			[0]		= 'b',
			[3]		= 'c',
			[4]		= 'd',
			[5.3]	= 'e',
		}
		local exp_tbl = {}
		for i, v in pairs(tbl) do
			exp_tbl[i + 1] = v
		end
		assert.same(exp_tbl, map(tbl, function (v, k)
			return v, k + 1
		end))
	end)

	test('new values, keep keys', function ()
		local tbl = {
			a	= 1,
			b	= 2,
			c	= 3,
			d	= 4,
		}
		local exp_tbl = {}
		for k, v in pairs(tbl) do
			exp_tbl[k] = v + 1
		end
		assert.same(exp_tbl, map(tbl, function (v)
			return v + 1
		end))
	end)

	test('swap keys with values', function ()
		local tbl = maketbl()
		local exp_tbl = {}
		for k, v in pairs(tbl) do
			exp_tbl[v] = k
		end
		assert.same(exp_tbl, map(tbl, function (v, k)
			return k, v
		end))
	end)
end)
