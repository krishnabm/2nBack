extends Node2D

@onready var start_button = %StartButton
@onready var exit_button = %ExitButton
@onready var n_value_slider = %NValueSlider
@onready var test_len_slider = %TestLenSlider
@onready var dual_n_toggle_button: CheckButton = %DualNToggleButton
@onready var dual_n_toggle_label = %DualNToggleLabel
@onready var parallax_background: MenuBackground = $ParallaxBackground

func _ready():
	GameState.init_store()
	n_value_slider.value = GameParams.nValue
	test_len_slider.value = GameParams.testLength
	dual_n_toggle_button.button_pressed = GameParams.dualMode
	
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
	GameParams.update_param("nValue",value)

func _on_test_len_slider_value_changed(value):
	GameParams.update_param("testLength",value)

func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Tutorial/tutorial.tscn")

func _on_check_button_toggled(toggled_on: bool) -> void:
	GameParams.update_param("dualMode",toggled_on)
	if (toggled_on):
		dual_n_toggle_label.text = "Dual N Mode"
		dual_n_toggle_label.add_theme_color_override("font_color",  Color("dd7680"))
		dual_n_toggle_label.add_theme_color_override("font_shadow_color", Color("784045"))
		parallax_background.direction = Vector2(-1,0.5)
		parallax_background.speed = 250
		#parallax_background.modulate_color = Color(1,0.9,0.8)
	else:
		dual_n_toggle_label.text = "Single N Mode"
		dual_n_toggle_label.add_theme_color_override("font_color",  Color("4c7c9e"))
		dual_n_toggle_label.add_theme_color_override("font_shadow_color", Color("33546b"))
		parallax_background.direction = Vector2(1,0.5)
		parallax_background.speed = 125
		#parallax_background.modulate_color = Color(1,1,1)
