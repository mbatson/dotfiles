mode: all
-
# Modes for lichess.org

lie chess mode white:
    mode.enable("user.lichess_white")
    user.display_notification("Lichess Mode White Enabled")
    mode.disable("sleep")
    mode.disable("dictation")
    mode.disable("command")

lie chess mode black:
    mode.enable("user.lichess_black")
    user.display_notification("Lichess Mode Black Enabled")
    mode.disable("sleep")
    mode.disable("dictation")
    mode.disable("command")

lie chess mode off:
    mode.disable("user.lichess_white")
    mode.disable("user.lichess_black")
    mode.enable("command")
    user.display_notification("Lichess Mode Off")
