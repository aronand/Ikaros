extends Label


func _process(delta: float) -> void:
	var frametime: float = Performance.get_monitor(Performance.TIME_PROCESS) * 1000
	text = "Frametime: %.3f ms" % frametime
