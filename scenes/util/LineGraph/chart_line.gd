extends Line2D

func _draw():
	for pointIndex in range(1,get_point_count()):
		var pointPos : Vector2 = get_point_position(pointIndex);
		draw_circle(pointPos, 4, Color("4c7c9e"))
