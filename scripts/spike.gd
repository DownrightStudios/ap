extends Area2D

func check_player(body: Node2D) -> void :
    if body.is_in_group("player"):
        Global.emit_signal("player_death")
