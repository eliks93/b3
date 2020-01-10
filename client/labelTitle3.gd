extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var ui = get_node('../UI')
	if ui.has_node('TouchControls'):
		self.text = ""
	else:
		self.text = 'Use right and left mouse button to fire primary and secondary projectiles!'
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
