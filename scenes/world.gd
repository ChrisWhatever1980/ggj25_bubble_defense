extends Node3D


@onready var camera_3d: Camera3D = $Camera/Camera3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_tower_bubble"):
		var new_tower_bubble = preload("res://scenes/tower_bubble.tscn").instantiate()
		new_tower_bubble.position = camera_3d.global_position
		new_tower_bubble.position.y -= 0.1

		new_tower_bubble.direction = -camera_3d.global_basis.z

		add_child(new_tower_bubble)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
