vim.cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

require('defaults')
require('colorscheme')
require('statusline')
require('baseplugins')
require('languages/polyglot')
require('languages/python')
require('languages/others')
require('languages/treesitter')
require('detectindent')
require('sandwich')
require('terminal')
require('filetree')
require('finder')
require('undotree')
require('commands')
require('tcomment')
require('scm')
require('ide')
require('utils')
require('mappings')
