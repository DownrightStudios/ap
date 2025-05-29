extends "res://scripts/level_map.gd"

var has_dashed: bool = false
var no_win_yet: bool = true

func _win():
    no_win_yet = false
    if not has_dashed:
        print("ADVANCEMENT: STYLE POINTS")

func _process(delta: float) -> void :
    if Input.is_action_just_pressed("dash") and no_win_yet:
        has_dashed = true
