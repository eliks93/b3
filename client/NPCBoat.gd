extends "res://Boat.gd"

signal turn_turret(mouse_position)

var mouse_position

var player_init = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

remote func update_health(hp):
	$PlayerBoat.hp = hp

remote func destroy():
	$PlayerBoat.queue_free()
