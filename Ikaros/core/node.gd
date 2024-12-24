class_name IkarosNode
extends Node
## Base class for Node based Ikaros nodes.

@onready var _logger: LogStream = Ikaros.get_logger(get_class_name())


## Returns the class name as defined in the script, or an empty string if no
## script is attached.
func get_class_name() -> StringName:
	var script: Variant = get_script()
	if script == null:
		return ""
	return (script as Script).get_global_name()


## Log message at LogStream.LogLevel.INFO
func log_info(message: String, values: Variant = null) -> void:
	_logger.info(message, values)


## Log message at LogStream.LogLevel.WARN
func log_warning(message: String, values: Variant = null) -> void:
	_logger.warn(message, values)


## Log message at LogStream.LogLevel.ERROR
func log_error(message: String, values: Variant = null) -> void:
	_logger.err(message, values)


## Log message at LogStream.LogLevel.DEBUG
func log_debug(message: String, values: Variant = null) -> void:
	_logger.dbg(message, values)


## Log message at LogStream.LogLevel.FATAL
func log_fatal(message: String, values: Variant = null) -> void:
	_logger.fatal(message, values)
