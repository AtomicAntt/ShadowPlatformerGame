extends Area2D

var canEnter: bool = false

func _input(event):
	if event.is_action_pressed("interact") and canEnter:
		var main = get_tree().get_nodes_in_group("main")[0]
		main.load_next_level()

func _on_area_entered(area):
	if area.is_in_group("PlayerHitbox"):
		canEnter = true

func _on_area_exited(area):
	if area.is_in_group("PlayerHitbox"):
		canEnter = false
