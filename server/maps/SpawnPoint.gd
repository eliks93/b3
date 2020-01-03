extends Area2D

var available = true
var bodies_in_area = 0

func _process(delta):
	if bodies_in_area == 0:
		available = true
	else:
		available = false

func _on_SpawnPoint_body_entered(body):
	if body.has_method("take_damage"):
		bodies_in_area += 1


func _on_SpawnPoint_body_exited(body):
	if body.has_method("take_damage"):
		bodies_in_area -= 1
