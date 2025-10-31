extends Area2D

var speed := 400.0
var direction: Vector2

func _process(delta: float) -> void:
	position += direction * speed * delta

func set_direction(target_position: Vector2)-> void:
	direction = (target_position - global_position).normalized()

func _on_body_entered(body: Node2D) -> void:
	if(body.has_method('take_damage')):
		body.take_damage(5)	
	queue_free() #remove bullet on first collision
