extends Control

signal loaded

class_name Slide

var loaded = false
onready var transition: Transition = $Transition


func _ready():
	visible = false
	# In the event we are the root node we can instant load ourself
	if get_parent() == get_viewport():
		start(self,null, State.Direction.Instant)
	
func start(prev: Control, current: Control, direction: int):
	visible = true
	if transition != null:
		transition.transition(prev, current, direction)
	else:
		complete_load()


func complete_load():
	loaded = true
	emit_signal("loaded", true)


func _on_Transition_tween_all_completed():
	complete_load()
