" Tab settings
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Tab usage shortcuts
map <Leader>0 :tab new<CR>
map <Leader>- :tabclose<CR>
map <Leader>1 1gt
map <Leader>2 2gt
map <Leader>3 3gt
map <Leader>4 4gt
map <Leader>5 5gt
map <Leader>6 6gt
map <Leader>7 7gt

" Backup files
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap

" Bundles
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
source ~/.vim/.vimrc.bundles
source ~/.vimrc.bundles.local

filetype plugin indent on     " required!

" Solarized
syntax enable
set background=dark
colorscheme solarized

" Power lines win
let g:Powerline_symbols = 'fancy'
set clipboard+=unnamed
set laststatus=2

" NerdTree
map <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen = 1

" .vimrc.local includes special user defined configuration options
" This should always be at the end of the file.
source ~/.vimrc.local
