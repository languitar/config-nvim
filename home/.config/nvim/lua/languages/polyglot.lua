local paq = require'paq-nvim'.paq

vim.g.polyglot_disabled = {'latex', 'markdown'}

paq{'sheerun/vim-polyglot'}

-- do not remove double quotes in view
vim.g.vim_json_syntax_conceal = 0
