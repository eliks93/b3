extends Node
var touch = OS.has_touchscreen_ui_hint()

var MainMenu = preload("res://MainMenu.tscn")
	
	
func _on_AudioController_start():
	get_node("..").swap_scene(get_node("."), MainMenu.instance())


func _on_buttonStart_pressed():

	if has_node('UI/TouchControls'):
		get_node("..").swap_scene(get_node("."), MainMenu.instance())
