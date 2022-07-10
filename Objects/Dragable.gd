extends RigidBody2D

var selected = false
var offset

export var speed = 10

func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Select"):
		offset = global_position - get_viewport().get_mouse_position()
		selected = true

func _input(event):
	if Input.is_action_just_released("Select"):
		selected = false
		
func _physics_process(delta):
	if selected:
		linear_velocity += -1 * (global_position - (get_viewport().get_mouse_position() + offset)) * delta * speed

func _on_Slide_loaded(success):
	mode = MODE_RIGID


func _on_Slide_leaving():
	mode = MODE_STATIC
