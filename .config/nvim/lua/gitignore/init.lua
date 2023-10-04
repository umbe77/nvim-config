local pickers = require "telescope.pickers"
local entry_display = require "telescope.pickers.entry_display"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require('telescope.config').values
local popup = require('plenary.popup')

local curl = require "plenary.curl"
local path = require "plenary.path"

local notify = require "notify"
local log = require('telescope.log')

local gitIgnoreUrl = "https://www.toptal.com/developers/gitignore/api/list?format=json"

local M = {}

local list = function()
	local response = curl["get"](gitIgnoreUrl)

	if (response ~= nil and response.status == 200) then
		--[[ local languagesHash = json.decode(response.body) ]]
		local languagesHash = vim.fn.json_decode(response.body)
		local languages = {}
		for _, value in pairs(languagesHash) do
			table.insert(languages, value)
		end
		return languages
	end

	return nil
end

local function msgLoadingPopup(msg, complete_fn)
	local row = math.floor((vim.o.lines - 5) / 2)
	local width = math.floor(vim.o.columns / 1.5)
	local col = math.floor((vim.o.columns - width) / 2)
	for _ = 1, (width - #msg) / 2, 1 do
		msg = " " .. msg
	end
	local prompt_win, prompt_opts = popup.create(msg, {
		border = {},
		borderchars = conf.borderchars,
		height = 5,
		col = col,
		line = row,
		width = width,
	})
	vim.api.nvim_win_set_option(prompt_win, 'winhl', 'Normal:TelescopeNormal')
	vim.api.nvim_win_set_option(prompt_win, 'winblend', 0)
	local prompt_border_win = prompt_opts.border and prompt_opts.border.win_id
	if prompt_border_win then vim.api.nvim_win_set_option(prompt_border_win, 'winhl', 'Normal:TelescopePromptBorder') end
	vim.defer_fn(vim.schedule_wrap(function()
		local results = list()
		if not pcall(vim.api.nvim_win_close, prompt_win, true) then
			log.trace("Unable to close window: ", "ghcli", "/", prompt_win)
		end
		complete_fn(results)
	end), 10)
end

local function Split(s, delimiter)
	local result = {};
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match);
	end
	return result;
end

local gitignore_files = function(opts)

	local displayer = entry_display.create {
		separator = " ",
		items = {
			{ width = 65 },
			{ remaining = true }
		}
	}

	local make_display = function(entry)
		return displayer {
			entry.name,
		}
	end

	msgLoadingPopup("Loading .gitignore", function(results)
		pickers.new(opts, {
			prompt_title = ".gitignore",
			finder = finders.new_table {
				results = results,
				entry_maker = function(entry)
					return {
						display = make_display,
						name = entry.name,
						value = entry,
						ordinal = entry.key,
						contents = entry.contents,
					}
				end
			},
			previewer = previewers.new_buffer_previewer {
				define_preview = function(self, entry)
					local lines = Split(entry.contents, "\n")
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, true, lines)
				end
			},
			sorter = sorters.get_fzy_sorter(opts),
			attach_mappings = function()
				actions.select_default:replace(function(prompt_bufnr)
					local entry = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					local gitignore = path:new(".gitignore")
					gitignore:write(entry.contents, "a")
					notify(string.format("%s gitignore added to .gitignore file", entry.name), "info", {
						title = "gitignore"
					})
				end)
				return true
			end
		}):find()
	end)
end

function M.setup()
	vim.cmd('command GitIgnore lua require"gitignore".run()')
end

function M.run()
	gitignore_files()
end

return M
