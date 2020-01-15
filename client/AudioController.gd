extends Node2D

var death_sound = preload('res://BasicBoatDetonation.tscn')
var fire_sound = preload('res://BasicProjectileFireSound.tscn')
var hit_sound = preload('res://BasicProjectileSound.tscn')
var machine_gun_sound = preload('res://MachineGunProjectileSound.tscn')
var machine_gun_fire = preload('res://MachineGunProjectileFireSound.tscn')
var invis = preload('res://Invis.tscn')
var shield = preload('res://Shield.tscn')
var phase = preload('res://Phase.tscn')
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
		node.connect('finished', self, 'finished')
	if sound == 'fire':
		node = fire_sound.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.3)
	if sound == 'hit':
		node = hit_sound.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)
	if sound == 'machine_hit':
		node = machine_gun_sound.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)
	if sound == 'machine_fire':
		node = machine_gun_fire.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)
	if sound == 'invis':
		node = invis.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)
	if sound == 'shield':
		node = shield.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)
	if sound == 'phase':
		node = phase.instance()
		node.position.x = x
		node.position.y = y
		add_child(node)
		node.play(0.0)
	