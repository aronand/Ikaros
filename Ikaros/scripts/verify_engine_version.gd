extends SceneTree  # We can't extend MainLoop as that lacks the quit() method
## Script to verify that the engine version matches that of the project.
##
## This script should be called as follows: godot --headless --quit --script <path>

var exit_code: int = 0


func _initialize() -> void:
	# Runs the verification when the script is initialized.
	print("Project engine version: %s" % Ikaros.project_engine_version)
	print("Engine version: %s" % Ikaros.engine_version)

	if Ikaros.is_correct_engine_version():
		print("Engine version matches project's engine version.")
		exit_code = 0
	else:
		printerr("Engine version does not match project's engine version.")
		exit_code = 1


func _finalize() -> void:
	# Exits Godot with the given exit code
	quit(exit_code)
