" The Number of plugins in spf13 is too damn high!
"                               - Bogdan Dumitru

" General settings / overrides {
	let mapleader = ","
	set pastetoggle=<F2>
	set nocompatible

	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set expandtab
  " Enable mouse
  set mouse=a

	" Tab usage shortcuts
	map <Leader>0 :tabnew<CR>
	map <Leader>- :tabclose<CR>
	map <Leader>1 1gt
	map <Leader>2 2gt
	map <Leader>3 3gt
	map <Leader>4 4gt
	map <Leader>5 5gt
	map <Leader>6 6gt
	map <Leader>7 7gt

  " Maximize window               
  map <Leader>M <C-W>\|<C-W>_

	" Backup files
	set backupdir=~/.vim/tmp/swap
	set directory=~/.vim/tmp/swap
	set viewdir=~/.vim/tmp/view
  set undodir=~/.vim/tmp/undo

  " Persistent undo
  set undofile
  set undolevels=1000
  set undoreload=10000

  " save and restore folds when a file is closed and re-opened
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview 
" }


" Bundle config {
	filetype off              

	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()

	Bundle 'gmarik/vundle'
	source ~/.vim/.vimrc.bundles
	source ~/.vimrc.bundles.local

	filetype plugin indent on
" }

" Solarized {
	syntax enable
	set background=dark
	colorscheme solarized
" }

" Powerlines! {
	let g:Powerline_symbols = 'fancy'
	set clipboard+=unnamed
	set laststatus=2
" }

" NerdTree { 
	map <C-e> :NERDTreeToggle<CR>
	let NERDTreeShowHidden=1
	let NERDTreeQuitOnOpen = 1
" }

" Fugitive {
		nnoremap <silent> <leader>gs :Gstatus<CR>
		nnoremap <silent> <leader>gd :Gdiff<CR>
		nnoremap <silent> <leader>gc :Gcommit<CR>
		nnoremap <silent> <leader>gb :Gblame<CR>
		nnoremap <silent> <leader>gl :Glog<CR>
		nnoremap <silent> <leader>gp :Git push<CR>
		nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
		nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
		nnoremap <silent> <leader>ge :Gedit<CR>
		nnoremap <silent> <leader>gg :GitGutterToggle<CR>
"}

" Ctrlp {
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }
"}

" Qargs {
" https://github.com/nelstrom/vim-qargs
  command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
  function! QuickfixFilenames()
    " Building a hash ensures we get each buffer only once
    let buffer_numbers = {}
    for quickfix_item in getqflist()
      let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
  endfunction
" }


" .vimrc.local includes special user defined configuration options
" This should always be at the end of the file.
source ~/.vimrc.local
