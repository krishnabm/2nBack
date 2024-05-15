extends Node2D
@export var abs_pos_marker: Marker2D

func _get_configuration_warnings():
	if not abs_pos_marker:
		return 'Provide a Marker2D to position'
	else:
		return ''

func _ready():
	var pos: Vector2 = Vector2(0,0)
	if abs_pos_marker:
		pos = abs_pos_marker.global_position
