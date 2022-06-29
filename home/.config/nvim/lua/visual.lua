require("lualine").setup({
	options = { theme = "tokyonight" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { { "filename", file_status = true, path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", file_status = true, path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})

require("nvim-web-devicons").setup({
	default = true,
	override = {
		Dockerfile = {
			icon = "",
			color = "#b8b5ff",
			name = "Dockerfile",
		},
	},
})

-- diagnostics
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = "Question" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "𥉉", texthl = "Question" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = "WarningMsg" })
vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = "ErrorMsg" })
