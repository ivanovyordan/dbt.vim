if !empty(globpath(&rtp, "syntax/jinja.vim"))
  syntax include @jinja syntax/jinja.vim
  syntax region jinjaTemplate start=/{{|{%|{%-|{#/ end=/}}|%} |-} |#}/ contains=@jinja
endif
