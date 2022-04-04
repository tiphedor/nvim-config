""""""""""""""""""""
"" Generic Config ""
set cursorline " highlight the current line
set hidden " todo
set number " line numbers
set expandtab " use spaces for tabs
set shiftwidth=2 " tabs size (ident)
set tabstop=2 " tabs size (tab char)
set nobackup " needed by coc
set nowritebackup " needed by coc
set updatetime=300
set shortmess+=c " improve autocomlete
set completeopt=menuone,noinsert,noselect " improve autocomplete
set clipboard=unnamed " link nvim clipboard with macos

"""""""""""""""""""""
"""""" Plugins """"""
call plug#begin("~/.vim/plugged")
  " Themes
  Plug 'marko-cerovac/material.nvim'
  Plug 'christianchiarulli/nvcode-color-schemes.vim'
  Plug 'dracula/vim'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'neovim/nvim-lspconfig'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'Xuyuanp/nerdtree-git-plugin'

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

" Sync openned file with what NERDTree is showing
  function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
  endfunction

  " Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
  " file, and we're not in vimdiff
  function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
      NERDTreeFind
      wincmd p
    endif
  endfunction
  autocmd BufRead * call SyncTree() " Run when buffer changes

" set term colors and enable color scheme
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

"let g:material_style = "darker"
"colorscheme material

"colorscheme dracula
"colorscheme nvcode
let g:tokyonight_style = "night"
colorscheme tokyonight

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" import lua config
luafile ~/.config/nvim/lua/init.lua
