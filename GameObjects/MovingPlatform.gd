extends Node2D

var duration: float = 5.0
var speed: float = 32.0
var original_pos: Vector2

func _ready():
	original_pos = $AnimatableBody2D.global_position
	
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "global_position", $Marker2D.global_position, $AnimatableBody2D.global_position.distance_to($Marker2D.global_position) / speed)
	tween.tween_property($AnimatableBody2D, "global_position", original_pos, $AnimatableBody2D.global_position.distance_to($Marker2D.global_position) / speed)


