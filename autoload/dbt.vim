function! s:preview(content)
  execute "new" "dbt_preview"
  setlocal buftype=nofile bufhidden=wipe

  setlocal modifiable
  silent %delete _
  call setline(1, a:content)
  setlocal nomodified nomodifiable
endfunction

function! dbt#on_buffer_compiled(error, content)
  if a:error
    echoerr a:error
    return
  endif

  call s:preview(a:content)
endfunction

function! dbt#start_server()
  call dbt#rpc#start_server('dbt#on_server_started')
endfunction

function! dbt#compile_buffer()
  let l:sql = join(getline(1, "$"), " ")
  let l:name = expand("%:t:r")

  call dbt#rpc#compile_sql(l:sql, l:name, "dbt#on_buffer_compiled")
endfunction
