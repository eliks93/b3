extends Node2D

var proj = preload("res://Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

remote func _spawn_projectile(projectile_type, _position, _direction):
	var player_id = get_tree().get_rpc_sender_id()

	rpc_unreliable("_spawn_projectile", projectile_type, _position, _direction, player_id)

remote func update_position(packet):
	print(packet.position.x)
	var player_id = get_tree().get_rpc_sender_id()
	for player in get_node("..").players:
		if (player_id != player):
			print(get_node("..").players)
			rpc_unreliable_id(player, "set_position", packet)

