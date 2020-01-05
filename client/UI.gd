extends CanvasLayer

func _ready():
	if OS.has_touchscreen_ui_hint():
		_build_mobile_UI()

func _build_mobile_UI():
	add_child(load("res://TouchControls.tscn").instance())
