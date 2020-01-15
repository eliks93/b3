extends Node
var touch = OS.has_touchscreen_ui_hint()

var MainMenu = preload("res://MainMenu.tscn").instance()


func _on_AudioController_start():
	get_node("..").swap_scene(get_node("."), MainMenu)


#func _on_buttonStart_pressed():
#
##	if self.touch:
##		get_node("..").swap_scene(get_node("."), MainMenu)


func _on_buttonStart_start_pressed():
	get_node("..").swap_scene(get_node("."), MainMenu)
