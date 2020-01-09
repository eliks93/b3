extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	set_as_toplevel(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var global_position = get_parent().get_node("SplashBoat").global_position
	global_position[1] -= 90
	global_position[0] -= self.rect_size.x / 2
	rect_global_position = global_position

