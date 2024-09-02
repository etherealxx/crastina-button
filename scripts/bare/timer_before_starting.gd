extends VBoxContainer

signal bigtimerstart

@onready var askers := get_parent()

var countdown_started := false

func _ready() -> void:
	#hidden.connect(_on_default_hidden)
	#@TODO
	pass

func start_countdown():
	countdown_started = true

func hide_and_reset():
	self.hide()
	countdown_started = false
	$ProgressBar.value = 0

func _process(delta: float) -> void:
	if countdown_started and self.visible:
		if $ProgressBar.value < $ProgressBar.max_value:
			$ProgressBar.value += delta * 40
		else:
			countdown_started = false
			bigtimerstart.emit()
			askers.goto_reminder()
