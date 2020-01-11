extends "res://Boat.gd"

signal fire_turret(group)
signal fire_turret_secondary
signal turn_turret(mouse_pos)
signal death_screen
onready var bar = $Bar/TextureProgress
onready var tween = $Tween

var mouse_pos = Vector2()

var animated_health = 0
var ripple_opacity = 0

var touch_enabled = OS.has_touchscreen_ui_hint()

var mob_x = 0
var mob_y = 0
var mob_firing = false

var player_max_health = 0

var touch_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	for Turret in $Turrets.get_children():
		Turret.connect("spawn_projectile", self, "_spawn_projectile")
	if has_node("TurretsSecondary"):
		for Turret in $TurretsSecondary.get_children():
			Turret.connect("spawn_projectile", self, "_spawn_projectile_secondary")
	player_max_health = hp
	animated_health = hp
	bar.max_value = player_max_health
	update_health(player_max_health)

func _process(delta):
	# Override mouse position with touch here
	if !touch_enabled:
		mouse_pos = get_global_mouse_position()
	else:
		mouse_pos = touch_position # Mobile pos

	emit_signal("turn_turret", mouse_pos)
	set_camera_position()
	bar.value = animated_health
	ripple_visibility()

func mobile_joystick(x, y):
	mob_x = x
	mob_y = y

func touch_aim(position):
	var zoom = 3
	var foo = self.position - get_viewport_rect().size * zoom / 2
	
	# This fire relative to the center of the screen, not the boats position.
	# It also does not continue to fire directly at the event unless the event is moving.
	
## this is wrong but it hauntingly smells of correctness
#	touch_position = zoom * position + foo + (
#		self.position - ($Camera2D.global_position + get_viewport_rect().size * zoom / 2)
#	)
	
	touch_position = $Camera2D.get_camera_position() + 3 * position
	
	print("Camera upper left: ", $Camera2D.get_camera_position())
	print("Boat position: ", self.position)
	print("Raw touch even: ", position)
	print("Hypothesis: ", touch_position)
	
	
	# We need to clamp the camera global_position here to account for map bounds.

func touch_firing(isFiring):
	mob_firing = isFiring

func get_input():
	var turn = 0
	if Input.is_action_pressed("steer_right"):
		turn += 1
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	
	steer_angle = turn * deg2rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	
	if (Input.is_action_pressed("fire_1")):
		emit_signal("fire_turret", 1)
	
	if (Input.is_action_pressed("fire_2")):
		emit_signal("fire_turret_secondary", 1)
	
	if (touch_enabled):
		if (mob_x > 0):
			turn += mob_x
		if (mob_x < 0):
			turn += mob_x
		
		steer_angle = turn * deg2rad(steering_angle)
		
		if (mob_y > 0):
			acceleration = transform.x * (engine_power * mob_y)
		if (mob_y < 0):
			acceleration = -transform.x * (braking * mob_y)
		
		if (mob_firing):
			emit_signal("fire_turret", 1)

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func ripple_visibility():
	var new_opacity = velocity.length() / 100
	
	if new_opacity > 1:
		new_opacity = 1
	
	$Tween.interpolate_property($BoatRipple, "modulate",
		Color(1, 1, 1, ripple_opacity), Color(1, 1, 1, new_opacity), 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	ripple_opacity = new_opacity

func set_camera_position():
	var offset = get_viewport().get_mouse_position() - self.global_position
	var x_offset = get_viewport().get_mouse_position()[0] - get_viewport_rect().size.x / 2
	var y_offset = get_viewport().get_mouse_position()[1] - get_viewport_rect().size.y / 2
	# The viewport scale is zoomed out by 3.  So we need to multiply the size by 3,
	# THEN perform normal operations
	$Camera2D.global_position[0] = self.global_position[0] - (get_viewport_rect().size.x * 3) / 2 + x_offset
	$Camera2D.global_position[1] = self.global_position[1] - (get_viewport_rect().size.y * 3) / 2 + y_offset

func explode():
	modulate.a = 1

	velocity = Vector2()
	$Sprite.hide()
	if has_node('Turrets'):
		$Turrets.queue_free()
	$CollisionShape2D.disabled = true
	$Explosion.show()
	$Explosion.play("fire")
	

func _on_Explosion_animation_finished():
#	get_parent().add_child(death_screen.instance())
	queue_free()
	emit_signal("death_screen")


func _on_WateryExplosion_animation_finished():
	pass # Replace with function body.
