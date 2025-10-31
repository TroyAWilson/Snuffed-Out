class_name Enemy extends CharacterBody2D

var counter := 0

func _ready():
	print('ready, I am an enemy')
	
func inc_counter():
	counter += 1
	print("Counter Value: " + str(counter))
	
func _process(delta: float) -> void:
	inc_counter()
