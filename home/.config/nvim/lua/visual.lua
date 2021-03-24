vim.cmd [[colorscheme base16-bright]]

-- vim.g.airline_theme = 'base16_bright'
--
-- vim.g.airline_highlighting_cache = 1
--
-- vim.g['airline#extensions#tabline#enabled'] = 1
-- -- already visible in gutter
-- vim.g['airline#extensions#syntastic#enabled'] = 0
-- -- I usually know where I am in a file
-- vim.g['airline#extensions#tagbar#enabled'] = 0
-- vim.g['airline#extensions#hunks#enabled'] = 0
-- vim.g['airline#extensions#branch#displayed_head_limit'] = 20
-- vim.g['airline#extensions#branch#format'] = 2
-- vim.g['airline#extensions#branch#sha1_len'] = 8
-- vim.g['airline#extensions#taboo#enabled'] = 1
-- vim.g['airline#extensions#ale#enabled'] = 0
-- vim.g['airline#extensions#languageclient#enabled'] = 0
-- vim.g['airline#extensions#virtualenv#enabled'] = 0
-- vim.g['airline#extensions#poetv#enabled'] = 0
-- vim.g['airline#extensions#coc#enabled'] = 0
-- vim.g['airline_detect_spell'] = 1
-- vim.g['airline_detect_spelllang'] = 0
-- vim.g['airline#extensions#fugitiveline#enabled '] =  1
-- -- hide mode indicator for the desired common case
-- vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
-- -- skip empty secionts
-- vim.g['airline_skip_empty_sections'] = 1
--
-- -- theming
-- vim.g.airline_powerline_fonts = 0
-- vim.g.airline_left_sep = '▙'
-- vim.g.airline_right_sep = '▟'
-- -- make things more compact
-- vim.g.airline_mode_map = {
--   ['__'] = '-',
--   ['n']  = 'N',
--   ['i']  = 'I',
--   ['R']  = 'R',
--   ['c']  = 'C',
--   ['v']  = 'V',
--   ['V']  = 'V',
--   [''] = 'V',
--   ['s']  = 'S',
--   ['S']  = 'S',
--   [''] = 'S',
--   ['t']  = 'T',
-- }
--
-- vim.g.airline_symbols = {spell =  '✓'}
-- vim.g.airline_section_z = '%4l/%L'

require('lualine').setup{
    options = {theme = 'material'}
}

require'nvim-web-devicons'.setup {
  default = true;
}
