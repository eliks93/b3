extends Node

func _ready():
	pass # Replace with function body.

func swap_scene(node, newNode):
	var parent = node.get_parent()
	print(node.name)
	print(get_node(".").name)
	parent.remove_child(node)
	parent.add_child(newNode)

func connect_to(ip, port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)

func join_game(room_name):
	rpc_id(1, "player_join_room", room_name)

func join_game_success():
	pass

func join_game_fail():
	pass