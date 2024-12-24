class_name IkarosLog
## Static class to handle logging throughout a project.

enum LogLevel { DEBUG, INFO, WARNING, ERROR, FATAL }

static var current_log_level: LogLevel = LogLevel.DEBUG

static var log_format: String = "[%s][%s] %s"


static func debug(message: String, logger: String) -> void:
	log_message(LogLevel.DEBUG, message, logger)


static func info(message: String, logger: String) -> void:
	log_message(LogLevel.INFO, message, logger)


static func warning(message: String, logger: String) -> void:
	log_message(LogLevel.WARNING, message, logger)


static func error(message: String, logger: String) -> void:
	log_message(LogLevel.ERROR, message, logger)


static func fatal(message: String, logger: String) -> void:
	log_message(LogLevel.FATAL, message, logger)


static func log_message(level: LogLevel, message: String, logger: String) -> void:
	if level < current_log_level:
		return
	_log.call_deferred(level, message, logger)


static func _log(level: LogLevel, message: String, logger: String) -> void:
	var level_string: String = LogLevel.keys()[level]
	var formatted_message: String = log_format % [level_string, logger, message]

	match level:
		LogLevel.DEBUG:
			print_rich("[color=gray]%s[/color]" % formatted_message)
		LogLevel.INFO:
			print_rich("%s" % formatted_message)
		LogLevel.WARNING:
			print_rich("[color=yellow]%s[/color]" % formatted_message)
			push_warning(message)
		_:  # LogLevel.ERROR and LogLevel.FATAL
			print_rich("[color=red]%s[/color]" % formatted_message)
			push_error(message)
