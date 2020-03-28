if empty(get(g:, "dbt_highlight_jinja", 1))
  finish
endif

let g:dbt_jinja_path = get(g:, "dbt_jinja_path", globpath(&rtp, "syntax/jinja.vim"))

if empty(g:dbt_jinja_path)
  echoerr "Jinja syntax not found. Please, consider installing one."
  finish
endif

syntax include @jinja g:dbt_jinja_path
syntax region jinjaTemplate start=/{{|{%|{%-|{#/ end=/}}|%}|-}|#}/ contains=@jinja
