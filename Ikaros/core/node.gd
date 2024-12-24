class_name IkarosNode
extends Node


func get_class_name() -> String:
	var script: Script = get_script()
	return script.get_global_name()
