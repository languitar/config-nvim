vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache", "__pycache__"}
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_allow_resize = 1

vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★"
    },
    folder = {
        default = "",
        open = "",
        symlink = ""
    }
}

vim.g.nvim_tree_special_files = {}

vim.api.nvim_set_keymap('', '<leader>n', ':NvimTreeToggle<CR>', {})
