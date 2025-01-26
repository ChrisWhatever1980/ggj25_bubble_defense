extends GPUParticles3D


var enemies_in_range = []


func stop_emitting():
	emitting = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		enemies_in_range.append(area.get_parent())


func _on_area_3d_area_exited(area: Area3D) -> void:
	if enemies_in_range.has(area.get_parent()):
		enemies_in_range.erase(area.get_parent())


func _on_timer_timeout() -> void:
	for e in enemies_in_range:
		print(e.name + " takes damage")
		e.take_damage()
