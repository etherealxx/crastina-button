extends VBoxContainer

var asker_task : String
var asker_duration_min : float

func hide_askers():
	$TaskAsker.hide_and_reset()
	$DurationAsker.hide_and_reset()	
	$TimerBeforeStarting.hide_and_reset()
	$ReminderLabel.hide()
	$DidProcrasAsker.hide()
	%ProcrasthingAsker.hide() # and reset
	$NewTimerAsker.hide()

func goto_duration():
	$DurationAsker.show()
	
func goto_timerbefore():
	$TimerBeforeStarting.show()
	$TimerBeforeStarting.start_countdown()
	
func goto_reminder():
	$TaskAsker.hide_and_reset()
	$DurationAsker.hide_and_reset()	
	$TimerBeforeStarting.hide_and_reset()
	$ReminderLabel.show()
	$ReminderLabel.text = \
	"""Your current task : %s
I'll ask you later if you did do your task.""" % asker_task

func goto_check_didprocras():
	$ReminderLabel.hide()
	$DidProcrasAsker.show_and_tell()
	
func goto_newtimer():
	$NewTimerAsker.show()
	
func goto_procrasthingasker():
	$DidProcrasAsker.hide()
	%ProcrasthingAsker.show()
	
func set_task(task: String):
	asker_task = task
	
func set_duration(duration_str: String):
	asker_duration_min = duration_str.trim_suffix(" min").to_float()

func get_duration_sec():
	return (asker_duration_min * 60.0)
