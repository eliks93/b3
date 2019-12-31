extends CanvasLayer

var lobby = preload("res://Lobby.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_buttonLobby_pressed():
	get_node("..").connect_to("127.0.0.1", 4587)
	get_node("..").swap_scene(get_node("."), lobby.instance())