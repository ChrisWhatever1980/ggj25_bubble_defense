extends Control

@onready var selected = false
@onready var bubble = $Panel/TextureButton
@onready var old_modulate = bubble.modulate

func _process(delta: float) -> void:
	if (selected):
		bubble.modulate = Color(1, 1, 1, 1)
	else:
		bubble.modulate = old_modulate
