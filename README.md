# dbt.vim

A Simple plugin that makes writing [dbt](https://www.getdbt.com/) in vim/Neovim a bit easier.


## Requirements

* a Jinja 2 plugin. You can use either the one from [Glench](https://github.com/Glench/Vim-Jinja2-Syntax) or the one from [lepture](https://github.com/lepture/vim-jinja).
* Vim/Neovim complied with Python 3 support


# Installation

Use your preferred method of installing Vim plugins.

# Usage

1. Start the RPC server by running `dbt rpc` in your terminal.
2. Call `DbtCompileBuffer` to see the result of the model you currently work on.
