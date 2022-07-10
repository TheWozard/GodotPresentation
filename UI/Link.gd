tool
extends HSplitContainer

export var text: String = "Github" setget setText
export var link: String

func _ready():
	setText(text)
	$LinkButton.link = link

func setText(newText: String):
	if is_inside_tree() && $LinkButton != null:
		$LinkButton.text = newText
	text = newText
