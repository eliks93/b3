extends Node2D

var player_init = {}
var p_name = "Not-Player"
var projectile = preload("res://Projectile.tscn")

var boat = preload("res://NPCboats/BigBoatNPC.tscn")

var p_owner
var player_name = "Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func initialize():
	var new_boat = boat.instance()
	new_boat.position.x = 0
	new_boat.position.y = 0
	new_boat.rotation = 0
	add_child(new_boat)
	get_child(0).set_name("NPCBoat")
	$NPCBoat.collision_layer = 1
	$NPCBoat.collision_mask = 1
	$NPCBoat/PlayerName.set_name(player_name)

remote func _spawn_projectile(projectile_type, _position, _direction, mask):
	var proj = projectile.instance()
	proj.p_owner = str(mask)
	add_child(proj)
	proj.start(_position, _direction)

func _physics_process(delta):
	pass

remote func set_position(packet):
	if ($NPCBoat):
		$NPCBoat.position.x = packet.position.x
		$NPCBoat.position.y = packet.position.y
		$NPCBoat.rotation = packet.rotation
		$NPCBoat.acceleration = packet.acceleration
		$NPCBoat.velocity = packet.velocity
		$NPCBoat.mouse_pos = packet.mouse_pos
	elif get_children().size():
		get_child(0).set_name("NPCBoat")
		$NPCBoat.collision_layer = 1
		$NPCBoat.collision_mask = 1
		$NPCBoat/PlayerName.set_name(player_name)
		

remote func update_health(hp):
	if $NPCBoat:
		$NPCBoat.update_health(hp)

remote func destroy():
	$NPCBoat.explode()

remote func respawn_player(x, y, rotation):
	var new_boat = boat.instance()
	for child in get_children():
		child.queue_free()
	new_boat.position.x = x
	new_boat.position.y = y
	new_boat.rotation = rotation
	add_child(new_boat)
	$NPCBoat.collision_layer = 1
	$NPCBoat.collision_mask = 1
	$NPCBoat/PlayerName.set_name(player_name)




























