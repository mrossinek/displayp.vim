if exists('g:displayp#loaded')
    finish
endif
let g:displayp#loaded = 1

if !exists('g:displayp#paddingNS')
    let g:displayp#paddingNS = 2
endif
if !exists('g:displayp#paddingWE')
    let g:displayp#paddingWE = 4
endif

if !hasmapto('<Plug>Displayp')
    map <unique> <Leader>d <Plug>Displayp
endif
noremap <unique> <script> <Plug>Displayp :call displayp#displayp()<CR>

if !exists(':Displayp')
    command Displayp :call displayp#displayp()
endif
