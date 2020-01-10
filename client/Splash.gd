extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var MainMenu = preload("res://MainMenu.tscn")

func _on_AudioController_start():
	get_node("..").swap_scene(get_node("."), MainMenu.instance())


func _on_buttonStart_pressed():
	get_node("..").swap_scene(get_node("."), MainMenu.instance())
