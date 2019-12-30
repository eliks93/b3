extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	look_at(get_global_mouse_position())