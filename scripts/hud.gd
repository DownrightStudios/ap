extends CanvasLayer

func _ready() -> void :
    $CheckpointUI.hide()

    if Global.current_world_id == 4 and Global.current_level_id == 9:
        $Map.visible = false
        $Map / Shadow.visible = false
    else:
        $Map.visible = true
        $Map / Shadow.visible = true

    $Map.text = "%s-%s" % [Global.current_world_id, Global.current_level_id]
    $Map / Shadow.text = "%s-%s" % [Global.current_world_id, Global.current_level_id]

func _process(delta: float) -> void :
    $Score.text = "%s" % [Global.score + Global.current_score]
    $Score / Shadow.text = "%s" % [Global.score + Global.current_score]

    $UIBG.visible = $CheckpointUI.visible
    $CheckpointUI.self_modulate = RenderingServer.get_default_clear_color().darkened(0.48)

    if len(Global.checkpoints) >= 1 and not Global.hardcore_mode:
        $Checkpoints.visible = !$CheckpointUI.visible
    else:
        $Checkpoints.visible = false

    if Input.is_action_just_pressed("checkpoint_menu") and len(Global.checkpoints) >= 1 and not Global.hardcore_mode:
        get_tree().paused = true
        $CheckpointUI.show()
        $CheckpointUI.selected_checkpoint = Global.checkpoints.size() - 1
