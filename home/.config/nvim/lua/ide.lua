local wk = require("which-key")

vim.diagnostic.config({
	underline = true,
	virtual_text = { severity_limit = "Warning" },
	float = {
		format = function(diagnostic)
			if diagnostic.code ~= nil then
				return string.format("%s [%s]", diagnostic.message, diagnostic.code)
			else
				return diagnostic.message
			end
		end,
	},
	signs = true,
})

local function select_client(method, on_choice)
	local clients = vim.tbl_values(vim.lsp.buf_get_clients())
	clients = vim.tbl_filter(function(client)
		return client.supports_method(method)
	end, clients)
	-- better UX when choices are always in the same order (between restarts)
	table.sort(clients, function(a, b)
		return a.name < b.name
	end)

	if #clients > 1 then
		vim.ui.select(clients, {
			prompt = "Select a language server:",
			format_item = function(client)
				return client.name
			end,
		}, on_choice)
	elseif #clients < 1 then
		on_choice(nil)
	else
		on_choice(clients[1])
	end
end

local function format_with_selected_client()
	select_client("textDocument/formatting", function(selected)
		if selected == nil then
			return
		end

		return vim.lsp.buf.format({
			filter = function(client)
				return client.name == selected.name
			end,
		})
	end)
end

---@diagnostic disable-next-line: unused-local
local custom_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	wk.add({
		{ "<leader>s", buffer = 1, group = "Code / LSP" },
		{ "<leader>sD", "<cmd>lua vim.lsp.buf.declaration()<CR>", buffer = 1, desc = "Go to declaration" },
		{ "<leader>sG", "<cmd>Telescope diagnostics<CR>", buffer = 1, desc = "Workspace diagnostics" },
		{ "<leader>sa", "<cmd>lua vim.lsp.buf.code_action()<CR>", buffer = 1, desc = "Code actions" },
		{ "<leader>sd", "<cmd>Telescope lsp_definitions<CR>", buffer = 1, desc = "Go to definition" },
		{ "<leader>sf", format_with_selected_client, buffer = 1, desc = "Format document" },
		{ "<leader>sg", "<cmd>Telescope diagnostics bufnr=0<CR>", buffer = 1, desc = "Document diagnostics" },
		{ "<leader>sh", "<cmd>lua vim.lsp.buf.hover()<CR>", buffer = 1, desc = "Hover" },
		{ "<leader>si", "<cmd>Telescope lsp_implementations<CR>", buffer = 1, desc = "Go to implementations" },
		{ "<leader>sr", "<cmd>lua vim.lsp.buf.rename()<CR>", buffer = 1, desc = "Rename" },
		{ "<leader>st", "<cmd>lua vim.lsp.buf.type_definition()<CR>", buffer = 1, desc = "Go to type definition" },
		{
			"<leader>sw",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
			buffer = 1,
			desc = "List workspace symbols",
		},
		{ "<leader>sx", "<cmd>Telescope lsp_references<CR>", buffer = 1, desc = "Go to references" },
	})
	-- see: https://github.com/folke/which-key.nvim/issues/153
	wk.add({
		{ "<leader>s", buffer = 1, group = "Code / LSP" },
		{ "<leader>sa", "<cmd>lua vim.lsp.buf.code_action()<CR>", buffer = 1, desc = "Code actions", mode = "v" },
		{ "<leader>sf", format_with_selected_client, buffer = 1, desc = "Format selection", mode = "v" },
	})

	wk.add({
		{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", buffer = 1, desc = "LSP hover" },
		{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", buffer = 1, desc = "Go to previous diagnostics" },
		{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", buffer = 1, desc = "Go to next diagnostics" },
	})
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
	"graphql",
	"gopls",
	"pyright",
	"solargraph",
	"sqlls",
	"lua_ls",
	"terraformls",
	"tsserver",
	"vale_ls",
	"yamlls",
}
for _, lsp in ipairs(servers) do
	nvim_lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = custom_attach,
	})
end

-- Neovim setup from nvim-lspconfig docs
nvim_lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
	on_attach = custom_attach,
})

nvim_lspconfig.ltex.setup({
	flags = {
		debounce_text_changes = 300,
	},
	settings = {
		ltex = {
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "de-DE",
			},
		},
	},
	capabilities = capabilities,
	on_attach = custom_attach,
})

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
		"bashls",
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

-- completion
vim.o.completeopt = "menuone,noselect"

-- debugger
wk.add({
	{ "<F10>", ":lua require'dap'.step_over()<CR>", desc = "Debug step over" },
	{ "<F11>", ":lua require'dap'.step_into()<CR>", desc = "Debug step into" },
	{ "<F12>", ":lua require'dap'.step_out()<CR>", desc = "Debug step out" },
	{ "<F5>", ":lua require'dap'.continue()<CR>", desc = "Debug continue" },
})
