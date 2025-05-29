extends Panel

var selected_checkpoint: int = 0

func _process(delta: float) -> void :
    $CurrentSave.text = "%s-%s" % [Global.checkpoints[selected_checkpoint][0], Global.checkpoints[selected_checkpoint][1]]

    if Input.is_action_just_pressed("ui_left"):
        if selected_checkpoint > 0:
            selected_checkpoint -= 1

    if Input.is_action_just_pressed("ui_right"):
        if selected_checkpoint < Global.checkpoints.size() - 1:
            selected_checkpoint += 1

    if Input.is_action_just_pressed("ui_accept"):
        Global.current_world_id = Global.checkpoints[selected_checkpoint][0]
        Global.current_level_id = Global.checkpoints[selected_checkpoint][1]
        hide()
        get_tree().paused = false
        Global.restart_level_check()

    if Input.is_action_just_pressed("ui_cancel"):
        hide()
        get_tree().paused = false
