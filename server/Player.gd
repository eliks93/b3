extends Node2D

var proj = preload("res://Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

remote func _spawn_projectile(projectile_type, _position, _direction):
	var player_id = get_tree().get_rpc_sender_id()
	rpc_unreliable("_spawn_projectile", projectile_type, _position, _direction, player_id)

remote func update_position(packet):

	if ($PlayerBoat):
		$PlayerBoat.position.x = packet.position.x
		$PlayerBoat.position.y = packet.position.y
		$PlayerBoat.rotation = packet.rotation
		$PlayerBoat.acceleration = packet.acceleration
		$PlayerBoat.velocity = packet.velocity

	var player_id = get_tree().get_rpc_sender_id()
	for player in get_node("..").players:
		if (player_id != player):
			rpc_unreliable_id(player, "set_position", packet)

remote func update_health(hp):
	var player_id = get_tree().get_rpc_sender_id()
	if hp == null:
		hp = 0
	$PlayerBoat.hp = hp
	if (hp > 0):
		rpc_unreliable("update_health", hp)
	else:
		for player in get_node("..").players:
			rpc_unreliable("destroy")
		$PlayerBoat.queue_free()