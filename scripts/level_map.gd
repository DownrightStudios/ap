extends Node

@export var bg_color: Color = Color.FIREBRICK

@export var next_world: int = 1
@export var next_level: int = 1

@export var hardcore_mode_check: CheckBox

@export var cam_start: Marker2D
@export var cam_end: Marker2D

func _ready() -> void :
    if hardcore_mode_check:
        hardcore_mode_check.button_pressed = Global.hardcore_mode

    Global.player_death.connect(player_death)
    Global.player_win.connect(switch_next_level)
    Global.player_win.connect(_win)

    RenderingServer.set_default_clear_color(bg_color)

func _process(delta: float) -> void :
    RenderingServer.set_default_clear_color(RenderingServer.get_default_clear_color().lerp(bg_color, 0.08 * (delta * 60)))

    if cam_start and cam_end:
        if Global.camera:
            Global.camera.limit_left = cam_start.global_position.x
            Global.camera.limit_right = cam_end.global_position.x
            if Global.player:
                Global.camera.global_position.x = Global.player.global_position.x

func _win():
    bg_color = Color8(20, 60, 20)

func switch_next_level():
    Global.current_world_id = next_world
    Global.current_level_id = next_level
    Global.restart_level()

func player_death():
    bg_color = Color8(30, 30, 36)
    RenderingServer.set_default_clear_color(Color.RED)
