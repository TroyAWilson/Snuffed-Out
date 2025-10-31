extends Area2D

#I need to make some kind of alterations so that this works with player when colliding with enemies
var persistentDamage := false

func _ready() -> void:
	print('hurt box ready')

func _on_body_entered(body: Node2D) -> void:
	print('body entered')
	executeDamage()
	#if(get_parent().has_method('take_damage')):
		#get_parent().take_damage(5)
	persistentDamage = true
	$Timer.start()

func _on_body_exited(body: Node2D) -> void:
	executeDamage()
	$Timer.start()

func _on_timer_timeout() -> void:
	persistentDamage = false

func executeDamage() -> void:
	if(get_parent().has_method('take_damage')):
		get_parent().take_damage(5)
