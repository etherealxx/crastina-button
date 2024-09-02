extends TextureProgressBar

var timer_started := false
var timer_duration_sec := 30.0
var timer_progress_value := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if timer_started:
		if value > 0:
			timer_progress_value -= (100.0 / timer_duration_sec) * delta
			value = timer_progress_value * delta # snapped((100.0 / timer_duration_sec) * delta, 0.001)
			print(timer_progress_value)
		else:
			if value <= 0: value = 0

func start_timer():
	timer_started = true
