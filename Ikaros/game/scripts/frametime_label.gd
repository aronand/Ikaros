extends Label

var frametime: float


func _process(_delta: float) -> void:
	frametime = Performance.get_monitor(Performance.TIME_PROCESS) * 1000
	text = "Frametime: %.3f ms" % frametime
