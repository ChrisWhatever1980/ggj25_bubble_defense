extends Node3D


func _process(delta: float) -> void:
	$Tower.rotation.y += delta * 0.7
