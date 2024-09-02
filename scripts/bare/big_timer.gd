extends ReferenceRect

signal timerover

var timer_started := false
var timer_duration_sec := 30.0
var timer_progress_value := 100.0
var time_left_sec : float

func _physics_process(delta: float) -> void:
	if timer_started:
		if $ProgressTimer.value > 0:
			timer_progress_value -= (100.0 / timer_duration_sec) * delta
			$ProgressTimer.value = timer_progress_value # snapped((100.0 / timer_duration_sec) * delta, 0.01)
			#print($ProgressTimer.value)
		else:
			timer_started = false
			if $ProgressTimer.value <= 0: $ProgressTimer.value = 0
			timerover.emit()
			# connected to MainBare

func format_digital_timer():
	# Felipe : https://forum.godotengine.org/t/how-to-convert-seconds-into-ddmm-ss-format/8174/2
	var sec_ = roundi(time_left_sec) % 60
	@warning_ignore("integer_division")
	var min_ = (roundi(time_left_sec) / 60) % 60
	
	$DigitalTimer.text = "%02d:%02d" % [min_, sec_]	

func start_timer(duration_sec : float):
	timer_duration_sec = duration_sec
	time_left_sec = timer_duration_sec
	#print(str(timer_duration_sec))
	self.show()
	timer_started = true
	format_digital_timer()
	$SecondTimer.start()

func _on_second_timer_timeout() -> void:
	if time_left_sec == 0:
		$SecondTimer.stop()
	else:
		time_left_sec -= 1.0
	format_digital_timer()
