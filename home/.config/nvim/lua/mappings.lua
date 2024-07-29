-- put leader to space
vim.api.nvim_set_keymap("", "<space>", "<leader>", {})
vim.api.nvim_set_keymap("", "<space><space>", "<leader><leader>", {})

-- window navigation
local wk = require("which-key")
wk.add({
	{ "<a-h>", "<c-w>h", desc = "Window left" },
	{ "<a-j>", "<c-w>j", desc = "Window down" },
	{ "<a-k>", "<c-w>k", desc = "Window up" },
	{ "<a-l>", "<c-w>l", desc = "Window right" },
})
wk.add({
	{
		mode = { "i" },
		{ "<a-h>", "<Esc><c-w>h", desc = "Window left" },
		{ "<a-j>", "<Esc><c-w>j", desc = "Window down" },
		{ "<a-k>", "<Esc><c-w>k", desc = "Window up" },
		{ "<a-l>", "<Esc><c-w>l", desc = "Window right" },
	},
})

wk.add({
	{ "<leader>E", "<cmd>lua require('telescope.builtin').grep_string()<CR>", desc = "Grep current word" },
	{ "<leader>P", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Any file" },
	{ "<leader>\\", hidden = true },
	{ "<leader>_", group = "TComment" },
	{ "<leader>d", group = "Debugging" },
	{
		"<leader>dB",
		"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		desc = "Set breakpoint with cond.",
	},
	{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
	{ "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue" },
	{ "<leader>dd", "<cmd>lua require'dap'.down()<CR>", desc = "Down in trace" },
	{ "<leader>de", "<cmd>lua require'dap'.set_exception_breakpoints()<CR>", desc = "Set exception breakpoints" },
	{ "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step into" },
	{ "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step over" },
	{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", desc = "Toggle REPL" },
	{ "<leader>dt", group = "Run" },
	{ "<leader>dtc", "<cmd>lua require('dap-python').test_class()<CR>", desc = "Test class" },
	{ "<leader>dtn", "<cmd>lua require('dap-python').test_method()<CR>", desc = "Test current method" },
	{ "<leader>dtt", "<cmd>lua require'dap'.run_last()<CR>", desc = "Run last test" },
	{ "<leader>du", "<cmd>lua require'dap'.up()<CR>", desc = "Up in trace" },
	{ "<leader>dx", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step out" },
	{ "<leader>e", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Live grep" },
	{ "<leader>g", group = "Git" },
	{ "<leader>gi", "<cmd>G<CR>", desc = "Status" },
	{ "<leader>gm", desc = "Messenger" },
	{ "<leader>h", ":nohlsearch <CR>", desc = "Remove search highlight" },
	{ "<leader>i", ":IBLToggle<CR>", desc = "Indent guides" },
	{ "<leader>n", ":NvimTreeToggle<CR>", desc = "File tree" },
	{ "<leader>o", group = "Open file" },
	{ "<leader>ob", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Buffer" },
	{ "<leader>of", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Any file" },
	{ "<leader>og", "<cmd>lua require('telescope.builtin').git_files()<CR>", desc = "Git file" },
	{ "<leader>on", "<cmd>enew<CR>", desc = "New file" },
	{ "<leader>or", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", desc = "Recent file" },
	{ "<leader>p", "<cmd>lua require('telescope.builtin').git_files()<CR>", desc = "Git file" },
	{ "<leader>q", ":BufDel<CR>", desc = "Delete buffer" },
	{ "<leader>s", group = "Code" },
	{ "<leader>sf", desc = "Auto format" },
	{ "<leader>t", group = "Test runner" },
	{ "<leader>tf", "<cmd>TestFile<CR>", desc = "Test file" },
	{ "<leader>tn", "<cmd>TestNearest<CR>", desc = "Test nearest unit" },
	{ "<leader>ts", "<cmd>TestSuite<CR>", desc = "Test suite" },
	{ "<leader>tt", "<cmd>TestLast<CR>", desc = "Run last test" },
	{ "<leader>u", ":UndotreeToggle<CR>", desc = "Undo tree" },
	{ "<leader>v", group = "vim" },
	{ "<leader>vc", "<cmd>lua require('telescope.builtin').commands()<CR>", desc = "Commands" },
	{ "<leader>vr", "<cmd>lua require('telescope.builtin').registers()<CR>", desc = "Registers" },
	{ "<leader>w", ":w<CR>", desc = "Save" },
	{ "<leader>z", desc = "Zeal lookup" },
	{
		"<leader>dts",
		"<ESC><cmd>lua require('dap-python').debug_selection()<CR>",
		desc = "Debug selection",
		mode = "v",
	},
})

