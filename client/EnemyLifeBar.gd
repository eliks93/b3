extends HBoxContainer

func _ready():
	var ui = get_node('../../../../UI')
	if ui.has_node('TouchControls'):
		self.hide()
