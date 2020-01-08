extends Area2D

export var life = 4
# Called when the node enters the scene tree for the first time.
var p_owner
func start(_position, _direction):
	if get_parent().has_node("PlayerBoat"):
		get_parent().get_node("PlayerBoat").hide()
		get_parent().get_node("PlayerBoat").get_node("Bar").hide()
		get_parent().get_node("PlayerBoat").get_node("PlayerName").hide()
	if get_parent().has_node("NPCBoat"):
		get_parent().get_node("NPCBoat").hide()
		get_parent().get_node("NPCBoat").get_node("Bar").hide()
		get_parent().get_node("NPCBoat").get_node("PlayerName").hide()
	$Lifetime.wait_time = life
	$Lifetime.start()

func _on_Lifetime_timeout():
	if get_parent().has_node("PlayerBoat"):
		get_parent().get_node("PlayerBoat").show()
		get_parent().get_node("PlayerBoat").get_node("Bar").show()
		get_parent().get_node("PlayerBoat").get_node("PlayerName").show()
	if get_parent().has_node("NPCBoat"):
		get_parent().get_node("NPCBoat").show()
		get_parent().get_node("NPCBoat").get_node("Bar").show()
		get_parent().get_node("NPCBoat").get_node("PlayerName").show()
	queue_free()
