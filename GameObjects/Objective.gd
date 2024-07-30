extends Area2D

@export var cutscene_id: int

var activatable = true

func _on_area_entered(area):
	if area.is_in_group("PlayerHitbox") and activatable:
		activatable = false
		var dialogue = get_tree().get_nodes_in_group("Dialogue")[0]
		dialogue.cause_dialogue(cutscene_id)
