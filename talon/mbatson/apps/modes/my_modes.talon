mode: all
-
# Modes for lichess.org

lie chess mode white:
    mode.enable("user.lichess_white")
    mode.disable("sleep")
    mode.disable("dictation")
    mode.disable("command")

lie chess mode black:
    mode.enable("user.lichess_black")
    mode.disable("sleep")
    mode.disable("dictation")
    mode.disable("command")

lie chess mode off:
    mode.disable("user.lichess_white")
    mode.disable("user.lichess_black")
    mode.enable("command")
