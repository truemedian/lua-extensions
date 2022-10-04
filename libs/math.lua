---Extensions to the Lua standard math library.
---@module extensions.math
---@alias ext_math

local ext_math = {}

for k, v in pairs(math) do
	ext_math[k] = v
end

---A value that is never equal to itself.
---@see isnan
ext_math.nan = 0 / 0

---Euler's number. This is the base of the natural logarithm.
ext_math.e = math.exp(1)

---Returns `num` clamped to [minValue, maxValue].
---@param num number
---@param minValue number
---@param maxValue number
---@return number
function ext_math.clamp(num, minValue, maxValue)
	return math.min(math.max(num, minValue), maxValue)
end

---Returns `num` rounded normally to `precision` decimals of precision.
---@param num number
---@param[opt] precision number
---@return number
function ext_math.round(num, precision)
	local m = 10 ^ (precision or 0)
	return math.floor(num * m + 0.5) / m
end

---Returns -1 for a negative number, 1 for a positive number and 0 for 0.
---@param n number
---@return number
function ext_math.sign(n)
	return n > 0 and 1 or n == 0 and 0 or -1
end

---Returns the cube root of `n`.
---@param n number
---@return number
function ext_math.cbrt(n)
	return n ^ (1 / 3)
end

---Returns the `n`th root of `x`.
---@param x number
---@param n number
---@return number
function ext_math.root(x, n)
    if n == 0 then
        return 1
    elseif x < 0 then
		return ext_math.nan
	end

	return x ^ (1 / n)
end

---Returns true if `n` is nan.
---@param n number
---@return boolean
function ext_math.isnan(n)
	return n ~= n
end

return ext_math
