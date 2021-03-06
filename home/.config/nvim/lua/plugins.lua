vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- visual
  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'bufferline'.setup {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {filetype = "NvimTree", text = "File Explorer", text_align = "center"},
          {filetype = "undotree", text = "Undo Tree", text_align = "center"},
          {filetype = "twiggy", text = "Git Branches", text_align = "center"},
        },
      }
    } end
  }
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_italic_keywords = false
      vim.g.tokyonight_colors = {
        border = "#333333",
      }
      vim.g.tokyonight_sidebars = {"qf", "undotree", "NvimTree", "packer", "twiggy"}
      vim.cmd[[colorscheme tokyonight]]
    end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end
  }
  use {
    'folke/which-key.nvim',
    config = function()
      local wk = require("which-key").setup {
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        }
      }
    end
  }

  -- utilities
  use 'kana/vim-textobj-user'
  use 'glts/vim-textobj-comment'
  use 'michaeljsmith/vim-indent-object'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'mbbill/undotree'
  use 'tpope/vim-surround'
  use 'roryokane/detectindent'
  use 'glepnir/indent-guides.nvim'
  use 'ojroques/nvim-bufdel'
  use 'tpope/vim-eunuch'
  use 'tomtom/tcomment_vim'
  use 'AndrewRadev/splitjoin.vim'
  use {
    'ggandor/lightspeed.nvim',
    config = function()
      require'lightspeed'.setup {
        limit_ft_matches = 20,
      }
      local wk = require("which-key")
      wk.register({
        s = "Lightspeed forward",
        S = "Lightspeed backwards",
      })
      function repeat_ft(reverse)
        local ls = require'lightspeed'
        ls.ft['instant-repeat?'] = true
        ls.ft:to(reverse, ls.ft['prev-t-like?'])
      end
      vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
                              {noremap = true, silent = true})
      vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
                              {noremap = true, silent = true})
    end
  }
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-repeat'
  use 'vim-scripts/visualrepeat'
  use 'wellle/targets.vim'

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
  use { 'stsewd/sphinx.nvim', run = ':UpdateRemotePlugins' }

  -- IDE-like features
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'ray-x/lsp_signature.nvim'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  use 'kosayoda/nvim-lightbulb'

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      cmp.setup {
          -- vsnip
          -- snippet = {
          --     expand = function(args)
          --         vim.fn['vsnip#anonymous'](args.body)
          --     end
          -- },
          snippet = {
              expand = function(args)
                  vim.fn["UltiSnips#Anon"](args.body)
              end,
          },
          sources = {
              { name = "nvim_lsp" },
              { name = "ultisnips" },
              { name = "path" },
              { name = "emoji" },
              { name = 'nvim_lua' },
              { name = "buffer" },
              { name = "nuspell" },
          },
          mapping = {
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-d>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.close(),
              ['<CR>'] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
              }),
          },
      }
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'f3fora/cmp-nuspell',
    },
    rocks={'lua-nuspell'},
  }

  use 'simrat39/symbols-outline.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use {
    'fhill2/telescope-ultisnips.nvim',
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('ultisnips')
    end
  }
  use 'KabbAmine/zeavim.vim'
  use 'janko-m/vim-test'
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'mfussenegger/nvim-dap-python'
  use 'nvim-telescope/telescope-dap.nvim'

  -- SCMs
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'shumphrey/fugitive-gitlab.vim'
  use 'sodapopcan/vim-twiggy'
  use 'rbong/vim-flog'
  use 'rhysd/git-messenger.vim'

end)
