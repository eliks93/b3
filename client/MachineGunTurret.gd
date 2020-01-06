extends Node2D

signal spawn_projectile(projectile_type)
signal fire_turret
export var baseBullet = preload("res://MachineGunProjectile.tscn")
export var fire_delay = 0.3

var _ready_to_fire
# Called when the node enters the scene tree for the first time.

func _ready():
	get_node("../..").connect("fire_turret", self, "_fire")
	get_node("../..").connect("turn_turret", self, "_turn")
	_ready_to_fire = true

func _turn(mouse_pos):
	look_at(mouse_pos)
	rotation_degrees -= 90

func _fire(group):
	if (_ready_to_fire):
#		ideal spot for fire sound in terms of timing of sound vs shot. Moving to audio controller
#		$PlayFireSound.play(0.1)
		var direction = Vector2(0, 1).rotated(self.global_rotation)
		print(direction, "direction")
		emit_signal("spawn_projectile", 1, $Muzzle.global_position, direction)
		$FireDelay.start(fire_delay)
		_ready_to_fire = false

func _on_FireDelay_timeout():
	_ready_to_fire = true
