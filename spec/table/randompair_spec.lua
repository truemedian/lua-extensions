local randompair = require('libs.table').randompair

describe('ext_table.randompair', function()
	local tbl = {}
	for i = 1, 1000 do
		tbl[tostring(i)] = i
	end

	test('if the returned pair exists in the passed table', function()
		local k, v = randompair(tbl)
		assert.equal(v, tbl[k])
	end)
	it('returns nil on empty table', function()
		local k, v = randompair({})
		assert.is_nil(k)
		assert.is_nil(v)
	end)
	it('returns the pair from the sequence portion too', function()
		local k, v = randompair({false})
		assert.equal(1, k)
		assert.equal(false, v)
	end)
	it('does not always return the same pair', function()
		local equal = true
		local k = (randompair(tbl))
		for _ = 1, 1000 do
			if k ~= (randompair(tbl)) then
				equal = false
				break
			end
		end
		assert.is_false(equal)
	end)
end)
