extends Node3D


@onready var paths = [$Path3D]
@onready var spawn_enemy_timer: Timer = $SpawnEnemyTimer


var current_wave_idx : int = 0
var current_wave_amount : int = 5
var current_wave_enemy : Globals.EnemyType = Globals.EnemyType.SimpleBoat
var enemies_left : int = 0


@export var waves = [
	{
		"EnemyType": Globals.EnemyType.SimpleBoat,
		"EnemyCount": 5
	},
	{
		"EnemyType": Globals.EnemyType.SimpleBoat,
		"EnemyCount": 2
	}
]


func _ready() -> void:
	GameEvents.enemy_destroyed.connect(on_enemy_destroyed)
	new_wave(0)


func new_wave(idx):
	current_wave_idx = idx
	current_wave_amount = waves[current_wave_idx].EnemyCount

	enemies_left = current_wave_amount

	current_wave_enemy = waves[current_wave_idx].EnemyType
	spawn_enemy_timer.start()
	print("Wave" + str(current_wave_idx) + " started: " + str(current_wave_amount) + " / " + str(waves[current_wave_idx].EnemyCount))


func on_enemy_destroyed(wave_idx):
	enemies_left -= 1

	GameEvents.wave_info_update.emit(current_wave_idx, enemies_left, waves[current_wave_idx].EnemyCount)
	#print("Wave Update: Wave " + str(current_wave_idx) + ": " + str(enemies_left) + " / " + str(waves[current_wave_idx].EnemyCount))

	if enemies_left <= 0:
		#print("Wave defeated")
		GameEvents.wave_defeated.emit(current_wave_idx)
		if current_wave_idx + 1 == waves.size():
			# all waves defeated, level completed
			#print("Level completed")
			GameEvents.level_completed.emit()
		else:
			new_wave(current_wave_idx + 1)


func _on_timer_timeout() -> void:
	if current_wave_amount > 0:
		var new_enemy = preload("res://scenes/enemy.tscn").instantiate()
		paths.pick_random().add_child(new_enemy)
		current_wave_amount -= 1
		if current_wave_amount <= 0:
			spawn_enemy_timer.stop()
