""""""""""""""""""""
"" Generic Config ""
set cursorline " highlight the current line
set hidden " todo
set mouse=a " enable the mouse
set number " line numbers
set expandtab " use spaces for tabs
set shiftwidth=2 " tabs size (ident)
set tabstop=2 " tabs size (tab char)
set nobackup " needed by coc
set nowritebackup " needed by coc
set updatetime=300
set shortmess+=c
set completeopt=menuone,noinsert,noselect


"""""""""""""""""""""
"""""" Plugins """"""
call plug#begin("~/.vim/plugged")
  Plug 'marko-cerovac/material.nvim'
  Plug 'dracula/vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neovim/nvim-lspconfig'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'nvim-lua/plenary.nvim'

  " Telescope
  Plug 'BurntSushi/ripgrep'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'sharkdp/fd'
  
  " Autocomplete
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  " Snippets
  Plug 'SirVer/ultisnips'
call plug#end()

"""""""""""""""""""""
"" Plugins Config  ""

""" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Autoopen NERDTree if nvim is started without arguments, then unfocus it by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"autocmd VimEnter * call NERDTreeAddKeyMap({
"  \ 'key': 'left',
"  \ 'callback': 'NERDTreeQQ',
"  \ 'quickhelpText': 'openclose dir with arrow keys' })
"function! NERDTreeQQ(dirnode)
"  dirnode.close()
"endfunction


" set term colors and enable color scheme
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
let g:material_style = "darker"
"colorscheme material
colorscheme dracula

" Telescope



" import lua config
luafile ~/.config/nvim/lua/init.lua
