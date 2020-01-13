extends Area2D

export var speed = 10000
export var damage = 10
export var life = 10.0

var velocity = Vector2()
var acceleration = Vector2()

var direction
var p_owner
signal explode_projectile
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(_position, _direction):
	position = _position
	direction = _direction.angle()
	rotation = direction
	$Lifetime.wait_time = life
	$Lifetime.start()
	velocity = _direction * speed

func _process(delta):
	position += velocity * delta
	rotation = direction

func explode():
	velocity = Vector2()
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play("ping")

func _on_Projectile_body_entered(body):
	if (body.get_node("..").name != p_owner):
		get_parent().get_parent().get_node('AudioController').create_sound('machine_hit', position.x, position.y)
		explode()
		if body.has_method("take_damage"):
			body.take_damage(damage, p_owner)
		if body.has_method("start"):
			body.start()

func _on_Explosion_animation_finished():
	queue_free()


func _on_Lifetime_timeout():
	velocity = Vector2()
	$Sprite.hide()
	$WateryExplosion.show()
	$WateryExplosion.play("sploosh")


func _on_WateryExplosion_animation_finished():
	queue_free()
