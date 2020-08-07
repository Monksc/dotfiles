let background='dark'
syntax on
" set foldmethod=syntax " set clipboard=unnamed
set ignorecase
set laststatus=2

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set backspace=indent,eol,start

set autowrite

" For Latex
let g:tex_flavor = 'latex'


"colo darcula

" vim ctrl w + hjkl ctrl is removed
let g:C_Ctrl_j='off'
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


call plug#begin()
Plug 'dense-analysis/ale'

Plug 'airblade/vim-gitgutter'

Plug 'jremmen/vim-ripgrep'

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
"Plug 'iamcco/coc-flutter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'| Plug 'honza/vim-snippets'

" Go
"Plug 'fatih/vim-go'
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

Plug 'ctrlpvim/ctrlp.vim'

Plug 'vim-scripts/c.vim'

Plug 'lervag/vimtex'
"
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"
"Plug 'preservim/nerdtree'

Plug 'scrooloose/syntastic'

"Plug 'dr-kino/cscope-maps'

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'OmniSharp/omnisharp-vim'
Plug 'markwoodhall/vim-nuget'

Plug 'kaicataldo/material.vim'
Plug 'vim-airline/vim-airline'
Plug 'mattn/webapi-vim'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim'
call plug#end()

" To install linters
" :CocInstall coc-java

set rtp+=~/.vim/bundle/Vundle.vim

let dart_html_in_string=v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 1

" Enable Flutter menu
"call FlutterMenu()

nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

" For a CoC mood
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" For a ALE mood
inoremap <silent> <C-n> <C-\><C-o>:ALEComplete<CR>
nnoremap <silent> ff :ALEGoToDefinition<CR>
nnoremap <silent> fs :ALEFindReferences<CR>

augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter

set number relativenumber
set ruler
set autowrite

"GO

let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1


set hlsearch " move to color scheme

set statusline=
set statusline+=%f
set statusline+=\ %l:%c

" d now deletes instead of cut
"nnoremap <leader>d "_D
"xnoremap <leader>p "_DP

" Mips Stuff
function! NewFile()
    silent! 0r $HOME/.vim/templates/skeleton.%:e
    s/<FILENAME>/\=expand("%:t:r")
endfunction

function! MipsFunction()
    r $HOME/.vim/templates/mips/functions.s
endfunction

function! MipsFor(fname, id, ivar, length)
    r $HOME/.vim/templates/mips/forloop.s
    %s/<FNAME>/\=a:fname
    %s/<ID>/\=a:id
    %s/<COUNTER_VAR>/\=a:ivar
    %s/<COUNTER_VAR>/\=a:ivar
    %s/<LENGTH>/\=a:length
endfunction

function! MipsIfElse()
    r $HOME/.vim/templates/mips/ifelse.s
endfunction


if has("autocmd")
  augroup templates
    autocmd BufNewFile *.s call NewFile()
    autocmd BufNewFile *.tex call NewFile()
  augroup END
endif

nnoremap <C-m>l :call MipsFor("", "1", "$s0", "10")
nnoremap <C-m>i :call MipsIfElse()<CR>
nnoremap <C-m>f :call MipsFunction()<CR>

" Latex Stuff

function! RedrawOnEnter()
    call input('Press any key to continue') | redraw!
endfunction

function! LatexSave()
    "silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!
    silent execute "!camlatex %" | call RedrawOnEnter()
    silent !open ./*.pdf
    silent !open -a Terminal
    "call RedrawOnEnter()
endfunction
autocmd BufWritePost *.tex call LatexSave()

inoremap {<CR> {<CR>}<Esc>O
"inoremap ( ()<Esc>ha


" Maximize Vim
"function! FullScreen()
"    norm! <C-w>|
"    norm! <C-w>-
"endfunction
"nnoremap <C-w>m !call FullScreen()<CR>
"nnoremap <C-w>M <C-w>=

" Pathogen
execute pathogen#infect()


" My Compiler
"autocmd BufNewFile,BufRead *.wf set syntax=go
function! UpdateWFColors()
    silent set filetype=watsonflowers
    silent color wastonflowerscolo
endfunction
autocmd BufRead,BufNewFile *.wf set filetype=watsonflowers
autocmd BufRead,BufNewFile *.wf colo wastonflowerscolo
"nnoremap <C-o> :call UpdateWFColors()<cr>


" Vim Grep
let g:rg_command = 'rg --vimgrep -S'
let g:rg_highlight = 'true'
"let g:rg_window_location = 'botright'



nnoremap & :RgIdentifier<CR>
nnoremap <C-f> :Rg -F "
nnoremap <C-f>f :RgFunction<CR>
nnoremap <C-f>c :RgCallers<CR>
nnoremap <C-f>s :RgStruct<CR>
nnoremap <C-f>S :RgString<CR>
nnoremap <C-f>t :!clear && tree -I node_modules \| less<CR>
"nnoremap <C-r> :source ~/.vimrc<CR>


" Gruvbox stuff
let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_contrast_light='soft'
set background=dark
"let g:gruvbox_termcolors=16
colo gruvbox
"hi Normal ctermbg=233 guibg=#000000
"hi LineNr ctermbg=233 guibg=#000000



" Material design look
let g:lightline = { 'colorscheme': 'material_vim' }
let g:airline_theme = 'material'
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
colo material
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

colo gruvbox

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}
