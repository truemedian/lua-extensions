local split = require('libs.string').split

describe('ext_string.split', function()
	local str = 'Foo.bar7@example.com'

	test('with pattern delimiter', function()
		assert.same({'Foo', 'bar7', 'example', 'com'}, split(str, '%p'))
		assert.same({'Foo.bar', '@example.com'}, split(str, '%d'))
		assert.same({'Foo.bar', 'example.com'}, split(str, '%d%p'))
		local empty_str = {}
		for i = 1, #str + 1 do
			empty_str[i] = ''
		end
		assert.same(empty_str, split(str, '.'))
	end)

	test('with plain delimiter', function()
		assert.same({'Foo.bar7', 'example.com'}, split(str, '@', true))
		assert.same({'Foo', 'bar7@example', 'com'}, split(str, '.', true))

		assert.same({'Foo.', '7@example.com'}, split(str, 'bar', true))
		assert.same({'Foo.bar7@example', ''}, split(str, '.com', true))
	end)

	test('with empty string delimiter', function()
		local chars = {}
		for i = 1, #str do
			chars[i] = str:sub(i, i)
		end
		assert.same(chars, split(str, ''))
	end)
end)
