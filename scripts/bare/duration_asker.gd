extends VBoxContainer

@onready var askers := get_parent()

func _ready() -> void:
	$Answer.hide()
	for node : Node in $DurationButtons.get_children():
		if "TaskButton" in node.name and node.has_signal("taskchosen"):
			node.taskchosen.connect(_every_task_chosen)
	#hidden.connect(_on_default_hidden)

func hide_and_reset():
	self.hide()
	$DurationButtons.show()
	$Answer.hide()
	
func _every_task_chosen(task : String):
	$DurationButtons.hide()
	$Answer.text = "✅in " + task
	$Answer.show()
	askers.set_duration(task)
	askers.goto_timerbefore()
	#askers.goto_duration()
