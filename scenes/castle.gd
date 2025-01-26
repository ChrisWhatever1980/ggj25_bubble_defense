extends Node3D


var health : int = 20


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		health -= 1
		area.get_parent().queue_free()
		
		if health <= 0:
			# player looses
			GameEvents.game_over.emit()
