extends Area2D

@export var flip: int = 1

func bounce_player(body: Node2D) -> void :
    if body.is_in_group("player"):
        Input.start_joy_vibration(0, 0.2, 0, 0.1)
        $Texture.play("spring")
        $Shadow.play("spring")
        body.velocity.y = ( - body.jump_height * 1.2) * flip
