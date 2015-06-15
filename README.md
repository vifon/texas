texas
=====

`texas` creates a shell session synchronized with a [ranger][1]
session. Whenever one's current directory changes, so does the
other's. It was created as an alternative to the Midnight Commander's
feature known as `ShowCommandLine` (the one bound to
<kbd>ctrl-o</kbd>).

[1]: https://github.com/hut/ranger

INSTALLATION
------------

You'll need to install a `ranger` plugin and one of the shell plugins
(only `zsh` is fully supported now, `bash` has a partial support).

**ranger** (mandatory)

Copy `texas.py` to `~/.config/ranger/plugins`.

**zsh**

Copy `texas.zsh` to your `$fpath`, rename it to just `texas` (remove
the `.zsh` suffix) and source the `texas_init.zsh` file from your
`zshrc` (add a line `source /path/to/texas_init.zsh`).

**bash**

Source `texas.bash` from your `bashrc` (add a line `source
/path/to/texas.bash`).

DEPENDENCIES
------------

- `ranger`
- `tmux`
- recommended: `zsh`

USAGE
-----

`texas` is using [tmux][2] internally. It is not necessary for the
user to know how to use `tmux` but thay will certainly benefit from
it.

[2]: http://tmux.github.io/

**Startup**

`texas` may be started either from inside the existing `tmux` session
or from a regular shell session. In the first case, it will use the
current `tmux` window. In the second one, it will create a new `tmux`
session **in the separate tmux daemon (named "texas")**.

**Switching windows**

If you're using `zsh`, you may use <kbd>ctrl-o</kbd> to switch between
windows, as long as there is no other program running in the shell
window (for example it will not work if you've got Vim running there).
The `tmux` keys for switching windows will work regardless of that
(please refer to the `tmux` manual). <kbd>ctrl-o</kbd> has one
advantage (other than being shorter): it will work even if you move
one of the `tmux` panes to a separate `tmux` window.

If you're using `bash`, <kbd>ctrl-o</kbd> works only in `ranger` but
not in the `bash` pane. It may change in the future.

SEE ALSO
--------

`ranger(1)`, `tmux(1)`

AUTHOR
------

Wojciech 'vifon' Siewierski < wojciech dot siewierski at onet dot pl >

COPYRIGHT
---------

Copyright (C) 2015  Wojciech Siewierski

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
