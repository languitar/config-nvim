-- put leader to space
vim.api.nvim_set_keymap('', '<space>', '<leader>', {})
vim.api.nvim_set_keymap('', '<space><space>', '<leader><leader>', {})

-- window navigation
vim.api.nvim_set_keymap('', '<A-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('', '<A-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('', '<A-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('', '<A-l>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-h>', '<Esc><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-l>', '<Esc><C-w>l', {noremap = true})

-- save etc
vim.api.nvim_set_keymap('', '<leader>w', ':w<CR>', {})
vim.api.nvim_set_keymap('', '<leader>q', ':call myhelpers#DeleteBuffer()<CR>', {})

-- stop search highlighting
vim.api.nvim_set_keymap('', '<leader>h', ':nohlsearch <CR>', {})
