extends Area2D

@export var uncoverable: bool = false
var uc_target_alpha: int = 255

@export var uncover_hitbox: Area2D

func _ready() -> void :
    $AnimationPlayer.play("hover")

    if uncoverable:
        uc_target_alpha = 0
        modulate.a = 0

func _process(delta: float) -> void :
    modulate.a = lerpf(modulate.a, float(uc_target_alpha), 0.08 * (delta * 60))

    if Global.player:
        if not Global.player.moving:
            global_position = global_position.lerp(Global.player.global_position - Vector2(0, 24), 0.2 * (delta * 60))

func win_maybe(body: Node2D) -> void :
    if body.is_in_group("player"):
        Global.emit_signal("player_win")
        RenderingServer.set_default_clear_color(Color.LIME_GREEN)
        Global.current_score += 500
        $Sprites / Particles.emitting = false
        Input.start_joy_vibration(0, 0.9, 0, 0.25)
        $AnimationPlayer.stop()
        uc_target_alpha = 1

func uncover_yes(body: Node2D) -> void :
    if body.is_in_group("player"):
        if uncoverable:
            uc_target_alpha = 1

func uncover_no(body: Node2D) -> void :
    if body.is_in_group("player"):
        if uncoverable:
            uc_target_alpha = 0
