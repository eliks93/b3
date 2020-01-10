extends Label

func _ready():
	var ui = get_node('../UI')
	if ui.has_node('TouchControls'):
		self.text = "Click Start to Begin!"
	else:
		self.text = 'Destroy the Start Button to begin!'
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
