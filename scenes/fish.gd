extends Node3D


@onready var fish: Node3D = $fish


var direction = Vector3.UP
var speed = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Vector3.UP + Vector3(randf_range(-1, 1), 0.0, randf_range(-1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position += direction * speed * delta

	fish.rotate_x(delta)
	fish.rotate_z(delta)
