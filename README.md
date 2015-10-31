texas
=====

`texas` creates a shell session synchronized with a [ranger][1]
session. Whenever one's current directory changes, so does the
other. It was created as an alternative to a Midnight Commander
feature known as `ShowCommandLine` (which is bound to
<kbd>ctrl-o</kbd>).

[1]: https://github.com/hut/ranger

INSTALLATION
------------

The installation is comprised of two steps: installing a `ranger`
plugin, and installing a shell plugin (`zsh` has full support while
`bash` support is partial).

**Step 1: Install ranger plugin** (mandatory)

Copy `texas.py` to `~/.config/ranger/plugins`.

**Step 2: Install shell plugin**

**zsh**

First copy the file `texas.zsh` to your `$fpath` and rename it to just
`texas` (remove the `.zsh` suffix). After that, source the
`texas_init.zsh` file by adding the line `source
/path/to/texas_init.zsh` to your `.zshrc`.

**bash**

Source the `texas.bash` file by adding the line `source
/path/to/texas.bash` to your `.bashrc`.


USAGE
-----

`texas` uses [tmux][2] internally. Although knowledge of how to use
`tmux` is not necessary, the user will certainly benefit from it.

[2]: http://tmux.github.io/

**Startup**

`texas` may be started either from inside an existing `tmux` session
or from a regular shell session. In the first case, it will use the
current `tmux` window and in the second case it will create a new
`tmux` session **in a separate tmux daemon automatically named
"texas"**.

If you launch `texas` from an existing `tmux` session, you may quit
`ranger` and the shell should still be running just as before
launching `texas`.

If you launch `texas` outside of an existing `tmux` session, `ranger`
and the shell are bound together: closing one will close the other and
in that regard they may be considered as a single application. Of
course, if you open some more `tmux` windows (which `texas` by all
means does *not* discourage), they will not be closed.

**Switching windows**

If you're using `zsh`, you may use <kbd>ctrl-o</kbd> to switch between
windows as long as there is no other program running in the shell
window (for example, it will not work if you've got Vim running
there), but the `tmux` keys for switching windows will work regardless
of that (please refer to the `tmux` manual). <kbd>ctrl-o</kbd> has one
advantage though (other than being shorter): it will work even if you
move one of the `tmux` panes to a separate `tmux` window.

If you're using `bash`, <kbd>ctrl-o</kbd> works only in `ranger` but
not in the `bash` pane. This may change in the future.

DEPENDENCIES
------------

- `ranger`
- `tmux`
- recommended: `zsh`

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
