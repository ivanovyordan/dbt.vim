function! dbt#job#new(command)
  if has("nvim")
    call dbt#job#neovim#new(a:command)
    return
  endif

  call s:start_vim_job(a:command)
endfunction


function! s:start_vim_job(command)
endfunction
