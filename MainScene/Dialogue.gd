extends Control

var character_per_second: float = 35
var tween: Tween # this guys in charge of making text visible

var intro_finished: bool = false

signal ConfirmDialogue

func write_text(name: String, textGiven: String) -> void:
	$DialogueBox/NameBox/Label.text = name
	$DialogueBox/Label.text = textGiven
	$DialogueBox/Label.visible_ratio = 0
	visible = true
	
	tween = get_tree().create_tween()
	tween.tween_property($DialogueBox/Label, "visible_ratio", 1, textGiven.length()/character_per_second)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if $DialogueBox/Label.visible_ratio < 1:
			tween.stop()
			$DialogueBox/Label.visible_ratio = 1
		else:
			emit_signal("ConfirmDialogue")

func start_level_0_text():
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.disable_movement()
	$DialogueBackground.modulate.a = 1
	
	write_text("Max, Head Researcher", "Hey man, can you get me some Dihydrogen Monoxide from storage room 7A?")
	await ConfirmDialogue
	
	write_text("Player", "Sure thing boss. I'll get you that stuff right away.")
	await ConfirmDialogue
	
	$DialogueBackground.modulate.a = 0.2
	write_text("Player", "Okay, it's my first task in this new job, I just need to look at the labels of each flask and give Max the right one!")
	await ConfirmDialogue
	
	player.enable_movement()
	
	visible = false

func start_introduction_cutscene():
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.disable_movement()
	
	write_text("Player", "Alright, there are a lot of chemicals I don't understand here, but surely one of these is the one he wants.")
	await ConfirmDialogue
	
	write_text("Player", "Let me reach out to this one and see if this is the right one.")
	await ConfirmDialogue
	
	write_text("Player", "Oops.")
	await ConfirmDialogue
	
	$DialogueBackground.modulate.a = 1
	write_text("Player", "[You accidentally knock over a bunch of potions on top of you]")
	get_tree().get_nodes_in_group("Highlight")[0].queue_free() # Rids of the potions that were highlighted
	player.transform_to_shadow()
	await ConfirmDialogue
	
	$DialogueBackground.modulate.a = 0.2
	write_text("Player", "Ugh, I feel drowsy, and I can't feel anything at all..")
	await ConfirmDialogue
	
	get_tree().get_nodes_in_group("TalkingComputer")[0].play("active") # Talking Computer is an Animated Sprite
	write_text("Talking Computer", "Hey, you alright?")
	await ConfirmDialogue
	
	write_text("Player", "Huh? Who are you, am I just seeing things now?")
	await ConfirmDialogue
	
	write_text("Talking Computer", "I am a person who turned into a computer, just like how you turned into a shadow.")
	await ConfirmDialogue
	
	write_text("Player", "[Looks at self] .. uh oh")
	await ConfirmDialogue
	
	write_text("Talking Computer", "In any case, this room is full of classified potions hidden away from the public eye because of their dangerous properties.")
	await ConfirmDialogue
	
	write_text("Player", "So there's no Dihydrogen Monoxide in here? My boss wanted some of that.")
	await ConfirmDialogue
	
	write_text("Talking Computer", "Dihydrogen Monoxide, you mean water? You definitely got the wrong room.")
	await ConfirmDialogue
	
	write_text("Player", "Oof.")
	await ConfirmDialogue
	
	write_text("Talking Computer", "Whatever, if you head down the hall and go to Room 13A, you can probably find a cure.")
	await ConfirmDialogue
	
	write_text("Player", "Thanks, hopefully I can get back to Max as soon as possible")
	
	get_tree().get_nodes_in_group("Instructions")[0].visible = true
	player.enable_movement()
	
	visible = false


