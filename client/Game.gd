extends Node2D

var player_ship = preload("res://Player.tscn")
var npc_ship = preload("res://NPC.tscn")
var respawn_player_ship = preload("res://RealPlayer.tscn")
var respawn_npc_ship = preload("res://NPCBoat.tscn")

var leader_board
# Called when the node enters the scene tree for the first time.
func _ready():

	# Announce ready to spawn here.
	rpc_id(1, "spawn_for")

func update_score(p_owner):
	print("score")
	rpc_unreliable_id(1, "set_score", p_owner)

remote func update_leaderboard(leaderboard_info):
	for leader in leaderboard_info:
		print(leaderboard_info[leader])
		leader_board = str(leader) + " " + str(leaderboard_info[leader])
		var player_id = get_tree().get_network_unique_id()
		get_node(str(player_id)).get_node("UI").get_node('./ItemList').add_item(leader_board)
#	print(leaderboard_info)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

remote func spawn_player(p_id):
	if (p_id == get_tree().get_network_unique_id()):
		var ship = player_ship.instance()
		ship.name = str(get_tree().get_network_unique_id())
		ship.initialize()
		self.add_child(ship)
		ship.map_limits = $Map01/Boundary.get_used_rect()
		ship.map_cellsize = $Map01/Boundary.cell_size
		ship.set_camera_limits()
	else:
		var ship = npc_ship.instance()
		ship.name = str(p_id)
		ship.get_node("NPCBoat").collision_layer = 1
		ship.get_node("NPCBoat").collision_mask = 1
		ship.initialize()
		self.add_child(ship)

remote func despawn_player(p_id):
	if (get_node(str(p_id))):
		remove_child(get_node(str(p_id)))





























