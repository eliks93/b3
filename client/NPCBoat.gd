extends "res://Boat.gd"

signal turn_turret(mouse_position)

onready var bar = $Bar/TextureProgress
onready var tween = $Tween

var animated_health = 100
var ripple_opacity = 0

var mouse_pos = Vector2()

var player_init = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var npc_max_health = hp
	bar.max_value = npc_max_health
	update_health(npc_max_health)

func _process(delta):
	bar.value = animated_health
	ripple_visibility()
	emit_signal("turn_turret", mouse_pos)

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func _on_NPCBoat_health_changed(new_value):
	update_health(new_value)

func explode():
	velocity = Vector2()
	$Sprite.hide()
	$Turret1/Sprite.hide()
	$Turret2/Sprite.hide()
	$CollisionShape2D.disabled = true
	$Explosion.show()
	$Explosion.play("fire")


func _on_Explosion_animation_finished():
	queue_free()

func ripple_visibility():
	var new_opacity = velocity.length() / 100
	
	if new_opacity > 1:
		new_opacity = 1
	
	$Tween.interpolate_property($BoatRipple, "modulate",
		Color(1, 1, 1, ripple_opacity), Color(1, 1, 1, new_opacity), 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	ripple_opacity = new_opacity