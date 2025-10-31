extends Area2D

@export var light : PointLight2D

func _on_area_entered(area: Area2D) -> void:
	light.visible = true
	
	$AnimatedSprite2D.animation = "burn"
