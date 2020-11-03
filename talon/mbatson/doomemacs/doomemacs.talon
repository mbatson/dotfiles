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
