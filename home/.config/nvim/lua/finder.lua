require("telescope").setup {}

vim.api.nvim_set_keymap('', '<Leader>b', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], {})
vim.api.nvim_set_keymap('', '<Leader>c', [[<Cmd>lua require('telescope.builtin').commands()<CR>]], {})
vim.api.nvim_set_keymap('', '<Leader>r', [[<Cmd>lua require('telescope.builtin').registers()<CR>]], {})
vim.api.nvim_set_keymap('', '<Leader>p', [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], {})
vim.api.nvim_set_keymap('', '<Leader>P', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], {})
vim.api.nvim_set_keymap('', '<Leader>e', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], {})
vim.api.nvim_set_keymap('', '<Leader>E', [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], {})
