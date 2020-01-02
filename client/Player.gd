extends Node2D

var player_init = {}
var p_name = "Player"
var projectile = preload("res://Projectile.tscn")

var death_screen = preload("res://DeathScreen.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerBoat/Turret1.connect("spawn_projectile", self, "req_spawn_projectile")
	$PlayerBoat/Turret2.connect("spawn_projectile", self, "req_spawn_projectile")
	$PlayerBoat/Turret3.connect("spawn_projectile", self, "req_spawn_projectile")

func initialize():
	$PlayerBoat.position.x = 0
	$PlayerBoat.position.y = 0

func req_spawn_projectile(projectile_type, _position, _direction):
	rpc_unreliable_id(1, "_spawn_projectile", projectile_type, _position, _direction)

remote func _spawn_projectile(projectile_type, _position, _direction, mask):
	var proj = projectile.instance()
	proj.p_owner = str(mask)
	add_child(proj)
	proj.start(_position, _direction)

func _physics_process(delta):
	if ($PlayerBoat):
		var packet = {
			'position': {
				'x': $PlayerBoat.position.x,
				'y': $PlayerBoat.position.y
			},
			'rotation': $PlayerBoat.rotation,
			'acceleration': $PlayerBoat.acceleration,
			'velocity': $PlayerBoat.velocity,
			'mouse_pos': $PlayerBoat.mouse_pos
		}
		rpc_unreliable_id(1, "update_position", packet)

func _on_PlayerBoat_health_changed(hp):
	rpc_id(1, "update_health", hp)

remote func update_health(hp):
	$PlayerBoat.hp = hp

remote func destroy():
	$PlayerBoat.queue_free()
	$Explosion.show()
	$Explosion.play("fire")
	
	

func set_camera_limits(map_limits,map_cellsize):
	$PlayerBoat/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$PlayerBoat/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$PlayerBoat/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$PlayerBoat/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func _on_Explosion_animation_finished():
	add_child(death_screen.instance())
	$Explosion.hide()
