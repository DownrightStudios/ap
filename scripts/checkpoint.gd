extends Area2D

var can_place: bool = true

func collect(body: Node2D) -> void :
    if body.is_in_group("player"):
        for checkpoint in Global.checkpoints:
            if checkpoint[0] == Global.current_world_id and checkpoint[1] == Global.current_level_id:
                can_place = false

        if can_place:
            $Texture.play("collected")
            $CollisionShape2D.set_deferred("disabled", true)
            Global.checkpoints.append([Global.current_world_id, Global.current_level_id])
            Global.save()
