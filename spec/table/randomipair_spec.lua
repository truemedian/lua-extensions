local randomipair = require('libs.table').randomipair

describe('ext_table.randomipair', function ()
	local tbl = {}
	for i = 1, 1000 do
		tbl[i] = i
	end

	test('if the returned pair exists in the passed table', function ()
		local i, v = randomipair(tbl)
		assert.equal(v, tbl[i])
	end)
	it('returns nil on empty sequence portion', function ()
		local i, v = randomipair({})
		assert.is_nil(i)
		assert.is_nil(v)
		i, v = randomipair({foo = 'bar'})
		assert.is_nil(i)
		assert.is_nil(v)
	end)
	it('does not always return the same pair', function ()
		local equal = true
		local n = (randomipair(tbl))
		for _ = 1, 1000 do
			if n ~= (randomipair(tbl)) then
				equal = false
				break
			end
		end
		assert.is_false(equal)
	end)
end)
