extends Node3D


func _process(delta: float) -> void:
	$Fish.rotation.y += delta * 0.7
	$Fish.speed = 0
