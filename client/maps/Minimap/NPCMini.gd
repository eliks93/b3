extends Node2D

var p_owner

func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_node("../../../..").has_node(p_owner):
		if get_node("../../../..").get_node(p_owner).has_node("NPCBoat"):
			$Sprite.show()
			position.x = (get_node("../../../..").get_node(p_owner).get_node("NPCBoat").position.x)/25
			position.y = (get_node("../../../..").get_node(p_owner).get_node("NPCBoat").position.y)/25
		else:
			$Sprite.hide()
	else:
		queue_free()