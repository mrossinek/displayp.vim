if get(s:, 'loaded')
    finish
endif
let s:loaded = 1

let s:window_config = {
                \ 'relative': 'win',
                \ 'focusable': v:false,
                \ 'style': 'minimal',
                \ 'height': 5+2*g:displayp#paddingNS,
                \ 'width': 5+2*g:displayp#paddingWE,
                \ }
let s:labels = map(range(0, 9), 'string(v:val)') + map(range(97, 122), 'nr2char(v:val)')
let s:label_windows = []

func! displayp#displayp()
    let winids = gettabinfo()[0]['windows']
    call s:label_windows(winids)
    " force redraw to actually display labels!
    redraw

    try
        let id = 0  " label '0' is not actually used
        while id > len(winids) || id <= 0
            " while the entered id is not contained in the winids
            let char = getchar()
            if char == 27  " Escape key
                break
            endif
            let id = index(s:labels, nr2char(char))
        endwhile
        call nvim_set_current_win(win_getid(id))

    finally
        call s:close()
    endtry
endfunc

func! s:close()
    while !empty(s:label_windows)
        let winid = remove(s:label_windows, -1)
            execute win_id2win(winid) . 'quit!'
    endwhile
endfunc

func! s:label_windows( winids )
    for winid in a:winids
        call s:label_window(winid)
    endfor
endfunc

func! s:label_window( winid )
    let config = s:window_config
    let config['win'] = a:winid

    let wininfo = getwininfo(a:winid)[0]
    let config['row'] = wininfo['height']/2 - config['height']/2
    let config['col'] = wininfo['width']/2 - config['width']/2

    let buf = s:print_label(win_id2win(a:winid))
    if buf > 0
        call add(s:label_windows, call('nvim_open_win', [buf, v:false, config]))
    endif
endfunc

func! s:print_label( winnr )
    let buf = nvim_create_buf(v:false, v:true)
    let lines = ['', '', '', '', '']
    let label = a:winnr
    if label > 34 || label < 0
        echoerr 'The maximum number of windows to be labeled is limited by 34.'
        return -1
    endif
    for idx in range(5)
        let lines[idx] = join([s:number_matrix[label][idx], lines[idx]], ' ')
    endfor

    " add padding
    for idx in range(5)
        let lines[idx] = join([repeat(' ', g:displayp#paddingWE), lines[idx]])
    endfor
    let lines = repeat([''], g:displayp#paddingNS) + lines

    call nvim_buf_set_lines(buf, 0, -1, v:false, lines)
    return buf
endfunc

let s:number_matrix = [
            \ ['█████',
            \  '█   █',
            \  '█   █',
            \  '█   █',
            \  '█████'],
            \
            \ ['    █',
            \  '    █',
            \  '    █',
            \  '    █',
            \  '    █'],
            \
            \ ['█████',
            \  '    █',
            \  '█████',
            \  '█    ',
            \  '█████'],
            \
            \ ['█████',
            \  '    █',
            \  '█████',
            \  '    █',
            \  '█████'],
            \
            \ ['█   █',
            \  '█   █',
            \  '█████',
            \  '    █',
            \  '    █'],
            \
            \ ['█████',
            \  '█    ',
            \  '█████',
            \  '    █',
            \  '█████'],
            \
            \ ['█████',
            \  '█    ',
            \  '█████',
            \  '█   █',
            \  '█████'],
            \
            \ ['█████',
            \  '    █',
            \  '    █',
            \  '    █',
            \  '    █'],
            \
            \ ['█████',
            \  '█   █',
            \  '█████',
            \  '█   █',
            \  '█████'],
            \ 
            \ ['█████',
            \  '█   █',
            \  '█████',
            \  '    █',
            \  '█████'],
            \
            \ ['█████',
            \  '█   █',
            \  '█████',
            \  '█   █',
            \  '█   █'],
            \
            \ ['████ ',
            \  '█   █',
            \  '█████',
            \  '█   █',
            \  '████ '],
            \
            \ ['█████',
            \  '█    ',
            \  '█    ',
            \  '█    ',
            \  '█████'],
            \
            \ ['████ ',
            \  '█   █',
            \  '█   █',
            \  '█   █',
            \  '████ '],
            \
            \ ['█████',
            \  '█    ',
            \  '█████',
            \  '█    ',
            \  '█████'],
            \
            \ ['█████',
            \  '█    ',
            \  '█████',
            \  '█    ',
            \  '█    '],
            \
            \ ['█████',
            \  '█    ',
            \  '█  ██',
            \  '█   █',
            \  '█████'],
            \
            \ ['█   █',
            \  '█   █',
            \  '█████',
            \  '█   █',
            \  '█   █'],
            \
            \ [' ███ ',
            \  '  █  ',
            \  '  █  ',
            \  '  █  ',
            \  ' ███ '],
            \
            \ ['█████',
            \  '  █  ',
            \  '  █  ',
            \  '  █  ',
            \  '███  '],
            \
            \ ['█   █',
            \  '█  █ ',
            \  '███  ',
            \  '█  █ ',
            \  '█   █'],
            \
            \ ['█    ',
            \  '█    ',
            \  '█    ',
            \  '█    ',
            \  '█████'],
            \
            \ ['     ',
            \  ' █ █ ',
            \  '█ █ █',
            \  '█   █',
            \  '     '],
            \
            \ ['     ',
            \  '██  █',
            \  '█ █ █',
            \  '█  ██',
            \  '     '],
            \
            \ [' ███ ',
            \  '█   █',
            \  '█   █',
            \  '█   █',
            \  ' ███ '],
            \
            \ ['████ ',
            \  '█   █',
            \  '████ ',
            \  '█    ',
            \  '█    '],
            \
            \ ['████ ',
            \  '█   █',
            \  '████ ',
            \  '█  █ ',
            \  '█   █'],
            \
            \ [' ███ ',
            \  '█   █',
            \  '█   █',
            \  '█  █ ',
            \  ' ██ █'],
            \
            \ ['█████',
            \  '█    ',
            \  '█████',
            \  '    █',
            \  '█████'],
            \
            \ ['█████',
            \  '  █  ',
            \  '  █  ',
            \  '  █  ',
            \  '  █  '],
            \
            \ ['█   █',
            \  '█   █',
            \  '█   █',
            \  '█   █',
            \  '█████'],
            \
            \ ['     ',
            \  '█   █',
            \  ' █ █ ',
            \  '  █  ',
            \  '     '],
            \
            \ ['     ',
            \  '█   █',
            \  '█ █ █',
            \  ' █ █ ',
            \  '     '],
            \
            \ ['█   █',
            \  ' █ █ ',
            \  '  █  ',
            \  ' █ █ ',
            \  '█   █'],
            \
            \ ['█   █',
            \  '█   █',
            \  ' █ █ ',
            \  '  █  ',
            \  '  █  '],
            \
            \ ['█████',
            \  '    █',
            \  ' ███ ',
            \  '█    ',
            \  '█████'],
            \ ]
