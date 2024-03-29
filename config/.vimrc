let background='dark'
syntax on
set spell spelllang=en_us
setlocal spell spelllang=en_us
" set foldmethod=syntax
" set clipboard=unnamed

" Plus means clipboard * means selection
nnoremap <Leader>Y "*y
nnoremap <Leader>P "*p
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <ESC>c "+y
nnoremap <ESC>v "+p

inoremap <Leader>Y "*y
inoremap <Leader>P "*p
inoremap <Leader>y "+y
inoremap <Leader>p "+p
inoremap <ESC>c "+y
inoremap <ESC>v "+p

vnoremap <Leader>Y "*y
vnoremap <Leader>P "*p
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
vnoremap <ESC>c "+y
vnoremap <ESC>v "+p

set ignorecase
set laststatus=2
"set shell=bash\ -l

" Up and down left and right padding
set so=8
" set sidescroll=8
" set nowrap
" set wrap

" To see tabs and other chatacters
set list
set listchars=tab:>-,trail:-

" To see commands typed in
"set cmdheight=10

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set backspace=indent,eol,start

set autowrite


fun! s:GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfun

" Add in authour information
let g:snips_author = 'Cameron Monks'
let g:snips_email = 'ccmonks32@gmail.com'
let g:snips_github = 'https://github.com/monksc'

" For Latex
let g:tex_flavor = 'latex'

"colo darcula

" vim ctrl w + hjkl ctrl is removed
let g:C_Ctrl_j='off'
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" vimspector debugger
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
" Easily escape
nmap <Leader>de :VimspectorReset<cr>
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
" Custom debugging ones i made
nmap <Leader>dc <Plug>VimspectorContinue
xmap <Leader>dc <Plug>VimspectorContinue
nmap <Leader>ds <Plug>VimspectorStepOver
xmap <Leader>ds <Plug>VimspectorStepOver
nmap <Leader>di <Plug>VimspectorStepInto
xmap <Leader>di <Plug>VimspectorStepInto
nmap <Leader>db <Plug>VimspectorToggleBreakpoint
xmap <Leader>db <Plug>VimspectorToggleBreakpoint
nmap <Leader>dj <Plug>VimspectorRunToCursor
xmap <Leader>dj <Plug>VimspectorRunToCursor
nmap <Leader>dp <Plug>VimspectorPause
xmap <Leader>dp <Plug>VimspectorPause
nmap <Leader>do <Plug>VimspectorStepOut
xmap <Leader>do <Plug>VimspectorStepOut

" Vim Grep
let g:rg_command = 'rg --vimgrep -S --pcre2'
let g:rg_highlight = 'true'
"let g:rg_window_location = 'botright'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

let g:snipMate = { 'snippet_version' : 1 }

call plug#begin()
" Debugger
Plug 'puremourning/vimspector'

Plug 'vim/killersheep'

Plug 'dense-analysis/ale'

" React
Plug 'eslint/eslint'

"Plug 'airblade/vim-gitgutter'

Plug 'jremmen/vim-ripgrep'

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

" Snippits
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'SirVer/ultisnips'| Plug 'honza/vim-snippets'

" Snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
" Optional:
Plug 'honza/vim-snippets'

" Go
Plug 'fatih/vim-go'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

Plug 'ctrlpvim/ctrlp.vim'

"Plug 'vim-scripts/c.vim'

"Plug 'lervag/vimtex'
"
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"
"Plug 'preservim/nerdtree'

"Plug 'scrooloose/syntastic'

"Plug 'dr-kino/cscope-maps'

Plug 'morhetz/gruvbox'
"Plug 'itchyny/lightline.vim'

"Plug 'OmniSharp/omnisharp-vim'
"Plug 'markwoodhall/vim-nuget'

" Looks at bottom of page
Plug 'kaicataldo/material.vim'
Plug 'vim-airline/vim-airline'

"Plug 'mattn/webapi-vim'
"Plug 'junegunn/fzf.vim'
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

function! Chomp(string)
    return substitute(a:string, '\n', '', '')
endfunction

function! OpenFlutterFiles()
    let line=getline('.')
    let filename=trim(system('my-flutter-tools.sh plugin -a "' . line . '"'))
    let command=':tabnew '.filename
    silent execute command
endfunction

nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>
autocmd BufRead,BufNewFile,BufEnter *.dart nnoremap ff :call OpenFlutterFiles()<cr>

" For a CoC mood
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" For a ALE mood
"inoremap <silent> <C-n> <C-\><C-o>:ALEComplete<CR>
inoremap <silent> <C-k> <C-\><C-o>:ALEComplete<CR>
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

" autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter

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


" Templates

funct! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
endfunct!

function! NewFile()
    let dir = split(finddir('.git/..', expand('%:p').';'), '/\|\')[-1]
" let quote = "'"
" let dir = Exec('!(git rev-parse --show-toplevel 2>/dev/null) | awk -v ' . quote . 'FS=/' . quote . ' ' . quote . '{print $NF }' . quote)
" echo "DIR" . dir
    silent! 0r $HOME/.vim/templates/skeleton.%:e
    %s/<FILENAME>/\=expand("%:t")
    %s/<PROJECT>/\=dir
    %s/<YEAR>/\=strftime("%Y")
    %s/<DATE>/\=strftime("%x")
endfunction

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.s call NewFile()
    autocmd BufNewFile *.c call NewFile()
    autocmd BufNewFile *.h call NewFile()
    autocmd BufNewFile *.tex call NewFile()
  augroup END
endif

" Mips Stuff
"
"function! MipsFunction()
"    r $HOME/.vim/templates/mips/functions.s
"endfunction
"
"function! MipsFor(fname, id, ivar, length)
"    r $HOME/.vim/templates/mips/forloop.s
"    %s/<FNAME>/\=a:fname
"    %s/<ID>/\=a:id
"    %s/<COUNTER_VAR>/\=a:ivar
"    %s/<COUNTER_VAR>/\=a:ivar
"    %s/<LENGTH>/\=a:length
"endfunction
"
"function! MipsIfElse()
"    r $HOME/.vim/templates/mips/ifelse.s
"endfunction


"nnoremap <C-m>l :call MipsFor("", "1", "$s0", "10")
"nnoremap <C-m>i :call MipsIfElse()<CR>
"nnoremap <C-m>f :call MipsFunction()<CR>

" Latex Stuff

function! RedrawOnEnter()
    call input('Press any key to continue') | redraw!
endfunction

function! LatexSave()
    "silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!
    "silent execute "!camlatex %" | call RedrawOnEnter()
    !pdflatex %
    silent !xdg-open ./*.pdf &
    "silent !xdg-open Alacritty &
    "silent !open ./*.pdf
    "silent !open -a Alacritty
    "call RedrawOnEnter()
endfunction
autocmd BufWritePost *.tex call LatexSave()

function! ScadSave()
    !time OpenSCAD -o a.stl %
    silent !open a.stl
    silent !open -a Alacritty
endfunction
autocmd BufWritePost *.scad call ScadSave()


"un! Getchar()
" return strcharpart(strpart(getline('.'), col('.') - 1), 0, 1)
"ndfun
"
"un! TypedQuote()
"   let s:currentchar = Getchar()
"   if s:currentchar == '"'
"       execute "insert <Right>"
"   else
"       execute "insert hello\r"
"   endif
"ndfun


inoremap {<CR> {<CR>}<Esc>O
"inoremap " ""<Left>
"inoremap " <esc>:call TypedQuote()<CR>i"<Left>"
inoremap <C-q> <C-a>
inoremap <C-a> <Esc>I
inoremap <C-r> <C-e>
inoremap <C-e> <Esc>A
inoremap <C-f> <Right>
inoremap <C-b> <Left>




"inoremap ( ()<Esc>ha


" Maximize Vim
"function! FullScreen()
"    norm! <C-w>|
"    norm! <C-w>-
"endfunction
"nnoremap <C-w>m !call FullScreen()<CR>
"nnoremap <C-w>M <C-w>=

" Pathogen
"execute pathogen#infect()


" My Compiler
"autocmd BufNewFile,BufRead *.wf set syntax=go
"function! UpdateWFColors()
"    silent set filetype=watsonflowers
"    silent color wastonflowerscolo
"endfunction
"autocmd BufRead,BufNewFile *.wf set filetype=watsonflowers
"autocmd BufRead,BufNewFile *.wf colo wastonflowerscolo
"nnoremap <C-o> :call UpdateWFColors()<cr>



nnoremap & :RgIdentifier<CR>
nnoremap <C-f> :Rg -F "
nnoremap <C-f>f :RgFunction<CR>
nnoremap <C-f>c :RgCallers<CR>
nnoremap <C-f>s :RgStruct<CR>
nnoremap <C-f>S :RgString<CR>
"nnoremap <C-r> :source ~/.vimrc<CR>


" Switching between tabs
nnoremap <C-w>s <C-w>s
nnoremap <C-w>v <C-w>v
nnoremap <C-w>h <C-w>h
nnoremap <C-w>j <C-w>j
nnoremap <C-w>k <C-w>k
nnoremap <C-w>l <C-w>l
nnoremap <C-w>H <C-w>H
nnoremap <C-w>J <C-w>J
nnoremap <C-w>K <C-w>K
nnoremap <C-w>L <C-w>L
nnoremap <C-w>x <C-w>x
nnoremap <C-w>= <C-w>=
nnoremap <C-w>\| <C-w>\|
nnoremap <C-w>_ <C-w>_

nnoremap <C-w>- <C-w>-
"nnoremap - <C-w>-
nnoremap <C-w>+ <C-w>+
"nnoremap + <C-w>+

nnoremap <C-w>> <C-w>>
"nnoremap <lt> <C-W><lt>
nnoremap <C-w>< <C-w><
"nnoremap > <C-w>>

nnoremap <C-w>e :Explore<CR>

function! TabNextXTimes(x, command)
    if a:x==0
        execute a:command
    else
        "execute '.,.+' . a:x . 'tabnext'
        execute a:command
    endif
endfunction

nnoremap <C-w> :echo "I PREVENTED IT FROM DOING SOMETHING STUPID"<CR>
"nnoremap <C-w>n ":.,.+".v:count."tabnext"
nnoremap <C-w>n :call TabNextXTimes(v:count, "tabnext")<CR>
"nnoremap <C-w>p :tabprev<CR>
nnoremap <C-w>p :call TabNextXTimes(v:count, "tabprev")<CR>
nnoremap <C-w>c :tabnew .<CR>
nnoremap <C-w>C :Texplore .<CR>
nnoremap <C-w>0 :tabfirst<CR>
nnoremap <C-w>1 :tabnext 1<CR>
nnoremap <C-w>2 :tabnext 2<CR>
nnoremap <C-w>3 :tabnext 3<CR>
nnoremap <C-w>4 :tabnext 4<CR>
nnoremap <C-w>5 :tabnext 5<CR>
nnoremap <C-w>6 :tabnext 6<CR>
nnoremap <C-w>7 :tabnext 7<CR>
nnoremap <C-w>8 :tabnext 8<CR>
nnoremap <C-w>9 :tabnext 9<CR>
nnoremap <C-w>$ :tablast<CR>


nnoremap <C-T>r :!tree -I "node_modules\|cache\|test_*\|build" \| less<CR>
nnoremap <C-w>t :split<CR><C-w>T
nnoremap <C-w>T <C-w>T
"nnoremap <C-T>e :set shell=bash\ -l<CR>:terminal<CR><C-w>J<C-w>10000-<C-w>20+<C-w>k:set shell=''<CR><C-w>j
nnoremap <C-T>e :terminal<CR><C-w>J<C-w>10000-<C-w>20+source $HOME/.bash_profile<CR>
"nnoremap <C-T>e :terminal<CR><C-w>J<C-w>10000-<C-w>20+

" Terminal mode

tnoremap <C-w> <C-w>.
tnoremap <C-w>w <C-w>.
tnoremap <C-w>. <C-w>.
tnoremap <C-w>h <C-w>h
tnoremap <C-w>j <C-w>j
tnoremap <C-w>k <C-w>k
tnoremap <C-w>l <C-w>l
tnoremap <C-w>H <C-w>H
tnoremap <C-w>J <C-w>J
tnoremap <C-w>K <C-w>K
tnoremap <C-w>L <C-w>L

" ShortCuts
" ab #i #include
" ab main #include <stdio.h><CR><CR>int main(int argc, char * argv[]) {<CR>printf("HELLO WORLD\n");<CR>return 0;<CR><esc>dd2kA
" nt main(int argc, char * argv[]) {
" printf("HELLO WORLD\n");
" 
" return 0;
" }

function! WriteToPipeWriter(foo)
    "silent execute 'silent !easypipe write vim -m ' . "$'" . escape(a:foo, "'") . "'" . '&' | redraw!
    "set shell=''
    for i in split(a:foo, '\n')
        " execute 'silent !pipe-writer -f vim -m ' . "$'" . escape(i, "'") . "'" . '&' | redraw!
        "execute 'silent !easypipe write vim -m ' . "$'" . escape(i, "'") . "'" . '&' | redraw!
        silent execute 'silent !easypipe write vim -m ' . "$'" . escape(i, "'%") . "'" . '&' | redraw!
        " silent execute '!easypipe write vim -m ' . "$'" . escape(i, "'") . "'"
    endfor
    silent execute 'silent !easypipe write vim -m " $(ascii 10)" &' | redraw!
    "set shell=bash\ -l
endfunction

"vnoremap <leader>r y:call WriteToPipeWriter(<C-R>=string(@")<CR>)<CR>
vnoremap <silent> <leader>r y:call WriteToPipeWriter(<C-R>=string(@")<CR>)<CR>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

function! ViewPasteHistory()
    let char = nr2char(getchar())
    while char =~ '^\j$'
        execute "normal u."
        redraw!
        let char = nr2char(getchar())
    endwhile
endfunction

nnoremap <leader>p "1p:call ViewPasteHistory()<CR>


" Gruvbox stuff
" let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
set background=dark
let g:gruvbox_termcolors=16
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
\ 'cs': ['OmniSharp'],
\ 'python': ['flake8', 'pylint', 'python-lsp-server']
\}

let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ 'c': ['gcc'],
  \ 'c++': ['gcc'],
  \ '.h': ['gcc']
\}

" let b:ale_linters = ['flake8', 'pylint']

let g:ale_cpp_gcc_options='-std=c++98 -Wall -Wextra'
let g:ale_c_gcc_options='-std=c99 -Wall -Wextra'

" augroup project
"   autocmd!
"   autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
" augroup END
" let &path.="src/include,/usr/include/AL,"
" set includeexpr=substitute(v:fname,'\\.','/','g')

command! -nargs=* -complete=file Hexview  :%!xxd
command! -nargs=* -complete=file Hexviewr :%!xxd -r

" set ft=tmux tw=0 nowrap

" Lighten the color of the current line and change line number to gold
" so you can easily see what line you are editing
se cursorline


" Useful commands
" Code folding
"       mb on start line
"       zf'b on endline
"
"       zo open fold
"       zc to close fold
"       za to toggle
" Indent code
"   =i{
" vip to visual a paragraph
" <C-a> to increment a number

hi SpellBad cterm=underline
