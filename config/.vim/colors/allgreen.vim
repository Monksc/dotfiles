"
" Darcula colorscheme for VIM.
"

highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "allgreen"

hi Cursor ctermfg=188 ctermbg=250 cterm=NONE guifg=#2b2b2b guibg=#a9b7c6 gui=NONE
hi Visual ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#214283 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#323232 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#313335 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#313335 gui=NONE
hi CursorLineNr ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#214283 gui=NONE
hi VertSplit ctermfg=60 ctermbg=236 cterm=NONE guifg=#555555 guibg=#323232 gui=NONE
hi MatchParen ctermfg=173 ctermbg=NONE cterm=underline guifg=#c57825 guibg=NONE gui=underline
hi StatusLine ctermfg=67 ctermbg=236 cterm=bold guifg=#a9b7c6 guibg=#323232 gui=bold
hi StatusLineNC ctermfg=188 ctermbg=236 cterm=NONE guifg=#a9b7c6 guibg=#323232 gui=NONE
hi Search term=reverse ctermfg=188 ctermbg=24 guifg=#a9b7c6 guibg=#214283 gui=none
hi IncSearch term=reverse ctermfg=188 ctermbg=24 guifg=#323232 guibg=#b1c73d gui=none
hi Directory ctermfg=103 ctermbg=NONE cterm=NONE guifg=#9676ac guibg=NONE gui=italic
hi Folded ctermfg=244 ctermbg=235 cterm=NONE guifg=#8e9292 guibg=#2b2b2b gui=NONE

hi Normal ctermfg=255 ctermbg=235 cterm=bold guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
hi Boolean ctermfg=51 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi Character ctermfg=11 ctermbg=NONE cterm=NONE guifg=#9676ac guibg=NONE gui=italic
hi Comment ctermfg=250 ctermbg=NONE cterm=NONE guifg=#8e9292 guibg=NONE gui=none
hi Conditional ctermfg=12 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi Constant ctermfg=12 ctermbg=NONE cterm=NONE guifg=#9676ac guibg=NONE gui=bold
hi Define ctermfg=12 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi DiffAdd ctermfg=12 ctermbg=64 cterm=bold guifg=#a9b7c6 guibg=#365546 gui=bold
hi DiffDelete ctermfg=12 ctermbg=NONE cterm=NONE guifg=#8c0909 guibg=NONE gui=NONE
hi DiffChange ctermfg=12 ctermbg=23 cterm=NONE guifg=#a9b7c6 guibg=#263b59 gui=NONE
hi DiffText ctermfg=12 ctermbg=24 cterm=bold guifg=#a9b7c6 guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=9 ctermbg=88 cterm=NONE guifg=#ffffff guibg=#990000 gui=NONE
hi WarningMsg ctermfg=11 ctermbg=88 cterm=NONE guifg=#ffffff guibg=#990000 gui=NONE
hi Float ctermfg=14 ctermbg=NONE cterm=NONE guifg=#7ca8c6 guibg=NONE gui=NONE
hi Function ctermfg=82 ctermbg=NONE cterm=bold guifg=#c57825 guibg=NONE gui=bold
hi Identifier ctermfg=82 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi Keyword ctermfg=80 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi Label ctermfg=12 ctermbg=NONE cterm=NONE guifg=#9676ac guibg=NONE gui=NONE
hi NonText ctermfg=19 ctermbg=235 cterm=NONE guifg=#888888 guibg=#2b2b2b gui=NONE
hi Number ctermfg=51 ctermbg=NONE cterm=NONE guifg=#7ca8c6 guibg=NONE gui=NONE
hi Operator ctermfg=255 ctermbg=NONE cterm=NONE guifg=#a9b7c6 guibg=NONE gui=NONE
hi PreProc ctermfg=12 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi Special ctermfg=12 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi SpecialKey ctermfg=12 ctermbg=236 cterm=NONE guifg=#bfbfbf guibg=#313335 gui=NONE
hi Statement ctermfg=217 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi StorageClass ctermfg=217 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold

hi String ctermfg=11 ctermbg=NONE cterm=NONE guifg=#5e8759 guibg=NONE gui=NONE
hi Tag ctermfg=217 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Title ctermfg=217 ctermbg=NONE cterm=bold guifg=#a9b7c6 guibg=NONE gui=bold
hi Todo ctermfg=14 ctermbg=NONE cterm=NONE guifg=#b1c73d guibg=NONE gui=bold,italic
hi Type ctermfg=51 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi Underlined ctermfg=13 ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi htmlTag ctermfg=130 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi htmlEndTag ctermfg=130 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi htmlTagName ctermfg=130 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi htmlString ctermfg=130 ctermbg=NONE cterm=NONE guifg=#8dc35b guibg=NONE gui=NONE
hi htmlArg ctermfg=130 ctermbg=NONE cterm=NONE guifg=#a9b7c6 guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=130 ctermbg=NONE cterm=NONE guifg=#67609c guibg=NONE gui=italic
hi yamlKey ctermfg=130 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAnchor ctermfg=130 ctermbg=NONE cterm=NONE guifg=#7ca8c6 guibg=NONE gui=NONE
hi yamlAlias ctermfg=130 ctermbg=NONE cterm=NONE guifg=#7ca8c6 guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=130 ctermbg=235 cterm=NONE guifg=NONE guibg=#292929 gui=NONE
hi cssURL ctermfg=NONE ctermbg=130 cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName ctermfg=130 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
hi cssColor ctermfg=130 ctermbg=NONE cterm=NONE guifg=#9676ac guibg=NONE gui=italic
hi cssPseudoClassId ctermfg=130 ctermbg=NONE cterm=NONE guifg=#d0d0ff guibg=NONE gui=NONE
hi cssClassName ctermfg=130 ctermbg=NONE cterm=NONE guifg=#d0d0ff guibg=NONE gui=NONE
hi cssValueLength ctermfg=130 ctermbg=NONE cterm=NONE guifg=#7ca8c6 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=130 ctermbg=NONE cterm=bold guifg=#06960e guibg=NONE gui=bold
hi cssBraces ctermfg=130 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

" Adjust the gutter.
"let g:gitgutter_override_sign_column_highlight = 0 " Tell git gutter to leave the background alone.
hi SignColumn ctermfg=93 ctermbg=236 cterm=NONE guifg=#888888 guibg=#323232 gui=NONE
hi LineNr ctermfg=93 ctermbg=236 cterm=NONE guifg=#888888 guibg=#323232 gui=NONE

" Extra Ruby highlighting.
hi rubyClass ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi rubyFunction ctermfg=222 ctermbg=NONE cterm=bold guifg=#c57825 guibg=NONE gui=bold
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=103 ctermbg=NONE cterm=NONE guifg=#67609c guibg=NONE gui=italic
hi rubyConstant ctermfg=68 ctermbg=NONE cterm=bold guifg=#9676ac guibg=NONE gui=bold
hi rubyStringDelimiter ctermfg=65 ctermbg=NONE cterm=NONE guifg=#5e8759 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
hi rubyInclude ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi rubyGlobalVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
hi rubyRegexp ctermfg=65 ctermbg=NONE cterm=NONE guifg=#5e8759 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=65 ctermbg=NONE cterm=NONE guifg=#5e8759 guibg=NONE gui=NONE
hi rubyEscape ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi rubyControl ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi rubyException ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi rubyPseudoVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#318495 guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=256 ctermbg=NONE cterm=bold guifg=#bbbbbb guibg=NONE gui=bold
hi rubyRailsARAssociationMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
hi rubyRailsARMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
hi rubyRailsRenderMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
hi rubyRailsMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=244 ctermbg=NONE cterm=NONE guifg=#8e9292 guibg=NONE gui=italic
hi erubyRailsMethod ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold

" Extra js highlighting.
hi jsFuncName ctermfg=222 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi jsFunction ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
"hi jsNoise ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi jsFuncCall ctermfg=222 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi jsComment ctermfg=244 ctermbg=NONE cterm=NONE guifg=#8e9292 guibg=NONE gui=none
hi jsBlockComment ctermfg=65 ctermbg=NONE cterm=NONE guifg=#5e8759 guibg=NONE gui=NONE
hi jsDocTags ctermfg=65 ctermbg=NONE cterm=bold guifg=#5e8759 guibg=NONE gui=bold
hi jsDocType ctermfg=65 ctermbg=NONE cterm=bold guifg=#5e8759 guibg=NONE gui=bold
hi jsFunctionKey ctermfg=222 ctermbg=NONE cterm=bold guifg=#c57825 guibg=NONE gui=bold
hi jsCommonJs ctermfg=222 ctermbg=NONE cterm=bold guifg=#c57825 guibg=NONE gui=bold
"hi jsParen ctermfg=222 ctermbg=NONE cterm=bold guifg=#c57825 guibg=NONE gui=bold
hi jsParen ctermfg=188 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
"hi jsFuncBlock ctermfg=103 ctermbg=NONE cterm=NONE guifg=#67609c guibg=NONE gui=italic
hi javaScriptFunction ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi javaScriptRailsFunction ctermfg=59 ctermbg=NONE cterm=bold guifg=#3c4c72 guibg=NONE gui=bold
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi jsObjectKey ctermfg=103 ctermbg=NONE cterm=bold guifg=#9676ac guibg=NONE gui=bold
hi jsGlobalObjects ctermfg=103 ctermbg=NONE cterm=bold guifg=#9676ac guibg=NONE gui=bold


" Extra Markdown highlighing.
hi markdownHeadingDelimiter ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold
hi markdownH1 ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi markdownH2 ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi markdownH3 ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi markdownH4 ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi markdownH5 ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi markdownH6 ctermfg=222 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE

" Extra Jade highlighing.
hi jadeId ctermfg=103 ctermbg=NONE cterm=NONE guifg=#67609c guibg=NONE gui=italic
hi jadeClass ctermfg=103 ctermbg=NONE cterm=NONE guifg=#9676ac guibg=NONE gui=NONE
hi jadePipedText ctermfg=65 ctermbg=NONE cterm=NONE guifg=#5e8759 guibg=NONE gui=NONE

" Extra JSON highlighting.
hi jsonBraces ctermfg=188 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE

" Extra CoffeeScript highlighting.
hi coffeeObject ctermfg=188 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
hi coffeeObjAssign ctermfg=222 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi coffeeSpecialVar ctermfg=188 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE

" Extra Java highlighting.
hi javaAnnotation ctermfg=222 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi javaTypeDef ctermfg=222 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
"hi javaOperator ctermfg=222 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE

" Extra VIM highlighting.
hi vimOption ctermfg=172 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi vimUserFunc ctermfg=172 ctermbg=NONE cterm=NONE guifg=#d9c767 guibg=NONE gui=NONE
hi vimCommand ctermfg=172 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=NONE
hi vimParenSep ctermfg=172 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
hi vimVar ctermfg=172 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
hi vimFuncName ctermfg=172 ctermbg=NONE cterm=NONE guifg=#a9b7c6 guibg=NONE gui=NONE
hi vimIsCommand ctermfg=172 ctermbg=235 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE

" Extra CtrlP highlighting.
hi CtrlPMatch term=reverse ctermfg=172 ctermbg=24 guifg=#a9b7c6 guibg=#214283 gui=none

" Python specific highlighting.
hi pythonOperator ctermfg=159 ctermbg=NONE cterm=NONE guifg=#c57825 guibg=NONE gui=bold

" Popup Highlighing.
hi Pmenu ctermfg=72 ctermbg=238 cterm=NONE guifg=NONE guibg=#323232 gui=NONE
hi PmenuSel ctermfg=72 ctermbg=24 term=reverse guifg=NONE guibg=#214283 gui=NONE
hi PmenuSbar  ctermfg=72 ctermbg=24 guifg=NONE guibg=#8e9292
hi PmenuThumb ctermfg=72 ctermbg=NONE guifg=NONE guibg=NONE

" Spelling highlighting.
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad ctermfg=9 ctermbg=NONE cterm=undercurl term=undercurl guifg=#aeae80 guibg=NONE gui=undercurl
hi SpellCap ctermfg=9 ctermbg=NONE cterm=undercurl guifg=#aeae80 guibg=NONE gui=undercurl
hi SpellRare ctermfg=9 ctermbg=NONE cterm=undercurl guifg=#aeae80 guibg=NONE gui=undercurl
hi SpellLocal ctermfg=9 ctermbg=NONE cterm=undercurl guifg=#aeae80 guibg=NONE gui=undercurl

" NonText are 'end of the window' symbols, showbreak and various others. See :he highlight-groups
hi NonText ctermfg=72 ctermbg=NONE cterm=NONE guifg=#8e9292 guibg=NONE gui=none

" Highlighting for built-in tabs.
hi TabLineFill ctermfg=72 ctermbg=16 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
hi TabLine ctermfg=72 ctermbg=16 cterm=NONE guifg=#a9b7c6 guibg=#2b2b2b gui=NONE
hi TabLineSel ctermfg=72 ctermbg=59 cterm=NONE guifg=#a9b7c6 guibg=#515658 gui=NONE

set background=dark
hi Normal ctermbg=232 guibg=#000000
hi LineNr ctermbg=0 guibg=#000000
