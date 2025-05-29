extends CheckBox

func toggle(toggled_on: bool) -> void :
    $Shadow.button_pressed = toggled_on
    Global.hardcore_mode = toggled_on
