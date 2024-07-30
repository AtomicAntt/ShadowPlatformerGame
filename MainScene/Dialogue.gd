extends Control

var character_per_second = 35
var tween: Tween

func write_text(name: String, textGiven: String) -> void:
	$DialogueBox/NameBox/Label.text = name
	$DialogueBox/Label.text = textGiven
	$DialogueBox/Label.visible_ratio = 0
	visible = true
	
	tween = get_tree().create_tween()
	tween.tween_property($DialogueBox/Label, "visible_ratio", 1, textGiven.length()/character_per_second)

func input(event):
	if event.is_action_pressed("ui_accept"):
		if $DialogueBox/Label.visible_ratio < 1:
			tween.stop()
			$DialogueBox/Label.visible_ratio = 1
		else:
			emit_signal("ConfirmDialogue")

func start_level_0_text():
	

