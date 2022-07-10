tool
extends RichTextLabel

func recalc_size(value):
	rect_min_size.x = 0.0
	for line in text.split("\n"):
		rect_min_size.x = max(rect_min_size.x, get_font("normal_font").get_string_size(line).x+1)
