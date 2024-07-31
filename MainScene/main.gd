extends Control

@onready var main_2d = $Main2D

var current_level: int = 0

var level_0 = preload("res://Levels/Level0.tscn") # Ugh, I have to do this because html export doesn't work otherwise..

var level_instance: Node2D

#func _ready():
	#$MainMenu.visible = false	
	#var level_instance = level_0.instantiate()
	#main_2d.add_child(level_instance)

func game_over() -> void:
	$Main2D/CanvasLayer/GameOver.visible = true

func unload_level() -> void:
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name : String) -> void:
	$MainMenu.visible = false
	$Main2D/CanvasLayer/GameOver.visible = false
	unload_level()
	var level_path: String = "res://Levels/%s.tscn" % level_name
	var level_resource: Resource = load(level_path)
	#var level_resource: Resource
	#match level_name:
		#"level0":
			#level_resource = level_0
	
	if level_resource:
		level_instance = level_resource.instantiate()
		main_2d.add_child(level_instance)
	
	match current_level:
		0: 
			$Main2D/CanvasLayer/Dialogue.start_level_0_text()
		1:
			$Main2D/CanvasLayer/Dialogue.start_level_1_text()
		2:
			$Main2D/CanvasLayer/Dialogue.start_level_2_text()
		3:
			$Main2D/CanvasLayer/Dialogue.start_level_3_text()
		4:
			$Main2D/CanvasLayer/Dialogue.start_level_4_text()

func load_next_level() -> void:
	current_level += 1
	load_level("Level"+str(current_level))

func reload_level() -> void:
	$Main2D/CanvasLayer/GameOver.visible = false
	load_level("Level"+str(current_level))

func _on_start_pressed():
	load_level("Level0")

func _on_restart_pressed():
	reload_level()
	
func _on_quit_to_main_menu_pressed():
	quit_to_main()

func quit_to_main():
	$Main2D/CanvasLayer/GameOver.visible = false
	$MainMenu.visible = true
	current_level = 0
	unload_level()
	
