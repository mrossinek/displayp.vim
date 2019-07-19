func! displayp#print_label( winnr )
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
        let lines[idx] = join([repeat(' ', s:displayp_padding_WE), lines[idx]])
    endfor
    let lines = repeat([''], s:displayp_padding_NS) + lines

    call nvim_buf_set_lines(buf, 0, -1, v:false, lines)
    return buf
endfunc

func! displayp#label_window( winid )
    let config = s:window_config
    let config['win'] = a:winid

    let wininfo = getwininfo(a:winid)[0]
    let config['row'] = wininfo['height']/2 - config['height']/2
    let config['col'] = wininfo['width']/2 - config['width']/2

    let buf = displayp#print_label(win_id2win(a:winid))
    if buf > 0
        call add(s:label_windows, call('nvim_open_win', [buf, v:false, config]))
    endif
endfunc

func! displayp#label_windows( winids )
    for winid in a:winids
        call displayp#label_window(winid)
    endfor
endfunc

func! displayp#displayp()
    let winids = gettabinfo()[0]['windows']
    call displayp#label_windows(winids)
    " force redraw to actually display labels!
    redraw

    let id = 0  " label '0' is not actually used
    while id > len(winids) || id <= 0
        " while the entered id is not contained in the winids
        let id = index(s:labels, nr2char(getchar()))
    endwhile
    call nvim_set_current_win(win_getid(id))

    call displayp#close()
endfunc

func! displayp#close()
    while !empty(s:label_windows)
        let winid = remove(s:label_windows, -1)
            execute win_id2win(winid) . 'quit!'
    endwhile
endfunc

let s:label_windows = []
let s:window_config = {
                \ 'relative': 'win',
                \ 'focusable': v:false,
                \ 'style': 'minimal',
                \ 'height': 5+2*s:displayp_padding_NS,
                \ 'width': 5+2*s:displayp_padding_WE,
                \ }
let s:displayp_padding_NS = 2
let s:displayp_padding_WE = 4

let s:labels = map(range(0, 9), 'string(v:val)') + map(range(97, 122), 'nr2char(v:val)')
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
