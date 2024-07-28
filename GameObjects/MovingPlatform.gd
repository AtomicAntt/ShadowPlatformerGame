extends Node2D

var offset: Vector2 = Vector2(-64, 0)
var duration: float = 5.0
var speed: float = 32.0

func _ready():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", $Marker2D.position, position.distance_to($Marker2D.position) / speed)
	tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, position.distance_to(Vector2.ZERO) / speed)


