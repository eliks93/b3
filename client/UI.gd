extends CanvasLayer
var set_cooldown
var cooldown_initiated = false

var ability_icons = {
	1: preload("res://assets/AbilityIcons/ability_shield.png"),
	2: "",
	3: "",
	4: ""
}

func _ready():
	if OS.has_touchscreen_ui_hint():
		_build_mobile_UI()
	

func _build_mobile_UI():
	add_child(load("res://TouchControls.tscn").instance())

func _process(delta):
	if cooldown_initiated:
		$Cooldown.value = ((set_cooldown - $Timer.get_time_left())/set_cooldown)*100


func start_cooldown(cooldown):
	set_cooldown = cooldown
	$Timer.wait_time = cooldown
	$Timer.start()
	cooldown_initiated = true

func _on_Timer_timeout():
	cooldown_initiated = false
