class_name IkarosAutoload
extends Node


var log_level: LogStream.LogLevel = LogStream.LogLevel.DEBUG


func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)
