extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func ready():
	$SplashBoat.position = Vector2(200.0, 200.0)
	$SplashBoat/Turret.connect('spawn_projectile', self, '_spawn_projectile')
	$SplashBoat/Turret2.connect('spawn_projectile', self, '_spawn_projectile_secondary')
	GameState.player_info.actor = $SplashBoat

func _spawn_projectile(projectile_type, _position, _direction):
	get_parent().get_node('AudioController').create_sound('fire', self.position.x, self.position.y)
	
	var proj = $SplashBoat.projectile.instance()
	
	proj.p_owner = "SplashPlayer"
	add_child(proj)
	proj.start(_position, _direction)
	
func _spawn_projectile_secondary(_position, _direction):
	get_parent().get_node('AudioController').create_sound('fire', self.position.x, self.position.y)
	var proj = $SplashBoat.projectile_secondary.instance()
	proj.p_owner = 'SplashPlayer'
	add_child(proj)
	proj.start(_position, _direction)

func _on_RigidBody2D_death_sound(p1, p2):
	
	get_node('..').get_node('AudioController').create_sound('death', p1, p2)



func _on_MuzzleAnimation_animation_finished():
	pass # Replace with function body.
