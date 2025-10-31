extends PointLight2D

var base_energy := 1.0

func _process(delta: float) -> void:
	energy = base_energy + randf_range(-0.1, 0.1)
