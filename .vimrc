set background=dark
set termguicolors
set number
set laststatus=2
set expandtab
set tabstop=2
set softtabstop=2
set cursorline

" Plug
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdTree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'sjl/gundo.vim'
  Plug 'rking/ag.vim'
call plug#end()

" Leader
let mapleader = ","

" Insert Remaps
inoremap jk <esc>

" Normal Remaps
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>a :Ag

" Global Remaps
map <C-n> :NERDTreeToggle<CR>

" CtrlP Setup
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Autogroups
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.rb,*.md
              \:call <SID>StripTrailingWhitespaces()
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
augroup END


" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

" NerdTree Setup
let NERDTreeShowHidden=1

" Color Scheme Setups
let g:lightline = { 'colorscheme': 'onedark' }
let g:onedark_hide_endofbuffer = 1
colorscheme onedark
