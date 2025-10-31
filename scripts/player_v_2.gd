extends CharacterBody2D

var exp := 0.0
var speed := 100.0
@export var projectile_scene : PackedScene
@export var gameover_scene : PackedScene
@export var healthBar : ProgressBar
@export var expBar : ProgressBar
var enemy : CharacterBody2D
var health := 100
var playerLevel := 1

func _ready() ->void:
	healthBar.value = health
	expBar.value = exp

func _physics_process(delta: float) -> void:
	if(exp >= expBar.max_value):
		handleLevelUp()
	else:
		expBar.value = exp
	velocity = Input.get_vector("left", "right", "up", "down")
	move_and_collide(velocity * delta * 300)

func handleLevelUp() -> void:
	print("Level Up!")
	exp = 0
	playerLevel += 1
	expBar.max_value = expBar.max_value * 1.1 #scale up xp per level

func _shoot_projectile() -> void:
	enemy = _find_closest_enemy()
	if (enemy == null): #if no enemies skip shoot
		return
	
	#This probably could have also been solved with messing with the collision layers
	
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	# Calculate direction to the enemy
	var direction = (enemy.global_position - global_position).normalized()

	# Calculate offset position
	var offset_position = global_position + direction
	projectile.global_position = offset_position
	projectile.set_direction(enemy.global_position)

		
func _find_closest_enemy() -> Node2D:
	var closest_enemy = null
	var shortest_distance := INF
	var max_distance = 300.0
	
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
	healthBar.value = health
	print("Player health: " + str(health))
	#set gameover state
	if(health <= 0):
		print('Player has died')
		var audio = $"../AudioStreamPlayer"
		audio.stream_paused = true #stop audio

		get_tree().paused = true #pause game
		#TODO: display gameover UI
		spawnGameOverScreen()
		
func spawnGameOverScreen() -> void:
	var gameOver = gameover_scene.instantiate()
	get_parent().add_child(gameOver)
