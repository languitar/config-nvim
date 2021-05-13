vim.cmd [[colorscheme base16-bright]]

require('lualine').setup{
  options = {theme = 'material'},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = { {'filename', file_status = true, path = 1} },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {  },
    lualine_b = {  },
    lualine_c = { {'filename', file_status = true, full_path = true} },
    lualine_x = { 'location' },
    lualine_y = {  },
    lualine_z = {  }
  },
}

require'nvim-web-devicons'.setup {
  default = true;
  override = {
    Dockerfile = {
      icon = "",
      color = "#b8b5ff",
      name = "Dockerfile"
    },
  }
}

-- diagnostics
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", texthl="Question"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", texthl="Question"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", texthl="WarningMsg"})
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", texthl="ErrorMsg"})

vim.cmd[[
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White
]]
