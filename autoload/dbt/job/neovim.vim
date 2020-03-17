function! s:on_event(job_id, data, event)
  echo a:event
  echo a:data

  " call jobstop(a:job_id)
endfunction


function! dbt#job#neovim#new(command)
  let l:callbacks = {
    \ "on_stdout": function("s:on_event"),
    \ "on_stderr": function("s:on_event"),
    \ "on_exit": function("s:on_event"),
  \ }

  call jobstart(a:command, l:callbacks)
endfunction
