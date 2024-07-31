extends Control

var character_per_second: float = 35
var tween: Tween # this guys in charge of making text visible

var intro_finished: bool = false

var time_started: int # when you start level 0

signal ConfirmDialogue

func write_text(name: String, textGiven: String) -> void:
	$DialogueBox/NameBox/Label.text = name
	$DialogueBox/Label.text = textGiven
	$DialogueBox/Label.visible_ratio = 0
	visible = true
	
	if name == "Player":
		$PlayerDialogue.play()
	elif name == "Talking Computer":
		$ComputerDialogue.play()
	elif name == "Max, Head Researcher":
		$MaxDialogue.play()
		
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
	for player in get_tree().get_nodes_in_group("Player"):
		player.disable_movement()
	
	$DialogueBackground.modulate.a = 1
	
	write_text("Max, Head Researcher", "Hey man, can you get me some Dihydrogen Monoxide from storage room 7A?")
	await ConfirmDialogue
	
	write_text("Player", "Sure thing boss. I'll get you that stuff right away.")
	await ConfirmDialogue
	
	time_started = Time.get_ticks_msec() # Lol
	
	$DialogueBackground.modulate.a = 0.2
	write_text("Player", "Okay, it's my first task in this new job. I just need to look at the labels of each flask and give Max the right one!")
	await ConfirmDialogue
	
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.enable_movement()
	
	
	visible = false

func start_level_1_text():
	for player in get_tree().get_nodes_in_group("Player"):
		player.disable_movement()
	
	write_text("Player", "Okay, made it to Room 13A, and I made sure it's the right room this time!")
	await ConfirmDialogue
	
	write_text("Player", "Just have to avoid the guard ahead, and turn off all of these lights so I don't melt.")
	await ConfirmDialogue
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.enable_movement()
	
	visible = false

func start_level_2_text():
	for player in get_tree().get_nodes_in_group("Player"):
		player.disable_movement()
	
	write_text("Player", "Alright, made it to storage room 5B where that all cure potion is located! It's finally time to get cured!")
	await ConfirmDialogue
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.enable_movement()
	
	visible = false
	
func start_level_3_text():
	for player in get_tree().get_nodes_in_group("Player"):
		player.disable_movement()
	
	write_text("Player", "This is room 6C, the place where I will finally become human with that (totally illegal) human potion!")
	await ConfirmDialogue
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.enable_movement()
	
	visible = false

func start_level_4_text():
	
	for player in get_tree().get_nodes_in_group("Player"):
		player.disable_movement()
	
	$DialogueBackground.modulate.a = 1
	
	write_text("Player", "Hey Boss, I got that Dihydrogen Monoxide for you!")
	await ConfirmDialogue
	
	write_text("Max, Head Researcher", "Hm. It has been " + str("%.3f" % ((float)(Time.get_ticks_msec() - time_started)/60000.0)) + " minutes since I have asked.. Does it usually take someone " + str("%.3f" % ((float)(Time.get_ticks_msec() - time_started)/60000.0)) + " minutes to get someone some water?")
	await ConfirmDialogue
	
	write_text("Max, Head Researcher", "Well it's alright, it's only your first day, don't beat yourself up about it. \n [GAME COMPLETE]")
	await ConfirmDialogue
	
	$DialogueBackground.modulate.a = 0.2
	visible = false
	$"../../..".quit_to_main()

func start_introduction_cutscene():
	for player in get_tree().get_nodes_in_group("Player"):
		player.disable_movement()
		
	
	write_text("Player", "Alright, there are a lot of chemicals I don't understand here, but surely one of these is the one he wants.")
	await ConfirmDialogue
	
	write_text("Player", "Let me reach out to this one and see if this is the right one.")
	await ConfirmDialogue
	
	write_text("Player", "Oops.")
	await ConfirmDialogue
	
	$DialogueBackground.modulate.a = 1
	$PotionBreak.play()
	write_text("Player", "[You accidentally knock over a bunch of potions on top of you]")
	get_tree().get_nodes_in_group("Highlight")[0].queue_free() # Rids of the potions that were highlighted
	for player in get_tree().get_nodes_in_group("Player"):
		player.transform_to_shadow()
	await ConfirmDialogue
	
	$DialogueBackground.modulate.a = 0.2
	write_text("Player", "Ugh, I feel drowsy, and I can't feel my legs..")
	await ConfirmDialogue
	
	get_tree().get_nodes_in_group("TalkingComputer")[0].play("active") # Talking Computer is an Animated Sprite
	write_text("Talking Computer", "Hey, you alright?")
	await ConfirmDialogue
	
	write_text("Player", "Huh? Who are you? Am I just seeing things now?")
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
	for player in get_tree().get_nodes_in_group("Player"):
		player.enable_movement()
	
	for door in get_tree().get_nodes_in_group("Door"):
		door.unlock()
	
	visible = false

func cause_dialogue(id: int) -> void:
	match id:
		0:
			for player in get_tree().get_nodes_in_group("Player"):
				player.disable_movement()
			
			write_text("Player", "Cool, this looks like the cure that computer taked about! I should drink up and get back to work.")
			await ConfirmDialogue
			
			$DialogueBackground.modulate.a = 1
			$HealthPotion.play()
			write_text("Player", "[You drink the health potion]")
			await ConfirmDialogue
			
			for objective in get_tree().get_nodes_in_group("Objective"):
				objective.queue_free()
			
			$DialogueBackground.modulate.a = 0.2
			for talking_computer in get_tree().get_nodes_in_group("TalkingComputer"):
				talking_computer.play("active")
			write_text("Talking Computer", "Feel any better now?")
			await ConfirmDialogue
			
			write_text("Player", "You're here too? Well, I guess it healed up the bruise I got earlier when those potions fell on me and I fell.")
			await ConfirmDialogue
			
			write_text("Talking Computer", "I guess a regular health potion these guys made wouldn't do the trick. I think storage room 5B should have just the thing, it's an all-cure potion that can cure all diseases!")
			await ConfirmDialogue
			
			write_text("Player", "Okay, I guess I better leave this room and get to that all-cure potion asap!")
			await ConfirmDialogue
			
			for player in get_tree().get_nodes_in_group("Player"):
				player.enable_movement()
	
			for door in get_tree().get_nodes_in_group("Door"):
				door.unlock()
			
			for instructions in get_tree().get_nodes_in_group("Instructions"):
				instructions.visible = true
	
			visible = false
		1: 
			for player in get_tree().get_nodes_in_group("Player"):
				player.disable_movement()
			
			write_text("Player", "Looks like this is the all cure potion!")
			await ConfirmDialogue
			
			$DialogueBackground.modulate.a = 1
			$AllCurePotion.play()
			write_text("Player", "[You drink the all cure potion]")
			await ConfirmDialogue
			
			for objective in get_tree().get_nodes_in_group("Objective"):
				objective.queue_free()
			
			$DialogueBackground.modulate.a = 0.2
			for talking_computer in get_tree().get_nodes_in_group("TalkingComputer"):
				talking_computer.play("active")
			write_text("Talking Computer", "Looks like the all cure potion can't cure shadow disease.")
			await ConfirmDialogue
			
			write_text("Player", "Ugh, this is awful, I just want to get back to being human again!")
			await ConfirmDialogue
			
			write_text("Talking Computer", "Just did a quick scan, and it looks like they have been recently working on a new potion that can turn things into human!")
			await ConfirmDialogue
			
			write_text("Player", "Sounds like exactly what I need, to become human again!")
			await ConfirmDialogue
			
			write_text("Talking Computer", "Just go to room 6C, they should have that over there.")
			await ConfirmDialogue
			
			for player in get_tree().get_nodes_in_group("Player"):
				player.enable_movement()
	
			for door in get_tree().get_nodes_in_group("Door"):
				door.unlock()
			
			for instructions in get_tree().get_nodes_in_group("Instructions"):
				instructions.visible = true
	
			visible = false
		2:
			for player in get_tree().get_nodes_in_group("Player"):
				player.disable_movement()
			
			write_text("Player", "Finally, I got my hands on the human potion, they really got it locked down.")
			await ConfirmDialogue
			
			for player in get_tree().get_nodes_in_group("Player"):
				player.transform_to_human()
			
			$DialogueBackground.modulate.a = 1
			$HumanPotion.play()
			write_text("Player", "[You drink the human potion]")
			await ConfirmDialogue
			
			for objective in get_tree().get_nodes_in_group("Objective"):
				objective.queue_free()
				
			
			
			$DialogueBackground.modulate.a = 0.2
			for talking_computer in get_tree().get_nodes_in_group("TalkingComputer"):
				talking_computer.play("active")
			
			write_text("Talking Computer", "Wow, I can see it working alright")
			await ConfirmDialogue
			
			write_text("Player", "I can feel my arms, my legs, I think I really am all better!")
			await ConfirmDialogue
			
			write_text("Talking Computer", "Yep, you can now bring whatever that guy was some of that water!")
			await ConfirmDialogue
			
			write_text("Player", "You sure you don't wanna find a cure for yourself?")
			await ConfirmDialogue
			
			write_text("Talking Computer", "Nah, I got the internet, just get outta here.")
			await ConfirmDialogue
			
			for player in get_tree().get_nodes_in_group("Player"):
				player.enable_movement()
	
			for door in get_tree().get_nodes_in_group("Door"):
				door.unlock()
			
			for instructions in get_tree().get_nodes_in_group("Instructions"):
				instructions.visible = true
	
			visible = false
			


