:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set notermguicolors

call plug#begin('~/.config/nvim/plugged')

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/windwp/nvim-autopairs' " Autopairs
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Fuzzy search
Plug 'ixru/nvim-markdown' " Markdown
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Treesitter

set encoding=UTF-8

call plug#end()

:colorscheme jellybeans

nnoremap <C-s> :syntax reset<CR>

nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

" Indent left and right
vmap < <gv
vmap > >gv

" vmap <A-k> :m .-2<CR>==
" vmap <A-j> :m .+1<CR>==

inoremap jk <Esc>
" Set tab to comment lines
nmap <Tab><Tab> gcc
vmap <Tab><Tab> gc

" Space bindings
" Clear searches
map <silent> <Space>h :noh<CR>
 " Open fuzzy search
nmap <Space><Space> :Files<CR>

" CoC shorthands
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" :set completeopt-=preview " For No Previews

imap <C-l> <Plug>(coc-snippets-expand)

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Coc
"""""""""""""""""""""""""""""""""""""""""
" Move between completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Autocomplete and format code on return
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"""""""""""""""""""""""""""""""""""""""""

" lua << EOF
" require'nvim-treesitter.configs'.setup {
"   -- A list of parser names, or "all"
"   ensure_installed = { "c", "rust" },

"   -- Install parsers synchronously (only applied to `ensure_installed`)
"   sync_install = false,

"   -- List of parsers to ignore installing (for "all")
"   ignore_install = { "javascript" },

"   highlight = {
"     -- `false` will disable the whole extension
"     enable = true,

"     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
"     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
"     -- the name of the parser)
"     -- list of language that will be disabled
"     -- disable = { "c", "rust" },

"     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"     -- Using this option may slow down your editor, and you may see some duplicate highlights.
"     -- Instead of true it can also be a list of languages
"     additional_vim_regex_highlighting = false,
"   },
" }
" EOF
