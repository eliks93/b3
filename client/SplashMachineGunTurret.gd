extends "res://Turret.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("..").connect("fire_turret", self, "_fire")
	get_node("..").connect("turn_turret", self, "_turn")

func _fire(group):
	if (_ready_to_fire):
		print("are you being called?")
		var direction = Vector2(0, 1).rotated(self.global_rotation)
		get_node('../..')._spawn_projectile(1, $Muzzle.global_position, direction)
		$FireDelay.start(fire_delay)
		_ready_to_fire = false