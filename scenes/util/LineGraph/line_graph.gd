extends Control

@onready var chart_line: Line2D = %ChartLine
@onready var graph_area: PanelContainer = %GraphArea

func _ready():
	pass


func plot_graph(stats):
	var graphSize: Vector2 = Vector2(887,245) #graph_area.size;
	var yStep = graphSize.y/20
	var xStep = graphSize.x/10
	
	# var tsIds = stats[0]
	var nValue = stats[1]
	var falseCount = stats[2]
	chart_line.add_point(Vector2(0,(20-nValue[0])*yStep))
	
	for i in range(0, nValue.size(), 1):
		var xCoord = i + 1
		var yCoord = 20 - nValue[i]
		
		var xPix = int(xCoord * xStep)
		var yPix = int(yCoord * yStep)
		
		chart_line.add_point(Vector2(xPix,yPix))
