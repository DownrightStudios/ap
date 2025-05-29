extends Camera2D

@export var shake_rand_strength: float = 10.0
@export var shake_fade: float = 8

var shake_rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready() -> void :
    Global.player_death.connect(apply_shake)
    Global.camera = self

func apply_shake():
    shake_strength = shake_rand_strength

func _process(delta: float) -> void :
    if shake_strength > 0:
        shake_strength = lerpf(shake_strength, 0, shake_fade * (delta))

        offset = random_offset()

func random_offset() -> Vector2:
    return Vector2(shake_rng.randf_range( - shake_strength, shake_strength), shake_rng.randf_range( - shake_strength, shake_strength))
