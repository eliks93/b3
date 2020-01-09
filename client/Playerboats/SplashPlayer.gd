extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func ready():
	$SplashBoat.position = Vector2(200.0, 200.0)
	$SplashBoat/Turret.connect('spawn_projectile', self, '_spawn_projectile')

func _spawn_projectile(projectile_type, _position, _direction):
	get_parent().get_node('AudioController').create_sound('fire', self.position.x, self.position.y)

	var proj = $SplashBoat.projectile.instance()
	
	proj.p_owner = "SplashPlayer"
	add_child(proj)
	proj.start(_position, _direction)
	

func _on_RigidBody2D_death_sound(p1, p2):
	print('singal received')
	get_node('..').get_node('AudioController').create_sound('death', p1, p2)

