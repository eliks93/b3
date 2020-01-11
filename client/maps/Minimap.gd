extends Node2D
var player_mini = preload("res://maps/Minimap/PlayerMini.tscn")
var npc_mini = preload("res://maps/Minimap/NPCMini.tscn")

func _ready():
	var player_spot = player_mini.instance()
	add_child(player_spot)

func _process(delta):
	for player in get_node("../../..").get_children():
		if !player.has_node("UI") && !player.get("mapped") == null:
			if !player.mapped:
				
				var npc_spot = npc_mini.instance()
				npc_spot.p_owner = player.name
				player.mapped = true
				add_child(npc_spot)
