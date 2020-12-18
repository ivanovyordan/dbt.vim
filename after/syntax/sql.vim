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

let g:dbt_highlight_jinja = get(g:, "dbt_highlight_jinja", 1)
if empty(g:dbt_highlight_jinja)
  finish
endif

let s:jinja_path_config = get(g:, "dbt_jinja_path")
let s:jinja_path_plugin = globpath(&rtp, "syntax/jinja.vim")
let s:jinja_path_polyglot = globpath(&rtp, "syntax/jinja2.vim")

if filereadable(s:jinja_path_config)
  let s:dbt_jinja_path = s:jinja_path_plugin
elseif file_readable(s:jinja_path_plugin)
  let s:dbt_jinja_path = s:jinja_path_plugin
elseif filereadable(s:jinja_path_polyglot)
  let s:dbt_jinja_path = s:jinja_path_polyglot
else
  echoerr "Jinja syntax not found. Please, consider installing one."
  finish
endif

let s:include_jinja = "syntax include @jinja " . s:dbt_jinja_path
execute s:include_jinja

syntax region jinjaTemplate start=/{{|{%|{%-|{#/ end=/}}|%}|-}|#}/ contains=@jinja
