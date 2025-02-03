extends Node3D


func _on_timer_timeout() -> void:
	var new_bubble = preload("res://scenes/soap_bubble.tscn").instantiate()
	var extend = 0.5
	new_bubble.position = extend * Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
	new_bubble.scale = Vector3.ONE * 0.1
	add_child(new_bubble)
