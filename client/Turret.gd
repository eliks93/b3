extends Node2D

signal spawn_projectile(projectile)

export var baseBullet = preload("res://Projectile.tscn")
export var fire_delay = 2.0

var _ready_to_fire

var projectile = baseBullet
# Called when the node enters the scene tree for the first time.

func _ready():
	get_node("..").connect("fire_turret", self, "_fire")
	_ready_to_fire = true

func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees -= 90

func _fire(group):
	if (_ready_to_fire):
		var direction = Vector2(1, 0).rotated(self.global_rotation + deg2rad(90))
		emit_signal("spawn_projectile", projectile, $Muzzle.global_position, direction)
		$FireDelay.start(fire_delay)
		_ready_to_fire = false

func _on_FireDelay_timeout():
	_ready_to_fire = true
