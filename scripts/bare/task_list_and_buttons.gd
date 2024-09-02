extends VBoxContainer

signal item_removed(itemname : String)

var selected_item_index : int

@onready var list = $TaskItemList

func show_option_buttons():
	$OptionButtons.show()
	$AddNewRow.hide()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AddNewRow.hide()
	list.item_selected.connect(_on_item_selected)

func list_all_tasks(taskarray : Array[String]):
	for task in taskarray:
		list.add_item(task)

func _on_item_selected(idx):
	selected_item_index = idx

func _on_delete_button_pressed() -> void:
	if list.is_selected(selected_item_index):
		var item_text : String = list.get_item_text(selected_item_index)
		list.remove_item(selected_item_index)
		item_removed.emit(item_text, "tasks")
		# signal catched by MainBare's script
		
func _on_add_button_pressed() -> void: # will show textbox
	%TypeNewItem.text = ""
	$OptionButtons.hide()
	$AddNewRow.show()

func _on_add_item_pressed() -> void: # will add the item from textbox
	var newtask : String = %TypeNewItem.text
	if newtask:
		if not newtask in GlobalVar.tasklist:
			GlobalVar.tasklist.append(newtask)
			print(str(GlobalVar.tasklist))
			list.add_item(newtask)
			SaveSystem.set_var("tasks", GlobalVar.tasklist)
			SaveSystem.save()
	show_option_buttons()

func _on_cancel_add_pressed() -> void:
	show_option_buttons()
	%TypeNewItem.text = ""
