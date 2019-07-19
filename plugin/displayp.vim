let s:label_windows = []

func! displayp#print_label( winnr )
    let buf = nvim_create_buf(v:false, v:true)
    let lines = ['', '', '', '', '']
    let label = a:winnr
    if label > 99 || label < 0
        " only two-digit labels are supported
        " (more than 99 visible windows are rather unlikely anyways)
        echoerr 'More than 99 visible windows cannot be labeled!'
        return -1
    endif
    while label > 0
        let digit = label % 10
        let label = label / 10
        for idx in [0, 1, 2, 3, 4]
            let lines[idx] = join([s:number_matrix[digit][idx], lines[idx]], ' ')
        endfor
    endwhile

    call nvim_buf_set_lines(buf, 0, -1, v:false, lines)
    return buf
endfunc

func! displayp#label_window( winid )
    let config = {
                \ 'relative': 'win',
                \ 'win': a:winid,
                \ 'height': 5,
                \ 'width': 11,
                \ 'row': 10,
                \ 'col': 10,
                \ 'focusable': v:false,
                \ 'style': 'minimal',
                \ }

    let buf = displayp#print_label(win_id2win(a:winid))
    if buf > 0
        call add(s:label_windows, call('nvim_open_win', [buf, v:false, config]))
    endif
endfunc

func! displayp#label_windows()
    for winid in gettabinfo()[0]['windows']
        call displayp#label_window(winid)
    endfor
endfunc

func! displayp#close()
    while !empty(s:label_windows)
        let winid = remove(s:label_windows, -1)
            execute win_id2win(winid) . 'quit!'
    endwhile
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
            \  '█████']
            \ ]
