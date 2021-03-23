local paq = require'paq-nvim'.paq

-- Better buffer deletion with more expected behavior
paq{'ojroques/nvim-bufdel'}
vim.api.nvim_set_keymap('', '<leader>q', ':BufDel<CR>', {})

-- highligh yanks
vim.api.nvim_command([[
autocmd TextYankPost * silent! lua vim.highlight.on_yank {timeout=500}
]])

-- Unix wrappers
paq{'tpope/vim-eunuch'}
