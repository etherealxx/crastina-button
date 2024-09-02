extends Button

signal taskchosen(task : String)

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed():
	taskchosen.emit(self.text)
