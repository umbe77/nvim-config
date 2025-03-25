return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "echasnovski/mini.icons" },
	keys = {
		{
			"<leader>b",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Opened Buffers",
		},
		{
			"<leader>p",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fa",
			function()
				require("fzf-lua").live_grep_native()
			end,
			desc = "Find All",
		},
	},
	opts = {},
}
