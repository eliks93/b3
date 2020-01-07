extends Area2D

export var speed = 1000
export var damage = 10
export var life = 10.0

var velocity = Vector2()
var acceleration = Vector2()

var direction

var p_owner

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(_position, _direction):
	position = _position
	direction = _direction.angle()
	rotation = direction
	$Lifetime.wait_time = life
	velocity = _direction * speed

remote func update_position(packet):
	rpc_unreliable("update_position", packet)

func _process(delta):
	position += velocity * delta
	rotation = direction

func explode():
	queue_free()

func _on_Projectile_body_entered(body):
	explode()
	if body.has_method("take_damage"):
		body.take_damage(damage)