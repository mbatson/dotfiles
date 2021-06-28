" Must install and run base16-shell for base16 256 color themes to work
" correctly.
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default-dark

syntax on
set encoding=utf-8
set showmode
set showcmd

" Fixes common backspace problems
set backspace=indent,eol,start

" Turn off vi compatibility
set nocompatible

" Show the line and column number of the cursor position
set ruler

" Show relative line numbers
set relativenumber

" Automatically wrap text beyond screen length
set wrap
" Avoid text wrapping in the middle of a word
set linebreak
" Remap j and k keys to move by screen line instead of buffer line
nnoremap j gj
nnoremap k gk

" Automatically match indentation on new lines
set autoindent

" Search options (ignorecase and smartcase together make searches ignore case
" if all lower case and case sensitive if upper case appears)
set hlsearch
set smartcase
set ignorecase
set incsearch

" Set clipboard to X's CLIPBOARD buffer
set clipboard=unnamedplus
