extends Node2D
@onready var secondary_stats_container = %SecondaryStatsContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	if not GameParams.dualMode:
		secondary_stats_container.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu/main_menu.tscn")
