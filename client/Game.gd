extends Node2D

var player_ship = preload("res://Player.tscn")
var npc_ship = preload("res://NPC.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Announce ready to spawn here.
	rpc_id(1, "spawn_for")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

remote func spawn_player(p_id):
	if (p_id == get_tree().get_network_unique_id()):
		var ship = player_ship.instance()
		ship.name = str(get_tree().get_network_unique_id())
		ship.initialize()
		self.add_child(ship)
	else:
		var ship = npc_ship.instance()
		ship.name = str(p_id)
		ship.get_node("NPCBoat").collision_layer = 1
		ship.get_node("NPCBoat").collision_mask = 1
		ship.initialize()
		self.add_child(ship)