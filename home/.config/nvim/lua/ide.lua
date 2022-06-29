local wk = require("which-key")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = { severity_limit = "Warning" },
	signs = true,
})

local custom_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	wk.register({
		s = {
			name = "Code / LSP",
			a = { [[<cmd>lua vim.lsp.buf.code_action()<CR>]], "Code actions" },
			D = { [[<cmd>lua vim.lsp.buf.declaration()<CR>]], "Go to declaration" },
			d = { [[<cmd>Telescope lsp_definitions<CR>]], "Go to definition" },
			h = { [[<cmd>lua vim.lsp.buf.hover()<CR>]], "Hover" },
			i = { [[<cmd>Telescope lsp_implementations<CR>]], "Go to implementations" },
			x = { [[<cmd>Telescope lsp_references<CR>]], "Go to references" },
			r = { [[<cmd>lua vim.lsp.buf.rename()<CR>]], "Rename" },
			t = { [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], "Go to type definition" },
			w = { [[<cmd>Telescope lsp_dynamic_workspace_symbols<CR>]], "List workspace symbols" },
			g = { [[<cmd>Telescope diagnostics bufnr=0<CR>]], "Document diagnostics" },
			G = { [[<cmd>Telescope diagnostics<CR>]], "Workspace diagnostics" },
			f = { [[<cmd>lua vim.lsp.buf.formatting()<CR>]], "Format document" },
		},
	}, { prefix = "<leader>", buffer = bufnr })
	-- see: https://github.com/folke/which-key.nvim/issues/153
	wk.register({
		s = {
			name = "Code / LSP",
			a = { [[<cmd>lua vim.lsp.buf.range_code_action()<CR>]], "Code actions", mode = "v" },
			f = { [[<cmd>lua vim.lsp.buf.range_formatting()<CR>]], "Format selection", mode = "v" },
		},
	}, { prefix = "<leader>", buffer = bufnr })

	wk.register({
		["["] = {
			g = { [[<cmd>lua vim.diagnostic.goto_prev()<CR>]], "Go to previous diagnostics" },
		},
		["]"] = {
			g = { [[<cmd>lua vim.diagnostic.goto_next()<CR>]], "Go to next diagnostics" },
		},
		["K"] = { [[<cmd>lua vim.lsp.buf.hover()<CR>]], "LSP hover" },
	}, { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

local nvim_lspconfig = require("lspconfig")
local servers = {
	"bashls",
	"clangd",
	"cmake",
	"gopls",
	"pyright",
	"sqls",
	"sumneko_lua",
	"terraformls",
	"tsserver",
	"yamlls",
}
for _, lsp in ipairs(servers) do
	nvim_lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = custom_attach,
	})
end

nvim_lspconfig["kotlin_language_server"].setup({
	capabilities = capabilities,
	on_attach = custom_attach,
	cmd = { "/usr/bin/kotlin-language-server" },
})

nvim_lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = custom_attach,
	cmd = { "vscode-json-languageserver", "--stdio" },
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})

nvim_lspconfig.jdtls.setup({
	cmd = { "jdtls" },
})

local local_efm_config = vim.fn.getcwd() .. "/efm-config.yaml"
local efm_command = { "efm-langserver" }
if vim.loop.fs_stat(local_efm_config) then
	efm_command = { "efm-langserver", "-c", local_efm_config }
end
nvim_lspconfig.efm.setup({
	cmd = efm_command,
	capabilities = capabilities,
	on_attach = custom_attach,
	init_options = {
		documentFormatting = true,
	},
	filetypes = {
		"css",
		"dockerfile",
		"fish",
		"html",
		"javascript",
		"json",
		"kotlin",
		"lua",
		"markdown",
		"python",
		"rst",
		"sh",
		"vim",
		"yaml",
	},
})

-- signature help
require("lsp_signature").on_attach()

-- show lightbulbs for code actions
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

-- completion
vim.o.completeopt = "menuone,noselect"

-- zeavim
vim.g.zv_file_types = { py = "python" }

-- vim-test and ultest
vim.g["test#strategy"] = "neovim"

-- debugger
require("nvim-dap-virtual-text").setup()
local dap = require("dap-python")
dap.setup("/usr/bin/python3")
dap.test_runner = "pytest"
require("telescope").load_extension("dap")
wk.register({
	["<F5>"] = { [[:lua require'dap'.continue()<CR>]], "Debug continue" },
	["<F10>"] = { [[:lua require'dap'.step_over()<CR>]], "Debug step over" },
	["<F11>"] = { [[:lua require'dap'.step_into()<CR>]], "Debug step into" },
	["<F12>"] = { [[:lua require'dap'.step_out()<CR>]], "Debug step out" },
})
