extends Node2D

var player_init = {}
var p_name = "Player"
var projectile = preload("res://Projectile.tscn")

var player_name = "Player"
var boat_selected = "0"

var boat_big = preload("res://Playerboats/BigBoat.tscn")
var boat_medium = preload("res://Playerboats/MediumBoat.tscn")
var boat_small = preload("res://Playerboats/SmallBoat.tscn")
var boats = [boat_big, boat_medium, boat_small]

var map_limits
var map_cellsize
var death_score
var leaderboard_info
var death_screen = preload("res://DeathScreen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	request_respawn()

func req_spawn_projectile(projectile_type, _position, _direction):
	rpc_unreliable_id(1, "_spawn_projectile", projectile_type, _position, _direction)

remote func _spawn_projectile(projectile_type, _position, _direction, mask):
	get_parent().get_node('AudioController').create_sound('fire', $PlayerBoat.position.x, $PlayerBoat.position.y)
	var proj = projectile.instance()
	
	proj.p_owner = str(mask)
	add_child(proj)
	proj.start(_position, _direction)

func _physics_process(delta):
	if has_node('PlayerBoat'):
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

func _on_PlayerBoat_health_changed(hp, p_owner):
	rpc_id(1, "update_health", hp, p_owner)

remote func update_health(hp):
	$PlayerBoat.update_health(hp)
	$PlayerBoat.hp = hp

remote func destroy():
	print("destroy called")
	get_parent().get_node('AudioController').create_sound('death', $PlayerBoat.position.x, $PlayerBoat.position.y)
	$PlayerBoat.explode()
	if has_node('DeathScreen'):
		death_screen()
#	$DeathScreen.current_score = current_score
#	print($DeathScreen.current_score)
	

func set_camera_limits():
	$PlayerBoat/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$PlayerBoat/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$PlayerBoat/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$PlayerBoat/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func request_respawn():
	rpc_unreliable_id(1, "respawn")


remote func respawn_player(x, y, rotation):
	var new_boat = boats[int(boat_selected)].instance()
	new_boat.position.x = x
	new_boat.position.y = y
	new_boat.rotation = rotation
	new_boat.get_node("PlayerName").set_name(player_name)
	add_child(new_boat)
	GameState.player_info.actor = new_boat
	set_camera_limits()
	$PlayerBoat.connect("health_changed", self, "_on_PlayerBoat_health_changed")
	for Turret in $PlayerBoat.get_node("Turrets").get_children():
		Turret.connect("spawn_projectile", self, "req_spawn_projectile")
	
	$PlayerBoat.connect("death_screen", self, "death_screen")

func death_screen():
	leaderboard_info = get_parent().leader_board
	var current_score = leaderboard_info[get_tree().get_network_unique_id()]['score']
	leaderboard_info = current_score
	var screen = death_screen.instance()
	screen.current_score = leaderboard_info
	add_child(screen)
