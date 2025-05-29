extends Control

func play_game() -> void :
    Transition.switch_scene(load("res://scenes/level.tscn"))
