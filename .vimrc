" -----------------------------------------------------------------------------
"  GENERAL SETTINGS FOR EVERYONE
"  ----------------------------------------------------------------------------
filetype off
filetype plugin indent on
set nocompatible
set autoindent
set nomodeline " disable modeline vulnerability
set clipboard=unnamed
syntax on
filetype plugin on

"my vimrc commands"
" nnoremap <C-x> :! sh ./% <CR>
nnoremap <C-Left> :tabprevious<CR>                                                                            
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>                                                                            
nnoremap <C-k> :tabnext<CR>

au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

set encoding=utf8

" use 4 spaces for tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

set backspace =indent,eol,start
set hidden
set laststatus =2

" Set linenumbers
set number
set relativenumber
set wrap

" column ruler at 100
"set ruler
"set colorcolumn=120
" set textwidth=120

" Highlight searching
set incsearch
set showmatch
set hlsearch
set ignorecase
set smartcase

" Leader
let mapleader=","
let maplocalleader = "\\"

if has("nvim")
    set inccommand="nosplit"
endif

set autoread " autoread files
set mouse=a " use mouse for scroll or window size

" -----------------------------------------------------------------------------
"  PLUGIN SETUP
"  ----------------------------------------------------------------------------
" Autoload vim plug if not already there

if has("nvim")
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        " autocmd VimEnter * PlugInstall
    endif
else 
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        " autocmd VimEnter * PlugInstall
    endif
endif

" All the plugins are listed here
if has('nvim')
    call plug#begin('~/.config/nvim/plug.vim')
else
    call plug#begin('~/.vim/plug.vim')
  endif

" Productivity
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'bpstahlman/txtfmt' 
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
           
"------------------------------------------------------------------------------
" TXTFMT OPTIONS
"------------------------------------------------------------------------------


autocmd BufNewFile,BufRead *.txt set ft=txtfmt

command! -nargs=1 AddExt execute "saveas ".expand("%:p").<q-args>
command! -nargs=1 ChgExt execute "saveas ".expand("%:p:r").<q-args>

" ----------------------------------------------------------------------------
" PANDOC SETTINGS
"------------------------------------------------------------------------------
augroup autodetect
  autocmd!
    autocmd BufNewFile,BufRead *.dat set ft=plumed
    autocmd Filetype plumed let &runtimepath.=',/Users/lukasherron/.local/bin/plumed-2.7.4/vim'
    autocmd Filetype plumed set completeopt=longest,menuone
    autocmd Filetype plumed let plumed_shortcuts=1
augroup END


autocmd FileType markdown nnoremap <buffer> <C-c> :! pandoc -s -V geometry:margin=1in --pdf-engine=xelatex -o %:r.pdf %:r.md

let mapleader="\\"

" Call compile
" Open the PDF from /tmp/
function! Preview()
        :call Compile()<CR><CR>
        execute "! zathura /tmp/op.pdf &"
endfunction

" [1] Get the extension of the file
" [2] Apply appropriate compilation command
" [3] Save PDF as /tmp/op.pdf
function! Compile()
        let extension = expand('%:e')
        if extension == "ms"
                execute "! groff -ms % -T pdf > /tmp/op.pdf"
        elseif extension == "tex"
                execute "! pandoc -f latex -t latex % -o /tmp/op.pdf"
        elseif extension == "md"
                execute "! pandoc % -s -o /tmp/op.pdf"
        endif
endfunction

" map \ + p to preview
noremap <leader>p :call Preview()<CR><CR><CR>

" map \ + q to compile
noremap <leader>q :call Compile()<CR><CR>


"-------------------------------------------------------------------------------
" SKELETON TEMPLATES
"-------------------------------------------------------------------------------

if has("autocmd")
    augroup templates
        autocmd BufNewFile *_agenda.md 0r ~/.vim/templates/skeleton_agenda.md
        autocmd BufNewFile *_agenda.md execute 'file' fnameescape(strftime("Notes - %Y-%m-%d_agenda.md"))
        autocmd VimEnter *_agenda.md 0pu=strftime('%c')
        autocmd VimEnter *_agenda.md 0s/^/#/g
        autocmd VimEnter *_agenda.md set filetype=markdown
    augroup END
endif
