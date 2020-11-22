from talon import Module, app

mod = Module()

@mod.action_class
class Actions:
    def display_notification(message: str):
        """Takes a message and sends it as a system notification"""
        app.notify(body=f"{message}")
