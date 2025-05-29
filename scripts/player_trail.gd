extends Line2D

var queue: Array
@export var MAX_LENGTH: int = 20

var tl: int = 20

func _process(_delta):
    var pos = get_parent().position

    queue.push_front(pos)
    if get_parent().trail_active:
        tl = 20
    else:
        tl = 1

    MAX_LENGTH = lerp(MAX_LENGTH, tl, 0.1)

    if queue.size() > MAX_LENGTH:
        queue.pop_back()

    clear_points()

    for point in queue:
        add_point(point)
