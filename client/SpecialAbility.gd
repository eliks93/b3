extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventScreenTouch:
		print("Hello!")
		var fake_event = InputEventAction.new()
		fake_event.action = "fire_2"
		fake_event.pressed = true
		Input.parse_input_event(fake_event)