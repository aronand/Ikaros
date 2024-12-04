class_name IkarosAutoload
extends Node

var log_level: LogStream.LogLevel = LogStream.LogLevel.DEBUG

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var player: IkarosCharacter = null
var player_can_move_in_air: bool = true


func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)
