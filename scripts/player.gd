extends CharacterBody2D

var exp := 0.0
var speed := 150.0
@export var projectile_scene : PackedScene
var enemy : CharacterBody2D
var health := 100.0

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down")
	move_and_collide(velocity * delta * 500)

func _shoot_projectile() -> void:
	enemy = _find_closest_enemy()
	if (enemy == null): #if no enemies skip shoot
		return
	
	#This probably could have also been solved with messing with the collision layers
	
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	# Calculate direction to the enemy
	var direction = (enemy.global_position - global_position).normalized()
	# Offset distance (adjust as needed)
	var offset_distance = 100.0
	# Calculate offset position
	var offset_position = global_position + direction * offset_distance
	projectile.global_position = offset_position
	projectile.set_direction(enemy.global_position)

		
func _find_closest_enemy() -> Node2D:
	var closest_enemy = null
	var shortest_distance := INF
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var distance = global_position.distance_to(enemy.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			closest_enemy = enemy

	return closest_enemy

func _on_timer_timeout() -> void:
	_shoot_projectile()
	
func take_damage(dmg:int) -> void:
	health -= dmg
	print('player health: ' + str(health)) 
