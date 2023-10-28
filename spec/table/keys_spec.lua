local keys = require('libs.table').keys

describe('ext_table.keys', function()
	local tbl = {[1] = 1, [math.pi] = math.pi, ['str'] = 'str', [{}] = {}, [false] = false}

	-- the following two tests depend on each other to succeed
	-- as such, group them together
	describe('', function()
		local result = keys(tbl)
		local map = {}

		test('if all returned keys actually exist in input table', function()
			for i = 1, #result do
				assert.is_not_nil(tbl[result[i]])
				map[result[i]] = true
			end
		end)
		test('if all table keys have been returned in the output', function()
			for key in pairs(tbl) do
				assert.is_not_nil(map[key])
			end
		end)
	end)
end)
