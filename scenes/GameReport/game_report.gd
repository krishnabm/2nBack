extends Node2D


#region Members
var database: SQLite
var dbOpsThread: Thread
var f1: Function
#endregion

#region Nodes
@onready var secondary_stats_container = %SecondaryStatsContainer
@onready var chart:Chart = %Chart
#endregion

#region Methods
func _ready():
	if not GameParams.dualMode:
		secondary_stats_container.visible = false
	
	dbOpsThread = Thread.new()
	dbOpsThread.start(store_stats_db.bind())
	
	get_tree().current_scene.call("update_bg_params", Vector2(1,0.5), 125)

func store_stats_db():
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	
	database.query("select * from stats limit 1")
	if database.error_message.length():
		var statTableSchema = {
			"tsId": {"data_type": "bigint", "primary_key": true, "not_null": true, "unique": true},
			"nValue": {"data_type": "int"},
			"testLen": {"data_type": "int"},
			"ptp": {"data_type": "int"},
			"stp": {"data_type": "int"},
			"pfp": {"data_type": "int"},
			"sfp": {"data_type": "int"},
			"pfn": {"data_type": "int"},
			"sfn": {"data_type": "int"},
		}
		database.create_table("stats", statTableSchema)
	
	if not GameState.early_exit :
		var data = {
			"tsId": int(Time.get_unix_time_from_system()),
			"nValue": GameParams.nValue,
			"testLen": GameParams.testLength,
			"ptp": GameState.truePositiveCount[0],
			"stp": GameState.truePositiveCount[1],
			"pfp": GameState.falsePositiveCount[0],
			"sfp": GameState.falsePositiveCount[1],
			"pfn": GameState.falseNegativeCount[0],
			"sfn": GameState.falseNegativeCount[1],
		}
		database.insert_row("stats", data)
	
	print(fetch_stats_db(database))

func fetch_stats_db(_database: SQLite):
	var res = _database.select_rows("stats", "", ["*"])
	var dateTimeStrs = res.map(func(row): return Time.get_datetime_string_from_unix_time(row.tsId))
	var nValues = res.map(func(row): return row.nValue)
	
	#region easy charts
	#var cp: ChartProperties = ChartProperties.new()
	#cp.colors.frame = Color(0.08627451211214, 0.10196078568697, 0.11372549086809)
	#cp.colors.background = Color.TRANSPARENT
	#cp.colors.grid = Color("#283442")
	#cp.colors.ticks = Color("#283442")
	#cp.colors.text = Color.WHITE_SMOKE
	#cp.draw_bounding_box = false
	#cp.title = "Air Quality Monitoring"
	#cp.x_label = "Dates"
	#cp.y_label = "N Values"
	#cp.x_scale = 1
	#cp.y_scale = 1
	#cp.interactive = true # false by default, it allows the chart to create a tooltip to show point values
	## and interecept clicks on the plot
	#
	## Let's add values to our functions
	#f1 = Function.new()
	#f1._init(
		#nValues, nValues, "NValue", # This will create a function with x and y values taken by the Arrays 
						## we have created previously. This function will also be named "Pressure"
						## as it contains 'pressure' values.
						## If set, the name of a function will be used both in the Legend
						## (if enabled thourgh ChartProperties) and on the Tooltip (if enabled).
		## Let's also provide a dictionary of configuration parameters for this specific function.
		#{ 
			#color = Color("#36a2eb"), 		# The color associated to this function
			#marker = Function.Marker.CIRCLE, 	# The marker that will be displayed for each drawn point (x,y)
											## since it is `NONE`, no marker will be shown.
			#type = Function.Type.LINE, 		# This defines what kind of plotting will be used, 
											## in this case it will be a Linear Chart.
			#interpolation = Function.Interpolation.STAIR 	# Interpolation mode, only used for 
															## Line Charts and Area Charts.
		#}
	#)
	#
	## Now let's plot our data
	#chart.plot([f1], cp)
	#endregion
	
	return [dateTimeStrs, nValues]

func _exit_tree():
	if dbOpsThread.is_alive() or dbOpsThread.is_started():
		dbOpsThread.wait_to_finish()
#endregion
	

#region Signal handlers
func _on_exit_button_pressed():
	queue_free()
	get_tree().quit()
func _on_menu_button_pressed():
	if GameParams.dualMode:
		get_tree().current_scene.call("update_bg_params", Vector2(-1,0.5), 250)
	else:
		get_tree().current_scene.call("update_bg_params", Vector2(1,0.5), 125)

	get_tree().current_scene.call("change_scene", "res://scenes/MainMenu/main_menu.tscn")
#endregion
