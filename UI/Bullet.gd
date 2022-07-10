tool
extends Control

export(String, MULTILINE) var text: String = "Example" setget set_text

func _ready():
	set_text(text)

func set_text(value):
	if $Label != null:
		$Label.text = value
	text = value
