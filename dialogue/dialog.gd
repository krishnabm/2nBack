class_name DialogOrchestrator
extends CenterContainer

var current_message_pointer: int
@onready var dialog_timer = %DialogTimer
@onready var label = %Label

#I/O
@export var messages: Array[String]

signal on_dialog_seq_ended

func _ready():
	current_message_pointer = 0

func start_dialog():
	dialog_timer.start()
	current_message_pointer = 0
	if messages.size() > 0:
		label.text = messages[current_message_pointer]

func _exit_tree():
	dialog_timer.stop()

func _on_dialog_timer_timeout():
	current_message_pointer += 1
	
	if (current_message_pointer >= messages.size()):
		label.text = messages[messages.size() - 1]
		dialog_timer.stop()
		on_dialog_seq_ended.emit()
	else:
		label.text = messages[current_message_pointer]
