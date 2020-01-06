extends Node2D

var death_sound = preload('res://BasicBoatDetonation.tscn')
var fire_sound = preload('res://BasicProjectileFireSound.tscn')
var hit_sound = preload('res://BasicProjectileSound.tscn')

func _ready():
	pass # Replace with function body.


func create_sound(sound, x, y):
	var node
	if sound == 'death':
		node = death_sound.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play()
	if sound == 'fire':
		node = fire_sound.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.1)
	if sound == 'hit':
		node = hit_sound.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)