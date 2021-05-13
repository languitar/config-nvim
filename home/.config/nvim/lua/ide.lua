-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     virtual_text = {
--       severity_limit = "Warning",
--     },
--     signs = true
--   }
-- )
--
-- local custom_attach = function(client, bufnr)
--   print('LSP started');
--
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   local opts = {noremap=true, silent=true}
--   buf_set_keymap('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n','gd',':Telescope lsp_definitions<CR>', opts)
--   buf_set_keymap('n','K','<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   buf_set_keymap('n','gr',':Telescope lsp_references<CR>', opts)
--   buf_set_keymap('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   buf_set_keymap('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   buf_set_keymap('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n','<leader>gw',':Telescope lsp_workspace_symbols<CR>', opts)
--   buf_set_keymap('n','<leader>sr','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   buf_set_keymap('n','<leader>sd','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   buf_set_keymap('n','<leader>sa',':Telescope lsp_code_actions<CR>', opts)
--   buf_set_keymap('n','<leader>sf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--   buf_set_keymap('v','<leader>sf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
--   -- Somehow this gets overwritten if configured in visual.lua
--   vim.cmd[[
-- hi LspDiagnosticsUnderlineHint gui=underline cterm=underline guisp=#6fb3d2
-- hi LspDiagnosticsUnderlineInformation gui=underline cterm=underline guisp=#6fb3d2
-- hi LspDiagnosticsUnderlineWarning gui=underline cterm=underline guisp=#fda331
-- hi LspDiagnosticsUnderlineError gui=underline cterm=underline guisp=#fb0120
--
-- hi LspDiagnosticsVirtualTextHint guifg=#6fb3d2
-- hi LspDiagnosticsVirtualTextInformation guifg=#6fb3d2
-- hi LspDiagnosticsVirtualTextWarning guifg=#fda331
-- hi LspDiagnosticsVirtualTextError guifg=#fb0120
--   ]]
-- end
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- local nvim_lspconfig = require'lspconfig'
-- local servers = {
--   "bashls",
--   "cmake",
--   "clangd",
--   "jsonls",
--   "jdtls",
--   "pyright",
--   "sqls",
--   "terraformls",
-- }
-- for _, lsp in ipairs(servers) do
--   nvim_lspconfig[lsp].setup {
--     capabilities = capabilities,
--     on_attach = custom_attach,
--   }
-- end
--
-- nvim_lspconfig.diagnosticls.setup {
--   filetypes = {"python", "fish", "markdown"},
--   init_options = {
--     filetypes = {
--       python = {"flake8", "pylint", "mypy"},
--       fish = {"fish"},
--       markdown = {"markdownlint"},
--     },
--     linters = {
--       flake8 = {
--         command = "flake8",
--         debounce = 100,
--         args = { "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s", "%file" },
--         offsetLine = 0,
--         offsetColumn = 0,
--         sourceName = "flake8",
--         formatLines = 1,
--         formatPattern = {
--           "(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$",
--           {
--             line = 1,
--             column = 2,
--             security = 3,
--             message = 4
--           }
--         },
--         securities = {
--           W = "warning",
--           E = "error",
--           F = "error",
--           C = "error",
--           N = "error"
--         },
--       },
--     },
--     mypy = {
--       sourceName = "mypy",
--       command = "mypy",
--       args = {
--         "--no-color-output",
--         "--no-error-summary",
--         "--show-column-numbers",
--         "--follow-imports=silent",
--         "%file"
--       },
--       formatPattern = {
--         "^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$",
--         {
--           line = 1,
--           column = 2,
--           security = 3,
--           message = 4
--         }
--       },
--       securities = {
--         error = "error"
--       },
--     },
--     fish = {
--       command = "fish",
--       args = {"-n", "%file"},
--       isStdout = false,
--       isStderr = true,
--       sourceName = "fish",
--       formatLines = 1,
--       formatPattern = {
--         "^.*\\(line (\\d+)\\): (.*)$",
--         {
--           line = 1,
--           message = 2
--         }
--       }
--     },
--     markdownlint = {
--       command = "markdownlint",
--       isStderr = true,
--       debounce = 100,
--       args = { "--stdin" },
--       offsetLine = 0,
--       offsetColumn = 0,
--       sourceName = "markdownlint",
--       formatLines = 1,
--       formatPattern = {
--         "^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$",
--         {
--           line = 1,
--           column = 3,
--           message = {4}
--         }
--       }
--     },
--   },
-- }
--
-- -- signature help
-- require'lsp_signature'.on_attach()
--
-- -- show lightbulbs for code actions
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
--
-- -- completion
-- vim.o.completeopt = "menuone,noselect"
--
-- require'compe'.setup {
--   enabled = true,
--   autocomplete = true,
--   debug = false,
--   min_length = 1,
--   preselect = "enable",
--   throttle_time = 80,
--   source_timeout = 200,
--   incomplete_delay = 400,
--   max_abbr_width = 100,
--   max_kind_width = 100,
--   max_menu_width = 100,
--   documentation = true,
--   source = {
--     path = true,
--     buffer = true,
--     calc = true,
--     vsnip = true,
--     nvim_lsp = true,
--     nvim_lua = true,
--     spell = true,
--     tags = false,
--     ultisnips = true,
--     treesitter = false
--   }
-- }
--
-- vim.cmd[[
-- inoremap <silent><expr> <C-Space> compe#complete()
-- inoremap <silent><expr> <CR>      compe#confirm('<CR>')
-- inoremap <silent><expr> <C-e>     compe#close('<C-e>')
-- ]]

-- coc
vim.g.coc_global_extensions = {
  'coc-cmake',
  'coc-conventional',
  'coc-css',
  'coc-diagnostic',
  'coc-dictionary',
  'coc-docker',
  'coc-emoji',
  'coc-fish',
  'coc-git',
  'coc-go',
  'coc-highlight',
  'coc-html',
  'coc-java',
  'coc-jira-complete',
  'coc-json',
  'coc-lists',
  'coc-markdownlint',
  'coc-omni',
  'coc-pyright',
  'coc-sh',
  'coc-sql',
  'coc-svg',
  'coc-swagger',
  'coc-syntax',
  'coc-tag',
  'coc-toml',
  'coc-ultisnips',
  'coc-vimlsp',
  'coc-vimtex',
  'coc-word',
  'coc-xml',
  'coc-yaml',
  'coc-yank',
  'coc-bibtex',
}

vim.cmd[[
function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
]]

vim.cmd[[
nnoremap <silent> K :call ShowDocumentation()<CR>
map <leader>sh :call ShowDocumentation()<CR>
map <leader>sd <Plug>(coc-definition)
map <leader>sr <Plug>(coc-rename)
map <leader>sl <Plug>(coc-codelens-action)
map <leader>ss :<C-u>CocList outline<cr>
map <leader>sw :<C-u>CocList -I symbols<cr>
nmap <leader>sf <Plug>(coc-format)
vmap <leader>sf <Plug>(coc-format-selected)
map <leader>sa <Plug>(coc-codeaction)
xmap <leader>sa <Plug>(coc-codeaction-selected)
map <leader>sq <Plug>(coc-fix-current)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <c-n> pumvisible() ? "\<C-n>" : coc#refresh()

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
]]

-- zeavim
vim.g.zv_file_types = {py = 'python,pandas,numpy'}

-- vim-test and ultest
vim.g['test#strategy'] = 'neovim'
vim.api.nvim_set_keymap('', '<leader>tt', ':TestLast<CR>', {})
vim.api.nvim_set_keymap('', '<leader>tf', ':TestFile<CR>', {})
vim.api.nvim_set_keymap('', '<leader>ts', ':TestSuite<CR>', {})
vim.api.nvim_set_keymap('', '<leader>tn', ':TestNearest<CR>', {})

-- snippets
vim.g.UltiSnipsEditSplit = 'context'
vim.g.UltiSnipsSnippetsDir = vim.fn.expand('~/.config/nvim/UltiSnips')
vim.g.UltiSnipsListSnippets = '<A-tab>'

-- auto-formatting
vim.g.neoformat_enabled_python = {'isort', 'black'}
vim.cmd [[
nnoremap <silent> <leader>sf :Neoformat<CR>
vnoremap <silent> <leader>sf :Neoformat<CR>
]]

-- debugger
vim.g.dap_virtual_text = true
local dap = require('dap-python')
dap.test_runner = 'pytest'
require('dap-python').setup('/usr/local/bin/python3')
vim.cmd [[
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
]]
