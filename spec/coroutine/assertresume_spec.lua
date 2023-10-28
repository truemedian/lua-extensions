local assertresume = require('libs.coroutine').assertresume

describe('ext_coro.assertresume', function()
	_G.unpack = table.unpack

	it('resumes and returns correctly', function()
		local co = coroutine.create(function(...)
			return ...
		end)

		local args = {1, 2, false}
		local rtn_args
		assert.no_error(function()
			rtn_args = {assertresume(co, table.unpack(args))}
		end)
		assert.same(args, rtn_args)
	end)

	it('throws an error', function()
		-- note: we are not checking for the error message
		-- since assertresume's error message will
		-- depend on the actual stack traceback
		local co = coroutine.create(error)
		assert.has_error(function()
			assertresume(co, 'test!')
		end)
	end)

	test('throws an error with the correct stack', function()
		local function a()
			error('test!')
		end
		local function b()
			a()
		end
		local function f()
			b()
		end

		-- normally resume the coroutine to get its expected stack traceback
		local co = coroutine.create(f)
		coroutine.resume(co)
		local expected_traceback = debug.traceback(co)

		-- re-create the coroutine but resume it with assertresume this time
		-- and see if we get a matching stack traceback to expected_traceback
		--
		-- note bellow "traceback" is technically the error message
		-- though since assertresume passes the traceback as the message
		-- we have to it this way since we can't just debug.traceback it
		co = coroutine.create(f)
		local success, traceback = pcall(assertresume, co)
		assert.falsy(success) -- just in case

		-- truncate the amount of characters we will be matching against
		-- without the error message
		traceback = traceback:gsub('^.-(stack traceback.+)', '%1'):sub(1, #expected_traceback)

		assert.equal(expected_traceback, traceback)
	end)
end)
