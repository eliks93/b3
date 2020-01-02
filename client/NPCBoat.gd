extends "res://Boat.gd"

signal turn_turret(mouse_position)

onready var bar = $Bar/TextureProgress
onready var tween = $Tween

var animated_health = 0
var mouse_pos = Vector2()

var player_init = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var npc_max_health = hp
	bar.max_value = npc_max_health
	update_health(npc_max_health)

func _process(delta):
	bar.value = animated_health
	emit_signal("turn_turret", mouse_pos)

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func _on_NPCBoat_health_changed(new_value):
	update_health(new_value)
