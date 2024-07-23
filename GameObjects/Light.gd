extends Node2D

var interactable = false

func _input(event):
	if event.is_action_pressed("interact") and interactable:
		$PointLight2D.enabled = !$PointLight2D.enabled


func _on_light_switch_area_entered(area):
	if area.is_in_group("PlayerHitbox"):
		interactable = true

func _on_light_switch_area_exited(area):
	if area.is_in_group("PlayerHitbox"):
		interactable = false