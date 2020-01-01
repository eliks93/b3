extends Node2D

var player_ship = preload("res://Player.tscn")
var npc_ship = preload("res://NPC.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Announce ready to spawn here.
	set_camera_limits()
	rpc_id(1, "spawn_for")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_camera_limits():
	var map_limits = $Map01/Border.get_used_rect()
	var map_cellsize = $Map01/Border.cell_size
	$Player/PlayerBoat/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/PlayerBoat/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/PlayerBoat/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/PlayerBoat/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

remote func spawn_player(p_info):
	if (p_info.id == get_tree().get_network_unique_id()):
		var ship = player_ship.instance()
		ship.name = str(get_tree().get_network_unique_id())
		ship.player_init = p_info
		ship.initialize()
		self.add_child(ship)
	else:
		var ship = npc_ship.instance()
		ship.name = str(p_info.id)
		ship.get_node("NPCBoat").collision_layer = 1
		ship.get_node("NPCBoat").collision_mask = 1
		ship.player_init = p_info
		ship.initialize()
		self.add_child(ship)