extends Tween

class_name Transition

var current: Control
var prev: Control
var direction: int

export var duration = 0.4

func transition(new_prev: Control, new_current: Control, new_direction: int):
	prev = new_prev
	current = new_current
	direction = new_direction
	stop_all()
	if direction == State.Direction.Instant:
		emit_signal("tween_all_completed")
		return
	interpolation()
	setup_transition()
	start()
	yield(self, "tween_all_completed")
	cleanup_transition()

func interpolation():
	interpolate_method(self, "interpolate", get_viewport().get_visible_rect().size.x, 0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func setup_transition():
	pass
	
func interpolate(value: float):
	if current != null:
		current.rect_position = Vector2(direction * value,0)
	if prev != null:
		prev.rect_position = Vector2(direction * (value - get_viewport().get_visible_rect().size.x), 0)

func cleanup_transition():
	pass
