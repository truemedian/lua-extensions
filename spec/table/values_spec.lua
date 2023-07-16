local values = require('libs.table').values

describe('ext_table.values', function()
	local tbl = {[1] = 1, [math.pi] = math.pi, ['str'] = 'str', [false] = false}

	it('returns all table values', function()
		local result = values(tbl)
		local map = {}
		for i = 1, #result do
			assert.is_not_nil(tbl[result[i]])
			map[result[i]] = true
		end
		for _, value in pairs(tbl) do
			assert.is_not_nil(map[value])
		end
	end)
end)
