extends Control

var slides = [
	preload("res://Slides/TitleSlide.tscn"),
	preload("res://Slides/OverviewSlide.tscn"),
	preload("res://Slides/Details1Slide.tscn"),
	preload("res://Slides/Details2Slide.tscn"),
]

var prev: Control
var current: Control

var transitioning = false
var slide_index = 0

func _input(event):
	if !transitioning && (event.is_action_pressed("ui_accept") || event.is_action_pressed("ui_right")):
		load_next_slide()
	if !transitioning && (event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_left")):
		load_previous_slide()

func _ready():
	slide_index = 0
	load_slide(slides[0].instance(), State.Direction.Instant)

func load_next_slide():
	set_slide_index(slide_index + 1, State.Direction.Forward)

func load_previous_slide():
	set_slide_index(slide_index - 1, State.Direction.Backward)

func load_slide(node: Slide, direction: int):
	transitioning = true
	prev = current
	add_child(node)
	current = node
	node.start(prev, current, direction)
	if prev != null && (node.loaded || yield(node, "loaded")):
		remove_child(prev)
	transitioning = false

func set_slide_index(index: int, direction: int):
	var prev_index = slide_index
	if index < len(slides) && index >= 0:
		slide_index = index
	elif index >= len(slides):
		slide_index = len(slides) -1
	else:
		slide_index = 0
	if prev_index != slide_index:
		var slide = slides[slide_index]
		load_slide(slide.instance(), direction)
