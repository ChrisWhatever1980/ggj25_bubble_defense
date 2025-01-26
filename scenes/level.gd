extends Node3D


@onready var spawn_enemy_timer: Timer = $SpawnEnemyTimer


@export var level_idx : int = -1


var paths = []
var current_wave_idx : int = 0
var current_wave_amount : int = 5
var current_wave_enemy : Globals.EnemyType = Globals.EnemyType.SimpleBoat
var enemies_left : int = 0
var first_enemy_destroyed = false


@export var waves = [
	{
		"EnemyType": Globals.EnemyType.RubberDuck,
		"EnemyCount": 5
	},
	{
		"EnemyType": Globals.EnemyType.SimpleBoat,
		"EnemyCount": 2
	}
]


func _ready() -> void:
	GameEvents.enemy_destroyed.connect(on_enemy_destroyed)

	for c in get_children():
		if c is Path3D:
			paths.append(c)


func new_wave(idx):
	current_wave_idx = idx
	current_wave_amount = waves[current_wave_idx].EnemyCount

	enemies_left = current_wave_amount

	current_wave_enemy = waves[current_wave_idx].EnemyType
	spawn_enemy_timer.start()
	print("Wave" + str(current_wave_idx) + " started: " + str(current_wave_amount) + " / " + str(waves[current_wave_idx].EnemyCount))


func on_enemy_destroyed(_wave_idx):
	if not first_enemy_destroyed:
		first_enemy_destroyed = true
		GameEvents.show_message.emit("Quick! Click the fishes before they fly away!", 4.0)
		await get_tree().create_timer(4.0).timeout
		GameEvents.show_message.emit("Spend fishes to build more towers!", 3.0)

	enemies_left -= 1

	GameEvents.wave_info_update.emit(current_wave_idx, enemies_left, waves[current_wave_idx].EnemyCount)
	#print("Wave Update: Wave " + str(current_wave_idx) + ": " + str(enemies_left) + " / " + str(waves[current_wave_idx].EnemyCount))

	if enemies_left <= 0:
		#print("Wave defeated")
		GameEvents.wave_defeated.emit(current_wave_idx)
		if current_wave_idx + 1 == waves.size():
			# all waves defeated, level completed
			#print("Level completed")
			GameEvents.level_completed.emit(level_idx)
		else:
			new_wave(current_wave_idx + 1)


func _on_timer_timeout() -> void:
	if current_wave_amount > 0:
		var new_enemy = null
		match current_wave_enemy:
			Globals.EnemyType.SimpleBoat:
				new_enemy = preload("res://scenes/enemy.tscn").instantiate()
			Globals.EnemyType.RubberDuck:
				new_enemy = preload("res://scenes/enemy_2.tscn").instantiate()
			Globals.EnemyType.Squid:
				new_enemy = preload("res://scenes/enemy_3.tscn").instantiate()
			Globals.EnemyType.Turd:
				new_enemy = preload("res://scenes/enemy_4.tscn").instantiate()

		paths.pick_random().add_child(new_enemy)
		current_wave_amount -= 1
		if current_wave_amount <= 0:
			spawn_enemy_timer.stop()
