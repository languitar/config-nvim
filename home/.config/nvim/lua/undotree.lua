local paq = require'paq-nvim'.paq

paq{'mbbill/undotree'}

vim.o.undodir = '~/.cache/nvim/undo/'
vim.o.undofile = true

vim.api.nvim_set_keymap('', '<leader>u', ':UndotreeToggle<CR>', {})
