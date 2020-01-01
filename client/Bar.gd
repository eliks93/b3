extends HBoxContainer

func _ready():
	set_as_toplevel(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var global_position = get_parent().global_position
	global_position[1] -= 230
	global_position[0] -= 200
	rect_global_position = global_position