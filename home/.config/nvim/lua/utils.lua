-- Better buffer deletion with more expected behavior
vim.api.nvim_set_keymap('', '<leader>q', ':BufDel<CR>', {})

-- highligh yanks
vim.api.nvim_command([[
autocmd TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}
]])

-- detect indent settings
vim.g.detectindent_preferred_expandtab = 1
vim.g.detectindent_preferred_indent = 4

-- indent guides
local ig = require('indent_guides')
ig.setup({
  indent_start_level = 2,
  indent_enable = false,
})
vim.api.nvim_set_keymap('', '<leader>i', ':IndentGuidesToggle<CR>', {})

-- recommended by sandwich to avoid confusion
vim.cmd([[
nmap s <Nop>
xmap s <Nop>
]])
