class_name IkarosAutoload
extends Node

var log_level: LogStream.LogLevel = LogStream.LogLevel.DEBUG

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)
