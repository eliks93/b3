extends Node

func _ready():
	pass # Replace with function body.

func swap_scene(node, newNode):
	var parent = node.get_parent()
	parent.remove_child(node)
	parent.add_child(newNode)

func connect_to(ip, port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)

func join_game(room_name):
	self.rpc_id(1, "player_joined_room", room_name)

remote func join_game_success(game_info):
	$Lobby.room_join_success(game_info)

func join_game_fail():
	pass

func request_lobby_update():
	rpc_id(1, "request_lobby_update")

remote func update_lobby(room_list):
	$Lobby.update(room_list)