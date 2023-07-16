local makeset = require('libs.table').makeset

describe('ext_table.makeset', function()
	local foo = {}
	local tbl = {[1] = 1, [math.pi] = math.pi, ['str'] = 'str', [foo] = foo, [false] = false}

	local result = makeset(tbl)
	test('if all input values are keys in the output', function()
		for _, value in pairs(tbl) do
			assert.is_not_nil(result[value])
		end
	end)
	test('if all keys in the output are values in the input', function()
		for key in pairs(result) do
			assert.is_not_nil(tbl[key])
		end
	end)
end)
