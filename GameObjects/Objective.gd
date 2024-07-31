extends Area2D

@export var cutscene_id: int

var activatable = true

func _on_area_entered(area):
	if area.is_in_group("PlayerHitbox") and activatable:
		var player = area.get_parent()
		if player.health >= 100:
			activatable = false
			$GoalAccomplished.play()
			var dialogue = get_tree().get_nodes_in_group("Dialogue")[0]
			dialogue.cause_dialogue(cutscene_id)
