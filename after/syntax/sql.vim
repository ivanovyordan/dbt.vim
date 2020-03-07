syntax include @jinja syntax/jinja.vim
syntax region jinjaTemplate start=/{{ |{% |{%- |{# / end=/ }}| %} | -} | #}/ contains=@jinja
