local errorf = require('libs.base').errorf

describe('ext_base.errorf', function()
	local _ = require('luassert.match')._
	test('raises an error', function()
		assert.has_error(function()
			errorf('test')
		end, 'test')
	end)

	test('passes expected values to string.format', function()
		local msg, arg = 'test %s', 'errorf'
		local formatted_msg = msg:format(arg)

		assert.has_error(function()
			errorf(msg, nil, arg)
		end, formatted_msg)
	end)

	test('increases error level', function()
		spy.on(_G, 'error')

		local index = 1
		assert.errors(function()
			errorf('', index)
		end)
		assert.spy(error).called_with(_, index + 1)

		error:revert()
	end)
end)
