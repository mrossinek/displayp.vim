func! displayp#label_window()
    let buf = nvim_create_buf(v:false, v:true)
    let label = nvim_get_current_win()
    call nvim_buf_set_lines(buf, 0, -1, v:false, [string(label)])

    let config = {
                \ 'relative': 'win',
                \ 'win': label,
                \ 'height': 3,
                \ 'width': 6,
                \ 'row': 10,
                \ 'col': 10,
                \ 'focusable': v:false,
                \ 'style': 'minimal',
                \ }

    let s:winid = nvim_open_win(buf, v:false, config)
endfunc

func! displayp#close()
    if exists('s:winid')
        execute win_id2win(s:winid) . 'quit!'
    endif
endfunc
