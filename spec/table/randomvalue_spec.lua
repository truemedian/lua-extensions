local randomvalue = require('libs.table').randomvalue

describe('ext_table.randomvalue', function()
	local tbl = {}
	for i = 1, 1000 do
		tbl[i] = i
	end

	it('returns values from both sequence and map portions', function()
		assert.equal(false, randomvalue({false}))
		assert.equal(false, randomvalue({foo = false}))
	end)
	it('returns nil on an empty table', function()
		assert.is_nil(randomvalue({}))
	end)
	test('if returned value exists in the table', function()
		local v = randomvalue(tbl)
		assert.equal(v, tbl[v]) -- the value is also the key
	end)
	it('does not always pick the same value', function()
		local equal = true
		local v = randomvalue(tbl)
		for _ = 1, 1000 do
			if v ~= randomvalue(tbl) then
				equal = false
				break
			end
		end
		assert.is_false(equal)
	end)
end)
