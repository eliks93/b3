extends CanvasLayer
var x = 0.0
var y = 0.0
var lock_respawn = true


var current_score = 0

	
	
func _ready():
	$Timer.start()
	print(x, y)
	print ($DeathCam.position, "before")
	$DeathCam.position = Vector2(x, y)
	$Score.text = str(current_score)
	if get_parent().boat_selected == 2:
		$BigLayer/Big.pressed = false
		$MediumLayer/Medium.pressed = false
		$SmallLayer/Small.pressed = true
		$OrbLayer/Orb.pressed = false
	elif get_parent().boat_selected == 1:
		$BigLayer/Big.pressed = false
		$MediumLayer/Medium.pressed = true
		$SmallLayer/Small.pressed = false
		$OrbLayer/Orb.pressed = false
	elif get_parent().boat_selected == 3:
		$BigLayer/Big.pressed = false
		$MediumLayer/Medium.pressed = false
		$SmallLayer/Small.pressed = false
		$OrbLayer/Orb.pressed = true
	else:
		$BigLayer/Big.pressed = true
		$MediumLayer/Medium.pressed = false
		$SmallLayer/Small.pressed = false
		$OrbLayer/Orb.pressed = false


func _on_Button_pressed():
	print(lock_respawn)
	if !lock_respawn:
		get_parent().request_respawn() # Request respawn on player object.
		get_parent().remove_child(self)

func _on_Big_pressed():
	$BigLayer/Big.pressed = true
	$MediumLayer/Medium.pressed = false
	$SmallLayer/Small.pressed = false
	$OrbLayer/Orb.pressed = false
	GameState.ship_info.ship_type = 0
	get_parent().boat_selected = 0
	get_parent().update_ship_type(0)

func _on_Medium_pressed():
	$BigLayer/Big.pressed = false
	$MediumLayer/Medium.pressed = true
	$SmallLayer/Small.pressed = false
	$OrbLayer/Orb.pressed = false
	GameState.ship_info.ship_type = 1
	get_parent().boat_selected = 1
	get_parent().update_ship_type(1)

func _on_Small_pressed():
	$BigLayer/Big.pressed = false
	$MediumLayer/Medium.pressed = false
	$SmallLayer/Small.pressed = true
	$OrbLayer/Orb.pressed = false
	GameState.ship_info.ship_type = 2
	get_parent().boat_selected = 2
	get_parent().update_ship_type(2)


func _on_Orb_pressed():
	$BigLayer/Big.pressed = false
	$MediumLayer/Medium.pressed = false
	$SmallLayer/Small.pressed = false
	$OrbLayer/Orb.pressed = true
	GameState.ship_info.ship_type = 3
	get_parent().boat_selected = 3
	get_parent().update_ship_type(3)


func _on_Timer_timeout():
	lock_respawn = false
