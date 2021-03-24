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
vim.g.indent_guides_default_mapping = 0
vim.g.indent_guides_auto_colors = 1
vim.api.nvim_set_keymap('', '<leader>i', ':IndentGuidesToggle<CR>', {})

-- recommended by sandwich to avoid confusion
vim.cmd([[
nmap s <Nop>
xmap s <Nop>
]])
