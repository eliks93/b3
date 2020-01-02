extends Node2D

var proj = preload("res://Projectile.tscn")

var boat = preload("res://RealPlayer.tscn")

export var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

remote func _spawn_projectile(projectile_type, _position, _direction):
	var player_id = get_tree().get_rpc_sender_id()
	print("spawning projectile ", player_id)

	rpc_unreliable("_spawn_projectile", projectile_type, _position, _direction, player_id)

remote func update_position(packet):

	if ($PlayerBoat):
		$PlayerBoat.position.x = packet.position.x
		$PlayerBoat.position.y = packet.position.y
		$PlayerBoat.rotation = packet.rotation
		$PlayerBoat.acceleration = packet.acceleration
		$PlayerBoat.velocity = packet.velocity
		$PlayerBoat.mouse_pos = packet.mouse_pos

	var player_id = get_tree().get_rpc_sender_id()
	for player in get_node("..").players:
		if (player_id != player):
			rpc_unreliable_id(player, "set_position", packet)

remote func update_health(hp, p_owner):
	var player_id = get_tree().get_rpc_sender_id()
	print(hp)
	if hp == null:
		hp = 0
	if $PlayerBoat:
		$PlayerBoat.hp = hp
	if (hp > 0):
		rpc_unreliable("update_health", hp)
	else:
		for player in get_node("..").players:
			rpc_unreliable("destroy")
		if $PlayerBoat:
			get_node("..").set_score(p_owner)
			$PlayerBoat.queue_free()

func send_leaderboard_info(p_owner):
	rpc_unreliable_id(int(get_node(".").name), "update_leaderboard", p_owner)

remote func respawn():
	var x = 0
	var y = 0
	var rotation = 0
	var new_boat = boat.instance()
	new_boat.position.x = x
	new_boat.position.y = y
	new_boat.rotation = rotation
	
	add_child(new_boat)
	rpc_unreliable("respawn_player", x, y, rotation)
































