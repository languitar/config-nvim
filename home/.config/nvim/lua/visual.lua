vim.cmd [[colorscheme base16-bright]]

require('lualine').setup{
    options = {theme = 'material'}
}

require'nvim-web-devicons'.setup {
  default = true;
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
