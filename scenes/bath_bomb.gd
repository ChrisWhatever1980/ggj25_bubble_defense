extends Node3D


var touching_water = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not touching_water:
		position.y += -1.0 * 0.2 * delta


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Water"):
		explode()


func explode() -> void:
	touching_water = true
	# spawn particle system
	var new_bath_bomb_bubbles = preload("res://scenes/bath_bomb_bubbles.tscn").instantiate()
	new_bath_bomb_bubbles.position = self.position
	get_parent().add_child(new_bath_bomb_bubbles)

	GameEvents.change_water_color.emit()

	queue_free()
