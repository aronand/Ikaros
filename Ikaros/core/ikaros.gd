class_name Ikaros
## Static class that houses commonly accessed members and methods.

## Returns the default gravity as defined in project settings.
static var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

## Reference to the current player instance.
static var player: IkarosCharacter = null

# TODO: Define the player settings file in the editor
## Holds settings affecting player behaviour.
static var player_settings: IkarosPlayerSettings = preload("res://game/player_settings.tres")

## Tracks the player score.
static var score: int = 0

## Returns the engine version as defined in project.godot.
static var project_engine_version: String:
	get:
		return ProjectSettings.get_setting("application/config/features")[0] as String

## Returns the engine version in "{major}.{minor}" format.
static var engine_version: String:
	get:
		var version: Dictionary = Engine.get_version_info()
		return "%d.%d" % [version["major"], version["minor"]]


## Handles exiting the game
static func quit(exit_code: int = 0) -> void:
	IkarosLog.info("Exiting game.")
	Engine.get_main_loop().quit(exit_code)


## Compares the engine version defined in project.godot to the currently running engine.
static func is_correct_engine_version() -> bool:
	return project_engine_version == engine_version
