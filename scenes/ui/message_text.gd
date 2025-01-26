extends Label


func _ready() -> void:
	GameEvents.select_level.connect(set_label_size)


func set_label_size(level_id: int) -> void:
	await get_tree().create_timer(0.2).timeout
	custom_minimum_size = Vector2(get_parent().size.x, 0)
