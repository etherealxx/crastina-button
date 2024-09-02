extends VBoxContainer

signal item_removed(itemname : String, itemtype : String)

var selected_item_index : int

@onready var list = $ProcrasItemList

func show_option_buttons():
	$OptionButtons.show()
	$AddNewRow.hide()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AddNewRow.hide()
	list.item_selected.connect(_on_item_selected)

func list_all_procrasthing(taskarray : Array[String]):
	for task in taskarray:
		list.add_item(task)

func _on_item_selected(idx):
	selected_item_index = idx

func _on_delete_button_pressed() -> void:
	if list.is_selected(selected_item_index):
		var item_text : String = list.get_item_text(selected_item_index)
		list.remove_item(selected_item_index)
		item_removed.emit(item_text, "procrasthing")
		# signal catched by MainBare's script
		
func _on_add_button_pressed() -> void: # will show textbox
	%TypeNewItem.text = ""
	$OptionButtons.hide()
	$AddNewRow.show()

func _on_add_item_pressed() -> void: # will add the item from textbox
	var newprocrasthing : String = %TypeNewItem.text
	if newprocrasthing:
		if not newprocrasthing in GlobalVar.procrasthinglist:
			GlobalVar.procrasthinglist.append(newprocrasthing)
			list.add_item(newprocrasthing)
			SaveSystem.set_var("procrasthing", GlobalVar.procrasthinglist)
			SaveSystem.save()
	show_option_buttons()

func _on_cancel_add_pressed() -> void:
	show_option_buttons()
	%TypeNewItem.text = ""
