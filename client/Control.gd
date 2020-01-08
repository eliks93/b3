extends Node

var peer = WebSocketClient.new()

func _input(event):
	if event.is_action_pressed("ui_toggle_fullscreen"):
		OS.window_maximized = !OS.window_maximized

func _ready():
	pass

func _process(delta):
	if (peer.get_connection_status() == NetworkedMultiplayerPeer.CONNECTION_CONNECTED ||
		peer.get_connection_status() == NetworkedMultiplayerPeer.CONNECTION_CONNECTING):
			peer.poll()

func swap_scene(node, newNode):
	var parent = node.get_parent()
	parent.remove_child(node)
	parent.add_child(newNode)

func connect_to(ip, port):
	peer = WebSocketClient.new()
	peer.connect_to_url('ws://' + ip + ':' + str(port), PoolStringArray(), true)
	get_tree().set_network_peer(peer)

func join_game(room_name):
	self.rpc_id(1, "join_room", room_name, GameState.player_info.name, GameState.ship_info.ship_type)

remote func join_game_success(game_info):
	$Lobby.room_join_success(game_info)

func join_game_fail():
	pass

func request_lobby_update():
	rpc_id(1, "request_lobby_update")

remote func update_lobby(room_list):
	if has_node('Lobby'):
		$Lobby.update(room_list)