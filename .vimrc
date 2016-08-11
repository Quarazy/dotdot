execute pathogen#infect()
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
syntax on
filetype plugin indent on
set ruler
set nu

"set binary
"set noeol
"Ctrl + N = auto word completion when editing
set expandtab

map <C-j> :NERDTreeToggle<CR>

autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
