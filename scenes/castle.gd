extends Node3D

@onready var castle: Node3D = $castle

var health : int = 10
var total_health = 10


func reset_health():
	health = total_health
	castle.position.y = 0.0


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		health -= 1

		GameEvents.enemy_finished.emit()

		area.get_parent().queue_free()

		castle.position.y = lerpf(-3.0, 0.0, health / float(total_health))

		if health <= 0:
			# player looses
			GameEvents.game_over.emit()
