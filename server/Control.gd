extends Node

signal player_added(pid)
signal player_removed(pid)

signal player_joined_room(pinfo)
signal player_left_room(pinfo)

var server_info = {
	name = "Main",
		max_players = 80,
		used_port = 4587
}

var players = {}
var games = {}

var gameTemplate = preload("res://Game.tscn")

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")

	create_server()
	create_game("Main Room")
	create_game("Test 1")
	create_game("Test 2")

func _on_player_connected(id):
	players[id] = id
	emit_signal("player_added", id)

func _on_player_disconnected(id):	
	players.erase(id)
	emit_signal("player_removed", id)

func create_server():
	# Initialize network
	var net = NetworkedMultiplayerENet.new()

	# Attempt to launch server
	if (net.create_server(server_info.used_port, server_info.max_players) != OK):
		print("Failed to create server")
		return

	get_tree().set_network_peer(net)

# Created a game node and sets the name to desired name.
func create_game(name):
	var newGame = gameTemplate.instance()
	newGame.name = name
	games[name] = {
		'name': name,
		'players': {}
	}
	self.add_child(newGame)

remote func player_joined_room(room_name):
	var player = get_tree().get_rpc_sender_id()
	if games.has(room_name):
		games[room_name].players[player] = players[player]
		rpc_id(player, "join_game_success", games[room_name])
		emit_signal("player_joined_room", player)
		# games[name].addChild() # Need to create player object to append here.
		# We need to create an instance of the player
		# In the game room here, and add them to the
		# Player list.
		# rpc_id(player, "join_game_success")

#func _on_player_disconnected(id):
#	print("Player ", players[id].name, " disconnected from server")
#
#	# Is always net server
#	unregister_player(id)
#	rpc("unregister_player", id)
#
#remote func register_player(pinfo):
#	for id in players:
#		# Sends new player info to current existing player
#		rpc_id(pinfo.net_id, "register_player", players[id])
#		# Do not need to confirm if current player is not server, as dedicated server is not in player list.
#		# Sends current existing player info to new player
#		rpc_id(id, "register_player", pinfo)
#
#	print("Registering player ", pinfo.name, " (", pinfo.net_id, ") to internal player table")
#
#	players[pinfo.net_id] = pinfo
#	spawn_players(pinfo)
#
#remote func unregister_player(id):
#	print("Removing player ", players[id].name, " from internal table")
#	# Cache player info for actor deletion
#	var pinfo = players[id]
#	# Remove player from list
#	players.erase(id)
#	# Notify game of list changing
#	emit_signal("player_removed", pinfo)
#
#
#
#
#remote func spawn_players(pinfo):
#
#	for id in players:
#
#		if (id != pinfo.net_id):
#			rpc_id(pinfo.net_id, "spawn_players", players[id])
#
#		rpc_id(id, "spawn_players", pinfo)
























































