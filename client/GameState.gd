extends Node

var boat = preload("res://Playerboats/BigBoat.tscn")

var player_info = {
	'name': "Player",
	'actor': boat.instance()
}

var ship_info = {
	'ship_type': 0,
	'turrets': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
}

var room_info = {
	'name': "Main Room"
}