extends PathFollow3D


@export var sound: AudioStreamPlayer3D = null
@export var run_duration : float = 25.0
@export var health : int = 10
var wave_idx = 0


@onready var sound_timer: Timer = $Timer


func _ready() -> void:
	sound_timer.wait_time = randf_range(3.0, 5.0)


func _process(delta: float) -> void:
	progress_ratio += delta / run_duration
	if progress_ratio >= 1.0:
		queue_free()


func take_damage():
	health -= 1
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
			get_parent().get_parent().get_parent().add_child(new_fish)

		queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Projectiles"):
		area.get_parent().queue_free()
		take_damage()


func _on_timer_timeout() -> void:
	if sound:
		sound.play()
		sound_timer.wait_time = randf_range(3.0, 5.0)
	
