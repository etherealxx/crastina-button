extends VBoxContainer

@onready var askers := get_parent()
@onready var taskbutton = load("res://scenes/bare/task_button.tscn")

func _ready() -> void:
	$Answer.hide()
	#for node : Node in $TaskButtons.get_children():
		#if "TaskButton" in node.name and node.has_signal("taskchosen"):
			#node.taskchosen.connect(_every_task_chosen)

func hide_and_reset():
	self.hide()
	$TaskButtons.show()
	$Answer.hide()
	
func _every_task_chosen(task : String):
	# get the newly selected task in front
	#@TODO might not work
	if task in GlobalVar.tasklist:
		GlobalVar.tasklist.erase(task)
		GlobalVar.tasklist.push_front(task)
	
	$TaskButtons.hide()
	$Answer.text = "✅" + task
	$Answer.show()
	askers.set_task(task)
	askers.goto_duration()

func get_buttons() -> Array[Button]:
	var buttons : Array[Button]
	for node in $TaskButtons.get_children():
		if node is Button:
			buttons.append(node)
	return buttons
	
func prepare_task_buttons():
	# remove all task button first
	for button in get_buttons():
		if 'TaskButton' in button.name:
			button.queue_free()
			print("button freed")
	var amountofcreatedbtn := 0
	for taskname : String in GlobalVar.tasklist:
		for button : Node in get_buttons():
			if button is Button: #@TODO remove this line later
				if not taskname in button.text and amountofcreatedbtn < 4: # limit to 4 button
					var newbtn = taskbutton.instantiate()
					$TaskButtons/SiblingSpot.add_sibling(newbtn)
					newbtn.name = "TaskButton" + str(amountofcreatedbtn)
					newbtn.text = taskname
					newbtn.taskchosen.connect(_every_task_chosen)
					amountofcreatedbtn += 1
					break
