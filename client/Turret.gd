extends Node2D

signal spawn_projectile(projectile_type)

export var baseBullet = preload("res://Projectile.tscn")
export var fire_delay = 2.0

var _ready_to_fire
# Called when the node enters the scene tree for the first time.

func _ready():
	print(get_node("..").name)
	get_node("..").connect("fire_turret", self, "_fire")
	get_node("..").connect("turn_turret", self, "_turn")
	_ready_to_fire = true

func _turn(mouse_pos):
	look_at(mouse_pos)
	rotation_degrees -= 90

func _fire(group):
	if (_ready_to_fire):
		var direction = Vector2(1, 0).rotated(self.global_rotation + deg2rad(90))
		emit_signal("spawn_projectile", 1, $Muzzle.global_position, direction)
		$FireDelay.start(fire_delay)
		_ready_to_fire = false

func _on_FireDelay_timeout():
	_ready_to_fire = true
