extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_node("../../..").has_node("PlayerBoat"):
		$Sprite.show()
		position.x = (get_node("../../..").get_node("PlayerBoat").position.x)/25
		position.y = (get_node("../../..").get_node("PlayerBoat").position.y)/25
		rotation = get_node("../../..").get_node("PlayerBoat").rotation
	else:
		$Sprite.hide()