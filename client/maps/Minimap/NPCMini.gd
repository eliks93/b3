extends Node2D

var leader_icon = preload("res://assets/UI/crossair_redOutline.png")
var npc_icon = preload("res://assets/circle-icon-16060.png")
var p_owner
func _process(delta):
	var score = get_node("../../../..").sorted_boi[0].keys()[0]
	var top_scorer = get_node("../../../..").sorted_boi[0][score].keys()[0]
	if score > 0:
		if str(top_scorer) == p_owner:
			$Sprite.set_texture(leader_icon)
			$Sprite.modulate = Color(1,1,1,1)
			$Sprite.scale.x = 1.5
			$Sprite.scale.y = 1.5
	else:
		$Sprite.set_texture(npc_icon)
		$Sprite.modulate = Color(0.8,0.01,0.01,1)
		$Sprite.scale.x = 0.04
		$Sprite.scale.y = 0.04
	if get_node("../../../..").has_node(p_owner):
		if get_node("../../../..").get_node(p_owner).has_node("NPCBoat"):
			print("oooo")
			$Sprite.show()
			position.x = (get_node("../../../..").get_node(p_owner).get_node("NPCBoat").position.x)/25
			position.y = (get_node("../../../..").get_node(p_owner).get_node("NPCBoat").position.y)/25
		else:
			$Sprite.hide()
	else:
		queue_free()