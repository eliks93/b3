extends "res://Boat.gd"

signal turn_turret(mouse_position)

onready var bar = $Bar/TextureProgress
onready var tween = $Tween

var animated_health = 0
var mouse_position

var player_init = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var npc_max_health = hp
	bar.max_value = npc_max_health
	update_health(npc_max_health)

slave func setPosition(packet):
	# Apply movement to other boats.
	pass

func _process(delta):
	bar.value = animated_health
#	emit_signal("turn_turret", mouse_position)

#var packet = {
#	'mouse_pos': get_global_mouse_position(),
#	'position': {
#		'x': position.x,
#		'y': position.y
#	},
#	'rotation': rotation,
#	'acceleration': self.acceleration,
#	'velocity': self.velocity
#}

func _on_PlayerBoat_health_changed(npc_health):
	update_health(npc_health)

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()