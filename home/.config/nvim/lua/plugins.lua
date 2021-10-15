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
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require'nvim-tree'.setup {
        view = {
          width = 30,
          side = 'left',
        }
      }
    end
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
  use {
    'Rykka/riv.vim',
    config = function()
      vim.g.riv_fold_auto_update = 0
    end
  }
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
  use 'rafamadriz/friendly-snippets'
  use {
    'L3MON4D3/LuaSnip',
    wants = "friendly-snippets",
    config = function()
        local ls = require("luasnip")
        -- some shorthands...
        local s = ls.snippet
        local sn = ls.snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local l = require("luasnip.extras").lambda
        local r = require("luasnip.extras").rep
        local p = require("luasnip.extras").partial
        local m = require("luasnip.extras").match
        local n = require("luasnip.extras").nonempty
        local dl = require("luasnip.extras").dynamic_lambda
        local types = require("luasnip.util.types")

        ls.config.set_config({
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "choiceNode", "Comment" } },
                    },
                },
            },
            -- treesitter-hl has 100, use something higher (default is 200).
            ext_base_prio = 300,
            -- minimal increase in priority.
            ext_prio_increase = 1,
        })

        ls.snippets = {
            all = {
                s("uuid", {
                    f(function()
                        local random = math.random
                        local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
                        local out
                        local function subs(c)
                            local v = (((c == "x") and random(0, 15)) or random(8, 11))
                            return string.format("%x", v)
                        end
                        out = template:gsub("[xy]", subs)
                        return out
                    end, {})
                }),
                s("date", {
                    f(function()
                        return os.date("!%Y-%m-%d")
                    end, {})
                }),
                s("datetime", {
                    f(function()
                        return os.date("!%Y-%m-%d %H:%M")
                    end, {})
                }),
                s("isodate", {
                    f(function()
                        return os.date("!%Y%m%dT%H%M%SZ")
                    end, {})
                }),
                s("timestamp", {
                    f(function()
                        return tostring(os.time(os.date("!*t")))
                    end, {})
                }),
            }
        }

        require('luasnip.loaders.from_vscode').load()
        require('luasnip.loaders.from_vscode').load({paths = {"~/.config/nvim/snippets"}})

        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        _G.snip_jump_next = function()
            if ls.jumpable(1) then
                return t "<Plug>luasnip-jump-next"
            else
                return t "<C-j>"
            end
        end
        _G.snip_jump_prev = function()
            if ls.jumpable(-1) then
                return t "<Plug>luasnip-jump-prev"
            else
                return t "<C-k>"
            end
        end

        _G.snip_expand = function()
            if ls.expandable() then
                return t "<Plug>luasnip-expand-snippet"
            else
                return t "<Tab>"
            end
        end

        vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.snip_jump_next()", {expr = true})
        vim.api.nvim_set_keymap("s", "<C-j>", "v:lua.snip_jump_next()", {expr = true})
        vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.snip_jump_prev()", {expr = true})
        vim.api.nvim_set_keymap("s", "<C-k>", "v:lua.snip_jump_prev()", {expr = true})
        vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.snip_expand()", {expr = true})
        vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.snip_expand()", {expr = true})
    end,
  }
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
          snippet = {
              expand = function(args)
                  require'luasnip'.lsp_expand(args.body)
              end
          },
          sources = {
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              { name = 'path' },
              { name = 'emoji' },
              { name = 'nvim_lua' },
              {
                  name = 'buffer',
                  opts = {
                      keyword_pattern = [[\k\+]]
                  }
              },
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
              }),
          },
      }
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
    },
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
