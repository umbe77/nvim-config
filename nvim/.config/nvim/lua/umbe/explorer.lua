require('oil').setup({
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
  },})

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require('neo-tree').setup()
