---Extensions to the Lua standard coroutine library.
---@module extensions.coroutine
---@alias ext_coro
local pack = table.pack
local resume, running = coroutine.resume, coroutine.running
local traceback = debug.traceback

local function pack_vararg(success, err, ...)
	return success, err, pack(...)
end

local ext_coro = {}

for k, v in pairs(coroutine) do
	ext_coro[k] = v
end

---Properly asserts a coroutine resume in order to get the correct traceback on error. Consumes the first return from resume (the success boolean)
---and returns the rest.
---@param thread thread
---@param[opt] ... any
---@return ...
function ext_coro.assertresume(thread, ...)
	local success, err, args = pack_vararg(resume(thread, ...))
	if not success then
		error(traceback(thread, err), 0)
	end

	return err, unpack(args, 1, args.n)
end

---Returns whether or not the function was run inside of a coroutine. Returns false if it is on the main thread.
---@return boolean
function ext_coro.isthread()
	return not select(2, running())
end

return ext_coro
