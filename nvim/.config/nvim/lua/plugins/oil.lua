return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
	columns = {
	       "icon",
	       "permissions",
	       "size",
	       "mtime",
	  },
	  keymaps = {
	    ["g?"] = "actions.show_help",
	    ["<CR>"] = "actions.select",
	    ["<C-s"] = "actions.select_vsplit",
	    ["<C-n>"] = "actions.select_split",
	    ["<C-p>"] = "actions.preview",
	    ["<C-c>"] = "actions.close",
	    ["<C-l>"] = "actions.refresh",
	    ["-"] = "actions.parent",
	    ["_"] = "actions.open_cwd",
	    ["`"] = "actions.cd",
	    ["~"] = "actions.tcd",
	    ["gs"] = "actions.change_sort",
	    ["gx"] = "actions.open_external",
	    ["g."] = "actions.toggle_hidden",
	  },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
