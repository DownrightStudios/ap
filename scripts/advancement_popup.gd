extends Control

@export var text: String = "Do it."

var target_x: int = 20
var x_hidden: int = -334

var id: int = 0

func _ready() -> void :
    show_adv()

func show_adv():
    $Info.text = text
    global_position.y = DisplayServer.window_get_size(0).y - (20 + (80 * id))
    x_hidden = - $Info.size.x - 20
    global_position.x = x_hidden
    get_tree().create_tween().tween_property(self, "global_position:x", 20, 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    await get_tree().create_timer(1).timeout
    get_tree().create_tween().tween_property(self, "global_position:x", x_hidden, 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
