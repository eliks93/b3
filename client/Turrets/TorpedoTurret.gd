extends Node2D

signal spawn_projectile(projectile_type)
signal fire_turret
export var baseBullet = preload("res://Projectile.tscn")
export var fire_delay = 1.0
var target = null
var locked = false

var _ready_to_fire
# Called when the node enters the scene tree for the first time.

func _ready():
	get_node("../..").connect("fire_turret_secondary", self, "_fire")
	_ready_to_fire = true

func _process(delta):
	if locked:
		look_at(target.position)
		rotation_degrees -= 90
	else:
		rotation_degrees = -90

func _fire(group):
	if (_ready_to_fire):
#		ideal spot for fire sound in terms of timing of sound vs shot. Moving to audio controller
#		$PlayFireSound.play(0.1)
		var direction = Vector2(0, 1).rotated(self.global_rotation)
		emit_signal("spawn_projectile", $Muzzle.global_position, direction)
		$FireDelay.start(fire_delay)
		_ready_to_fire = false

func _on_FireDelay_timeout():
	_ready_to_fire = true


func _on_Area2D_body_entered(body):
	print("entered")
	if !locked and body.name == "NPCBoat":
		if body.has_method('take_damage'):
			target = body
			locked = true


func _on_Area2D_body_exited(body):
	if target == body:
		target = null
		locked = false
		$Area2D/CollisionShape2D.scale.x = 0
		$Area2D/CollisionShape2D.scale.y = 1
