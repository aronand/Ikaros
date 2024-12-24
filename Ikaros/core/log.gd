class_name IkarosLog
## Static class to handle logging throughout a project.

enum LogLevel {
	DEBUG,
	INFO,
	WARNING,
	ERROR,
	FATAL
}

static var current_log_level: LogLevel = LogLevel.DEBUG

# TODO: Implement log format
static var log_format: String = "[lb]{hour}:{minute}:{second}[rb][lb]{level}[rb][lb]{log_name}[rb] {message}"

static func debug(message: String) -> void:
	_log(LogLevel.DEBUG, message)


static func info(message: String) -> void:
	_log(LogLevel.INFO, message)


static func warning(message: String) -> void:
	_log(LogLevel.WARNING, message)


static func error(message: String) -> void:
	_log(LogLevel.ERROR, message)


static func fatal(message: String) -> void:
	_log(LogLevel.FATAL, message)


static func _log(level: LogLevel, message: String) -> void:
	if level < current_log_level:
		return

	match level:
		LogLevel.DEBUG:
			print_rich("[color=gray]%s[/color]" % message)
		LogLevel.INFO:
			print_rich("%s" % message)
		LogLevel.WARNING:
			print_rich("[color=yellow]%s[/color]" % message)
			push_warning(message)
		_:  # LogLevel.ERROR and LogLevel.FATAL
			print_rich("[color=red]%s[/color]" % message)
			push_error(message)
