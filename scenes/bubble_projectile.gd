extends Node3D


@onready var soap_bubble: Node3D = $SoapBubble


var velocity = Vector3.ZERO
var speed = 2.5
var damage = 0.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta * speed
