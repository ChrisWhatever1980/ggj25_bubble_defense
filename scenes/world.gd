extends Node3D

@onready var camera_3d: Camera3D = $Camera3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_tower_bubble"):
		var new_tower_bubble = preload("res://scenes/tower_bubble.tscn").instantiate()
		new_tower_bubble.position = camera_3d.position
		add_child(new_tower_bubble)
