extends Area2D

func _on_area_entered(area):
	if area.is_in_group("PlayerHitbox"):
		var dialogue = get_tree().get_nodes_in_group("Dialogue")[0]
		dialogue.start_introduction_cutscene()
		queue_free()
