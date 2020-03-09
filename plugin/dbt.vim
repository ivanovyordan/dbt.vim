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

let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
:py3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
import dbt
EOF

function! DbtStartServer()
  py3 dbt.start_server()
endfunction
command -nargs=0 DbtStartServer call DbtStartServer()

function! DbtStopServer()
  py3 dbt.stop_server()
endfunction
command -nargs=0 DbtStopServer call DbtStopServer()

function! DbtCompileBuffer()
  py3 dbt.compile_buffer()
endfunction
command -nargs=0 DbtCompileBuffer call DbtCompileBuffer()

let g:dbt_loaded = 1
