vim.o.shell = 'bash'
vim.g.python3_host_prog = '/usr/bin/python3'

vim.o.hidden = true
vim.o.showmode = false
vim.o.shortmess = vim.o.shortmess .. 'c'

-- preferred file formats in descending priority
vim.o.fileformats = 'unix,dos,mac'

vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.shiftround = true

-- detect lists when wrapping lines
vim.bo.formatoptions = vim.bo.formatoptions .. 'n'
vim.bo.formatlistpat = vim.bo.formatlistpat .. [[^\s*\(\d\+[\]:.)}\t ]\|[*-][\t ]\)\s*]]

-- always keep some lines of text visible around the cursor
vim.o.scrolloff = 3

-- gutter and number settings
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.foldcolumn = '1'
vim.wo.signcolumn = 'yes'  -- always show the sign colum to prevent flickering

-- split settings
vim.o.fillchars = [[vert:│]]

-- default spell settings
vim.wo.spell = true
vim.bo.spelllang = 'en,de'

-- search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'nosplit'

-- show an indicator in case textwidth is defined
vim.wo.colorcolumn = '-0'

-- enable virtual line breaks
vim.wo.linebreak = true
vim.wo.breakindent = true

-- tab completion mode with partial match and list
vim.o.wildmode = 'list:longest,full'

-- allow mouse control
vim.o.mouse = 'a'

-- avoid delays when exiting insert mode with escape
vim.o.ttimeoutlen = 0

-- more frequent updates and cursor hold
vim.o.updatetime = 2000

-- allow full color support
vim.o.termguicolors = true

-- TODO
-- reload changed files
-- autocmd vimrc FocusGained * :checktime
-- remember tab names in sessions
-- set sessionoptions+=tabpages,globals,winpos,winsize,blank,resize

-- " ensure that ctrl+u in insert mode can be reversed
-- " http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
-- inoremap <c-u> <c-g>u<c-u>
-- inoremap <c-w> <c-g>u<c-w>
