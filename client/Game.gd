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
	rpc_unreliable_id(1, "set_score", p_owner)

	
remote func update_leaderboard(leaderboard_info):
	var sorted_leaderboard = []
	var sort
	for leader in leaderboard_info:
		sorted_leaderboard.append({leaderboard_info[leader]: leader})

	sorted_leaderboard.sort_custom(self, "custom_sort")

	var player_id = get_tree().get_network_unique_id()
	get_node(str(player_id)).get_node('UI').get_node('HBoxContainer').get_node('./PlayerList').clear()
	get_node(str(player_id)).get_node('UI').get_node('HBoxContainer').get_node('./ScoreList').clear()
	for leader in sorted_leaderboard:
		var player_name
		
		if len(str(leader.values()[0])) > 7:
			player_name = str(leader.values()[0]).left(7) + "..."
		else:
			player_name = str(leader.values()[0]) 
		get_node(str(player_id)).get_node('UI').get_node('HBoxContainer').get_node('./PlayerList').add_item(player_name)
		get_node(str(player_id)).get_node('UI').get_node('HBoxContainer').get_node('./ScoreList').add_item(str(leader.keys()[0]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func custom_sort(a, b):
	if a.keys() < b.keys():
		return true
	return false

	

remote func spawn_player(p_id):
	if (p_id == get_tree().get_network_unique_id()):
		var ship = player_ship.instance()
		ship.name = str(get_tree().get_network_unique_id())
		ship.initialize()
		self.add_child(ship)
		ship.map_limits = $Map01/Boundary.get_used_rect()
		ship.map_cellsize = $Map01/Boundary.cell_size
		ship.set_camera_limits()
		ship.request_spawn()
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





























