extends CanvasLayer

var lobby = preload("res://Lobby.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_buttonLobby_pressed():
#	get_node("..").connect_to("ec2-18-191-0-94.us-east-2.compute.amazonaws.com", 4587)
	get_node("..").connect_to("44.226.231.200", 4587)
	get_node("..").swap_scene(get_node("."), lobby.instance())

func _on_editName_text_changed(new_text):
	GameState.player_info.name = $editName.text