local isempty = require('libs.table').isempty

describe('ext_table.isempty', function()
	it('returns true on empty table', function()
		assert.is_true(isempty({}))
	end)
	it('returns false on non-empty table', function()
		assert.is_false(isempty({[1] = 1, [math.pi] = math.pi, ['str'] = 'str', [{}] = {}, [false] = false}))
		assert.is_false(isempty({[255] = 0 / 0}))
	end)
end)
