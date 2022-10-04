---Extensions to the Lua standard coroutine library.
---@module extensions.coroutine
---@alias ext_coro

local ext_coro = {}

local function pack_vararg(success, ...)
	return success, { ... }, select('#', ...)
end

for k, v in pairs(coroutine) do
	ext_coro[k] = v
end

---Properly asserts a coroutine resume in order to get the correct traceback on
---error. Consumes the first return from resume (the success boolean)
---and returns the rest.
---@param thread thread
---@param[opt] ... any
---@return ...
function ext_coro.assertresume(thread, ...)
	local success, args, n = pack_vararg(coroutine.resume(thread, ...))
	if not success then
		error(debug.traceback(thread, args[1]), 0)
	end

	return unpack(args, 1, n)
end

---Returns whether or not the function was run inside of a coroutine. Returns
---false if it is on the main thread.
---@return boolean
function ext_coro.isthread()
	return not select(2, coroutine.running())
end

return ext_coro
