let s:label_windows = []

func! displayp#label_window( winid )
    let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:false, [string(a:winid)])

    let config = {
                \ 'relative': 'win',
                \ 'win': a:winid,
                \ 'height': 3,
                \ 'width': 6,
                \ 'row': 10,
                \ 'col': 10,
                \ 'focusable': v:false,
                \ 'style': 'minimal',
                \ }

    call add(s:label_windows, call('nvim_open_win', [buf, v:false, config]))
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
