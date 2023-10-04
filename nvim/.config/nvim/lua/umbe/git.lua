require('gitsigns').setup({
  -- See `:help gitsigns.txt`
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '契' },
    topdelete = { text = '契' },
    changedelete = { text = '▎' },
  },
  on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
      { buffer = bufnr, desc = 'Preview git hunk' })

    -- don't override the built-in and fugitive keymaps
    local gs = package.loaded.gitsigns
    vim.keymap.set({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
    vim.keymap.set({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
  end,
})

require("neogit").setup({})