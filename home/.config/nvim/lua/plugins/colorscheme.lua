return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local tokyonight = require("tokyonight")
        tokyonight.setup({
          on_colors = function(c)
            c.border = c.blue0
          end,
        })
        return tokyonight.load()
      end,
    },
  },
}
