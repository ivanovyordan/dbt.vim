" Copyright 2020 Yordan Ivanov
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"    http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

if !has("python3")
  echo "vim has to be compiled with +python3 to run this"
  finish
endif

if exists('g:dbt_loaded')
  finish
endif

function DbtStartServer()
  call dbt#start_server()
endfunction
command -nargs=0 DbtStartServer call DbtStartServer()

function DbtCompileBuffer()
  call dbt#compile_buffer()
endfunction
command -nargs=0 DbtCompileBuffer call DbtCompileBuffer()

function! s:init_python()
  let s:plugin_root_dir = expand('<sfile>:p:h')

  py3 << EOF
import sys
from os.path import normpath, join
import vim

plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, 'python'))

vim.command("let g:dbt_python_path = '%s'" % sys.executable)
vim.command("let g:dbt_python_code = '%s'" % python_root_dir)
EOF
endfunction

function! s:init()
  if filereadable("dbt_project.yml") == 0
    return
  endif

  let g:dbt_path = get(g:, "dbt_path", "dbt")
  let g:dbt_server_host = get(g:, "dbt_server_host", "0.0.0.0")
  let g:dbt_server_port = get(g:, "dbt_server_port", "8580")
  let g:dbt_server_autostart = get(g:, "dbt_server_autostart", 0)

  call s:init_python()

  if g:dbt_server_autostart
    call dbt#start_server()
  endif
endfunction

call s:init()

let g:dbt_loaded = 1
