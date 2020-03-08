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

function! DbtCompileBuffer()
  py3 dbt.compile_buffer()
endfunction
command -nargs=0 DbtCompileBuffer call DbtCompileBuffer()

let g:dbt_loaded = 1
