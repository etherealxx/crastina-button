extends Control

var bigbutton_cancelmode := false
#var tasklist : Array[String] = ["Godot (Coding)", "Blender (Modelling)"]

func hide_askers():
	%Askers.hide_askers()
	%BigTimer.hide()


func load_array_from_save(varname : String, default_value : Array):
	var loaded_array = SaveSystem.get_var(varname, default_value)
	if loaded_array is Array: return loaded_array
	else: return default_value
		

func _ready() -> void:
	hide_askers()
	%TimerBeforeStarting.bigtimerstart.connect(_on_big_timer_start)
	#@TODO test for save system
	#SaveSystem._load()
	GlobalVar.set_tasklist(load_array_from_save("tasks", ["Godot (Coding)", "Blender (Modelling)"]))
	GlobalVar.set_procrasthinglist(load_array_from_save("procrasthing", ["Eat", "Watching Youtube"]))
	%TaskListAndButtons.list_all_tasks(GlobalVar.tasklist)
	%ProcrasListAndButtons.list_all_procrasthing(GlobalVar.procrasthinglist)
	%TaskListAndButtons.item_removed.connect(_on_listitem_removed)
	%ProcrasListAndButtons.item_removed.connect(_on_listitem_removed)
	%BigTimer.timerover.connect(_on_big_timer_over)

func cancel_big_button():
	if bigbutton_cancelmode:
		bigbutton_cancelmode = false
		hide_askers()
		%BigButton.text = "Press Me"

func _on_big_button_pressed() -> void:
	if !bigbutton_cancelmode:
		bigbutton_cancelmode = true
		%TaskAsker.prepare_task_buttons()
		%TaskAsker.show()
		%BigButton.text = "( CANCEL )"
	else:
		cancel_big_button()

func _on_listitem_removed(itemname : String, itemtype: String):
	match (itemtype):
		"tasks":
			for item in GlobalVar.tasklist:
				if item == itemname:
					GlobalVar.tasklist.erase(item)
					SaveSystem.set_var("tasks", GlobalVar.tasklist)
					SaveSystem.save()
					#@TODO make sure the timer isn't running so no conflict
					hide_askers()
					cancel_big_button()
					break
		"procrasthing":
			for item in GlobalVar.procrasthinglist:
				if item == itemname:
					GlobalVar.procrasthinglist.erase(item)
					SaveSystem.set_var("procrasthing", GlobalVar.procrasthinglist)
					SaveSystem.save()
					#@TODO make sure the timer isn't running so no conflict
					hide_askers()
					cancel_big_button()
					break
		_:
			push_error("itemtype unrecognized: " + itemtype)

func _on_big_timer_start():
	%BigButton.hide()
	%BigTimer.start_timer(%Askers.get_duration_sec())

func _on_big_timer_over():
	%Askers.goto_check_didprocras()
