extends Node

signal player_added_to_game(room, pid)
signal player_removed_from_game(room, pid)

signal invalid_ship

var server_info = {
	name = "Main",
	max_players = 80,
	used_port = 4587
}

var players = {}
# Players will look like this
# pid: {
# 	'name': "Player",
# 	'room': null,
# 	'ship': instance of ship
# }

var games = {}
# Games will simply hold game instances.
# We can reach into the instance for any
# info we need.

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

func _on_player_disconnected(id):	
	players.erase(id)

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
	games[name] = newGame
	add_child(newGame)

func update_lobby(pid):
	pass
	# We're going to have to create a flag to check if the games
	# have been modified since the last update for the player.
	# If they have, recompile the list and send it.
	# Don't worry about efficiency yet.
	# If they haven't, just skip.

remote func request_update_lobby():
	var player = get_tree().get_rpc_sender_id()
	update_lobby(player)

remote func player_join_room(room_name):
	var player = get_tree().get_rpc_sender_id()
	if games.has(room_name):
		games[name].addChild() # Need to create player object to append here.
		# We need to create an instance of the player
		# In the game room here, and add them to the
		# Player list.
		rpc_id(player, "join_game_success")

remote func player_select_ship(ship):
	var player = get_tree().get_rpc_sender_id()
	# Validation check for selected ship.
	# If true
	players[player].ship = ship
	# If false
	emit_signal("invalid_ship")


















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
























































