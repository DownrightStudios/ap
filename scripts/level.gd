extends Node2D

@export var current_level: PackedScene

var target_bg_speed: float = 2.6

func _ready() -> void :
    Global.player_death.connect(die)

    Global.score += Global.current_score
    Global.current_score = 0

    if not current_level:
        current_level = load("res://assets/maps/%s_%s.tscn" % [Global.current_world_id, Global.current_level_id])

    load_level()

func die():
    $PlayerDeath.emitting = true
    target_bg_speed = 0

    if Global.hardcore_mode:
        Global.current_world_id = 1
        Global.current_level_id = 1
        await get_tree().create_timer(1.4).timeout
        Global.current_score = 0
        Global.score = 0

func load_level():
    if current_level:
        var level = current_level.instantiate()
        add_child(level)

func _process(delta: float) -> void :
    if Global.player:
        $PlayerDeath.global_position = Global.player.global_position

    $BG / AnimationPlayer.speed_scale = lerpf($BG / AnimationPlayer.speed_scale, target_bg_speed, 0.03 * (delta * 60))
