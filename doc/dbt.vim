*dbt.txt* dbt development plugin

                   _   _       _                 _
                  | | | |     | |               (_)
                __| | | |__   | |_      __   __  _   _ __ ___
               / _` | | '_ \  | __|     \ \ / / | | | '_ ` _ \
              | (_| | | |_) | | |_   _   \ V /  | | | | | | | |
               \__,_| |_.__/   \__| (_)   \_/   |_| |_| |_| |_|

                    A Vim/Neovim plugin for working with dbt

==============================================================================

CONTENTS                                                                   *dbt*

1. USAGE ........................................................... |dbt-usage|
2. SETTINGS ..................................................... |dbt-settings|
    2.1 g:dbt_highlight_jinja .......................... |g:dbt_highlight_jinja|
    2.2 g:dbt_jinja_path .................................... |g:dbt_jinja_path|

==============================================================================

1. USAGE                                                             *dbt-usage*

No need to do anything. It works automatically.

2. SETTINGS                                                       *dbt-settings*

You can configure the following settings to change how dbt.vim works.

------------------------------------------------------------------------------

2.1 g:dbt_highlight_jinja                                *g:dbt_highlight_jinja*

Set this to 0 to disable Jinja 2 syntax highlighting for all SQL files: >

    let dbt_highlight_jinja = 0

Default: 1

------------------------------------------------------------------------------

2.1 g:dbt_jinja_path                                          *g:dbt_jinja_path*

Set this to change the path to the Jinja 2 syntax file: >

    let dbt_jinja_path = "~/.vim/my-jinja-syntax.vim"

This option only has effect if |g:dbt_highlight_jinja| is enabled

Default: globpath(&rtp, "syntax/jinja.vim")

vim: ft=help
