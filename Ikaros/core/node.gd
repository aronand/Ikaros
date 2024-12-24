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


## Log message at IkarosLog.LogLevel.INFO
func log_info(message: String) -> void:
	IkarosLog.info(message)


## Log message at IkarosLog.LogLevel.WARN
func log_warning(message: String) -> void:
	IkarosLog.warning(message)


## Log message at IkarosLog.LogLevel.ERROR
func log_error(message: String) -> void:
	IkarosLog.error(message)


## Log message at IkarosLog.LogLevel.DEBUG
func log_debug(message: String) -> void:
	IkarosLog.debug(message)


## Log message at IkarosLog.LogLevel.FATAL
func log_fatal(message: String) -> void:
	IkarosLog.fatal(message)
