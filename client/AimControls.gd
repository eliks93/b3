extends Control

func _input(event):
	if GameState.player_info.actor:
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			if !get_parent().get_node("VirtualJoystick/Joystick/TouchScreenButton").is_joystick_input(event):
				if (event.position.x != 0 || event.position.y != 0):
					GameState.player_info.actor.touch_aim(event.position)
				print(event.position)
				GameState.player_info.actor.touch_firing(true)
				return
		
		GameState.player_info.actor.touch_firing(false)