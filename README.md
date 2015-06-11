texas
=====

TODO

INSTALLATION
------------

TODO

**ranger** (mandatory)

Copy `texas.py` to `~/.config/ranger/plugins`.

**zsh**

Copy `texas.zsh` to your `$fpath`, rename it to just `texas` (remove
the `.zsh` suffix) and add these lines to your `.zshrc`:

    autoload -U texas
    if [ -n "$LAUNCH_TEXAS" ]; then
        unset LAUNCH_TEXAS
        texas
    fi

**bash**

Not supported yet.

PLANNED FEATURES
----------------

- Bash support
- a proper readme
- an option to run in a separate `tmux` window

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
