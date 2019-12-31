extends "res://Boat.gd"

signal turn_turret(mouse_position)

var mouse_position

var player_init = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

slave func setPosition(packet):
	# Apply movement to other boats.
	pass

#func _process(delta):
#	emit_signal("turn_turret", mouse_position)

#var packet = {
#	'mouse_pos': get_global_mouse_position(),
#	'position': {
#		'x': position.x,
#		'y': position.y
#	},
#	'rotation': rotation,
#	'acceleration': self.acceleration,
#	'velocity': self.velocity
#}