extends Node3D


@onready var camera_3d: Camera3D = $Camera/Camera3D
@onready var stream: Node3D = $bathroom/Stream
@onready var animation_player: AnimationPlayer = $bathroom/body/AnimationPlayer
@onready var turrets: Dictionary = {
	Globals.TurretType.WindMill: preload("res://scenes/tower_bubble.tscn"),
	Globals.TurretType.Catapult: preload("res://scenes/catapult_bubble.tscn"),
	Globals.TurretType.Bomb: preload("res://scenes/bath_bomb_bubble.tscn")
}
@onready var selected_turret: int = Globals.TurretType.WindMill
@onready var wiggle_timer: Timer = $bathroom/body/WiggleTimer
@onready var menu_camera: Camera3D = $MenuCamera


func _ready() -> void:
	stream.visible = false
	GameEvents.select_level.connect(select_level)
	GameEvents.select_turret.connect(select_turret)
	GameEvents.spawn_tower.connect(spawn_tower)
	GameEvents.level_completed.connect(return_to_menu.bind(true))
	GameEvents.game_over.connect(return_to_menu.bind(false))


func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("wiggle_toes"):
		animation_player.play("LegWipping")

	if Input.is_action_just_pressed("spawn_tower_bubble"):
		spawn_bath_bomb()

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func spawn_bath_bomb():
	var new_bomb = turrets[Globals.TurretType.Bomb].instantiate()
	new_bomb.position = camera_3d.global_position
	new_bomb.position.y -= 0.1

	new_bomb.direction = -camera_3d.global_basis.z

	add_child(new_bomb)


func spawn_tower():
	var new_tower_bubble = turrets[selected_turret].instantiate()
	new_tower_bubble.position = camera_3d.global_position
	new_tower_bubble.position.y -= 0.1

	new_tower_bubble.direction = -camera_3d.global_basis.z

	add_child(new_tower_bubble)


func select_level(level_id: int) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_3d.current = true
	$LevelWrapper.get_node('Level').new_wave(0)
	stream.visible = true
	GameEvents.show_game_ui.emit()
	
	if level_id == 0:
		# new game
		GameEvents.show_message.emit("Defend your bubble bath from an invasion!", 5.0)
		await get_tree().create_timer(5.0).timeout
		GameEvents.show_message.emit("Right click to let a tower bubble fly.", 3.0)
		await get_tree().create_timer(3.5).timeout
		GameEvents.show_message.emit("Left click the bubble to make it pop where you want the tower.", 4.0)


func return_to_menu(completed_level_idx, win):
	if win:
		GameEvents.show_message.emit("You defended your bubble bath. Now relax!", 5.0)
	else:
		GameEvents.show_message.emit("Your bubble bath was ruined. Ruined! Muhaha!", 5.0)

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	menu_camera.current = true
	stream.visible = false
	GameEvents.show_main_menu.emit()


func select_turret(turret_id: int) -> void:
	selected_turret = turret_id


func _on_wiggle_timer_timeout() -> void:
	animation_player.play("LegWipping")
	wiggle_timer.wait_time = randf_range(10.0, 20.0)


func _on_jazz_music_finished() -> void:
	pass # Replace with function body.
