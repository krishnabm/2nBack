extends Node2D

var current_scene: Node2D

@onready var menu_background = %MenuBackground

func _ready():
	var main_menu_scn: PackedScene = preload("res://scenes/MainMenu/main_menu.tscn")
	current_scene = main_menu_scn.instantiate()
	add_child(current_scene)

func update_bg_params(direction = null, speed = null):
	if direction != null:
		menu_background.direction = direction
	if speed != null:
		menu_background.speed = speed

func change_scene(scenePath: String):
	remove_child(current_scene)
	current_scene.queue_free()
	
	var new_scn: PackedScene = load(scenePath)
	current_scene = new_scn.instantiate()
	add_child(current_scene)
