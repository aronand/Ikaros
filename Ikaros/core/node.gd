class_name IkarosNode
extends Node
## Base class for Node based Ikaros nodes.


## Returns the class name as defined in the script, or an empty string if no
## script is attached.
func get_class_name() -> StringName:
	var script: Variant = get_script()
	if script == null:
		return ""
	return (script as Script).get_global_name()
