class_name Ikaros

static var log_level: LogStream.LogLevel = LogStream.LogLevel.DEBUG

static var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

static var player: IkarosCharacter = null
static var player_can_move_in_air: bool = true


static func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)
