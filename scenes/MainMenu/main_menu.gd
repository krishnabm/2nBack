extends Node2D

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/GameBoard/game_board.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
