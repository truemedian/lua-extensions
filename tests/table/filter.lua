local filter = require('libs.table').filter

describe('ext_table.filter', function ()
	local tbl = {
		[-6] = 'nine',
		[-1] = false,
		[0] = 0,
		1,
		2,
		[math.pi] = 'pi',
		foo = 'bar',
		[false] = true,
		[coroutine.create(filter)] = filter,
		[{}] = {layer = {}},
	}

	test('with true returned for all keys', function ()
		assert.same(tbl, filter(tbl, function ()
			return true
		end))
	end)
	test('with false returned for all keys', function ()
		assert.same({}, filter(tbl, function ()
			return false
		end))
	end)
	test('does iterate all keys', function ()
		local seen = {}
		filter(tbl, function (v, k)
			seen[k] = v
		end)
		assert.same(seen, tbl)
	end)
	test('with true to numeric keys', function ()
		local exp_tbl = {
			[-6] = 'nine',
			[math.pi] = 'pi',
			foo = 'bar',
		}
		assert.same(exp_tbl, filter(tbl, function (v)
			return type(v) == 'string'
		end))
	end)
	test('with true to string values', function ()
		local exp_tbl = {
			[-6] = 'nine',
			[-1] = false,
			[0] = 0,
			1,
			2,
			[math.pi] = 'pi',
		}
		assert.same(exp_tbl, filter(tbl, function (_, k)
			return type(k) == 'number'
		end))
	end)
end)
