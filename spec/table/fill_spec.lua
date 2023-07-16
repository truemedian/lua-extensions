local fill = require('libs.table').fill

local function expect(...)
	local p, args = 0, {...}
	local tbl = {}
	while true do
		for i = args[2 + p], args[3 + p] do
			tbl[i] = args[1 + p]
		end
		p = p + 3
		if not args[1 + p] then
			break
		end
	end
	return tbl
end

describe('ext_table.fill', function()
	test('positive start', function()
		assert.same(expect(true, 1, 5), fill({}, true, 5, 1))
		assert.same(expect(false, 1, 256), fill({}, false, 256))
		assert.same({}, fill({}, nil, 256, 1))
		assert.same(expect(1, 1, 4, '.', 5, 10), fill({1, 1, 1, 1}, '.', 6, 5))
		assert.same(expect(true, -1, -1, 0, 1, 5), fill({[-1] = true}, 0, 5, 1))
		assert.same({}, fill({1, false, true}, nil))
		assert.same(expect(true, 1, 5), fill({1, false, true, '', 0}, true))
		assert.same(expect(true, 1, 10), fill({1, false, true, '', 0}, true, 10))
		assert.same(expect(0, 1, 2, 1, 3, 5, 0, 6, 7), fill({0, 0, 0, 0, 0, 0, 0}, 1, 3, 3))
	end)
	test('negative start', function()
		assert.same(expect(0, -5, -1), fill({}, 0, 5, -5))
		assert.same(expect(0, -5, 5), fill({}, 0, 11, -5))
	end)
end)
