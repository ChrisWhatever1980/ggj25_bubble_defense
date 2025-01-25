extends Control

@onready var selected = false
@onready var bubble = $Panel/TextureButton
@onready var old_self_modulate = bubble.self_modulate

func _process(delta: float) -> void:
	if (selected):
		bubble.self_modulate = bubble.self_modulate.lightened(1)
	else:
		bubble.self_modulate = old_self_modulate
