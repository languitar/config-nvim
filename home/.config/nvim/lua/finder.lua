require("telescope").setup {
    defaults = {
        file_sorter = require'telescope.sorters'.get_fzy_sorter
    }
}
