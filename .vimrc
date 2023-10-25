
" macOS-specific settings for clipboard integration
if has("mac")
    " Map Cmd + V to paste from clipboard
	nnoremap <D-v> "+p
        inoremap <D-v> <Esc>"+pi
        vnoremap <D-v> <Esc>"+p
        endif
                

" Initialize plugin system
call plug#begin('~/.vim/plugged')

inoremap <Tab> <C-n>
set backspace=indent,eol,start

" Highlight search results as you type
set incsearch
" " Keep the search result highlighted until you start a new search
set hlsearch"

" Python IDE Plugins

" Syntax highlighting and more for Python
Plug 'vim-python/python-syntax'

" Linting for Python
Plug 'neomake/neomake'

" Autocompletion
Plug 'davidhalter/jedi-vim'

" File browsing
Plug 'scrooloose/nerdtree'

" Enhanced status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Close brackets automatically
Plug 'jiangmiao/auto-pairs'

" End of plugin system
call plug#end()

" Python IDE settings

" Enable filetype plugins
filetype plugin on
filetype indent on

" Use Jedi for Python autocompletion
let g:jedi#auto_vim_configuration = 1
let g:jedi#use_splits_not_buffers = "right"

" Use Neomake for linting
let g:neomake_python_enabled_makers = ['flake8']
autocmd! BufWritePost * Neomake

" Automatically open and close the NERDTree
map <C-n> :NERDTreeToggle<CR>

" Airline configurations
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'

" Auto-pairs configuration
let g:AutoPairsFlyMode = 1

" Linting for Bash with shellcheck using Neomake
autocmd FileType sh let b:neomake_sh_enabled_makers = ['shellcheck']

autocmd FileType sh let b:neomake_sh_enabled_makers = ['shellcheck']

nnoremap <F2> :%s/\t/    /g<CR>

" Folding settings
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " don't fold by default

"" Keybinding to toggle folding
nnoremap <space> za
"
" "
