local printf = require('libs.base').printf

describe('ext_base.printf', function()
	it('passes the right arguments to string.format', function()
		local msg, arg = 'printf %s', 'test'
		local rtn = msg:format(arg)

		stub(_G, 'print')
		spy.on(string, 'format')
		printf(msg, arg)

		local format = string.format
		assert.spy(format).called_with(msg, arg)
		assert.spy(format).returned_with(rtn)
		assert.spy(print).called_with(rtn)

		format:revert()
		print:revert()
	end)
end)
