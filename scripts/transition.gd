extends CanvasLayer

var trailer_mode: bool = false

func _process(delta: float) -> void :
    if trailer_mode:
        $AnimationPlayer.speed_scale = 0.2
    else:
        $AnimationPlayer.speed_scale = 1

func switch_scene(scene: PackedScene):
    $AnimationPlayer.play("close")
    await $AnimationPlayer.animation_finished
    get_tree().change_scene_to_packed(scene)
    $AnimationPlayer.play("open")

func switch_scene_reset_score(scene: PackedScene):
    $AnimationPlayer.play("close")
    await $AnimationPlayer.animation_finished
    Global.current_score = 0
    get_tree().change_scene_to_packed(scene)
    $AnimationPlayer.play("open")

func switch_scene_reset_score2(scene: PackedScene):
    $AnimationPlayer.play("close")
    await $AnimationPlayer.animation_finished
    Global.current_score = 0
    Global.score = 0
    get_tree().change_scene_to_packed(scene)
    $AnimationPlayer.play("open")

func _ready():
    $AnimationPlayer.play("open")
