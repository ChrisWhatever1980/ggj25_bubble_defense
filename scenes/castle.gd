extends Node3D

@onready var castle: Node3D = $castle

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

		GameEvents.enemy_finished.emit()

		area.get_parent().queue_free()

		castle.position.y = lerpf(-3.0, 0.0, health / 20.0)

		if health <= 0:
			# player looses
			GameEvents.game_over.emit()
