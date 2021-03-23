local paq = require'paq-nvim'.paq

paq{'nvim-treesitter/nvim-treesitter', run=require'nvim-treesitter.install'.commands.TSUpdate.run}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- TODO useful mappins
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  }
}


-- Treesitter stops syntax files from being loaded so need to redefine
-- commentstrings for languages we care about.
local commentstrings = {
  python  = '#',
  json    = '#',
  bash    = '#',
  c       = '//',
  cpp     = '//',
}

require'nvim-treesitter'.define_modules {
  fixspell = {
    enable = true,
    attach = function(bufnr, lang)
      local cs = commentstrings[lang]
      vim.cmd(
        ('syntax match spellComment "%s.*" contains=@Spell'):format(cs)
      )
    end,
    detach = function(bufnr)
    end,
    is_supported = function(lang)
      if commentstrings[lang] == nil then
        return false
      end
      if require('nvim-treesitter.query').get_query(lang, 'highlights') == nil then
        return false
      end
      return true
    end
  }
}

-- use treesitter for folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
