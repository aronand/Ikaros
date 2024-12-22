extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventKey:
		return

	if event.is_action_pressed("open_debug_menu"):
		visible = not visible
