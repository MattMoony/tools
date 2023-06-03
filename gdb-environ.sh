#!/bin/bash

EXT_BASE="/mnt/d/hacking/tools"

activate () {
    echo "source $EXT_BASE/voltron/voltron/entry.py" >> $HOME/.gdbinit
    if [[ $1 == "peda" ]]; then
        echo "source $EXT_BASE/peda/peda.py" >> $HOME/.gdbinit
    elif [[ $1 == "pwngdb" ]]; then
        echo "source $EXT_BASE/Pwngdb/pwngdb.py
source $EXT_BASE/Pwngdb/angelheap/gdbinit.py
define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end" >> $HOME/.gdbinit
    elif [[ $1 == "pwndbg" ]]; then
        echo "source /usr/share/pwndbg/gdbinit.py" >> $HOME/.gdbinit
    elif [[ $1 == "gef" ]]; then
        echo "source $EXT_BASE/gef/gef.py" >> $HOME/.gdbinit
    fi
}

echo "+ Switching GDB environments ... "
if [[ $1 == "peda" ]]; then
    echo "  -> Activating \"PEDA+PWNGDB\""
    rm ~/.gdbinit
    activate "peda"
    activate "pwngdb"
elif [[ $1 == "dbg" ]]; then
    echo "  -> Activating \"PWNDBG\""
    rm ~/.gdbinit
    activate "pwndbg"
elif [[ $1 == "gef" ]]; then
    echo "  -> Activating \"GEF\""
    rm ~/.gdbinit
    activate "gef"
elif [[ $1 == "all" ]]; then
    echo "  -> Activating \"PWNDBG+PEDA+PWNGDB\""
    rm ~/.gdbinit
    activate "pwndbg"
    activate "peda"
    activate "pwngdb"
    activate "gef"
elif [[ $1 == "vanilla" ]]; then
    echo "  -> Activating \"VANILLA\""
    rm ~/.gdbinit
elif [[ $1 == "" ]]; then
    echo "- Missing argument ... "
else
    echo "- Unkown environment ... "
fi
