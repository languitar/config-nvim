scriptencoding utf8
if !has('nvim')
    set encoding utf8
end

" bundle settings
set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/bundle/')

" general configuration
Plug 'sjl/badwolf'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'albfan/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'kopischke/unite-spell-suggest'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neoyank.vim'
Plug 'termoshtt/unite-bibtex'
Plug 'gcmt/taboo.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'easymotion/vim-easymotion'
Plug 'itspriddle/ZoomWin'
Plug 'tpope/vim-eunuch'

" completion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi', {'for': ['python', 'python3']}
Plug 'Rip-Rip/clang_complete', {'for': ['c', 'cpp']}
Plug 'benekastah/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" SCM support
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" editing aids
Plug 'roryokane/detectindent', {'on': 'DetectIndent'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'nathanaelkane/vim-indent-guides', {'on': 'IndentGuidesToggle'}
Plug 'tomtom/tcomment_vim'
Plug 'sk1418/Join', {'on': 'Join'}
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'

" language support
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'Rykka/riv.vim', {'for': 'rst'}
Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'dag/vim-fish', {'for': 'fish'}
Plug 'bfredl/nvim-ipy', {'on': ['IPython', 'IPython2'] }
Plug 'hynek/vim-python-pep8-indent', {'for': ['python', 'python3']}
Plug 'kana/vim-textobj-user', {'for': ['python', 'python3']}
Plug 'bps/vim-textobj-python', {'for': ['python', 'python3']}
Plug 'tmhedberg/SimpylFold', {'for': ['python', 'python3']}
Plug 'jamessan/vim-gnupg'
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'vim-scripts/icalendar.vim', {'for': 'icalendar'}
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}

call plug#end()

filetype plugin indent on

" define a default autocmd group to prevent duplicated commands
augroup vimrc
    " Remove everything that existed in this group to prevent duplicated calls
    autocmd!
augroup END

" general settings independent of plugins
set shell=bash " fix the shell to something vim understand

syntax on " enable syntax highlighting
set number " show line numbers

set fileformats=unix,dos,mac " set newline preferences

" default indentation settings
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent

" detect lists when wrapping lines
set formatoptions+=n
let &formatlistpat='^\s*\(\d\+[\]:.)}\t ]\|[*-][\t ]\)\s*'

" scrolling
set scrolloff=3

" spell checking
set spell spelllang=en,de

" search options
set hlsearch " highlight search matches. Turn of with :nohlsearch after a search
set incsearch " highlight partial search pattern matches while typing
set ignorecase " usually ignore case when searching
set smartcase " unless a search term starts with a capital letter

" print margin at the specified textwidth setting (- important to distinguish
" from off (being 0))
set colorcolumn=-0

" show leader character
set showcmd

" virtual line breaks on word boundaries with correct indentation
set linebreak
if exists("&breakindent")
    set breakindent
endif

" allow project-specific settings
set exrc
set secure

" let backspace do something reasonable, i.e. delete also things outside the
" current insert operation
set backspace=indent,eol,start

" ensure that ctrl+u in insert mode can be reversed
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" bracket matching settings
highlight MatchParen cterm=bold ctermbg=none ctermfg=9

" tab completion mode with partial match and list
set wildmode=list:longest,full
set wildmenu

" allow mouse control
set mouse=a

" avoid delays when exiting insert mode with escape
set timeoutlen=1000
set ttimeoutlen=0

" put leader to space
map <space> <leader>
map <space><space> <leader><leader>

" shortcut for replacing words under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" color scheme
" set background=dark
colorscheme badwolf
let g:airline_theme="badwolf"
" local color scheme modifications
" highlight ColorColumn ctermbg=8
highlight DiffAdd ctermbg=2
highlight DiffDelete ctermbg=1
highlight DiffChange ctermbg=238
highlight DiffChange ctermbg=242

" solid utf-8 lines for splits
set fillchars=vert:\│

" indent guides
let g:indent_guides_default_mapping = 0
let g:indent_guides_auto_colors = 0
highlight IndentGuidesOdd  guibg=red   ctermbg=234
highlight IndentGuidesEven guibg=green ctermbg=236

" status line modification
set laststatus=2 " always show a status line
let g:airline#extensions#tabline#enabled=1
" already visible in gutter
let g:airline#extensions#syntastic#enabled=0
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#branch#enabled=1
" already done by another plugin
let g:airline#extensions#whitespace#checks=['indent', 'mixed-indent-file']
let g:airline_powerline_fonts=1
" make things more compact
let g:airline_mode_map={
    \ '__': '-',
    \ 'n' : 'N',
    \ 'i' : 'I',
    \ 'R' : 'R',
    \ 'c' : 'C',
    \ 'v' : 'V',
    \ 'V' : 'V',
    \ '': 'V',
    \ 's' : 'S',
    \ 'S' : 'S',
    \ '': 'S',
    \ }
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.spell = '✓'
let g:airline_section_z = '%4l/%L'

" detect indent settings
let g:detectindent_preferred_expandtab=1
let g:detectindent_preferred_indent=4
" autocmd BufReadPost * :DetectIndent

" nerdtree modifications
" change cwd with nerd tree
let NERDTreeChDirMode=2

" Neomake settings
let g:neomake_error_sign = {
            \ 'text': '>>',
            \ 'texthl': 'ErrorMsg',
            \ }
hi MyWarningMsg ctermbg=3 ctermfg=0
let g:neomake_warning_sign = {
            \ 'text': '>>',
            \ 'texthl': 'MyWarningMsg',
            \ }

let g:neomake_c_enabled_makers = []
let g:neomake_cpp_enabled_makers = []
let g:neomake_tex_enabled_makers = [ 'chktex' ]
" let g:neomake_python_enabled_makers = [ 'pylama', 'pylint' ]
autocmd vimrc BufReadPost,BufWritePost * Neomake

" deoplete settings
let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_camel_case = 1

let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_use_library = 1
let g:clang_complete_macros = 1
let g:clang_auto_user_options = 'compile_commands.json'
" let g:clang_complete_patterns = 1

" unite settings
" nmap <C-y> :Unite source<CR>

call unite#filters#sorter_default#use(['sorter_word', 'sorter_rank'])
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
"   \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))
" sort files by best match
call unite#custom#source('file_mru,file_rec,file_rec/async,file_rec/git',
  \ 'sorters', 'sorter_selecta')
call unite#custom#source('spell_suggest,history/yank,buffer',
  \ 'sorters', 'sorter_nothing')

let g:unite_prompt = '>>> '
let g:unite_winheight = 15
let g:unite_update_time = 200
let g:unite_split_rule = 'botright'
let g:unite_data_directory = $HOME.'/.cache/unite'

autocmd vimrc FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " imap <silent><buffer><expr> <C-s> unite#do_action('split')
  " imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  " imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
endfunction
nmap z= :Unite spell_suggest <CR>

" taboo settings
let g:taboo_tabline = 0

" JSON highlighting settings
let g:vim_json_syntax_conceal=0 " do not remove double quotes in view

" InstantRst settings
" let g:instant_rst_browser='chromium-browser'
let g:instant_rst_bind_scroll=0

" latex settings
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_IgnoredWarnings=''

" signify
let g:signify_vcs_list = [ 'git', 'svn', 'hg' ]

" vim-slime
let g:slime_target="tmux"
let g:slime_python_ipython=1
let g:slime_no_mappings=1
nmap <c-c><c-f> vaf :SlimeSend<CR>
nmap <c-c><c-c> vac :SlimeSend<CR>
nmap <c-c><c-l> V :SlimeSend<CR>
nmap <c-c><c-p> vip :SlimeSend<CR>
xmap <c-c><c-c> :SlimeSend<CR>

" python folding
let g:SimpylFold_docstring_preview=1

" riv rest settings
" let g:riv_disable_folding=1

" fix editing modes to file types
autocmd vimrc BufRead,BufNewFile rsb.conf set filetype=dosini
autocmd vimrc BufRead,BufNewFile *.project set filetype=json
autocmd vimrc BufRead,BufNewFile *.template set filetype=json
autocmd vimrc BufRead,BufNewFile *.distribution set filetype=json
autocmd vimrc BufRead,BufNewFile *.ics set filetype=icalendar
autocmd vimrc BufNewFile,BufReadPost *.md set filetype=markdown
autocmd vimrc BufNewFile,BufReadPost *.md.erb set filetype=markdown

" key bindings to open navigation aids
nmap <leader>nt :NERDTreeToggle <CR>
map <leader>tb :TagbarToggle <CR>
map <leader>u :UndotreeToggle <CR>
map <leader>i :IndentGuidesToggle <CR>
map <leader>b :Unite buffer <CR>
map <leader>r :UniteResume <CR>
map <leader>p :UniteWithProjectDir -start-insert file_rec/async<CR>
map <leader>g :Unite -start-insert file_rec/git<CR>
map <leader>e :Unite grep/git<CR>

map <leader>w :w<CR>

" UltiSnips settings
let g:UltiSnipsEditSplit = "context"
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"

" settings for neovim terminals
if has('nvim')
    autocmd vimrc TermOpen * setlocal nospell
    autocmd vimrc TermOpen * set bufhidden=hide
    command! Fish :terminal fish
    autocmd vimrc BufEnter * if &buftype == 'terminal' | :startinsert | endif
    let g:terminal_scrollback_buffer_size=100000
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif

" mappings for navigating between windows with alt+homerow
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-l> <Esc><C-w>l

" Handle tmux $TERM quirks in vim
map <Esc>OH <Home>
map! <Esc>OH <Home>
map <Esc>OF <End>
map! <Esc>OF <End>

" leader combination to stop search highlighting
map <leader>h :nohlsearch <CR>

" make vimtex work with neovim
if has('nvim')
    let g:vimtex_latexmk_progname = 'nvr'
endif

" deoplete completion for LaTeX
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
    \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
    \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
    \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
    \ .')'

" function to explain the different highlights for spelling errors
function! s:SpellLegend()
    for [l:group, l:explanation] in [
    \   ['SpellBad', 'word not recognized'],
    \   ['SpellCap', 'word not capitalized'],
    \   ['SpellRare', 'rare word'],
    \   ['SpellLocal', 'wrong spelling for selected region']
    \]
        echo ''
        echon l:group . "\t"
        execute 'echohl' l:group
        echon 'xxx'
        echohl None
        echon "\t" . l:explanation
    endfor
endfunction
command! -bar SpellLegend call s:SpellLegend()

" utility commands
command! W w

" system-specific changes
if filereadable(glob("~/.config/nvim/local.vim"))
    source ~/.config/nvim/local.vim
endif
