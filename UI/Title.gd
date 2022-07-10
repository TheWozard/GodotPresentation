tool
extends CenterContainer

enum Effect {
	None, Shake, HardShake, Wave
}

enum Ending {
	None, Question, Bang,
}

export var text: String = "Title" setget setText
export var subText: String = "" setget setSubText
export(Effect) var effect = Effect.None setget setEffect
export(Ending) var ending = Ending.None setget setEnding

# Called when the node enters the scene tree for the first time.
func _ready():
	setText(text)
	setSubText(subText)
	setEnding(ending)

func setText(newText: String):
	if is_inside_tree() && $Stack/Split/Label != null:
		$Stack/Split/Label.bbcode_text = "%s%s" % [prefix(effect), newText]
		$Stack/Split/Label.recalc_size(newText)
	text = newText
	
func setSubText(newSubText: String):
	if is_inside_tree() && $Stack/Center/SubLabel != null:
		$Stack/Center/SubLabel.visible = newSubText != ""
		$Stack/Center/SubLabel.text = newSubText
	subText = newSubText
	
func setEffect(newEffect):
	effect = newEffect
	setText(text)
	
func prefix(effect) -> String:
	match effect:
		Effect.Shake:
			return "[shake]"
		Effect.HardShake:
			return "[shake rate=20 level=20]"
		Effect.Wave:
			return "[wave amp=50 freq=5]"
		_:
			return ""

func setEnding(newEnding):
	if is_inside_tree() &&  $Stack/Split/Endings == null:
		return
	match ending:
		Ending.Question:
			$Stack/Split/Endings/Question.visible = false
			$Stack/Split/Endings/Question.emitting = false
		Ending.Bang:
			$Stack/Split/Endings/Bang.visible = false
			$Stack/Split/Endings/Bang.emitting = false
		Ending.None:
			$Stack/Split/Endings.visible = true
	match newEnding:
		Ending.Question:
			$Stack/Split/Endings/Question.visible = true
			$Stack/Split/Endings/Question.emitting = true
		Ending.Bang:
			$Stack/Split/Endings/Bang.visible = true
			$Stack/Split/Endings/Bang.emitting = true
		Ending.None:
			$Stack/Split/Endings.visible = false
	ending = newEnding
