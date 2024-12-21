" Vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
" File explorer
Plug 'preservim/nerdtree'

" For NERDTree enhancement
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Language Server Protocol (LSP) support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Scheme for Vimm
Plug 'morhetz/gruvbox'

" Auto pairs for brackets
Plug 'jiangmiao/auto-pairs'

" Code snippets
Plug 'honza/vim-snippets'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Indetn Line Plugins
Plug 'Yggdroot/indentLine'

" File searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

"----------------------BASIC CONFIGURATINO------------

filetype on
filetype plugin on
filetype indent on
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set showmatch
set wrap
set linebreak
set noswapfile
set nobackup
set scrolloff=8
set sidescrolloff=8
set updatetime=300
set signcolumn=yes
set nocompatible
set shortmess+=I
set clipboard=unnamed
set number
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase
set incsearch
set ruler
set showcmd
set wildmenu
set mouse+=a
let mapleader = ","
syntax on

" --------------------REMAP CONFIGURATINO-----------------

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
map <S-w>w <C-w>w  " 循环切换窗口
map <S-w>h <C-w>h  " 移动到左边窗口
map <S-w>j <C-w>j  " 移动到下面窗口
map <S-w>k <C-w>k  " 移动到上面窗口
map <S-w>l <C-w>l  " 移动到右边窗口
map <S-w>v <C-w>v  " 垂直分割窗口
map <S-w>s <C-w>s  " 水平分割窗口
map <S-w>c <C-w>c  " 关闭当前窗口
nnoremap <Leader>p :bp<CR>
" --------------------Plugin CONFIGURATINO----------------
"---COC---
nmap <leader>rn <Plug>(coc-rename)
autocmd BufWritePre *.py :silent call CocAction('format')

" Tab 键直接选中补全项
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Shift+Tab 选择下一项
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"

" function for auto-completion
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ------NERDTree-------

" 启用 devicons
let g:webdevicons_enable = 1
" 启用 NERDTree 图标
let g:webdevicons_enable_nerdtree = 1
" 文件夹图标
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" 不显示隐藏文件
let NERDTreeShowHidden = 0
" 启用文件类型图标
let g:WebDevIconsUnicodeDecorateFileNodes = 1
" 自动跟随
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoCenter = 1

"autostart for nerdtree
autocmd VimEnter * NERDTree

" Start NERDTree when Vim starts with no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree when Vim starts with a directory argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window remaining in the only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" 切换 NERDTree，定位到当前文件，并将光标定位到 NERDTree 窗口
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
" -----FZF configuration-----
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>

let g:indentLine_char = '┊'  " 设置缩进线字符
let g:indentLine_enabled = 1  " 默认启用

"------------------------ 设置主题-------------------------

let g:gruvbox_contrast_dark = 'medium'
:set bg=dark
colorscheme gruvbox
