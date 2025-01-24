extends Node3D

@onready var soap_bubble: Node3D = $SoapBubble


@export var speed = 0.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		position.x += -1.0 * speed * delta


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		# bubble is popped, drop tower
		soap_bubble.visible = false

		var new_tower = preload("res://scenes/tower.tscn").instantiate()
		new_tower.position = self.position
		get_parent().add_child(new_tower)

		queue_free()
