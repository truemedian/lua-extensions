local swapremove = require('libs.table').swapremove

describe('ext_table.swapremove', function ()
	test('first element', function ()
		local t = {true, 1, 2, false}
		assert.equal(t[1], swapremove(t, 1))
		assert.same({false, 1, 2, false}, t)
	end)
	test('last element', function ()
		local t = {1, 2, 3}
		assert.equal(t[#t], swapremove(t, 3))
		assert.same({1, 2, 3}, t)
	end)
end)


