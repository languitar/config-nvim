vim.o.undodir = vim.fn.expand("~/.cache/nvim/undo/")
vim.o.undofile = true

vim.api.nvim_set_keymap("", "<leader>u", ":UndotreeToggle<CR>", {})
