# dbt.vim

A Simple plugin that makes writing [dbt](https://www.getdbt.com/) in vim/Neovim a bit easier.


## Requirements

No hard requirements, but if you need the full featured experience you'd need:
* a Jinja 2 plugin. You can use either the one from [Glench](https://github.com/Glench/Vim-Jinja2-Syntax) or the one from [lepture](https://github.com/lepture/vim-jinja).
* Vim/Neovim complied with Python 3 support

- Jinja 2 syntax. I recommend using either the one from
[Glench](https://github.com/Glench/Vim-Jinja2-Syntax) or from
[lepture](https://github.com/lepture/vim-jinja).


## Installation

Use your preferred method of installing Vim plugins.

## Options

The full documentation can be found at [doc/dbt.vim.txt](doc/dbt.vim.txt). You can display it from
within Vim/Neovim with `:help dbt.vim`.

# Usage

1. Start the RPC server by running `dbt rpc` in your terminal.
2. Call `DbtCompileBuffer` to see the result of the model you currently work on.
