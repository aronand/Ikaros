class_name IkarosSceneManager
extends IkarosNode


func _init() -> void:
	pass


func _ready() -> void:
	assert(has_node("IkarosCameraController"))
	assert(has_node("IkarosPlayerController"))


func _process(_delta: float) -> void:
	pass
