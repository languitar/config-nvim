-- Git signs
require("gitsigns").setup({
	on_attach = function(bufnr)
		local wk = require("which-key")
		wk.register({
			g = {
				s = { [[<cmd>lua require"gitsigns".stage_hunk()<CR>]], "Stage hunk" },
				u = { [[<cmd>lua require"gitsigns".undo_stage_hunk()<CR>]], "Undo stage hunk" },
				p = { [[<cmd>lua require"gitsigns".preview_hunk()<CR>]], "Preview hunk" },
				r = { [[<cmd>lua require"gitsigns".reset_hunk()<CR>]], "Rest hunk" },
				d = { [[<cmd>Gitsigns toggle_deleted<CR>]], "Toggle deleted lines" },
			},
		}, { prefix = "<leader>", buffer = bufnr })
		wk.register({
			c = { [[<cmd>Gitsigns next_hunk<CR>]], "Next hunk" },
		}, { prefix = "]", buffer = bufnr })
		wk.register({
			c = { [[<cmd>Gitsigns prev_hunk<CR>]], "Next hunk" },
		}, { prefix = "[", buffer = bufnr })
	end,
})
