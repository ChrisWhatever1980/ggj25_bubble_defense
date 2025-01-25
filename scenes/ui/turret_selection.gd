extends Control

@onready var container : VBoxContainer = $VBoxContainer
@export_range(0, 10, 1.0) var initial_turret: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0;
	for turret_option in container.get_children():
		if (i == initial_turret):
			turret_option.selected = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
