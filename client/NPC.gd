extends Node2D

var player_init = {}
var p_name = "Not-Player"
var projectile = preload("res://Projectile.tscn")
var boat_selected = "1"

var boat_big = preload("res://NPCboats/BigBoatNPC.tscn")
var boat_medium = preload("res://NPCboats/MediumBoatNPC.tscn")
var boat_small = preload("res://NPCboats/SmallBoatNPC.tscn")
var boat_orb = preload("res://NPCboats/OrbBoatNPC.tscn")
var boats = [boat_big, boat_medium, boat_small, boat_orb]

var alive
var mapped = false
var p_owner
var player_name = "Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func initialize():
	if alive:
		var new_boat = boats[int(boat_selected)].instance()
		new_boat.position.x = 0
		new_boat.position.y = 0
		new_boat.rotation = 0
		add_child(new_boat)
		get_child(0).set_name("NPCBoat")
		$NPCBoat.collision_layer = 1
		$NPCBoat.collision_mask = 1
		$NPCBoat/PlayerName.set_name(player_name)

remote func _spawn_projectile(projectile_type, _position, _direction, mask):
	if boat_selected == 0:
		get_parent().get_node('AudioController').create_sound('fire', $NPCBoat.position.x, $NPCBoat.position.y)
	elif boat_selected == 2:
		get_parent().get_node('AudioController').create_sound('machine_fire', $NPCBoat.position.x, $NPCBoat.position.y)
	else:
		get_parent().get_node('AudioController').create_sound('fire', $NPCBoat.position.x, $NPCBoat.position.y)
	var proj = get_child(0).projectile.instance()
	proj.p_owner = str(mask)
	add_child(proj)
	proj.start(_position, _direction)

remote func _spawn_projectile_secondary(_position, _direction, mask):
	if boat_selected == 0:
		get_parent().get_node('AudioController').create_sound('shield', $NPCBoat.position.x, $NPCBoat.position.y)
	elif boat_selected == 1:
		get_parent().get_node('AudioController').create_sound('invis', $NPCBoat.position.x, $NPCBoat.position.y)	
	elif boat_selected == 2:
		get_parent().get_node('AudioController').create_sound('fire', $NPCBoat.position.x, $NPCBoat.position.y)	
	else:
		get_parent().get_node('AudioController').create_sound('phase', $NPCBoat.position.x, $NPCBoat.position.y)
	var proj = get_child(0).projectile_secondary.instance()
	proj.p_owner = str(mask)
	add_child(proj)
	proj.start(_position, _direction)

# Currently only used for Energy Projectiles
remote func _spawn_controlled_projectile(p_name, projectile_type, _position, _direction, mask):
	
	var proj = $NPCBoat.projectile.instance()
	
	proj.name = p_name
	proj.p_owner = str(mask)
	add_child(proj)
	proj.start(_position, _direction)

func _physics_process(delta):
	pass

remote func set_position(packet):
	if has_node('NPCBoat'):
		$NPCBoat.position.x = packet.position.x
		$NPCBoat.position.y = packet.position.y
		$NPCBoat.rotation = packet.rotation
		$NPCBoat.acceleration = packet.acceleration
		$NPCBoat.velocity = packet.velocity
		$NPCBoat.mouse_pos = packet.mouse_pos
	else:
		for child in get_children():
			if child.has_method('take_damage'):
				child.set_name('NPCBoat')
				$NPCBoat/PlayerName.set_name(player_name)


remote func update_health(hp):
	if $NPCBoat:
		$NPCBoat.update_health(hp)

remote func destroy(placeholder):
		get_parent().get_node('AudioController').create_sound('death', $NPCBoat.position.x, $NPCBoat.position.y)
		$NPCBoat.explode()

remote func respawn_player(x, y, rotation, ship_type):
	boat_selected = ship_type
	var new_boat = boats[int(boat_selected)].instance()
	for child in get_children():
		child.queue_free()
	new_boat.position.x = x
	new_boat.position.y = y
	new_boat.rotation = rotation
	add_child(new_boat)
	if has_node('NPCBoat/PlayerName'):
		$NPCBoat/PlayerName.set_name(player_name)

remote func heal():
	var new_hp = clamp(($NPCBoat.npc_max_health / 2) + $NPCBoat.hp, 0, $NPCBoat.npc_max_health)
	
	$NPCBoat.update_health(new_hp)
	$NPCBoat.hp = new_hp



























