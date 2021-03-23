local paq = require'paq-nvim'.paq

-- Git signs
paq{'lewis6991/gitsigns.nvim'}
require('gitsigns').setup {
    signs = {
        add = {hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr"},
        change = {hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr"},
        delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
        topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
        changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
    },
}

-- Git frontend
paq{'tpope/vim-fugitive'}
paq{'tpope/vim-rhubarb'}
paq{'shumphrey/fugitive-gitlab.vim'}

-- Branch and commit trees
paq{'sodapopcan/vim-twiggy'}
paq{'rbong/vim-flog'}

-- popup messenger
paq{'rhysd/git-messenger.vim'}
