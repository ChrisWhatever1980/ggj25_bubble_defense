extends Node3D


func _on_timer_timeout() -> void:
	var new_bubble = preload("res://scenes/soap_bubble.tscn").instantiate()
	new_bubble.position = Vector3(randf_range(-5.0, 5.0), -5.0, randf_range(-5.0, 5.0))
	add_child(new_bubble)
