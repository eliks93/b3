extends Button
signal start_pressed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	print(event)
	if event is InputEventScreenTouch:
		emit_signal('start_pressed')


