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

func start():
	$Lifetime.wait_time = life
	$Lifetime.start()

remote func update_position(packet):
	if p_owner == get_tree().get_rpc_sender_id():
		rpc_unreliable("update_position", packet)

remote func explode():
	if get_tree().get_rpc_sender_id() == p_owner:
		queue_free()

func _on_Lifetime_timeout():
	queue_free()
