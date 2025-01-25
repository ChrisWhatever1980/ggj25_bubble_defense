extends PathFollow3D


@export var run_duration : float = 25.0


var health = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta / run_duration


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Projectiles"):
		print("contact")
		health -= 1
		area.get_parent().queue_free()
		if health <= 0:
			queue_free()
