extends KinematicBody2D

export var launch_speed = 0.5
export var speed = 0.2
export var damage = 25
export var life = 8.0

var is_RC = true

var alive = true

var velocity = Vector2()
var acceleration = Vector2()

var direction
var p_owner
signal explode_projectile

# NETWORK OPTIMIZATION
var last_packet_time = 0.0
var current_time = 0.0

var packet = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	$EExploson.connect("remove", self, "_delete")
	add_collision_exception_with(get_parent().get_node("PlayerBoat"))
	start()

func start(_position = Vector2(1, 1), _direction = Vector2(160, 160)):
	$AnimationPlayer.play("EBall")
	position = _position
	direction = _direction.angle()
	$Lifetime.wait_time = life
	$Lifetime.start()
	velocity = _direction * launch_speed

func _physics_process(delta):
	current_time += delta
	if alive && p_owner == str(get_tree().get_network_unique_id()):
		var target = get_global_mouse_position()
		if (get_parent().get_node("PlayerBoat").touch_enabled):
			target = get_parent().get_node("PlayerBoat").touch_position
		var movement = target - position
		move_and_slide(movement)
		rotation += deg2rad(30) * delta
		if (p_owner == str(get_tree().get_network_unique_id()) && current_time >= last_packet_time + 0.05):
			packet = {
				'mouse_pos': target,
				'position': position,
			}
			last_packet_time = current_time
			rpc_unreliable_id(1, "update_position", packet)

remote func update_position(packet):
	if p_owner != str(get_tree().get_network_unique_id()):
		position = packet.position
		var mouse_pos = packet.mouse_pos

func explode():
	rpc_unreliable_id(1, "explode")
	alive = false
	velocity = Vector2()
	if $CollisionShape2D:
		$CollisionShape2D.queue_free()
	if $HitBox:
		$HitBox.queue_free()
	$EBall.hide()
	$EExploson/AnimationPlayer.play("EExplosion")

func _delete():
	queue_free()

func _on_Lifetime_timeout():
	explode()

func _on_HitBox_body_entered(body):
	if (body.get_node("..").name != p_owner):
		get_parent().get_parent().get_node('AudioController').create_sound('hit', position.x, position.y)
		if body.get("is_RC"):
			body.explode()
		explode()
		if body.has_method("take_damage"):
			body.take_damage(damage, p_owner)
