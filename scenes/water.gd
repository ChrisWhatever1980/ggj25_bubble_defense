extends Node3D

@onready var water: MeshInstance3D = $water/Water

func _ready() -> void:
	GameEvents.change_water_color.connect(on_change_water_color)


func on_change_water_color():
	var colors = [
		Color.GREEN,
		Color.RED,
		Color.PURPLE,
		Color.YELLOW
	]
	water.get_active_material(0).set_shader_parameter("ColorParameter", colors.pick_random())
