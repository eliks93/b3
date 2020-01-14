extends Area2D

export var life = 10.0

var p_owner

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(_position, _direction):
	$Lifetime.wait_time = life
	$Lifetime.start()

func _process(delta):
	if get_parent().has_node("PlayerBoat"):
		position.x = get_parent().get_node("PlayerBoat").position.x
		position.y = get_parent().get_node("PlayerBoat").position.y
	
	if get_parent().has_node("NPCBoat"):
		position.x = get_parent().get_node("NPCBoat").position.x
		position.y = get_parent().get_node("NPCBoat").position.y

func _on_Lifetime_timeout():
	queue_free()

func _on_Projectile_area_entered(area):
	if (area.get("p_owner") && area.p_owner != p_owner) and area.has_method("start"):
		area.velocity.x = -area.velocity.x
		area.velocity.y = -area.velocity.y
		area.p_owner = p_owner
	if area.get_parent().has_node("EBall"):
		area.get_parent().explode()