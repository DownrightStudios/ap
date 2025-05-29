extends StaticBody2D

func _process(delta: float) -> void :
    $BGColor.modulate = RenderingServer.get_default_clear_color()
