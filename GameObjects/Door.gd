extends Area2D

var canOpen: bool = false # After completing the level's goal, you can enter the door.
var canEnter: bool = false

func _input(event):
	if event.is_action_pressed("interact") and canEnter and canOpen:
		var main = get_tree().get_nodes_in_group("main")[0]
		main.load_next_level()

func _on_area_entered(area):
	if area.is_in_group("PlayerHitbox") and canOpen:
		$Label.visible = true
		canEnter = true

func _on_area_exited(area):
	if area.is_in_group("PlayerHitbox"):
		$Label.visible = false
		canEnter = false

func unlock() -> void:
	canOpen = true
	$AnimatedSprite2D.play("unlocked")
