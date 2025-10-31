extends CanvasLayer

func _ready():
	print("CanvasLayer visible:", visible)
	for child in get_children():
		if child is CanvasItem:
			print(child.name, "visible:", child.visible)
