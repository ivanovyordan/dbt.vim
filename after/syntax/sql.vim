let s:dbt_default_jina_path = globpath(&rtp, "syntax/jinja.vim")
let g:dbt_jinja_path = get(g:, "dbt_jinja_path", s:dbt_default_jina_path)
let g:dbt_highlight_jinja = get(g:, "dbt_highlight_jinja", 1)

if empty(g:dbt_highlight_jinja)
  finish
endif

if !filereadable(g:dbt_jinja_path)
  echoerr "Jinja syntax not found. Please, consider installing one."
  finish
endif

execute "syntax include @jinja " . g:dbt_jinja_path
syntax region jinjaTemplate start=/{{|{%|{%-|{#/ end=/}}|%}|-}|#}/ contains=@jinja
