scriptencoding utf-8

if exists('b:current_syntax')
    finish
endif

syntax match DisplaypCurrent '█'
highlight default DisplaypCurrent ctermfg=Red

let b:current_syntax = 'displayp_current'
