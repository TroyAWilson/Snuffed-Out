extends Node2D

@export var enemy : PackedScene

#TODO:
# - create player health UI
# - create gameover screen
# - think about how the light mechanic will work
# - Parallax being weird and exists over the darkness layer
# - I thinkthe enemy spawn on takes into account the initial screen poitions

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)

func spawnEnemy() -> void:
	var enemy_instance = enemy.instantiate()
	var screenSize = get_viewport_rect().size
	print(screenSize) 
	#The spawner is only getting the size of the screen
	#however what I really need is position relative to player based on screen size
	var randomX = randf_range(-screenSize.x, screenSize.x)
	var randomY = randf_range(-screenSize.y, screenSize.y)
	
	enemy_instance.position = Vector2(randomX, randomY)
	add_child(enemy_instance)
	
func _on_enemy_spawn_timeout() -> void:
	spawnEnemy()
