extends Node3D

@onready var right_animation_player: AnimationPlayer = $body/AnimationPlayer
@onready var left_animation_player: AnimationPlayer = $body2/AnimationPlayer
@onready var catapult_animation_player: AnimationPlayer = $Catapult/catapult/AnimationPlayer
@onready var squid_animation_player: AnimationPlayer = $squid/AnimationPlayer
@onready var tower_animation_tree: AnimationTree = $Tower/AnimationTree
@onready var wiggle_timer: Timer = $WiggleTimer
@onready var wiggle_timer_2: Timer = $WiggleTimer2

var players = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#trigger all animations
	right_animation_player.play("LegWipping")
	left_animation_player.play("LegWipping")
	catapult_animation_player.play("CatapultRotate")
	squid_animation_player.play("SquidArmsFlailing")
	tower_animation_tree.set("parameters/ActivateRotation/scale", 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wiggle_timer_timeout() -> void:
	right_animation_player.play("LegWipping")
	wiggle_timer.wait_time = randf_range(0.8, 1.5)


func _on_wiggle_timer_2_timeout() -> void:
	left_animation_player.play("LegWipping")
	wiggle_timer_2.wait_time = randf_range(0.8, 1.5)
