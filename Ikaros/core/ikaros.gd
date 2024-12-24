class_name Ikaros

static var log_level: LogStream.LogLevel = LogStream.LogLevel.DEBUG

static var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

static var player: IkarosCharacter = null

# TODO: Define the player settings file in the editor
static var player_settings: IkarosPlayerSettings = preload("res://game/player_settings.tres")

static var score: int = 0

static var _logger: LogStream = get_logger("Ikaros")


static func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)


## Handles exiting the game
static func quit(exit_code: int = 0) -> void:
	_logger.info("Exiting")
	Engine.get_main_loop().quit(exit_code)


## Compares the engine version defined in project.godot to the currently running engine.
static func is_correct_engine_version() -> bool:
	var project_engine_version: String = (
		ProjectSettings.get_setting("application/config/features")[0] as String
	)
	var engine_version: Dictionary = Engine.get_version_info()
	var engine_version_string: String = "%d.%d" % [engine_version["major"], engine_version["minor"]]
	return project_engine_version == engine_version_string
