class_name Ikaros

static var log_level: LogStream.LogLevel = LogStream.LogLevel.DEBUG

static var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

static var player: IkarosCharacter = null

# TODO: Define the player settings file in the editor
static var player_settings: IkarosPlayerSettings = preload("res://game/player_settings.tres")


static func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)


## Handles exiting the game
static func quit(exit_code: int = 0) -> void:
	Engine.get_main_loop().quit(exit_code)
