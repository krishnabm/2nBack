extends Node2D

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton
@onready var n_value_slider = %NValueSlider
@onready var test_len_slider = %TestLenSlider

func _ready():
	GameState.init_store()
	n_value_slider.value = GameParams.nValue
	test_len_slider.value = GameParams.testLength
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/GameBoard/game_board.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit() 


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/GameBoard/game_board.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_n_value_slider_value_changed(value):
	GameParams.nValue = value

func _on_test_len_slider_value_changed(value):
	GameParams.testLength = value

func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Tutorial/tutorial.tscn")
