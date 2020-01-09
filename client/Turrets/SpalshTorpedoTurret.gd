extends "res://Turrets/TorpedoTurret.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("fire_turret_secondary", self, "_fire")
	_ready_to_fire = true

func _fire(group):
	if (_ready_to_fire):
#		ideal spot for fire sound in terms of timing of sound vs shot. Moving to audio controller
#		$PlayFireSound.play(0.1)
		var direction = Vector2(0, 1).rotated(self.global_rotation)
		get_node('../..')._spawn_projectile_secondary($Muzzle.global_position, direction)
		$FireDelay.start(fire_delay)
		_ready_to_fire = false
