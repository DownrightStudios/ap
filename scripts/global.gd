extends Node

signal player_death
signal player_win
signal player_land
signal pickup_coin

signal checkpoint(world: int, level: int, player_pos: Vector2)

var score: int
var current_score: int

var checkpoints: Array = [

]

var current_world_id: int = 1
var current_level_id: int = 1

var target_player_pos: Vector2

var player: CharacterBody2D
var camera: Camera2D

var fullscreen: bool = false

var hardcore_mode: bool = false

func _ready() -> void :
    Global.loadd()
    Global.player_death.connect(restart_level_die)

func _process(delta: float) -> void :
    if Input.is_action_just_pressed("fullscreen"):
        fs()

func fs():
    fullscreen = !fullscreen

    if fullscreen:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
    else:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func save() -> void :
    var config_file: = ConfigFile.new()

    config_file.set_value("Info", "checkpoints", checkpoints)

    var error: = config_file.save("user://save.ini")
    if error:
        print("An error happened while saving data: ", error)


func loadd() -> void :
    var config_file: = ConfigFile.new()
    var error: = config_file.load("user://save.ini")

    if error:
        print("An error happened while loading data: ", error)
        return

    checkpoints = config_file.get_value("Info", "checkpoints", [])

func restart_level():
    target_player_pos = Vector2.ZERO
    await get_tree().create_timer(1).timeout
    Transition.switch_scene(load("res://scenes/level.tscn"))

func restart_level_check():
    Transition.switch_scene(load("res://scenes/level.tscn"))

func restart_level_die():
    target_player_pos = Vector2.ZERO
    await get_tree().create_timer(1).timeout
    Transition.switch_scene_reset_score(load("res://scenes/level.tscn"))
