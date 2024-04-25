extends Node2D

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/GameBoard/game_board.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/GameBoard/game_board.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit() 

func _ready():
	GameState.init_store()


func _on_n_value_input_value_changed(value):
	GameParams.nValue = value
