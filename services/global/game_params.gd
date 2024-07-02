# This script is autoloaded from Project Settings > Autoload
#
# Global Class Name : GameParams
# This stores config like properties
extends Node2D

var nValue = 2
var testLength = 10
var dualMode = false
var statsChartDepth = 10
var config = ConfigFile.new()

func _ready() -> void:
	# Load data from a file.
	var err = config.load("user://config.cfg")
	# If the file didn't load, ignore it.
	if err != OK:
		push_warning("Couldn't load config. Creating new default config")
		config.set_value("GameParams", "nValue", nValue)
		config.set_value("GameParams", "testLength", testLength)
		config.set_value("GameParams", "dualMode", dualMode)
		config.set_value("GameParams", "statsChartDepth", statsChartDepth)
		config.save("user://config.cfg")
	else:
		self.nValue = get_value_or_default("GameParams", "nValue")
		self.testLength = get_value_or_default("GameParams", "testLength")
		self.dualMode = get_value_or_default("GameParams", "dualMode")
		self.statsChartDepth = get_value_or_default("GameParams", "statsChartDepth")

func get_value_or_default(section: String, key: String):
	var res = config.get_value(section, key)
	if res == null:
		res = self[key]
		config.set_value(section, key, res)
		config.save("user://config.cfg")
	return res;
	
# Number of true positives that must be generated based on test length
func get_test_positive_count():
	if testLength >= 20:
		return 8
	if testLength >= 15:
		return 6
	if testLength >= 12:
		return 5
	if testLength >= 10:
		return 4
	if testLength >= 5:
		return 2
	return 2


func update_param(paramName: String, value: Variant) -> void:
	self[paramName] = value
	config.set_value("GameParams", paramName, value)

func _exit_tree() -> void:
	config.save("user://config.cfg")
