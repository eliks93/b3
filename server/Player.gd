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

remote func update_position(packet):
	print(packet.position.x)
	var player_id = get_tree().get_rpc_sender_id()
	for player in get_node("..").players:
		if (player_id != player):
			print(get_node("..").players)
			rpc_unreliable_id(player, "set_position", packet)