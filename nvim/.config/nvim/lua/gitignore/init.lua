local curl = require("plenary.curl")
local path = require("plenary.path")

local gitIgnoreUrl = "https://www.toptal.com/developers/gitignore/api/list?format=json"

local languagesHash = {}
local get_languages = function()
	local resp = curl.get(gitIgnoreUrl)
	if resp ~= nil and resp.status == 200 then
		local languages = {}
		local languages_resp = vim.fn.json_decode(resp.body)
		if languages_resp ~= nil then
			for _, value in pairs(languages_resp) do
				languagesHash[value.name] = value
				table.insert(languages, value)
			end
		end
		return languages
	end
	return nil
end

local gitignore_files = function(fzf_cb)
	coroutine.wrap(function()
		local co = coroutine.running()
		local languages = get_languages()
		if not languages then
			fzf_cb() -- EOF
			return
		end
		for _, lang in ipairs(languages) do
			fzf_cb(lang.name, function()
				coroutine.resume(co)
			end)
			coroutine.yield()
		end
		fzf_cb() -- EOF
	end)()
end

local open_gitignore = function()
	require("fzf-lua").fzf_exec(gitignore_files, {
		fzf_opts = {
			["--prompt"] = "Gitignore> ",
			["--preview-window"] = "nohidden,60%",
			["--preview"] = function(items)
				-- print(vim.inspect(items[1]))
				-- print(vim.inspect(languagesHash[items[1]].key))
				return languagesHash[items[1]] and languagesHash[items[1]].contents or ""
			end,
		},
		actions = {
			["default"] = function(selected)
				local content = languagesHash[selected[1]] and languagesHash[selected[1]].contents or ""
				local gitignore = path:new(".gitignore")
				gitignore:write(content, "a")
				---@diagnostic disable-next-line: undefined-global
				Snacks.notify.notify(string.format("Added %s to .gitignore", selected[1]))
			end,
		},
	})
end

local _M = {}

_M.setup = function()
	vim.api.nvim_create_user_command("GitIgnore", function()
		open_gitignore()
	end, {})
end

_M.run = function()
	open_gitignore()
end

return _M
