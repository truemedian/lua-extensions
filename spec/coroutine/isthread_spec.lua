local isthread = require('libs.coroutine').isthread

describe('ext_coro.isthread', function()
	test('inside a coroutine', function()
		coroutine.wrap(function()
			assert.truthy(isthread())
		end)()
	end)

	test('inside the default thread', function()
		local _, running = coroutine.running()
		assert.equal(not running, isthread())
	end)
end)
