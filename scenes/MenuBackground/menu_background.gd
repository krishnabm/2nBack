class_name MenuBackground
extends Node2D

@onready var parallax_background = %ParallaxBackground
@onready var primary_bg_sprite = %PrimaryBGSprite

@export var speed: int = 500
@export var direction: Vector2 = Vector2(1,1)
@export var modulate_color: Color = Color(1,1,1,1)


func _process(delta):
	parallax_background.scroll_base_offset += delta*speed*direction
	primary_bg_sprite.modulate = modulate_color
