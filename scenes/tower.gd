extends Node3D


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var firing_timer: Timer = $FiringTimer
@onready var pause_timer: Timer = $PauseTimer
@onready var projectile_emitter: Node3D = $ProjectileEmitter


var touching_water = true
var firing = false
var target = null
var reload_duration = 0.6
var reload_time = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not touching_water:
		position.y += -1.0 * 0.2 * delta
		

	if touching_water:
		if not target:
			firing_timer.stop()
			target = acquire_new_target()

		if target:
			var target_pos = target.global_position
			target_pos.y = self.global_position.y
			look_at(target_pos)
			fire()

		if reload_time > 0.0:
			reload_time -= delta

		if target and firing and reload_time <= 0.0:
			# todo: create bubble projectiles
			var new_projectile = preload("res://scenes/bubble_projectile.tscn").instantiate()
			new_projectile.position = projectile_emitter.global_position
			new_projectile.velocity = (target.global_position - self.global_position).normalized()
			get_parent().add_child(new_projectile)
			reload_time = reload_duration


func acquire_new_target():
	# get closest enemy
	var enemies = get_tree().get_nodes_in_group("Enemies")
	var min_dist = 1000.0
	var selected_enemy = null
	for enemy in enemies:
		var dist = enemy.global_position.distance_to(self.global_position)
		if dist < 1.0:
			if dist < min_dist:
				selected_enemy = enemy
				min_dist = dist

	return selected_enemy


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Water"):
		touching_water = true


func fire():
	animation_tree.set("parameters/ActivateRotation/scale", 1.0)
	firing_timer.start()
	firing = true


func _on_firing_timer_timeout() -> void:
	#animation_tree.set("parameters/ActivateRotation/scale", 0.0)
	pause_timer.start()
	firing = false


func _on_pause_timer_timeout() -> void:
	if target:
		fire()
