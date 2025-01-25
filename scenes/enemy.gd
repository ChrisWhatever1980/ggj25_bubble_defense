extends PathFollow3D


@export var run_duration : float = 25.0


var health = 10
var wave_idx = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	progress_ratio += delta / run_duration
	if progress_ratio >= 1.0:
		queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Projectiles"):
		health -= 1
		area.get_parent().queue_free()
		if health <= 0:
			GameEvents.enemy_destroyed.emit(wave_idx)

			# spawn fishes
			for f in range(0, 3):
				var  new_fish = null
				match randi_range(1, 3):
					1:
						new_fish = preload("res://scenes/fish1.tscn").instantiate()
					2:
						new_fish = preload("res://scenes/fish2.tscn").instantiate()
					3:
						new_fish = preload("res://scenes/fish3.tscn").instantiate()
				new_fish.position = self.global_position
				get_parent().get_parent().add_child(new_fish)

			queue_free()
