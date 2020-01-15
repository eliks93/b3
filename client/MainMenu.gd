extends CanvasLayer

var lobby = preload("res://Lobby.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$editName.placeholder_text = "YourNameHere!"
	$editName.grab_focus()
	
func _on_buttonLobby_pressed():
	get_node("..").connect_to("44.226.231.200", 4587)
#	get_node("..").connect_to("127.0.0.1", 4587)
	get_node("..").swap_scene(get_node("."), lobby.instance())

func _on_editName_text_changed(new_text):
	GameState.player_info.name = $editName.text

func _on_Big_pressed():
	$BigLayer/Big.pressed = true
	$MediumLayer/Medium.pressed = false
	$SmallLayer/Small.pressed = false
	$OrbLayer/Orb.pressed = false
	GameState.ship_info.ship_type = 0

func _on_Medium_pressed():
	$BigLayer/Big.pressed = false
	$MediumLayer/Medium.pressed = true
	$SmallLayer/Small.pressed = false
	$OrbLayer/Orb.pressed = false
	GameState.ship_info.ship_type = 1

func _on_Small_pressed():
	$BigLayer/Big.pressed = false
	$MediumLayer/Medium.pressed = false
	$SmallLayer/Small.pressed = true
	$OrbLayer/Orb.pressed = false
	GameState.ship_info.ship_type = 2


func _on_Orb_pressed():
	$BigLayer/Big.pressed = false
	$MediumLayer/Medium.pressed = false
	$SmallLayer/Small.pressed = false
	$OrbLayer/Orb.pressed = true
	GameState.ship_info.ship_type = 3


func _on_editName_focus_entered():
	if OS.has_touchscreen_ui_hint():
		OS.show_virtual_keyboard("")


func _on_editName_focus_exited():
	OS.hide_virtual_keyboard()
