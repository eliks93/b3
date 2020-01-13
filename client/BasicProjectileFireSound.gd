extends AudioStreamPlayer2D
signal done
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var pan = AudioServer.get_bus_effect(AudioServer.get_bus_index("L/R"), 0)
	if (pan.pan < 0.25):
		pan.pan = 0.25
	if (pan.pan > 0.75):
		pan.pan = 0.75
	# Need to create manual panning based on max distance and actual distance.  Ratio for each earpiece.

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_AudioStreamPlayer2D_finished():
	emit_signal('done')
	queue_free()
