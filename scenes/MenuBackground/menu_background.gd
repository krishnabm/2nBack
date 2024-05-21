class_name MenuBackground
extends Node2D

@onready var parallax_background = %ParallaxBackground
@onready var primary_bg_sprite = %PrimaryBGSprite

@export var speed: int = 500
@export var direction: Vector2 = Vector2(1,1)
# @export var modulate_color: bool = false

func _process(delta):
	parallax_background.scroll_base_offset += delta*speed*direction
	
	var material: ShaderMaterial = primary_bg_sprite.material
	if GameParams.dualMode:
		material.set_shader_parameter("tintShift", true)
	else:
		material.set_shader_parameter("tintShift", false)
