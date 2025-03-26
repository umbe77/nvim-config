return {
	"mistweaverco/kulala.nvim",
	keys = {
		{
			"<F5>",
			function()
				require("kulala").run()
			end,
			desc = "Send request",
		},
		{
			"<leader>kt",
			function()
				require("kulala").toggle_view()()
			end,
			desc = "toggle header view",
		},
		{
			"<leader>kc",
			function()
				require("kulala").close()
			end,
			desc = "close view",
		},
	},
	ft = { "http", "rest" },
	opts = {
		-- your configuration comes here
		global_keymaps = false,
	},
}
