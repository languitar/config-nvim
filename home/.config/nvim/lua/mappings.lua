-- put leader to space
vim.api.nvim_set_keymap('', '<space>', '<leader>', {})
vim.api.nvim_set_keymap('', '<space><space>', '<leader><leader>', {})

-- window navigation
vim.api.nvim_set_keymap('', '<A-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('', '<A-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('', '<A-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('', '<A-l>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-h>', '<Esc><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-l>', '<Esc><C-w>l', {noremap = true})

local wk = require("which-key")
wk.register({
  o = {
    name = "Open file",
    b = { [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], "Buffer" },
    g = { [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], "Git file" },
    f = { [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], "Any file" },
    r = { [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], "Recent file" },
    n = { [[<Cmd>enew<CR>]], "New file" },
  },

  p = { [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], "Git file" },
  P = { [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], "Any file" },

  e = { [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], "Live grep" },
  E = { [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], "Grep current word" },

  v = {
    name = "vim",
    c = { [[<Cmd>lua require('telescope.builtin').commands()<CR>]], "Commands" },
    r = { [[<Cmd>lua require('telescope.builtin').registers()<CR>]], "Registers" },
  },

  q = { "Delete buffer" },
  h = { ":nohlsearch <CR>", "Remove search highlight" },
  w = { ":w<CR>", "Save" },

  z = { "Zeal lookup" },
  u = { "Undo tree" },
  n = { "File tree" },
  i = { "Indent guides" },

  _ = {
    name = "TComment",
  },

  d = {
    name = "Debugging",
    b = { [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]], "Toggle breakpoint" },
    B = { [[<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]], "Set breakpoint with cond." },
    r = { [[<Cmd>lua require'dap'.repl.open()<CR>]], "Open REPL" },
    t = { [[<Cmd>lua require'dap'.run_last()<CR>]], "Run last test" },
    n = { [[<Cmd>lua require('dap-python').test_method()<CR>]], "Test current method" },
    c = { [[<Cmd>lua require('dap-python').test_class()<CR>]], "Test class" },
    s = { [[<ESC><Cmd>lua require('dap-python').debug_selection()<CR>]], "Debug selection", mode = "v" },
  },

  t = {
    name = "Test runner",
    t = { [[<Cmd>TestLast<CR>]], "Run last test" },
    f = { [[<Cmd>TestFile<CR>]], "Test file" },
    s = { [[<Cmd>TestSuite<CR>]], "Test suite" },
    n = { [[<Cmd>TestNearest<CR>]], "Test nearest unit" },
  },

  s = {
    name = "Code",
    f = "Auto format",
  },

  ["\\"] = "which_key_ignore",
}, { prefix = "<leader>" })
