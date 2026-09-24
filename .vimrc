" вообще это просто буквальный порт init.lua от неовима
" просто сделанный силами чатгпт

" ============================================================
" Basic settings
" ============================================================

syntax on

set number
set relativenumber
set showcmd
set ruler
set report=0
set incsearch
set hlsearch
set ignorecase
set smartcase
set hidden

set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set foldmethod=indent
set foldlevel=99

" ============================================================
" Leader
" ============================================================

let mapleader = " "
let maplocalleader = " "

" ============================================================
" Key mappings
" ============================================================

nnoremap <leader>b :buffers<CR>:b 
nnoremap <leader>y :%y+<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>s yiw:%s/<C-r>"/

" Pressing <CR> with a count switches to that buffer.
"
" 3<CR>  -> :buffer 3
"
" Without a count, <CR> behaves normally.

function! BufferByCount() abort
    if v:count > 0
        execute 'buffer ' . v:count
    endif
endfunction

nnoremap <silent> <CR> :call BufferByCount()<CR>

" ============================================================
" LSP
" ============================================================

" yegappan/lsp
"
" Install:
"
"   git clone https://github.com/yegappan/lsp \
"       ~/.vim/pack/downloads/opt/lsp
"
" Then Vim loads it here.

packadd lsp


" Lua
call LspAddServer([#{
    \   name: 'lua_ls',
    \   filetype: ['lua'],
    \   path: 'lua-language-server',
    \   args: []
    \ }])


" JavaScript / TypeScript
call LspAddServer([#{
    \   name: 'ts_ls',
    \   filetype: ['javascript', 'typescript'],
    \   path: 'typescript-language-server',
    \   args: ['--stdio']
    \ }])


" Go
call LspAddServer([#{
    \   name: 'gopls',
    \   filetype: ['go'],
    \   path: 'gopls',
    \   args: [],
    \   syncInit: v:true
    \ }])


" Rust
call LspAddServer([#{
    \   name: 'rust_analyzer',
    \   filetype: ['rust'],
    \   path: 'rust-analyzer',
    \   args: [],
    \   syncInit: v:true
    \ }])


" ============================================================
" Go formatting
" ============================================================

augroup GoFormat
    autocmd!
    autocmd BufWritePre *.go silent! LspFormat
augroup END
