extends Label

func _ready():
	if get_parent().touch:
		self.text = "Click Start to Begin!"
	else:
		self.text = 'Destroy the Start Button to begin!'
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
