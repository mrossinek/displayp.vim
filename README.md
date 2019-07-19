displayp.vim
============

`displayp` is a plugin which implements a command that mimics tmux's displayp
command. It labels all visible windows on the current tab page and awaits an
input of the user to pick a label, of the window which should be selected next.

Installation
------------

I would recommend using [minpac](https://github.com/k-takata/minpac) which makes extensive use of the package feature
which was added to Vim 8 and Neovim.
```
call minpac#add('https://gitlab.com/mrossinek/displayp.vim')
```
Other package managers work in a similar fashion.

Usage
-----

By default, the mapping `<leader>d` and the command `:Displayp` are created when
the plugin is initially loaded. Either one of these can be used to trigger the
command.

Configuration
-------------

`displayp.vim` makes use of the following variables:

* `g:displayp#loaded`: if existing, displayp is not loaded again [Default: `1` (after initial loading)]
* `g:displayp#paddingNS`: number of empty lines to pad the top and bottom of the label window [Default: `2`]
* `g:displayp#paddingWE`: number of whitespaces to pad the left and right of the label window [Default: `4`]

