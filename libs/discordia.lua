---Extensions to the SinisterRectus's [Discordia](https://github.com/SinisterRectus/Discordia).
---@module extensions.discordia
---@alias ext_discordia
local utf8 = require 'utf8'
local floor = math.floor

local function dkjson_isarray(tbl)
	local max, n, arraylen = 0, 0, 0
	for k, v in pairs(tbl) do
		if k == 'n' and type(v) == 'number' then
			arraylen = v
			if v > max then
				max = v
			end
		else
			if type(k) ~= 'number' or k < 1 or floor(k) ~= k then
				return false, 'non-sequential key: ' .. tostring(k)
			end
			if k > max then
				max = k
			end
			n = n + 1
		end
	end
	if max > 10 and max > arraylen and max > n * 2 then
		return false, 'too many holes' -- don't create an array with too many holes
	end
	return true
end

local ext_discordia = {}

---Validates a Discord message for consumption by Discordia's send function.
---@param message table
---@return boolean
---@error Position and description of what is invalid
function ext_discordia.validate(message)
	local has_content = false

	if message.content ~= nil then
		if type(message.content) ~= 'string' then
			return false, 'message.content: wrong type (expected string or nil, got ' .. type(message.content) .. ')'
		elseif utf8.len(message.content) < 1 then
			return false, 'message.content: too small (' .. utf8.len(message.content) .. ' < 1)'
		elseif utf8.len(message.content) > 256 then
			return false, 'message.content: too large (' .. utf8.len(message.content) .. ' > 256)'
		end

		has_content = true
	end

	if message.embed ~= nil then
		if type(message.embed) ~= 'table' then
			return false, 'message.embed: wrong type (expected table or nil, got ' .. type(message.table) .. ')'
		end

		local valid, why = ext_discordia.validateembed(message.embed, 'message.embed')
		if not valid then
			return false, why
		end

		has_content = true
	end

	if not has_content then
		return false, 'message: must contain one of `content`, `embed`'
	end

	if message.tts ~= nil then
		if type(message.tts) ~= 'boolean' then
			return false, 'message.tts: wrong type (expected boolean or nil, got ' .. type(message.tts) .. ')'
		end
	end

	if message.nonce ~= nil then
		if type(message.nonce) ~= 'number' and type(message.nonce) ~= 'string' then
			return false, 'message.nonce: wrong type (expected string or number or nil, got ' .. type(message.nonce) .. ')'
		end
	end

	return true
end

---Validates a Discord message embed for consumption by Discordia's send function.
---@param embed table
---@return boolean
---@error Position and description of what is invalid
function ext_discordia.validateembed(embed, prefix)
	prefix = prefix or 'embed'
	local total_size = 0

	if embed.title ~= nil then
		if type(embed.title) ~= 'string' then
			return false, prefix .. '.title: wrong type (expected string or nil, got ' .. type(embed.title) .. ')'
		elseif utf8.len(embed.title) < 1 then
			return false, prefix .. '.title: too small (' .. utf8.len(embed.title) .. ' < 1)'
		elseif utf8.len(embed.title) > 256 then
			return false, prefix .. '.title: too large (' .. utf8.len(embed.title) .. ' > 256)'
		end

		total_size = total_size + utf8.len(embed.title)
	end

	if embed.type ~= nil then
		return false, prefix .. '.type: wrong type (expected nil, got ' .. type(embed.type) .. ')'
	end

	if embed.description ~= nil then
		if type(embed.description) ~= 'string' then
			return false, prefix .. '.description: wrong type (expected string or nil, got ' .. type(embed.description) .. ')'
		elseif utf8.len(embed.description) < 1 then
			return false, prefix .. '.description: too small (' .. utf8.len(embed.description) .. ' < 1)'
		elseif utf8.len(embed.description) > 2048 then
			return false, prefix .. '.description: too large (' .. utf8.len(embed.description) .. ' > 2048)'
		end

		total_size = total_size + utf8.len(embed.description)
	end

	if embed.url ~= nil then
		if type(embed.url) ~= 'string' then
			return false, prefix .. '.url: wrong type (expected string or nil, got ' .. type(embed.url) .. ')'
		end
	end

	if embed.timestamp ~= nil then
		-- TODO: validate ISO-8601 (using Discordia?)
		if type(embed.timestamp) ~= 'string' then
			return false, prefix .. '.timestamp: wrong type (expected string or nil, got ' .. type(embed.timestamp) .. ')'
		end
	end

	if embed.color ~= nil then
		if type(embed.color) ~= 'number' then
			return false, prefix .. '.color: wrong type (expected number or nil, got ' .. type(embed.color) .. ')'
		elseif embed.color < 0 then
			return false, prefix .. '.color: too small (' .. embed.color .. ' < 0)'
		elseif embed.color > 16777215 then
			return false, prefix .. '.color: too large (' .. embed.color .. ' > 16777215)'
		end
	end

	if embed.footer ~= nil then
		if type(embed.footer) ~= 'table' then
			return false, prefix .. '.footer: wrong type (expected table or nil, got ' .. type(embed.footer) .. ')'
		end

		if type(embed.footer.text) ~= 'string' then
			return false, prefix .. '.footer.text: wrong type (expected string, got ' .. type(embed.footer.text) .. ')'
		elseif utf8.len(embed.footer.text) < 1 then
			return false, prefix .. '.footer.text: too small (' .. utf8.len(embed.footer.text) .. ' < 1)'
		elseif utf8.len(embed.footer.text) > 2048 then
			return false, prefix .. '.footer.text: too large (' .. utf8.len(embed.footer.text) .. ' > 2048)'
		end

		total_size = total_size + utf8.len(embed.footer.text)

		if embed.footer.icon_url ~= nil then
			if type(embed.footer.icon_url) ~= 'string' then
				return false, prefix .. '.footer.icon_url: wrong type (expected string or nil, got ' .. type(embed.footer.icon_url) .. ')'
			end
		end

		if type(embed.footer.proxy_icon_url) ~= 'nil' then
			return false, prefix .. '.footer.proxy_icon_url: wrong type (expected nil, got ' .. type(embed.footer.proxy_icon_url) .. ')'
		end
	end

	if embed.image ~= nil then
		if type(embed.image) ~= 'table' then
			return false, prefix .. '.image: wrong type (expected table or nil, got ' .. type(embed.image) .. ')'
		end

		if embed.image.url ~= nil then
			if type(embed.image.url) ~= 'string' then
				return false, prefix .. '.image.url: wrong type (expected string or nil, got ' .. type(embed.image.url) .. ')'
			end
		end

		if embed.image.proxy_url ~= nil then
			return false, prefix .. '.image.proxy_url: wrong type (expected nil, got ' .. type(embed.image.proxy_url) .. ')'
		end

		if embed.image.height ~= nil then
			return false, prefix .. '.image.height: wrong type (expected nil, got ' .. type(embed.image.height) .. ')'
		end

		if embed.image.width ~= nil then
			return false, prefix .. '.image.width: wrong type (expected nil, got ' .. type(embed.image.width) .. ')'
		end
	end

	if embed.thumbnail ~= nil then
		if type(embed.thumbnail) ~= 'table' then
			return false, prefix .. '.thumbnail: wrong type (expected table or nil, got ' .. type(embed.thumbnail) .. ')'
		end

		if embed.thumbnail.url ~= nil then
			if type(embed.thumbnail.url) ~= 'string' then
				return false, prefix .. '.thumbnail.url: wrong type (expected string or nil, got ' .. type(embed.thumbnail.url) .. ')'
			end
		end

		if embed.thumbnail.proxy_url ~= nil then
			return false, prefix .. '.thumbnail.proxy_url: wrong type (expected nil, got ' .. type(embed.thumbnail.proxy_url) .. ')'
		end

		if embed.thumbnail.height ~= nil then
			return false, prefix .. '.thumbnail.height: wrong type (expected nil, got ' .. type(embed.thumbnail.height) .. ')'
		end

		if embed.thumbnail.width ~= nil then
			return false, prefix .. '.thumbnail.width: wrong type (expected nil, got ' .. type(embed.thumbnail.width) .. ')'
		end
	end

	if embed.video ~= nil then
		return false, prefix .. '.video: wrong type (expected nil, got ' .. type(embed.video) .. ')'
	end

	if embed.provider ~= nil then
		return false, prefix .. '.provider: wrong type (expected nil, got ' .. type(embed.provider) .. ')'
	end

	if embed.author ~= nil then
		if type(embed.author) ~= 'table' then
			return false, prefix .. '.author: wrong type (expected table or nil, got ' .. type(embed.author) .. ')'
		end

		if embed.author.name ~= nil then
			if type(embed.author.name) ~= 'string' then
				return false, prefix .. '.author.name: wrong type (expected string or nil, got ' .. type(embed.author.name) .. ')'
			elseif utf8.len(embed.author.name) < 1 then
				return false, prefix .. '.author.name: too small (' .. utf8.len(embed.author.name) .. ' < 1)'
			elseif utf8.len(embed.author.name) > 256 then
				return false, prefix .. '.author.name: too large (' .. utf8.len(embed.author.name) .. ' > 256)'
			end
		end

		total_size = total_size + utf8.len(embed.author.name)

		if embed.author.url ~= nil then
			if type(embed.author.url) ~= 'string' then
				return false, prefix .. '.author.url: wrong type (expected string or nil, got ' .. type(embed.author.url) .. ')'
			end
		end

		if embed.author.icon_url ~= nil then
			if type(embed.author.icon_url) ~= 'string' then
				return false, prefix .. '.author.icon_url: wrong type (expected string or nil, got ' .. type(embed.author.icon_url) .. ')'
			end
		end

		if type(embed.author.proxy_icon_url) ~= 'nil' then
			return false, prefix .. '.author.proxy_icon_url: wrong type (expected nil, got ' .. type(embed.author.proxy_icon_url) .. ')'
		end
	end

	if embed.fields ~= nil then
		if type(embed.fields) ~= 'table' then
			return false, prefix .. '.fields: wrong type (expected table or nil, got ' .. type(embed.fields) .. ')'
		end

		local is_array, why = dkjson_isarray(embed.fields)
		if not is_array then
			return false, prefix .. '.fields: not an array (' .. why .. ')'
		end

		if #embed.fields > 25 then
			return false, prefix .. '.fields: too large (' .. #embed.fields .. ' > 25)'
		end

		for i = 1, #embed.fields do
			local field = embed.fields[i]

			if type(field) ~= 'table' then
				return false, prefix .. '.fields[' .. i .. ']: wrong type (expected table, got ' .. type(field) .. ')'
			end

			if type(field.name) ~= 'string' then
				return false, prefix .. '.fields[' .. i .. '].name: wrong type (expected string, got ' .. type(field.name) .. ')'
			elseif utf8.len(field.name) < 1 then
				return false, prefix .. '.fields[' .. i .. '].name: too small (' .. utf8.len(field.name) .. ' < 1)'
			elseif utf8.len(field.name) > 256 then
				return false, prefix .. '.fields[' .. i .. '].name: too large (' .. utf8.len(field.name) .. ' > 256)'
			end

			total_size = total_size + utf8.len(embed.field.name)

			if type(field.value) ~= 'string' then
				return false, prefix .. '.fields[' .. i .. '].value: wrong type (expected string, got ' .. type(field.value) .. ')'
			elseif utf8.len(field.value) < 1 then
				return false, prefix .. '.fields[' .. i .. '].value: too small (' .. utf8.len(field.value) .. ' < 1)'
			elseif utf8.len(field.value) > 1024 then
				return false, prefix .. '.fields[' .. i .. '].value: too large (' .. utf8.len(field.value) .. ' > 1024)'
			end

			total_size = total_size + utf8.len(embed.field.value)

			if field.inline ~= nil then
				if type(field.inline) ~= 'string' then
					return false, prefix .. '.fields[' .. i .. '].inline: wrong type (expected boolean or nil, got ' .. type(field.inline) .. ')'
				end
			end
		end
	end

	if total_size > 6000 then
		return false, prefix .. ': embed content exceeds 6000 characters'
	end

	return true
end

---Strips the code and language out of a fenced codeblock.
---Expects only the fenced codeblock with no surrounding content.
---@param code string
---@return string, string
function ext_discordia.stripcode(code)
	local unfenced = code:match('^```(.-)```$')

	if unfenced:find('^[a-zA-Z0-9-_+.]+\n') then
		local language, content = unfenced:match('^([a-zA-Z0-9-_+.]+)\n(.*)$')
		return content, language
	else
		return unfenced
	end
end

---Formats a discord fenced codeblock.
---Asserts that the provided language is valid (any of a-z, A-Z, 0-9, '-', '_', '+', '.')
---@param code string
---@param[opt] language string
---@return string
function ext_discordia.formatcode(code, language)
	if language then
		assert(not string.find(language, '[^a-zA-Z0-9-_+.]'), 'invalid language')

		return '```' .. language .. '\n' .. code .. '```'
	else
		return '```' .. code .. '```'
	end
end

---Strips the snowflake id out of a discord mention.The second return signifies what kind of mention was parsed,
---either `raw` (only an id was passed), `user`, `role`, `channel`, or `none`.
---@param mention string
---@return string?, string
function ext_discordia.stripmention(mention)
	if tonumber(mention) then
		return mention, 'raw'
	end

	local symbol, id = mention:match('<([@#][&!]?)(%d+)>')

	if symbol == '@' or symbol == '@!' then
		return id, 'user'
	elseif symbol == '@&' then
		return id, 'role'
	elseif symbol == '#' then
		return id, 'channel'
	end

	return nil, 'none'
end

return ext_discordia
