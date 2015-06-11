import ranger.api

import os
import os.path
import signal

old_hook_init = ranger.api.hook_init
def hook_init(fm):
    try:
        # Get the PID of the associated shell.
        texas_shell_pid = int(os.environ['TEXAS_SHELL_PID'])

        # Bind the 'cd' signal to a function sending the ranger's cwd
        # to the associated shell.
        def ranger_to_sh_sync(sig):
            try:
                os.kill(texas_shell_pid, signal.SIGUSR1)
            except OSError:
                exit(0)
        fm.signal_bind(
            'cd',
            ranger_to_sh_sync)

        # Handle the SIGUSR1 signal.
        def sh_to_ranger_sync(sig, frame):
            cwd = "/proc/{}/cwd".format(texas_shell_pid)
            fm.cd(os.path.realpath(cwd))
        signal.signal(
            signal.SIGUSR1,
            sh_to_ranger_sync)

        # Bind to C-o
        fm.execute_console("map <C-o> shell -s tmux select-pane -t :.+")

        # Close the associated shell along with the whole texas on
        # ranger exit.
        import atexit
        def texas_cleanup():
            os.kill(texas_shell_pid, signal.SIGHUP)
        atexit.register(texas_cleanup)
    except KeyError:
        # The texas shell is not running.
        pass
    finally:
        return old_hook_init(fm)

ranger.api.hook_init = hook_init
