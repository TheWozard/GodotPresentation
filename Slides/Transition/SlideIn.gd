extends Transition

func interpolation():
	interpolate_method(self, "interpolate", get_viewport().get_visible_rect().size.x, 0, 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
