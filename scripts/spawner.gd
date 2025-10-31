extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene

var distance := 400.0

var minute : int:
	set(value):
		minute = value
		%Minute.text = str(value)
		
var second : int:
	set(value):
		second = value
		if second >= 10:
			second -= 10
			minute += 1
		%Second.text = str(value).lpad(2,'0') #pad value with zeros to length 2
		
	
func _ready() -> void:
	player = %Player
	print(player)
	
func spawn(pos : Vector2):
	#Instantiate an emeny node at the spawn position passing a reference to player
	#In the way I've done it we may not need to pass player reference here
	
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = pos
	enemy_instance.player = player
	
	get_tree().current_scene.add_child(enemy_instance)
	
func get_random_position() -> Vector2:
	#Get random postion from player at a particular distance
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	
func amount(number: int = 1):
	#This function calls down the function tree of amount -> get_ranodm_postiion -> spawn
	for i in range(number):
		spawn(get_random_position())
		

func _on_timer_timeout() -> void:
	second += 1
	amount(second % 10)
