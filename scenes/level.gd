extends Node3D

@onready var path_3d: Path3D = $Path3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_enemy = preload("res://scenes/enemy.tscn").instantiate()
	path_3d.add_child(new_enemy)
