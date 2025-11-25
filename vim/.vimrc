" ~/dotfiles/vim/.vimrc

" --- General Settings ---
set nocompatible            " Disable vi compatibility
set number                  " Show line numbers
set relativenumber          " Show relative line numbers (great for jumping)
set ruler                   " Show cursor position
syntax on               " Enable syntax highlighting
set clipboard=unnamedplus   " Use system clipboard (requires vim-gtk/features)

" --- Indentation ---
set tabstop=4               " Tab width
set shiftwidth=4            " Indent width
set expandtab               " Use spaces instead of tabs
set autoindent              " Copy indent from current line when starting new one

" --- Search ---
set ignorecase              " Ignore case when searching...
set smartcase               " ...unless capital letters are used
set hlsearch                " Highlight search results
set incsearch               " Jump to result as you type

" --- UI ---
set scrolloff=8             " Keep 8 lines above/below cursor when scrolling
set wildmenu                " Visual autocomplete for command menu
