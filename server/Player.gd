extends Node2D

var proj = preload("res://Projectile.tscn")

export var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

remote func _spawn_projectile(projectile_type, _position, _direction):
	var player_id = get_tree().get_rpc_sender_id()
	print("spawning projectile ", player_id)

	rpc_unreliable("_spawn_projectile", projectile_type, _position, _direction, player_id)

remote func update_position(packet):

	var player_id = get_tree().get_rpc_sender_id()
	for player in get_node("..").players:
		if (player_id != player):
			rpc_unreliable_id(player, "set_position", packet)

remote func update_health(hp):
	var player_id = get_tree().get_rpc_sender_id()
	if (hp > 0):
		rpc_unreliable("update_health", hp)
	else:
		for player in get_node("..").players:
			rpc_unreliable("destroy")