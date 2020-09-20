scriptencoding utf-8

if exists('b:current_syntax')
    finish
endif

syntax match DisplaypCurrent '█'
highlight default DisplaypCurrent ctermfg=Red guifg=Red
highlight clear ExtraWhitespace

let b:current_syntax = 'displayp_current'
