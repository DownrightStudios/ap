extends Area2D

var target_pos_offset: Vector2
var target_position: Vector2

var target_color = Color.WHITE

var collected: bool = false
var died: bool = false

var ts: Color

func _ready() -> void :
    target_position = global_position
    modulate = RenderingServer.get_default_clear_color()

    Global.player_death.connect(die)

func die():
    collected = true
    died = true

func _process(delta: float) -> void :
    global_position = global_position.lerp(target_position + target_pos_offset, 0.3 * (delta * 60))
    if not collected:
        target_color = RenderingServer.get_default_clear_color()
        modulate = target_color
    elif died and collected:
        ts = RenderingServer.get_default_clear_color()
        ts.a = 0
        target_color = ts
        modulate = modulate.lerp(target_color, 0.15 * (delta * 60))
    elif collected:
        ts = RenderingServer.get_default_clear_color()
        ts.a = 0
        target_color = ts
        modulate = modulate.lerp(target_color, 0.15 * (delta * 60))

func collect():
    $Collision.set_deferred("disabled", true)
    target_pos_offset = Vector2(0, -20)
    collected = true
    ts = RenderingServer.get_default_clear_color()
    ts.a = 0
    target_color = ts
    Global.current_score += 100
    Global.pickup_coin.emit()
    Input.start_joy_vibration(0, 0.3, 0, 0.15)
    await get_tree().create_timer(0.6).timeout
    queue_free()

func check_player(body: Node2D) -> void :
    if body.is_in_group("player"):
        collect()
