"""""" Plugins """"""
call plug#begin("~/.vim/plugged")
  " Color schemes
  Plug 'marko-cerovac/material.nvim'

  Plug 'scrooloose/nerdtree' " Tree view
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ryanoasis/vim-devicons' " Icons
  Plug 'nvim-lua/plenary.nvim' " Utils lib, dependency of other plugs 
  Plug 'nvim-lualine/lualine.nvim' " Bottom bar
  Plug 'lukas-reineke/indent-blankline.nvim' " Show ident lines
  Plug 'Xuyuanp/nerdtree-git-plugin' " Git status in treeview
  Plug 'norcalli/nvim-colorizer.lua' " Show hex/css colors
  Plug 'lewis6991/gitsigns.nvim' " Git status in the gutter + inline blame
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' } " Top bufferline
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'windwp/nvim-ts-autotag'

  " Telescope - file nav/grepper
  Plug 'BurntSushi/ripgrep' " Depedency of telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'sharkdp/fd' " Depedency of telescope
call plug#end()

""""""""""""""""""""
"" Generic Config ""
set cursorline " highlight the current line
set number " line numbers
set expandtab " use spaces for tabs
set shiftwidth=2 " tabs size (ident)
set tabstop=2 " tabs size (tab char)
set updatetime=300
set completeopt=menuone,noinsert,noselect " improve autocomplete
set clipboard=unnamed " link nvim clipboard with macos 
let mapleader = "\<C-l>"
set ic " ignore case for searches
set termguicolors
syntax enable
let g:material_style = "darker"
colorscheme material

" Highlight on yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400}
augroup END

"""" Generic - Keybinds
nnoremap <leader>s <cmd>w<cr>
nnoremap <silent><leader><Tab> :BufferLineCycleNext<CR>
nnoremap <silent><leader><S-Tab> :BufferLineCyclePrev<CR>

"""""""""""""
"""" CoC """"
nmap <leader>rs <Plug>(coc-rename)
set hidden " todo
set nobackup " needed by coc
set nowritebackup " needed by coc
set shortmess+=c " improve autocomlete
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab to scroll through suggestions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"""" CoC - Keybinds
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>jj <Plug>(coc-implementation)
nmap <silent> <leader>jr <Plug>(coc-references)
nmap <silent> <leader>rr <Plug>(coc-rename)
nmap <silent> <leader>qq <cmd>CocAction<cr> 
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


""""""""""""""""""
"""" NerdTree """"
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeWinSize=45

" Autoopen NERDTree if nvim is started without arguments, then unfocus it by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

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

" hide the path at the top of the window
augroup nerdtreehidecwd
  autocmd!
  autocmd FileType nerdtree setlocal conceallevel=3
          \ | syntax match NERDTreeHideCWD #^[</].*$# conceal
          \ | setlocal concealcursor=n
augroup end

"""" NerdTree - Keybinds 
nnoremap <leader>b <cmd>NERDTreeFocus<cr>


"""""""""""""""""""
"""" Telescope """"
"""" Telescope - Keybinds 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" import lua config
luafile ~/.config/nvim/lua/init.lua

