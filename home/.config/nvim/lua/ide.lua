local paq = require'paq-nvim'.paq

paq{'neovim/nvim-lspconfig'}

-- Server auto installation
paq{'kabouzeid/nvim-lspinstall'}

require'lspinstall'.setup() -- important

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{
	capabilities = capabilities
    }
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- signature help
paq{'ray-x/lsp_signature.nvim'}
require'lsp_signature'.on_attach()

-- show lightbulbs for code actions
paq{'kosayoda/nvim-lightbulb'}
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- snippets
paq{'SirVer/ultisnips'}
paq{'honza/vim-snippets'}
paq{'hrsh7th/vim-vsnip'}

-- completion
vim.o.completeopt = "menuone,noselect"
paq{'hrsh7th/nvim-compe'}

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
        spell = true,
        tags = true,
        ultisnips = true,
        treesitter = true
    }
}
