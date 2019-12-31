extends Node2D

var player_mask = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Boat/Turret1.connect("spawn_projectile", self, "_spawn_projectile")
	$Boat/Turret2.connect("spawn_projectile", self, "_spawn_projectile")
	$Boat/Turret3.connect("spawn_projectile", self, "_spawn_projectile")
	$Boat.collision_mask = 6
	$Boat.collision_layer = 6

func _spawn_projectile(projectile, _position, _direction):
	var proj = projectile.instance()
	add_child(proj)
	proj.start(_position, _direction)