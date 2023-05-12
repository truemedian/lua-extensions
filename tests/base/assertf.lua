local assertf = require('libs.base').assertf

describe('ext_base.assertf', function()
	local _ = require('luassert.match')._
	test('raises an error', function()
		assert.has_error(function()
			assertf(false, 'test')
		end, 'test')
	end)

	test('returns all arguments', function()
		local tbl = {1, {}, 'test', false}
		local rtn = {assertf(table.unpack(tbl))}

		assert.same(rtn, tbl)
	end)

	test('increases error level', function()
		stub(_G, 'error')

		local index = 2
		assertf(false, 'test', index)
		assert.stub(error).called_with('test', index + 1)

		error:revert()
	end)

	test('formats error message properly', function()
		local msg, arg = 'test %s', 'errorf'
		local formatted_msg = msg:format(arg)

		assert.has_error(function()
			assertf(false, msg, nil, arg)
		end, formatted_msg)
	end)
end)
