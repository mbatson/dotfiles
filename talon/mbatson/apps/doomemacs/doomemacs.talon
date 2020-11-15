# Doom Emacs commands (evil-mode)

title: /Doom Emacs/
mode: command
-

###
# Vim-style auto completion with company
###

complete global next: key(ctrl-n)

complete global previous: key(ctrl-p)

complete next:
    key(ctrl-x)
    key(ctrl-n)

complete previous:
    key(ctrl-x)
    key(ctrl-p)

complete line:
    key(ctrl-x)
    key(ctrl-l)


###
# Window control
###

doom window split [vertical]:
    key(space)
    key(w)
    key(v)

doom window split horizontal:
    key(space)
    key(w)
    key(s)

doom window close:
    key(space)
    key(w)
    key(d)

# Enters window selection mode with ace-window
doom window jump:
    key(space)
    key(w)
    key(ctrl-w)

###
# Buffer control
###

buffer next:
    key(space)
    key(b)
    key(])

buffer previous:
    key(space)
    key(b)
    key([)

buffer switch:
    key(space)
    key(b)
    key(b)

buffer i buffer:
    key(space)
    key(b)
    key(i)

###
# Workspaces
###

workspace show:
    key(space)
    key(tab)
    key(tab)

workspace one:
    key(space)
    key(tab)
    key(1)

workspace two:
    key(space)
    key(tab)
    key(2)

workspace three:
    key(space)
    key(tab)
    key(3)
