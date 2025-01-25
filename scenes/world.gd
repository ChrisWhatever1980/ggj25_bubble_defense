extends Node3D


@onready var camera_3d: Camera3D = $Camera/Camera3D
@onready var main_ui: Control = $Main
@onready var level: Node3D = $Level
@onready var settings: Control = $Settings
@onready var stream: Node3D = $bathroom/Stream
@onready var cross_hair: CenterContainer = $CrossHair
@onready var animation_player: AnimationPlayer = $bathroom/body/AnimationPlayer


func _ready() -> void:
	stream.visible = false
	cross_hair.visible = false


func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("wiggle_toes"):
		animation_player.play("LegWipping")

	if Input.is_action_just_pressed("start_game"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		main_ui.visible = false
		camera_3d.current = true
		level.new_wave(0)
		stream.visible = true
		cross_hair.visible = true

	if Input.is_action_just_pressed("show_settings"):
		if main_ui.visible:
			main_ui.visible = false
			settings.visible = true
		else:
			main_ui.visible = true
			settings.visible = false

	if Input.is_action_just_pressed("spawn_tower_bubble"):
		var new_tower_bubble = preload("res://scenes/catapult_bubble.tscn").instantiate()
		new_tower_bubble.position = camera_3d.global_position
		new_tower_bubble.position.y -= 0.1

		new_tower_bubble.direction = -camera_3d.global_basis.z

		add_child(new_tower_bubble)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
