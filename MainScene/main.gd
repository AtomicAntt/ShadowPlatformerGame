extends Control

@onready var main_2d = $Main2D

var level_instance: Node2D

#func _ready():
	#load_level("Level0")

func unload_level() -> void:
	if is_instance_valid(level_instance):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name : String) -> void:
	unload_level()
	var level_path: String = "res://Levels/%s.tscn" % level_name
	var level_resource: Resource = load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		main_2d.add_child(level_instance)
