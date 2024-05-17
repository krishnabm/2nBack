# This script is autoloaded from Project Settings > Autoload
#
# Global Class Name : GameParams
# This stores config like properties
extends Node2D

var nValue = 2
var testLength = 10
var dualMode = false
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
		config.save("user://config.cfg")
	else:
		self.nValue = config.get_value("GameParams", "nValue")
		self.testLength = config.get_value("GameParams", "testLength")
		self.dualMode = config.get_value("GameParams", "dualMode")

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
