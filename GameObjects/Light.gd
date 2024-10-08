extends Node2D

var interactable = false

func _input(event):
	if event.is_action_pressed("interact") and interactable:
		$Sound.play()
		$PointLight2D.enabled = !$PointLight2D.enabled
		for raycast in $PointLight2D.raycasts:
			raycast.enabled = $PointLight2D.enabled
		
		if !$PointLight2D.enabled:
			$LightSwitch/AnimatedSprite2D.play("default")
		else:
			$LightSwitch/AnimatedSprite2D.play("on")

func _on_light_switch_area_entered(area):
	if area.is_in_group("PlayerHitbox"):
		interactable = true
		$LightSwitch/Label.visible = true

func _on_light_switch_area_exited(area):
	if area.is_in_group("PlayerHitbox"):
		interactable = false
		$LightSwitch/Label.visible = false
		
