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

TL;DR: Run `./install.sh`. You don't need to read any further if
you're not interested what does it actually do.

Currently there is no support for the plugin managers such as
[antigen](https://github.com/zsh-users/antigen) due to a bit tricky
loading process. If you use them, be sure to load `texas` after
loading the plugins managed by the manager. I've encountered some
strange hard to track issues otherwise.

**INSTALLATION DETAILS**

The installation is comprised of two steps: installing a `ranger`
plugin and installing a shell plugin. Both are mandatory.

An unattended installation may be performed like this:

    $ yes | ./install.sh

**Step 1: Install ranger plugin**

Copy `texas.py` to `~/.config/ranger/plugins`.

**Step 2: Install shell plugin**

**bash**

Source the `texas.bash` file by adding the line `source
/path/to/texas.bash` to your `.bashrc`.

**zsh**

First copy the file `texas.zsh` to your `$fpath` and rename it to just
`texas` (remove the `.zsh` suffix). After that, source the
`texas_init.zsh` file by adding the line `source
/path/to/texas_init.zsh` to your `.zshrc`.

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
in that regard they may be considered as a single application. If you
open any more `tmux` windows (which `texas` by all means does not
discourage), they will *not* be closed. Only `ranger` and the
associated shell will close leaving all the other `tmux` windows
intact.

**Switching windows**

If you run `texas` in a new `tmux` session (see the previous
paragraph), you may use <kbd>ctrl-o</kbd> to switch between windows,
like in Midnight Commander. The regular `tmux` keys for switching
windows will work too (please refer to the `tmux` manual).
<kbd>ctrl-o</kbd> has one advantage though (other than being shorter):
it will work even if you move one of the `tmux` panes to a separate
`tmux` window (for example with the `:break-pane` `tmux` command) as
it intelligently switches either to a second split or a second window.

Before `v1.0` it was supported only in `zsh`. Since `v1.0` it works in
`bash` too.

Since `v1.1` <kbd>ctrl-o</kbd> is bound in `tmux` itself. Before that
it was handled by `bash`/`zsh` and `ranger`.

Since `v1.2` <kbd>ctrl-o</kbd> is bound only when run in a new
`tmux` daemon to prevent contaminating the all the other tmux sessions
with this keybinding.

CONFIGURATION
-------------

The followind environmental variables may be used to customize `texas`:

- **TEXAS_CONFIG_NOSWAP** — display `ranger` below the shell instead
  of on top of it (set to "1" to enable)
- **TEXAS_CONFIG_SIZE** — customize the size of the `ranger` pane,
  as percentage (default: 70).
- **TEXAS_CONFIG_TMUX_CONFIG** — an *additional* `tmux` config to
  source after starting `texas`. Only used in a dedicated `tmux`
  session, i.e. when `texas` is started from outside of an already
  running `tmux`.
- **TEXAS_CONFIG_SWITCH_KEY** — a `tmux` key to be bound in a
  dedicated `tmux` session for the pane switching (default:
  <kbd>C-o</kbd>)
- **TEXAS_CONFIG_HORIZONTAL** - start tmux with `-h` flag thus
  making split horizontal instead of vertical (default). Set to
  "1" to enable.

DEPENDENCIES
------------

- `ranger`
- `tmux`
- `bash` or `zsh`

KNOWN ISSUES
------------

If used with `bash`, each time `ranger` changes its current directory
a new prompt line will be shown in `bash`. It will erase the contents
of the command line and may be seen as ugly.

In `tmux 2.1` with `TEXAS_CONFIG_NOSWAP=0` the wrong pane is being
focused. It can be fixed by manually adding `-d` to the `tmux
swap-pane` call. I've detected this behavior only in `tmux 2.1`. In
both `2.0` and `2.2` `-d` causes the exactly opposite effect, so it
seems to be a bug in `tmux 2.1`.

SEE ALSO
--------

`ranger(1)`, `tmux(1)`

AUTHOR
------

Wojciech 'vifon' Siewierski < wojciech dot siewierski at onet dot pl >

COPYRIGHT
---------

Copyright (C) 2015-2016  Wojciech Siewierski

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
