require("telescope").setup {
    defaults = {
        file_sorter = require'telescope.sorters'.get_fzy_sorter
    },
    extensions = {
        bibtex = {
            format = "markdown",
            global_files = { "/home/languitar/Nextcloud/notes/zotero.bib" }
        },
    },
}
require"telescope".load_extension("bibtex")
