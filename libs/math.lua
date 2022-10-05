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

---The machine epsilon, an upper bound on the relative error due to rounding.
ext_math.epsilon = 2 ^ -52

---The largest representable number
ext_math.max_normal = (2 - 2 ^ -52) * 2 ^ 1023

---The smallest normal representable number
ext_math.min_normal = 2 ^ -1022

---The smallest subnormal representable number
ext_math.min_subnormal = 2 ^ -1074

if 2 ^ 24 + 1 == 2 ^ 24 then
	-- 32 bit float
	ext_math.epsilon = 2 ^ -23

	ext_math.max_normal = (2 - 2 ^ -23) * 2 ^ 127

	ext_math.min_normal = 2 ^ -126

	ext_math.min_subnormal = 2 ^ -149
end

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
	if n > 0 then
		return 1
	elseif n < 0 then
		return -1
	else
		return 0
	end
end

---Returns the cube root of `n`.
---@param n number
---@return number
function ext_math.cbrt(n)
	return n ^ (1 / 3)
end

---Returns the real `base`th root of `n`. This extends the root function to
---`n < 0` for odd bases.
---@usage math.root(-8, 3) -- -2
---@usage math.root(-4, 2) -- nan
---@param n number
---@param base number
---@return number
function ext_math.root(n, base)
	if base == 0 then
		return ext_math.nan
	end

	if n < 0 then
		if base % 2 == 0 then
			return ext_math.nan
		else
			return -(-n) ^ (1 / base)
		end
	else
		return n ^ (1 / base)
	end
end

---Returns the principal `base`th root of `n`.
---@usage math.root(-8, 3) -- nan
---@usage math.root(8, 3) -- 2
---@param n number
---@param base number
---@return number
function ext_math.proot(n, base)
	if base == 0 or n < 0 then
		return ext_math.nan
	end

	return n ^ (1 / base)
end

---Returns true if `n` is nan.
---@param n number
---@return boolean
function ext_math.isnan(n)
	return n ~= n
end

---Performs an approximate comparison of two numbers.
---
---Tolerance may be left nil to use the default value of `math.epsilon`, a very
---small value. The tolerance should never be larger than small multiple of
---`math.epsilon`
---
---This function is recommended for comparing small values near zero; using
---`approxeqrel` is suggested otherwise.
---@param a number
---@param b number
---@param[opt] tolerance number
function ext_math.approxeqabs(a, b, tolerance)
	tolerance = tolerance or ext_math.epsilon

	-- quick path to handle infinities, signed zeroes and nans
	if a == b then
		return true
	end

	return math.abs(a - b) <= tolerance
end

---Performs an approximate comparison of two numbers.
---
---Tolerance may be left nil to use the default value of `sqrt(math.epsilon)`,
---which means half of the digits are equal.
---
---Note that for comparisons of small numbers around zero this function won't
---give meaningful results, use `approxeqabs` instead.
---@param a number
---@param b number
---@param[opt] tolerance number
function ext_math.approxeqrel(a, b, tolerance)
	tolerance = tolerance or math.sqrt(ext_math.epsilon)

	-- quick path to handle infinities, signed zeroes and nans
	if a == b then
		return true
	end

	return math.abs(a - b) <= math.max(math.abs(a), math.abs(b)) * tolerance
end

return ext_math
