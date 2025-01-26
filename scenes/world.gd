extends Node3D


@onready var camera_3d: Camera3D = $Camera/Camera3D
@onready var stream: Node3D = $bathroom/Stream
@onready var animation_player: AnimationPlayer = $bathroom/body/AnimationPlayer
@onready var turrets: Dictionary = {
	Globals.TurretType.WindMill: preload("res://scenes/tower_bubble.tscn"),
	Globals.TurretType.Catapult: preload("res://scenes/catapult_bubble.tscn")
}
@onready var selected_turret: int = Globals.TurretType.WindMill
@onready var wiggle_timer: Timer = $bathroom/body/WiggleTimer


func _ready() -> void:
	stream.visible = false
	GameEvents.select_level.connect(select_level)
	GameEvents.select_turret.connect(select_turret)


func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("wiggle_toes"):
		animation_player.play("LegWipping")

	if Input.is_action_just_pressed("spawn_tower_bubble"):
		var new_tower_bubble = turrets[selected_turret].instantiate()
		new_tower_bubble.position = camera_3d.global_position
		new_tower_bubble.position.y -= 0.1

		new_tower_bubble.direction = -camera_3d.global_basis.z

		add_child(new_tower_bubble)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func select_level(level_id: int) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_3d.current = true
	$LevelWrapper.get_node('Level').new_wave(0)
	stream.visible = true
	GameEvents.show_game_ui.emit()


func select_turret(turret_id: int) -> void:
	selected_turret = turret_id	


func _on_wiggle_timer_timeout() -> void:
	animation_player.play("LegWipping")
	wiggle_timer.wait_time = randf_range(10.0, 20.0)
