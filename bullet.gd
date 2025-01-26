extends Area2D

var direction
var travelled_distance = 0
var body_entered_counter = 3
const SPEED = 2000
const RANGE = 1200

func _physics_process(delta: float) -> void:
	direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body_entered_counter > 0:
		body_entered_counter -= 1
	else:
		queue_free()
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
