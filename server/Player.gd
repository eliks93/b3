extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerBoat/Turret1.connect("spawn_projectile", self, "_spawn_projectile")
	$PlayerBoat/Turret2.connect("spawn_projectile", self, "_spawn_projectile")
	$PlayerBoat/Turret3.connect("spawn_projectile", self, "_spawn_projectile")

func _spawn_projectile(projectile, _position, _direction):
	var proj = projectile.instance()
	add_child(proj)
	proj.start(_position, _direction)

func update_position(id, packet):
	rpc_unreliable_id(id, "update_position", packet)