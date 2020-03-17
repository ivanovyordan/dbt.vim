function! s:exec(method, args, callback)
  let l:params = map(
    \ a:args,
    \ {_, v -> shellescape(v)},
  \ )

  let l:job = [
    \ g:dbt_python_path,
    \ g:dbt_python_code . "/rpc.py",
    \ "--host", g:dbt_server_host,
    \ "--port", g:dbt_server_port,
    \ "--method", a:method,
    \ "--callback", a:callback,
  \ ] + ["--params"] + l:params

  echo l:job
  call dbt#job#new(l:job)
endfunction

function! dbt#rpc#start_server(callback)
  call s:exec("start_server", ["path", g:dbt_path], a:callback)
endfunction

function! dbt#rpc#compile_sql(name, sql, callback)
  call s:exec("compile_sql", ["name", a:name, "sql", a:sql], a:callback)
endfunction
