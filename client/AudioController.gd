extends Node2D

var death_sound = preload('res://BasicBoatDetonation.tscn')

func _ready():
	pass # Replace with function body.

func create_sound(sound, x, y):
	var node
	if sound == 'death':
		node = death_sound.instance()
		print(node.position)
		node.position.x = x
		node.position.y = y
		print(node.position)
		add_child(node)
		node.play()
