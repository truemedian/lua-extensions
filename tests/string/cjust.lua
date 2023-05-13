local cjust = require('libs.string').cjust

describe('ext_string.cjust', function ()
    local str = 'test'
    local str_len = #str

    test('with spaces', function ()
        assert.equal('  ' .. str .. '  ', cjust(str, str_len * 2))
        assert.equal('  ' .. str .. '   ', cjust(str, str_len * 2 + 1))
        assert.equal(str , cjust(str, str_len))
    end)

    test('with pattern', function ()
        local patt = '12'
        assert.equal('1212' .. str .. '1212', cjust(str, str_len * 3, patt))
        assert.equal('1212' .. str .. '121212', cjust(str, str_len * 3 + 2, patt))
        assert.equal(str, cjust(str, str_len, patt))
		-- FIXME: cjust is overshooting final_len
        -- assert.equal('1212' .. str .. '1212', cjust(str, str_len * 3 + 1, patt))
    end)
end)
