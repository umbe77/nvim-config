return {
	"github/copilot.vim",
	init = function()
		vim.g.copilot_no_tab_map = true
	end,
	config = function()
		vim.keymap.set("i", "<TAB>", [[copilot#Accept()]], {
			silent = true,
			expr = true,
			script = true,
			replace_keycodes = false,
		})
	end,
}
