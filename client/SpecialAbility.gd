extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fake_event = InputEventAction.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	fake_event.action = "fire_2"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SpecialAbility_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		print("Hello!")
		fake_event.pressed = true
		Input.parse_input_event(fake_event)
	elif event is InputEventScreenTouch and !event.is_pressed():
		print("Goodbye")
		fake_event.pressed = false
		Input.parse_input_event(fake_event)