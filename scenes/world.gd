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
@onready var tutorial_enabled: bool = true
@onready var level_wrapper: Node3D = $LevelWrapper
@onready var castle: Node3D = $bathroom/Castle


func _ready() -> void:
	stream.visible = false
	GameEvents.select_level.connect(select_level)
	GameEvents.select_turret.connect(select_turret)
	GameEvents.spawn_tower.connect(spawn_tower)
	GameEvents.level_completed.connect(return_to_menu)
	GameEvents.game_over.connect(return_to_menu)
	GameEvents.toggle_tutorial.connect(toggle_tutorial)
	GameEvents.toggle_particle_effects.connect(toggle_particles)


func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("wiggle_toes"):
		animation_player.play("LegWipping")

	if Input.is_action_just_pressed("spawn_tower_bubble"):
		spawn_tower()

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_pressed("ui_right"):
		Engine.time_scale = 3.0
	else:
		Engine.time_scale = 1.0


func spawn_tower():
	var new_tower_bubble = turrets[selected_turret].instantiate()
	new_tower_bubble.position = camera_3d.global_position
	new_tower_bubble.position.y -= 0.1

	new_tower_bubble.direction = -camera_3d.global_basis.z

	add_child(new_tower_bubble)


func select_level(level_id: int) -> void:

	# reset play area
	
	# delete level
	if level_wrapper.get_child_count() > 0:
		level_wrapper.get_child(0).queue_free()

	# reset castle health
	castle.reset_health()

	# delete towers
	var towers = get_tree().get_nodes_in_group("IngameTowers")
	for t in towers:
		t.queue_free()

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_3d.current = true

	var load_level = null
	match level_id:
		0:
			load_level = preload("res://scenes/levels/level_1.tscn").instantiate()
		1:
			load_level = preload("res://scenes/levels/level_2.tscn").instantiate()
		2:
			load_level = preload("res://scenes/levels/level_3.tscn").instantiate()
		3:
			load_level = preload("res://scenes/levels/level_4.tscn").instantiate()

	level_wrapper.add_child(load_level)
	load_level.new_wave(0)

	stream.visible = true
	GameEvents.show_game_ui.emit()
	
	if level_id == 0 && tutorial_enabled:
		# new game
		GameEvents.show_message.emit(tr("DEFEND YOUR BUBBLE BATH FROM AN INVASION!"), 5.0)
		await get_tree().create_timer(5.0).timeout
		GameEvents.show_message.emit(tr("RIGHT CLICK TO LET A TOWER BUBBLE FLY."), 3.0)
		await get_tree().create_timer(3.5).timeout
		GameEvents.show_message.emit(tr("LEFT CLICK THE BUBBLE TO MAKE IT POP WHERE YOU WANT THE TOWER."), 4.0)


func return_to_menu(completed_level_idx, win):
	if win:
		GameEvents.show_message.emit(tr("YOU DEFENDED YOUR BUBBLE BATH. NOW RELAX!"), 5.0)
	else:
		GameEvents.show_message.emit(tr("YOUR BUBBLE BATH WAS RUINED. RUINED! MUHAHA!"), 5.0)

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	menu_camera.current = true
	stream.visible = false
	GameEvents.show_main_menu.emit()


func select_turret(turret_id: int) -> void:
	selected_turret = turret_id


func _on_wiggle_timer_timeout() -> void:
	animation_player.play("LegWipping")
	wiggle_timer.wait_time = randf_range(10.0, 20.0)


func toggle_tutorial(toggled_on: bool) -> void:
	tutorial_enabled = toggled_on


func toggle_particles(toggled_on: bool) -> void:
	stream.visible = toggled_on


func _on_jazz_music_finished() -> void:
	pass # Replace with function body.
