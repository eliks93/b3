extends Button

var fake_event = InputEventAction.new()

var ongoing_touch = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	fake_event.action = "fire_2"


#func _on_SpecialAbility_gui_input(event):
#	if event is InputEventScreenTouch and event.is_pressed():
#		fake_event.pressed = true
#		Input.parse_input_event(fake_event)
#		ongoing_touch = event.get_index()
#	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_touch:
#		fake_event.pressed = false
#		Input.parse_input_event(fake_event)

func _on_SpecialAbility_pressed():
	fake_event.pressed = true
	Input.parse_input_event(fake_event)
	$Timer.wait_time = 0.25
	$Timer.start()


func _on_Timer_timeout():
	fake_event.pressed = false
	Input.parse_input_event(fake_event)
