extends PathFollow3D


@export var run_duration : float = 25.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta / run_duration


func _on_timer_timeout() -> void:
	var new_enemy = preload("res://scenes/enemy.tscn").instantiate()
	new_enemy
