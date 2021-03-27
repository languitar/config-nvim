vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

	-- base libraries
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/popup.nvim'

	-- visual
	use 'hoob3rt/lualine.nvim'
	use 'chriskempson/base16-vim'

	-- utilities
	use 'kana/vim-textobj-user'
	use 'glts/vim-textobj-comment'
	use 'michaeljsmith/vim-indent-object'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'
	use 'mbbill/undotree'
	use 'machakann/vim-sandwich'
	use 'roryokane/detectindent'
	use 'glepnir/indent-guides.nvim'
	use 'ojroques/nvim-bufdel'
	use 'tpope/vim-eunuch'
	use 'tomtom/tcomment_vim'
	use 'AndrewRadev/splitjoin.vim'
	use 'easymotion/vim-easymotion'

	-- general language support
	use 'sheerun/vim-polyglot'
	use 'Vimjas/vim-python-pep8-indent'
	use 'bps/vim-textobj-python'
	use 'Rykka/riv.vim'
	use 'jamessan/vim-gnupg'
	use 'chrisbra/csv.vim'
	use 'vim-scripts/icalendar.vim'
	use 'gutenye/json5.vim'
	use 'neo4j-contrib/cypher-vim-syntax'
	use 'rasjani/robotframework-vim'
	use 'towolf/vim-helm'
	use 'plasticboy/vim-markdown'
	use 'gurpreetatwal/vim-avro'
	use { 'stsewd/sphinx.nvim', run = vim.fn['remote#host#UpdateRemotePlugins'] }

	-- IDE-like features
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'neovim/nvim-lspconfig'
	use 'ray-x/lsp_signature.nvim'
	use 'kosayoda/nvim-lightbulb'
	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/nvim-compe'
	use 'nvim-telescope/telescope.nvim'
	use 'KabbAmine/zeavim.vim'
	use 'sbdchd/neoformat'
	use 'janko-m/vim-test'

	-- SCMs
	use 'lewis6991/gitsigns.nvim'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'shumphrey/fugitive-gitlab.vim'
	use 'sodapopcan/vim-twiggy'
	use 'rbong/vim-flog'
	use 'rhysd/git-messenger.vim'

end)

