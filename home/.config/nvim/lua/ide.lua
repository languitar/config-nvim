local wk = require("which-key")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {severity_limit = "Warning"},
        signs = true
    })

local custom_attach = function(client, bufnr)
    print('LSP started');

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    wk.register({
       s = {
           name = "Code / LSP",
           a = { [[<cmd>Telescope lsp_code_actions<CR>]], "Code actions" },
           a = { [[<cmd>Telescope lsp_range_code_actions<CR>]], "Code actions", mode = "v" },
           D = { [[<cmd>lua vim.lsp.buf.declaration()<CR>]], "Go to declaration" },
           d = { [[<cmd>Telescope lsp_definitions<CR>]], "Go to definition" },
           h = { [[<cmd>lua vim.lsp.buf.hover()<CR>]], "Hover" },
           i = { [[<cmd>Telescope lsp_implementations<CR>]], "Go to implementations" },
           x = { [[<cmd>Telescope lsp_references<CR>]], "Go to references" },
           r = { [[<cmd>lua vim.lsp.buf.rename()<CR>]], "Rename" },
           t = { [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], "Go to type definition" },
           w = { [[<cmd>Telescope lsp_dynamic_workspace_symbols<CR>]], "List workspace symbols" },
           g = { [[<cmd>Telescope lsp_document_diagnostics<CR>]], "Document diagnostics" },
           G = { [[<cmd>Telescope lsp_workspace_diagnostics<CR>]], "Workspace diagnostics" },
       }
    }, { prefix = "<leader>", buffer = bufnr })

    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts)
    buf_set_keymap('n', 'K', [[<cmd>lua vim.lsp.buf.hover()<CR>]],
                   opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport =
    {properties = {'documentation', 'detail', 'additionalTextEdits'}}

local nvim_lspconfig = require 'lspconfig'
local servers = {
    "bashls", "cmake", "clangd", "jsonls", "jdtls", "pyright", "sqls",
    "terraformls", "yamlls", "jsonls",
}
for _, lsp in ipairs(servers) do
    nvim_lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = custom_attach
    }
end

nvim_lspconfig.diagnosticls.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
    filetypes = {"python", "fish", "markdown"},
    init_options = {
        filetypes = {
            python = {"flake8", "pylint", "mypy"},
            fish = {"fish"},
            markdown = {"markdownlint"}
        },
        linters = {
            flake8 = {
                command = "flake8",
                debounce = 100,
                args = {
                    "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s",
                    "%file"
                },
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = "flake8",
                formatLines = 1,
                formatPattern = {
                    "(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$",
                    {line = 1, column = 2, security = 3, message = 4}
                },
                securities = {
                    W = "warning",
                    E = "error",
                    F = "error",
                    C = "error",
                    N = "error"
                }
            }
        },
        mypy = {
            sourceName = "mypy",
            command = "mypy",
            args = {
                "--no-color-output", "--no-error-summary",
                "--show-column-numbers", "--follow-imports=silent", "%file"
            },
            formatPattern = {
                "^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$",
                {line = 1, column = 2, security = 3, message = 4}
            },
            securities = {error = "error"}
        },
        fish = {
            command = "fish",
            args = {"-n", "%file"},
            isStdout = false,
            isStderr = true,
            sourceName = "fish",
            formatLines = 1,
            formatPattern = {
                "^.*\\(line (\\d+)\\): (.*)$", {line = 1, message = 2}
            }
        },
        markdownlint = {
            command = "markdownlint",
            isStderr = true,
            debounce = 100,
            args = {"--stdin"},
            offsetLine = 0,
            offsetColumn = 0,
            sourceName = "markdownlint",
            formatLines = 1,
            formatPattern = {
                "^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$",
                {line = 1, column = 3, message = {4}}
            }
        }
    }
}

-- signature help
require'lsp_signature'.on_attach()

-- show lightbulbs for code actions
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- completion
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        path = true,
        buffer = true,
        calc = true,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = true,
        spell = false,
        tags = false,
        ultisnips = true,
        treesitter = false
    }
}

vim.cmd [[
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
]]

-- zeavim
vim.g.zv_file_types = {py = 'python'}

-- vim-test and ultest
vim.g['test#strategy'] = 'neovim'

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
dap.setup('/usr/bin/python3')
dap.test_runner = 'pytest'
require('telescope').load_extension('dap')
wk.register({
    ['<F5>'] = { [[:lua require'dap'.continue()<CR>]], "Debug continue" },
    ['<F10>'] = { [[:lua require'dap'.step_over()<CR>]], "Debug step over" },
    ['<F11>'] = { [[:lua require'dap'.step_into()<CR>]], "Debug step into" },
    ['<F12>'] = { [[:lua require'dap'.step_out()<CR>]], "Debug step out" },
})
