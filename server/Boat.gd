extends KinematicBody2D

signal update_position
signal health_changed

export var hp = 100

# NETWORK OPTIMIZATION
var last_packet_time = 0.0
var current_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

export var engine_power = 1200
export var wheel_base = 160
export var steering_angle = 15

var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_angle = 0

var reset_vel = false

export var braking = -800
export var max_speed_reverse = 250

export var friction = -0.01
export var drag = -0.002

func _physics_process(delta):
	var old_vel = null
	current_time += delta
	
	if velocity.length() != 0:
		old_vel = {}
		old_vel.x = velocity.x > 0
		old_vel.y = velocity.y > 0
	
	get_input()
	apply_friction()
	calculate_steering(delta)
	
	
	
	velocity += acceleration * delta
	print(velocity)
	print('LENGTH: ', velocity.length())
	if (old_vel && (old_vel.x != (velocity.x > 0) || velocity.x == 0) && 
		(old_vel.y != (velocity.y > 0) || velocity.y == 0)):
		velocity = Vector2.ZERO
		acceleration = Vector2.ZERO
	
	velocity = move_and_slide(velocity)
	if current_time - last_packet_time + 0.03:
		last_packet_time = current_time
		emit_signal("update_position")

# Method override in lower boat classes
func get_input():
	pass

func apply_friction():
	# No good value to stop wobble with revamp.
	# Need new solution.
	if velocity.length() < 8:
		velocity = Vector2.ZERO
	var friction_force = velocity * velocity.length() * friction
	var drag_force = velocity * velocity.length() * drag
	
	acceleration += drag_force + friction_force

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 4.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	
	rotation = new_heading.angle()

func take_damage(dmg, p_owner):
	hp -= dmg
	emit_signal("health_changed", hp, p_owner)

