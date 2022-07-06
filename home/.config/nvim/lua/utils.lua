-- highligh yanks
vim.api.nvim_command([[
autocmd TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}
]])
