-- must be set before loading polyglot
vim.g.polyglot_disabled = {'latex', 'markdown'}

vim.cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

-- base libraries
paq{'nvim-lua/plenary.nvim'}
paq{'nvim-lua/popup.nvim'}

-- visual
paq{'hoob3rt/lualine.nvim'}
paq{'chriskempson/base16-vim'}

-- utilities
paq{'kana/vim-textobj-user'}
paq{'glts/vim-textobj-comment'}
paq{'michaeljsmith/vim-indent-object'}
paq{'kyazdani42/nvim-tree.lua'}
paq{'kyazdani42/nvim-web-devicons'}
paq{'mbbill/undotree'}
paq{'machakann/vim-sandwich'}
paq{'roryokane/detectindent'}
paq{'glepnir/indent-guides.nvim'}
paq{'ojroques/nvim-bufdel'}
paq{'tpope/vim-eunuch'}
paq{'tomtom/tcomment_vim'}
paq{'AndrewRadev/splitjoin.vim'}
paq{'easymotion/vim-easymotion'}

-- general language support
paq{'sheerun/vim-polyglot'}
paq{'Vimjas/vim-python-pep8-indent'}
paq{'bps/vim-textobj-python'}
paq{'Rykka/riv.vim'}
paq{'jamessan/vim-gnupg'}
paq{'chrisbra/csv.vim'}
paq{'vim-scripts/icalendar.vim'}
paq{'gutenye/json5.vim'}
paq{'neo4j-contrib/cypher-vim-syntax'}
paq{'rasjani/robotframework-vim'}
paq{'towolf/vim-helm'}
paq{'plasticboy/vim-markdown'}
paq{'gurpreetatwal/vim-avro'}
paq{'stsewd/sphinx.nvim', run = vim.fn['remote#host#UpdateRemotePlugins']}

-- IDE-like features
paq{'nvim-treesitter/nvim-treesitter', run=function ()
    require'nvim-treesitter.install'.commands.TSUpdate.run()
end}
paq{'neovim/nvim-lspconfig'}
paq{'ray-x/lsp_signature.nvim'}
paq{'kosayoda/nvim-lightbulb'}
paq{'SirVer/ultisnips'}
paq{'honza/vim-snippets'}
paq{'hrsh7th/vim-vsnip'}
paq{'hrsh7th/nvim-compe'}
paq{'nvim-telescope/telescope.nvim'}
paq{'KabbAmine/zeavim.vim'}
paq{'sbdchd/neoformat'}
paq{'janko-m/vim-test'}

-- SCMs
paq{'lewis6991/gitsigns.nvim'}
paq{'tpope/vim-fugitive'}
paq{'tpope/vim-rhubarb'}
paq{'shumphrey/fugitive-gitlab.vim'}
paq{'sodapopcan/vim-twiggy'}
paq{'rbong/vim-flog'}
paq{'rhysd/git-messenger.vim'}

require('defaults')
require('visual')
require('languages')
require('terminal')
require('filetree')
require('finder')
require('undotree')
require('commands')
require('scm')
require('ide')
require('utils')
require('mappings')

-- allow project-specific settings
local local_vimrc = vim.fn.getcwd() .. '/.exrc'
if vim.loop.fs_stat(local_vimrc) then
  print("Sourcing local config")
  vim.cmd('source '..local_vimrc)
end
