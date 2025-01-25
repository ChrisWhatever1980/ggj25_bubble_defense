extends Node3D

@onready var soap_bubble: Node3D = $SoapBubble
@onready var catapult_rotate: Node3D = $CatapultRotate


@export var speed = 0.2


var direction = Vector3(-1.0, 0.0, 0.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		position += direction * speed * delta

		catapult_rotate.rotate_x(delta)
		catapult_rotate.rotate_z(delta)


func pop():
	soap_bubble.pop()

	var new_catapult = preload("res://scenes/catapult.tscn").instantiate()
	new_catapult.position = self.position
	new_catapult.touching_water = false
	get_parent().add_child(new_catapult)

	catapult_rotate.visible = false

	await get_tree().create_timer(1.0).timeout

	queue_free()
