extends StaticBody2D
signal death_sound(p1, p2)
signal start
var hp = 100
onready var bar = $Bar2/TextureProgress
onready var tween = $Tween
var animated_health = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var max_health = hp
	bar.max_value = max_health
	update_health(max_health)
	
func _process(delta):
	bar.value = animated_health
		
func start():
	hp -= 20

	if hp <= 0:
		emit_signal('death_sound', position.x, position.y)
		
		get_node('../buttonStart').hide()
		$CollisionShape2D.disabled = true
		$Explosion.show()
		$Explosion.play('fire')
	else:
		update_health(hp)
		
func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func _on_Explosion_animation_finished():
	queue_free()

