extends CharacterBody2D

var delta: float = 0

@export var default_speed: int = 9600
var speed: int = 9600
var speed_mult: float = 1
@export var accel: int = 12.5
@export var decel: int = 20

@export var jump_height: int = 375
var jumps: int = 1

enum States{Idle, Dashing, Jumping, Falling}
var current_state: States = States.Idle

enum TargetUpDirections{Normal = 1, UpsideDown = -1}
var target_up_direction: TargetUpDirections = TargetUpDirections.Normal

var dashing: bool = false
var moving = true

var target_scale: Vector2

func _ready() -> void :
    if Global.target_player_pos != Vector2.ZERO:
        global_position = Global.target_player_pos

    Global.player_death.connect(die)
    Global.player_win.connect(win)
    Global.player = self

func die():
    Input.start_joy_vibration(0, 1, 0.2, 0.45)
    queue_free()

func win():
    moving = false

func _physics_process(_delta: float) -> void :
    delta = _delta

    if Input.is_action_just_pressed("flip"):
        target_up_direction *= -1
        jumps = 1

    if is_on_floor() and target_up_direction == 1:
        jump()

    elif is_on_ceiling() and target_up_direction == -1:
        jump()

    elif not is_on_floor() and target_up_direction == 1:
        gravity()

    elif not is_on_ceiling() and target_up_direction == -1:
        gravity()


    var move_vector = Input.get_axis("left", "right")

    speed_mult = lerpf(speed_mult, 1.0, 0.1)
    speed = default_speed * speed_mult

    if Input.is_action_just_pressed("dash"):
        speed_mult = 3

    if speed_mult > 1.3 and velocity.x != 0:
        velocity.y = 0

    if speed_mult >= 1.3:
        current_state = States.Dashing
    else:
        if velocity.y > 0:
            if target_up_direction == TargetUpDirections.Normal:
                current_state = States.Falling
            elif target_up_direction == TargetUpDirections.UpsideDown:
                current_state = States.Jumping
        elif velocity.y < 0 and target_up_direction == TargetUpDirections.Normal:
            if target_up_direction == TargetUpDirections.Normal:
                current_state = States.Jumping
            elif target_up_direction == TargetUpDirections.UpsideDown:
                current_state = States.Falling
        elif velocity.y == 0:
            current_state = States.Idle

    if moving:
        if current_state == States.Idle:
            target_scale = Vector2(1, 1)
        elif current_state == States.Dashing and velocity.x != 0:
            target_scale = Vector2(1.25, 0.75)
        elif current_state == States.Jumping:
            target_scale = Vector2(0.75, 1.25)
        elif current_state == States.Falling:
            target_scale = Vector2(0.9, 1.075)
        velocity.x = move_vector * speed * delta
        move_and_slide()
    else:
        target_scale = Vector2.ONE

    scale = scale.lerp(target_scale, 0.2 * (delta * 60))

func gravity():
    velocity.y += (900 * delta) * target_up_direction
    if Input.is_action_just_pressed("jump") and jumps >= 1:
        velocity.y = ( - jump_height / 1.2) * target_up_direction
        jumps = 0

        speed_mult = 1

func jump():
    jumps = 2
    if Input.is_action_just_pressed("jump"):
        velocity.y = - jump_height * target_up_direction

        dashing = false
        speed_mult = 1

        jumps = 1
