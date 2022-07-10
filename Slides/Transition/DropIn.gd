extends Transition

func interpolation():
	interpolate_method(self, "interpolate", get_viewport().get_visible_rect().size.y, 0, 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)

func interpolate(value: float):
	if current != null:
		current.rect_position = Vector2(0, -direction * value)
