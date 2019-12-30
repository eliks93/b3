extends Node2D

var players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("..").connect("player_added_to_game", self, "_player_added")
	get_node("..").connect("player_removed_from_game", self, "_player_removed")

func _server_created():
	# Need a function to generate map here.
	pass

func _player_added(id):
	players[id] = id
	_render_player_list()

func _player_removed(id):
	players.erase(id)
	_render_player_list()

func _render_player_list():
	$ItemList.clear()
	for player in players:
		$ItemList.add_item(str(player))