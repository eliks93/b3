extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().boat_selected == 2:
		$Big.pressed = false
		$Medium.pressed = false
		$Small.pressed = true
	elif get_parent().boat_selected == 1:
		$Big.pressed = false
		$Medium.pressed = true
		$Small.pressed = false
	else:
		$Big.pressed = true
		$Medium.pressed = false
		$Small.pressed = false
	$Score.text = str(current_score)

func _on_Button_pressed():
	get_parent().request_respawn() # Request respawn on player object.
	get_parent().remove_child(self)

func _on_Big_pressed():
	$Big.pressed = true
	$Medium.pressed = false
	$Small.pressed = false
	$Orb.pressed = false
	GameState.ship_info.ship_type = 0
	get_parent().boat_selected = 0
	get_parent().update_ship_type(0)

func _on_Medium_pressed():
	$Big.pressed = false
	$Medium.pressed = true
	$Small.pressed = false
	$Orb.pressed = false
	GameState.ship_info.ship_type = 1
	get_parent().boat_selected = 1
	get_parent().update_ship_type(1)

func _on_Small_pressed():
	$Big.pressed = false
	$Medium.pressed = false
	$Small.pressed = true
	$Orb.pressed = false
	GameState.ship_info.ship_type = 2
	get_parent().boat_selected = 2
	get_parent().update_ship_type(2)


func _on_Orb_pressed():
	$Big.pressed = false
	$Medium.pressed = false
	$Small.pressed = false
	$Orb.pressed = true
	GameState.ship_info.ship_type = 3
	get_parent().boat_selected = 3
	get_parent().update_ship_type(3)
