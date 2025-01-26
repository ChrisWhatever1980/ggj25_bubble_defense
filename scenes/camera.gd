extends Node3D


const ray_length = 10000


@onready var camera: Camera3D = $Camera3D
@onready var music_player: Node = $"../MusicPlayer"
@onready var coffee_table: Node3D = $"../bathroom/CoffeeTable"


var mouse_sensitivity = 0.001
var ray_query_params
var targeted_object = null


func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ray_query_params = PhysicsRayQueryParameters3D.create(position, position + Vector3(0, -10, 0))


func _physics_process(_delta):
	var from = camera.project_ray_origin(get_viewport().size / 2)
	var to = from + camera.project_ray_normal(get_viewport().size / 2) * ray_length
	var space_state = get_world_3d().direct_space_state

	# intersect with star
	ray_query_params.from = from
	ray_query_params.to = to
	ray_query_params.exclude = [self]
	ray_query_params.collide_with_areas = true
	ray_query_params.collide_with_bodies = false
	ray_query_params.collision_mask = 0b00000000000000000001

	var object_result = space_state.intersect_ray(ray_query_params)
	if object_result:
		var target_name = object_result.collider.get_parent().name
		#print("Hit: " + target_name)
		if target_name == "water_model":
			targeted_object = null
		else:
			targeted_object = object_result.collider.get_parent()
	else:
		targeted_object = null


func _input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_instance_valid(targeted_object):
				if targeted_object.is_in_group("TowerBubbles"):
					targeted_object.pop()
					targeted_object = null
				elif targeted_object.is_in_group("Fishes"):
					targeted_object.pop()
					targeted_object = null
				elif targeted_object.is_in_group("MusicPlayer"):
					music_player.next_song()
				elif targeted_object.is_in_group("Candles"):
					coffee_table.toggle_candles()

		if event.button_index == MOUSE_BUTTON_RIGHT:
			GameEvents.spawn_tower.emit()

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
