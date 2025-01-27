extends Node3D


@onready var fish: Node3D = $fish
@onready var soap_bubble: Node3D = $SoapBubble
@onready var area_3d: Area3D = $Area3D


var direction = Vector3.UP
var speed = 0.25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Vector3.UP + Vector3(randf_range(-1, 1), 0.0, randf_range(-1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position += direction * speed * delta

	fish.rotate_x(delta)
	fish.rotate_z(delta)


func pop():
	soap_bubble.pop()

	area_3d.monitorable = false
	area_3d.monitoring = false

	GameEvents.fish_collected.emit()

	fish.visible = false

	await get_tree().create_timer(1.0).timeout

	queue_free()
