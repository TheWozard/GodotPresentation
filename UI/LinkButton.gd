extends LinkButton

export var link: String

func _on_LinkButton_button_up():
	OS.shell_open(link)
