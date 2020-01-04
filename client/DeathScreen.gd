extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = str(current_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_parent().request_respawn() # Request respawn on player object.
	get_parent().remove_child(self)