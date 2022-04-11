-- JSON: do not remove double quotes in view
vim.g.vim_json_syntax_conceal = 0

-- Python
vim.g.python_highlight_space_errors = 0
vim.g.python_highlight_all = 1

-- General treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "g.",
      node_incremental = ".",
      scope_incremental = ";",
      node_decremental = ",",
    },
  }
}
local wk = require("which-key")
wk.register({
    ['.'] = "Start incremental selection"
}, { prefix = "g" })

-- use treesitter for folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.wo.foldlevel = 1
