extends Node2D

var player_init = {}
var p_name = "Not-Player"
var projectile = preload("res://Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$NPCBoat/Turret1.connect("spawn_projectile", self, "_spawn_projectile")
	$NPCBoat/Turret2.connect("spawn_projectile", self, "_spawn_projectile")

remote func _spawn_projectile(projectile_type, _position, _direction, mask):
	print("Spawn please")
	var proj = projectile.instance()
	proj.collision_layer = 0
	proj.collision_mask = 0
	add_child(proj)
	proj.start(_position, _direction)

func initialize():
	p_name = player_init.name
	$NPCBoat.position.x = player_init.position.x
	$NPCBoat.position.y = player_init.position.y

remote func set_position(packet):
	$NPCBoat.position.x = packet.position.x
	$NPCBoat.position.y = packet.position.y
	$NPCBoat.rotation = packet.rotation
	$NPCBoat.acceleration = packet.acceleration
	$NPCBoat.velocity = packet.velocity