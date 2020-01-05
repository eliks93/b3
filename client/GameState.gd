extends Node

var boat = preload("res://RealPlayer.tscn")

var player_info = {
	'name': "Player",
	'actor': boat.instance()
}

var ship_info = {
	'ship_type': "res://RealPlayer.tscn",
	'turrets': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
}

var room_info = {
	'name': "Main Room"
}