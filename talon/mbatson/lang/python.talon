title: /.py/
mode: command
-

is assigned: " = "
is equal to: " == "
is not equal to: " != "
is greater than: " > "
is greater than or equal to: " >= "
is less than: " < "
is less than or equal to: " <= "

comment: "# "
doc string:
    insert("\"\"\"")

state define: "def "
state class: "class "
state else if: "elif "

co slap:
    key(end)
    key(:)
    key(enter)
