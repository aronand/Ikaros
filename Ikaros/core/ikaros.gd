class_name Ikaros

static var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

static var player: IkarosCharacter = null

# TODO: Define the player settings file in the editor
static var player_settings: IkarosPlayerSettings = preload("res://game/player_settings.tres")

static var score: int = 0

static var log_level: LogStream.LogLevel:
	get:
		return LogStream.LogLevel.DEBUG

static var _logger: LogStream = null:
	get:
		if _logger == null:
			_logger = get_logger("Ikaros")
		return _logger

static var project_engine_version: String:
	get:
		return ProjectSettings.get_setting("application/config/features")[0] as String

static var engine_version: String:
	get:
		var version: Dictionary = Engine.get_version_info()
		return "%d.%d" % [version["major"], version["minor"]]


static func get_logger(log_name: String) -> LogStream:
	return LogStream.new(log_name, log_level)


## Handles exiting the game
static func quit(exit_code: int = 0) -> void:
	_logger.info("Exiting")
	Engine.get_main_loop().quit(exit_code)


## Compares the engine version defined in project.godot to the currently running engine.
static func is_correct_engine_version() -> bool:
	return project_engine_version == engine_version
