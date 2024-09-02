extends VBoxContainer

@onready var askers := get_parent()

func show_and_tell():
	self.show()
	$Label.text = \
	"""Time's up! Have you done your task yet?
[ Your task: ➡️%s ]""" % askers.asker_task
	#$RichTextLabel.text = \
	#"""[center]Time's up! Have you done your task yet?
#[Your task: [b]%s[/b] ][/center]""" % askers.asker_task

func _on_donetask_yes_pressed() -> void:
	$DoneOrProcrasted.hide()
	$Answer.show()
	askers.goto_newtimer()

func _on_procrasted_no_pressed() -> void:
	askers.goto_procrasthingasker()
