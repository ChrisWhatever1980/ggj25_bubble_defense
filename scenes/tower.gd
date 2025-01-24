extends Node3D


var touching_water = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not touching_water:
		position.y += -1.0 * 0.2 * delta


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Water"):
		touching_water = true
