@tool
extends Control

@export var affected_labels : Array[Node]
@export var font_choices : Array[Font]
@export_enum("double_jump", "climb", "dash") var character_skills

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
