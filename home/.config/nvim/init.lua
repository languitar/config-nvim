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
require('detectindent')
require('sandwich')
require('terminal')
require('commands')
require('tcomment')
require('mappings')
