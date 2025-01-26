extends Node3D

@onready var soap_bubble: Node3D = $SoapBubble

@export var speed = 0.2
@onready var bath_bomb: Node3D = $BathBomb


var direction = Vector3(-1.0, 0.0, 0.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		position += direction * speed * delta


func pop():
	soap_bubble.pop()

	var new_bomb = preload("res://scenes/bath_bomb.tscn").instantiate()
	new_bomb.position = self.position
	new_bomb.touching_water = false
	get_parent().add_child(new_bomb)

	bath_bomb.visible = false

	await get_tree().create_timer(1.0).timeout

	queue_free()
