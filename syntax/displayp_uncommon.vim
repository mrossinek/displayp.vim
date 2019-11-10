scriptencoding utf-8

if exists('b:current_syntax')
    finish
endif

syntax match DisplaypUncommon '█'
highlight default DisplaypUncommon ctermfg=Blue
highlight clear ExtraWhitespace

let b:current_syntax = 'displayp_uncommon'
