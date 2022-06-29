vim.cmd("command! Fish :terminal fish")

vim.bo.scrollback = -1

-- provide known window navigation commands
vim.api.nvim_set_keymap("t", "<A-h>", [[<C-\><C-n><C-w>h]], { noremap = true })
vim.api.nvim_set_keymap("t", "<A-j>", [[<C-\><C-n><C-w>j]], { noremap = true })
vim.api.nvim_set_keymap("t", "<A-k>", [[<C-\><C-n><C-w>k]], { noremap = true })
vim.api.nvim_set_keymap("t", "<A-l>", [[<C-\><C-n><C-w>l]], { noremap = true })

vim.api.nvim_command([[
augroup MyTerminalSettings
autocmd TermOpen * setlocal nospell nonumber norelativenumber signcolumn=no foldcolumn=0 bufhidden=hide
" autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END 
]])
