extends Control

signal loaded
signal leaving

class_name Slide

var loaded = false
onready var transition: Transition = $Transition

func _ready():
	visible = false
	# In the event we are the root node we can instant load ourself
	if get_parent() == get_viewport():
		start(null, State.Direction.Instant)
	
func start(prev: Slide, direction: int):
	visible = true
	if prev != null:
		prev.emit_signal("leaving")
	if transition != null:
		transition.transition(prev, self, direction)
	else:
		complete_load()


func complete_load():
	loaded = true
	print("loaded")
	emit_signal("loaded", true)

func _on_Transition_tween_all_completed():
	complete_load()
