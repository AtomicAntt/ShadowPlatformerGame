extends Control

@onready var main_2d = $Main2D

var current_level: int = 0

var level_instance: Node2D

#func _ready():
	#load_level("Level0")

func game_over() -> void:
	$Main2D/CanvasLayer/GameOver.visible = true

func unload_level() -> void:
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name : String) -> void:
	$MainMenu.visible = false
	unload_level()
	var level_path: String = "res://Levels/%s.tscn" % level_name
	var level_resource: Resource = load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		main_2d.add_child(level_instance)

func load_next_level() -> void:
	load_level("Level"+str(current_level+1))

func reload_level() -> void:
	load_level("Level"+str(current_level))
	$Main2D/CanvasLayer/GameOver.visible = false

func _on_start_pressed():
	load_level("level0")

func _on_restart_pressed():
	reload_level()
	
func _on_quit_to_main_menu_pressed():
	unload_level()
	$Main2D/CanvasLayer/GameOver.visible = false
	$MainMenu.visible = true
	
