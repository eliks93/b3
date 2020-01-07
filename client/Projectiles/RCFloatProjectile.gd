extends Area2D

export var launch_speed = 0.5
export var speed = 0.2
export var damage = 50
export var life = 8.0

var alive = true

var velocity = Vector2()
var acceleration = Vector2()

var will_bounce = true
var bounce_velocity = Vector2()

var direction
var p_owner
signal explode_projectile
# Called when the node enters the scene tree for the first time.
func _ready():
	$EExploson.connect("remove", self, "_delete")
	start()

func start(_position = Vector2(1, 1), _direction = Vector2(160, 160)):
	$AnimationPlayer.play("EBall")
	position = _position
	direction = _direction.angle()
	$Lifetime.wait_time = life
	$Lifetime.start()
	velocity = _direction * launch_speed

func _physics_process(delta):
	if alive:
		var target = get_global_mouse_position()
		if (bounce_velocity.length() > 0):
			position += bounce_velocity * 0.2
			if bounce_velocity.length() < 1:
				bounce_velocity = Vector2()
			else:
				bounce_velocity *= 0.8
		var movement = target - position
		position += movement * delta
		rotation += deg2rad(30) * delta

func explode():
	alive = false
	velocity = Vector2()
	if $CollisionShape2D:
		$CollisionShape2D.queue_free()
	$EBall.hide()
	$EExploson/AnimationPlayer.play("EExplosion")
	

func _on_RCFloatProjectile_body_entered(body):
	if (body.get_node("..").name != p_owner):
		get_parent().get_parent().get_node('AudioController').create_sound('hit', position.x, position.y)
		explode()
		if body.has_method("take_damage"):
			body.take_damage(damage, p_owner)


func _on_RCFloatProjectile_area_entered(area):
	if ("will_bounce" in area):
		var difference = position - area.position
		bounce_velocity = difference * 0.6

	if (area.get_node("..").name != p_owner):
		explode()

func _delete():
	queue_free()

func _on_Lifetime_timeout():
	explode()
