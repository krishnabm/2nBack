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
	fetch_stats_db(database)

func fetch_stats_db(_database: SQLite):
	var res = _database.select_rows("stats", "", ["*"])
	return res
	pass

func _exit_tree():
	if dbOpsThread.is_alive() or dbOpsThread.is_started():
		dbOpsThread.wait_to_finish()
#endregion
	

#region Signal handlers
func _on_exit_button_pressed():
	queue_free()
	get_tree().quit()
func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu/main_menu.tscn")
#endregion
