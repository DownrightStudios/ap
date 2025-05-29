extends Node2D

@export var id: int = 0
@export var max_ids: int = 0
@export var backwards: bool = false

func _ready() -> void :
    play()

func play():
    await get_tree().create_timer(1 * id).timeout
    if backwards:
        $AnimationPlayer.play_backwards("yes")
    else:
        $AnimationPlayer.play("yes")
    await get_tree().create_timer(1 * max_ids).timeout
    play()
