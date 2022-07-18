extends Control

var slides = [
	preload("res://Slides/TitleSlide.tscn"),
	preload("res://Slides/WhatIsIt.tscn"),
	preload("res://Slides/ImportantChoice.tscn"),
	preload("res://Slides/WhatIsSpecialAboutIt.tscn"),
	preload("res://Slides/OpenSource.tscn"),
	preload("res://Slides/SelfContained.tscn"),
	preload("res://Slides/BeginnerFriendly.tscn"),
	preload("res://Slides/Modern.tscn"),
	preload("res://Slides/WhatHasBeenMadeWithIt.tscn"),
	# preload("res://Slides/EverythingIsNodes.tscn"),
	# preload("res://Slides/NodesGoOnTheSceneTree.tscn"),
	# preload("res://Slides/NodesTalkBySignals.tscn"),
	# preload("res://Slides/NodesThinkInGDScript.tscn"),
	# preload("res://Slides/AsyncExamplesInGDScript.tscn"),
	# preload("res://Slides/LotsMoreFeatures.tscn"),
	preload("res://Slides/WasItFun.tscn"),
	preload("res://Slides/Yes.tscn"),
	# reload("res://Slides/Questions.tscn"),
	preload("res://Slides/QuickOverview.tscn"),
]

var prev: Slide
var current: Slide

var transitioning = false
var slide_index = 0

func _input(event):
	if !transitioning && (event.is_action_pressed("ui_accept") || event.is_action_pressed("ui_right")):
		load_next_slide()
	if !transitioning && (event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_left")):
		load_previous_slide()
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _ready():
	slide_index = 0
	load_slide(slides[0].instance(), State.Direction.Instant)

func load_next_slide():
	if Input.is_action_pressed("fast_mode"):
		set_slide_index(slide_index + 1, State.Direction.Instant)
	else:
		set_slide_index(slide_index + 1, State.Direction.Forward)

func load_previous_slide():
	if Input.is_action_pressed("fast_mode"):
		set_slide_index(slide_index - 1, State.Direction.Instant)
	else:
		set_slide_index(slide_index - 1, State.Direction.Backward)

func load_slide(node: Slide, direction: int):
	transitioning = true
	prev = current
	add_child(node)
	current = node
	node.start(prev, direction)
	if prev != null && (node.loaded || yield(node, "loaded")):
		remove_child(prev)
	transitioning = false

func set_slide_index(index: int, direction: int):
	var prev_index = slide_index
	slide_index = clamp(index, 0, len(slides) -1)
	if prev_index != slide_index:
		var slide = slides[slide_index]
		load_slide(slide.instance(), direction)
