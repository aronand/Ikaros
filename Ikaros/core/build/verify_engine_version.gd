extends SceneTree  # We can't extend MainLoop as that lacks the quit() method

var exit_code: int = 0


func _initialize() -> void:
	print("Project engine version: %s" % Ikaros.project_engine_version)
	print("Engine version: %s" % Ikaros.engine_version)

	if Ikaros.is_correct_engine_version():
		print("Engine version matches project's engine version.")
		exit_code = 0
	else:
		printerr("Engine version does not match project's engine version.")
		exit_code = 1


func _finalize() -> void:
	Ikaros._logger.free()
	quit(exit_code)
