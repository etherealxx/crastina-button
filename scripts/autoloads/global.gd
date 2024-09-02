extends Node

var tasklist : Array[String] = ["Godot (Coding)", "Blender (Modelling)"]
var procrasthinglist : Array[String]
func get_tasklist():
	return tasklist

func set_tasklist(newtasks : Array):
	var stringarray : Array[String]
	for task in newtasks:
		stringarray.append(str(task))
	tasklist = stringarray

func set_procrasthinglist(newthing : Array):
	var stringarray : Array[String]
	for task in newthing:
		stringarray.append(str(task))
	procrasthinglist = stringarray
