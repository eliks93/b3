extends TouchScreenButton

var radius = Vector2(12, 12)
var boundary = 12
# -1 is false, positive numbers are to separate concurrent touch events
var ongoing_drag = -1
var return_accel = 20

export var cardinal_dz = 1.0

func _process(delta):
	# Gradually move stick back to center outside of drag events.
	if GameState.player_info.actor:
		if ongoing_drag == -1:
			var pos_difference = (Vector2() - radius) - position
			position += pos_difference * return_accel * delta
		_control_ship(get_button_pos())

func get_button_pos():
	return position + radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		if is_joystick_input(event):
			if get_button_pos().length() > boundary:
				set_position( get_button_pos().normalized() * boundary - radius )
			
			ongoing_drag = event.get_index()
	
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

func is_joystick_input(event):
	var event_dist_from_center = (event.position - get_parent().global_position).length()
		
	if event_dist_from_center <= boundary * global_scale.x or event.get_index() == ongoing_drag:
		set_global_position(event.position - radius * global_scale)
		return true
	return false

func get_value():
	return get_button_pos()

func _control_ship(analog_pos):
	var x = 0.0
	var y = 0.0
	
	if (analog_pos.x < -cardinal_dz || analog_pos.x > cardinal_dz):
		if (analog_pos.x < 0):
			x = analog_pos.x / 11.0
		else:
			x = analog_pos.x / 11.0
	if (analog_pos.y < -cardinal_dz || analog_pos.y > cardinal_dz):
		if (analog_pos.y < 0):
			y = -analog_pos.y / 11
		else:
			y = -analog_pos.y / 11
	print(x, " ", y)
	GameState.player_info.actor.mobile_joystick(x, y)





















